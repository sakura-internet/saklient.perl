#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/../lib";
use Saclient::Cloud::API;
use Saclient::Cloud::Enums::EServerInstanceStatus;
use Saclient::Cloud::Errors::HttpException;
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use File::Basename qw(basename dirname);
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 18;



# load config file
my $root = dirname $FindBin::RealBin;
my $test_ok_file = $root . '/testok';
ok -f $test_ok_file, "テストを行うと課金が発生する場合があります。よろしければ、確認のために $test_ok_file をtouchしてください。";
my $config_file = $root . '/config.sh';
ok -f $config_file, "$config_file を作成してください。";
my %config = ();
my $fh;
open $fh, '<', $config_file;
while (my $line = readline $fh) {
	next unless $line =~ /^\s*export\s+(\w+)\s*=\s*(.+?)\s*$/;
	my $key = $1;
	my $value = $2;
	$value =~ s/'([^']*)'|"([^"]*)"|\\(.)|(.)/$1||$2||$3||$4/ge;
	$config{$key} = $value;
}
close $fh;
ok $config{'SACLOUD_TOKEN'}, 'SACLOUD_TOKEN must be defined in config.sh';
ok $config{'SACLOUD_SECRET'}, 'SACLOUD_SECRET must be defined in config.sh';
#ok $config{'SACLOUD_ZONE'}, 'SACLOUD_ZONE must be defined in config.sh';



# authorize
my $api = Saclient::Cloud::API::authorize($config{'SACLOUD_TOKEN'}, $config{'SACLOUD_SECRET'});
$api = $api->in_zone($config{'SACLOUD_ZONE'}) if $config{'SACLOUD_ZONE'};
isa_ok $api, 'Saclient::Cloud::API';



# should be found
my $servers = $api->server()->find();
isa_ok $servers, 'ARRAY';
cmp_ok scalar(@$servers), '>', 0;

foreach my $server (@$servers) {
	$tests += 7;
	isa_ok $server, 'Saclient::Cloud::Resource::Server';
	isa_ok $server->plan(), 'Saclient::Cloud::Resource::ServerPlan';
	cmp_ok $server->plan()->cpu(), '>', 0;
	cmp_ok $server->plan()->memory_mib(), '>', 0;
	cmp_ok $server->plan()->memory_gib(), '>', 0;
	is($server->plan()->memory_mib() / $server->plan()->memory_gib(), 1024);
	isa_ok $server->tags(), 'ARRAY';
	foreach my $tag (@{$server->tags()}) {
		$tests += 2;
		ok !ref($tag);
		like($tag, qr/./);
	}
}



# should be CRUDed and power-controlled
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saclient.perl test';
my $tag = 'saclient-test';
my $cpu = 1;
my $mem = 2;
#
my $server = $api->server->create;
isa_ok $server, 'Saclient::Cloud::Resource::Server';
$server->name($name);
$server->description($description);
$server->tags([$tag]);
$server->plan($api->product->server->get_by_spec($cpu, $mem));
$server->save();
#
cmp_ok $server->id, '>', 0;
is $server->name, $name;
is $server->description, $description;
isa_ok $server->tags, 'ARRAY';
is scalar(@{$server->tags}), 1;
is $server->tags->[0], $tag;
is $server->plan->cpu, $cpu;
is $server->plan->memory_gib, $mem;

# test_boot
$server->boot;
sleep 1;
$server->reload;
is $server->instance->status, Saclient::Cloud::Enums::EServerInstanceStatus::up, 'サーバが起動しません';

# test_boot_conflict
my $ok = 0;
try {
	$server->boot;
}
catch Saclient::Cloud::Errors::HttpException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'conflict';
	$ok = 1;
};
#
ok $ok, 'サーバ起動中の起動試行時は HttpConflictException がスローされなければなりません';

# test_stop
$server->stop;
diag 'サーバの停止を待機中…';

if (1) {
	# sleep* style
	
	fail 'サーバが正常に停止しません' unless $server->sleep_until_down;
	
	# test_destroy
	$server->destroy;
	
	#
	plan tests => $tests;
	done_testing;
	
}
else {
	# after* style
	
	$server->after_down(sub{
		shift;
		my $ok = shift;
		fail 'サーバが正常に停止しません' unless $ok;
		# test_destroy
		$server->destroy;
		#
		plan tests => $tests;
		done_testing;
	});
	
}

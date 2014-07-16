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

my $tests = 27;



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
my $servers = $api->server->find;
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

# should be limited
$servers = $api->server->limit(1)->find;
is scalar(@$servers), 1;



# should be CRUDed
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saclient.perl test';
my $tag = 'saclient-test';
my $cpu = 1;
my $mem = 2;

# search archives
diag 'searching archives...';
my $archives = $api->archive
	->with_name_like('CentOS 6.5 64bit')
	->with_size_gib(20)
	->with_shared_scope
	->limit(1)
	->find;
cmp_ok scalar(@$archives), '>', 0;
my $archive = $archives->[0];

# create a disk
diag 'creating a disk...';
my $disk = $api->disk->create
	->name($name)
	->description($description)
	->tags([$tag])
	->source($archive)
	->save;
is $disk->size_gib, 20;

# create a server
diag 'creating a server...';
my $server = $api->server->create;
isa_ok $server, 'Saclient::Cloud::Resource::Server';
$server->name($name);
$server->description($description);
$server->tags([$tag]);
$server->plan($api->product->server->get_by_spec($cpu, $mem));
$server->save();

# check the server properties
cmp_ok $server->id, '>', 0;
is $server->name, $name;
is $server->description, $description;
isa_ok $server->tags, 'ARRAY';
is scalar(@{$server->tags}), 1;
is $server->tags->[0], $tag;
is $server->plan->cpu, $cpu;
is $server->plan->memory_gib, $mem;

# wait disk copy
diag 'waiting disk copy...';
fail 'アーカイブからディスクへのコピーがタイムアウトしました' unless $disk->sleep_while_copying;
$disk->source(undef);
$disk->reload;
isa_ok $disk->source, 'Saclient::Cloud::Resource::Archive';
is $disk->source->id, $archive->id;
is $disk->size_gib, $archive->size_gib;

# connect the disk to the server
diag 'connecting the disk to the server...';
$disk->connect_to($server);

# boot
diag 'booting the server...';
$server->boot;
sleep 1;
$server->reload;
is $server->instance->status, Saclient::Cloud::Enums::EServerInstanceStatus::up, 'サーバが起動しません';

# boot conflict
diag 'checking the server power conflicts...';
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

# stop
sleep 3;
diag 'stopping the server...';
$server->stop;
fail 'サーバが正常に停止しません' unless $server->sleep_until_down;

# disconnect the disk from the server
diag 'disconnecting the disk from the server...';
$disk->disconnect;

# delete the server
diag 'deleting the server...';
$server->destroy;

# duplicate the disk
diag 'duplicating the disk (expanding to 40GiB)...';
my $disk2 = $api->disk->create;
$disk2->name($name . "-copy");
$disk2->description($description);
$disk2->tags([$tag]);
$disk2->source($disk);
$disk2->size_gib(40);
$disk2->save;

# wait disk duplication
diag 'waiting disk duplication...';
fail 'ディスクの複製がタイムアウトしました' unless $disk2->sleep_while_copying;
$disk2->source(undef);
$disk2->reload;
isa_ok $disk2->source, 'Saclient::Cloud::Resource::Disk';
is $disk2->source->id, $disk->id;
is $disk2->size_gib, 40;

# delete the disks
diag 'deleting the disks...';
$disk2->destroy;
$disk->destroy;

#
plan tests => $tests;
done_testing;


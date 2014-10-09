#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Cloud::API;
use Saklient::Errors::SaklientException;
use Socket;
use List::Util 'min';
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 11;



# load config file
my $root = dirname $FindBin::RealBin;
my $test_ok_file = $root . '/testok';
unless (-f $test_ok_file) {
	diag "詳細テストを行うには $test_ok_file をtouchしてください。";
	ok 1;
	plan tests => 1;
	done_testing;
	exit 0;
}
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
my $api = Saklient::Cloud::API::authorize($config{'SACLOUD_TOKEN'}, $config{'SACLOUD_SECRET'});
$api = $api->in_zone($config{'SACLOUD_ZONE'}) if $config{'SACLOUD_ZONE'};
isa_ok $api, 'Saklient::Cloud::API';



# should be CRUDed
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saklient.perl test';
my $tag = 'saklient-test';


# search a switch
diag 'searching a swytch...';
my $swytches = $api->swytch->with_tag('lb-attached')->limit(1)->find;
cmp_ok scalar(@$swytches), '>', 0;
my $swytch = $swytches->[0];
isa_ok $swytch, 'Saklient::Cloud::Resources::Swytch';
cmp_ok scalar(@{$swytch->ipv4_nets}), '>', 0;
my $net = $swytch->ipv4_nets->[0];
diag sprintf('%s/%d -> %s', $net->address, $net->mask_len, $net->default_route);

# create a loadbalancer
diag 'creating a LB...';
my $vrid = 123;
my $lb = $api->appliance->create_load_balancer($swytch, $vrid, ['133.242.255.244', '133.242.255.245'], 1);

my $ok = 0;
try {
	$lb->save;
}
catch Saklient::Errors::SaklientException with {
	my $ex = shift;
	$ok = 1;
};
fail 'Requiredフィールドが未set時は SaklientException がスローされなければなりません' unless $ok;
diag 'saving...';
$lb->name($name);
$lb->description('');
$lb->tags([$tag]);
$lb->save;

$lb->reload;
is $lb->default_route, $net->default_route;
is $lb->mask_len, $net->mask_len;
is $lb->vrid, $vrid;
is $lb->swytch_id, $swytch->id;

# wait the LB becomes up
diag 'waiting the LB becomes up...';
fail 'ロードバランサが正常に起動しません' unless $lb->sleep_until_up;

# stop the LB
sleep 1;
diag 'stopping the LB...';
fail 'ロードバランサが正常に停止しません' unless $lb->stop->sleep_until_down;

# delete the LB
diag 'deleting the LB...';
$lb->destroy;

#
plan tests => $tests;
done_testing;

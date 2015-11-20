#!perl

use strict;
use warnings;
use errors;
use Test::More tests => 15;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Cloud::API;
use Saklient::Util qw(get_by_path set_by_path exists_path ip2long long2ip);
use Saklient::Errors::HttpException;
use Socket;
use List::Util 'min';
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
binmode STDOUT, ":utf8";



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

#
diag 'GSLBを作成しています...';
my $gslb = $api->common_service_item->create_gslb('http', 10, 1);
isa_ok $gslb, 'Saklient::Cloud::Resources::Gslb';
$gslb->path_to_check('/index.html');
$gslb->response_expected(200);
$gslb->name($name);
$gslb->description('This is a test');
$gslb->save;
my $id = $gslb->id;
cmp_ok $id, '>', 0;
is $gslb->name, $name;
is scalar(@{$gslb->servers}), 0;

$gslb = $api->common_service_item->get_by_id($id);
is $gslb->id, $id;
is $gslb->path_to_check, '/index.html';
is $gslb->response_expected, 200;
is $gslb->name, $name;
is scalar(@{$gslb->servers}), 0;

my $server = $gslb->add_server;
$server->enabled(1);
$server->weight(10);
$server->ip_address('49.212.82.90');
$gslb->save;
is scalar(@{$gslb->servers}), 1;

$gslb = $api->common_service_item->get_by_id($id);
is scalar(@{$gslb->servers}), 1;

diag 'GSLBを削除しています...';
$gslb->destroy;

my $ok = 0;
try {
	$gslb = $api->common_service_item->get_by_id($id);
}
catch Saklient::Errors::HttpException with {
	my $ex = shift;
	$ok = 1;
};
fail 'GSLBが正しく削除されていません' unless $ok;

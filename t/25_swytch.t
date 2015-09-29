#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Cloud::API;
use Socket;
use List::Util 'min';
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 10;



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

#
diag 'スイッチを作成しています...';
my $swytch = $api->swytch->create;
isa_ok $swytch, 'Saklient::Cloud::Resources::Swytch';
$swytch->name($name)
	->description($description)
	->save;
cmp_ok $swytch->id, '>', 0;

#
diag 'サーバを作成しています...';
my $server = $api->server->create;
isa_ok $server, 'Saklient::Cloud::Resources::Server';
$server->name($name)
	->description($description)
	->plan($api->product->server->get_by_spec(1, 1))
	->save;
cmp_ok $server->id, '>', 0;

#
diag 'インタフェースを増設しています...';
my $iface = $server->add_iface;
isa_ok $iface, 'Saklient::Cloud::Resources::Iface';
cmp_ok $iface->id, '>', 0;

#
diag 'インタフェースをスイッチに接続しています...';
$iface->connect_to_swytch($swytch);

#
diag 'インタフェースをスイッチから切断しています...';
$iface->disconnect_from_swytch;

#
diag 'サーバを削除しています...';
$server->destroy;

#
diag 'スイッチを削除しています...';
$swytch->destroy;

#
plan tests => $tests;
done_testing;

#!perl

use strict;
use warnings;
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

my $tests = 13;



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
my $mask_len = 28;

#
my $swytch;
if (1) {
	diag 'ルータ＋スイッチの帯域プランを検索しています...';
	my $plans = $api->product->router->find;
	my $min_mbps = 0x7FFFFFFF;
	foreach my $plan (@$plans) {
		isa_ok $plan, 'Saklient::Cloud::Resource::RouterPlan';
		cmp_ok $plan->band_width_mbps, '>', 0;
		$min_mbps = min($plan->band_width_mbps, $min_mbps);
		$tests += 2;
	}
	
	diag 'ルータ＋スイッチを作成しています...';
	my $router = $api->router->create;
	$router->name($name);
	$router->description($description);
	$router->band_width_mbps($min_mbps);
	$router->network_mask_len($mask_len);
	$router->save;

	diag 'ルータ＋スイッチの作成完了を待機しています...';
	fail 'ルータが正常に作成されません' unless $router->sleep_while_creating;
	$swytch = $router->get_swytch;
}
else {
	diag '既存のルータ＋スイッチを取得しています...';
	my $swytches = $api->swytch->with_name_like('saklient-static-1')->limit(1)->find;
	is scalar(@$swytches), 1;
	$swytch = $swytches->[0];
	$tests++;
}

isa_ok $swytch, 'Saklient::Cloud::Resource::Swytch';
cmp_ok scalar(@{$swytch->ipv4_nets}), '>', 0;
isa_ok $swytch->ipv4_nets->[0], 'Saklient::Cloud::Resource::Ipv4Net';

#
diag 'ルータ＋スイッチの帯域プランを変更しています...';
my $router_id_before = $swytch->router->id;
$swytch->change_plan($swytch->router->band_width_mbps == 100 ? 500 : 100);
isnt $swytch->router->id, $router_id_before;

#
if (0 < scalar(@{$swytch->ipv6_nets})) {
	diag 'ルータ＋スイッチからIPv6ネットワークの割当を解除しています...';
	$swytch->remove_ipv6_net;
}
diag 'ルータ＋スイッチにIPv6ネットワークを割り当てています...';
my $v6net = $swytch->add_ipv6_net;
isa_ok $v6net, 'Saklient::Cloud::Resource::Ipv6Net';
is scalar(@{$swytch->ipv6_nets}), 1;

#
for (my $i = scalar(@{$swytch->ipv4_nets}) - 1; 1 <= $i; $i--) {
	diag 'ルータ＋スイッチからスタティックルートの割当を解除しています...';
	my $net = $swytch->ipv4_nets->[$i];
	$swytch->remove_static_route($net);
}

diag 'ルータ＋スイッチにスタティックルートを割り当てています...';
my $net0 = $swytch->ipv4_nets->[0];
my $next_hop_n = unpack("N*", inet_aton($net0->address)) + 4;
my $next_hop = inet_ntoa(pack("N*", $next_hop_n));
my $sroute = $swytch->add_static_route(28, $next_hop);
isa_ok $sroute, 'Saklient::Cloud::Resource::Ipv4Net';
is scalar(@{$swytch->ipv4_nets}), 2;

#
plan tests => $tests;
done_testing;

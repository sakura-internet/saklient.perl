#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Cloud::API;
use Saklient::Util;
use Saklient::Errors::SaklientException;
use Socket;
use List::Util 'min';
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
binmode STDOUT, ":utf8";

my $TESTS_CONFIG_READYMADE_LB_ID = 112600809060;
my $tests = 46 + ($TESTS_CONFIG_READYMADE_LB_ID ? 0 : 11);



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



# create a LB

my ($lb, $swytch, $net);
if (!$TESTS_CONFIG_READYMADE_LB_ID) {
	
	# search a switch
	diag 'searching a swytch...';
	my $swytches = $api->swytch->with_tag('lb-attached')->limit(1)->find;
	cmp_ok scalar(@$swytches), '>', 0;
	$swytch = $swytches->[0];
	isa_ok $swytch, 'Saklient::Cloud::Resources::Swytch';
	cmp_ok scalar(@{$swytch->ipv4_nets}), '>', 0;
	$net = $swytch->ipv4_nets->[0];
	diag sprintf('%s/%d -> %s', $net->address, $net->mask_len, $net->default_route);
	
	# create a loadbalancer
	diag 'creating a LB...';
	my $vrid = 123;
	$lb = $api->appliance->create_load_balancer($swytch, $vrid, ['133.242.255.244', '133.242.255.245'], 1);
	
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
	
}
else {
	
	$lb = $api->appliance->get_by_id($TESTS_CONFIG_READYMADE_LB_ID);
	isa_ok $lb, 'Saklient::Cloud::Resources::LoadBalancer';
	$swytch = $lb->get_swytch;
	isa_ok $swytch, 'Saklient::Cloud::Resources::Swytch';
	$net = $swytch->ipv4_nets->[0];
	isa_ok $net, 'Saklient::Cloud::Resources::Ipv4Net';
	diag sprintf('%s/%d -> %s', $net->address, $net->mask_len, $net->default_route);
	
}


		


# clear virtual ips

$lb->clear_virtual_ips();
$lb->save();
$lb->reload();
is scalar(@{$lb->virtual_ips}), 0;



# setting virtual ips test 1
diag 'setting virtual ips test 1';

my $vip1Ip     = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 5));
my $vip1SrvIp1 = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 6));
my $vip1SrvIp2 = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 7));
my $vip1SrvIp3 = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 8));
my $vip1SrvIp4 = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 9));

my $cfg = {
	'vip' => $vip1Ip,
	'port' => 80,
	'delay' => 15,
	'servers' => [
		{ 'ip'=>$vip1SrvIp1, 'port'=>80, 'protocol'=>'http', 'path_to_check'=>'/index.html', 'response_expected'=>200 },
		{ 'ip'=>$vip1SrvIp2, 'port'=>80, 'protocol'=>'https', 'path_to_check'=>'/', 'response_expected'=>200 },
		{ 'ip'=>$vip1SrvIp3, 'port'=>80, 'protocol'=>'tcp' }
	]
};
$lb->add_virtual_ip($cfg);

my $vip2Ip     = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 10));
my $vip2SrvIp1 = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 11));
my $vip2SrvIp2 = inet_ntoa(pack("N*", unpack("N*", inet_aton($net->default_route)) + 12));

my $vip2 = $lb->add_virtual_ip();
$vip2->virtual_ip_address($vip2Ip);
$vip2->port(80);
$vip2->delay_loop(15);
my $vip2Srv1 = $vip2->add_server();
$vip2Srv1->ip_address($vip2SrvIp1);
$vip2Srv1->port(80);
$vip2Srv1->protocol('http');
$vip2Srv1->path_to_check('/index.html');
$vip2Srv1->response_expected(200);
my $vip2Srv2 = $vip2->add_server();
$vip2Srv2->ip_address($vip2SrvIp2);
$vip2Srv2->port(80);
$vip2Srv2->protocol('tcp');
$lb->save();
$lb->reload();

is scalar(@{$lb->virtual_ips}), 2;
is $lb->virtual_ips->[0]->virtual_ip_address, $vip1Ip;
is scalar(@{$lb->virtual_ips->[0]->servers}), 3;
is $lb->virtual_ips->[0]->servers->[0]->ip_address, $vip1SrvIp1;
is $lb->virtual_ips->[0]->servers->[0]->port, 80;
is $lb->virtual_ips->[0]->servers->[0]->protocol, 'http';
is $lb->virtual_ips->[0]->servers->[0]->path_to_check, '/index.html';
is $lb->virtual_ips->[0]->servers->[0]->response_expected, 200;
is $lb->virtual_ips->[0]->servers->[1]->ip_address, $vip1SrvIp2;
is $lb->virtual_ips->[0]->servers->[1]->port, 80;
is $lb->virtual_ips->[0]->servers->[1]->protocol, 'https';
is $lb->virtual_ips->[0]->servers->[1]->path_to_check, '/';
is $lb->virtual_ips->[0]->servers->[1]->response_expected, 200;
is $lb->virtual_ips->[0]->servers->[2]->ip_address, $vip1SrvIp3;
is $lb->virtual_ips->[0]->servers->[2]->port, 80;
is $lb->virtual_ips->[0]->servers->[2]->protocol, 'tcp';
is $lb->virtual_ips->[1]->virtual_ip_address, $vip2Ip;
is scalar(@{$lb->virtual_ips->[1]->servers}), 2;
is $lb->virtual_ips->[1]->servers->[0]->ip_address, $vip2SrvIp1;
is $lb->virtual_ips->[1]->servers->[0]->port, 80;
is $lb->virtual_ips->[1]->servers->[0]->protocol, 'http';
is $lb->virtual_ips->[1]->servers->[0]->path_to_check, '/index.html';
is $lb->virtual_ips->[1]->servers->[0]->response_expected, 200;
is $lb->virtual_ips->[1]->servers->[1]->ip_address, $vip2SrvIp2;
is $lb->virtual_ips->[1]->servers->[1]->port, 80;
is $lb->virtual_ips->[1]->servers->[1]->protocol, 'tcp';



# setting virtual ips test 2
diag 'setting virtual ips test 2';

$lb->get_virtual_ip_by_address($vip1Ip)->add_server({
	'ip'=> $vip1SrvIp4,
	'port'=> 80,
	'protocol'=> 'ping'
});
$lb->save();
$lb->reload();

is scalar(@{$lb->virtual_ips}), 2;
is scalar(@{$lb->virtual_ips->[0]->servers}), 4;
is $lb->virtual_ips->[0]->servers->[3]->ip_address, $vip1SrvIp4;
is $lb->virtual_ips->[0]->servers->[3]->port, 80;
is $lb->virtual_ips->[0]->servers->[3]->protocol, 'ping';
is scalar(@{$lb->virtual_ips->[1]->servers}), 2;



# checking status
diag 'checking status';

$lb->reload_status();
foreach my $vip (@{$lb->virtual_ips}) {
	diag sprintf('  vip %s:%s every %ssec(s)', $vip->virtual_ip_address, $vip->port, $vip->delay_loop);
	foreach my $server (@{$vip->servers}) {
		my $msg = '';
		$msg .= sprintf('    [%s(%s)]', $server->status, $server->active_connections);
		$msg .= sprintf(' server %s://%s', $server->protocol, $server->ip_address);
		$msg .= sprintf(':%d', $server->port) if $server->port();
		$msg .= $server->path_to_check if $server->path_to_check();
		$msg .= ' answers';
		$msg .= sprintf(' %d', $server->response_expected) if $server->response_expected();
		diag $msg;
		is $server->status, 'down';
	}
}



# delete the LB

if (!$TESTS_CONFIG_READYMADE_LB_ID) {
	
	# stop the LB
	sleep 1;
	diag 'stopping the LB...';
	fail 'ロードバランサが正常に停止しません' unless $lb->stop->sleep_until_down();
	
	# delete the LB
	diag 'deleting the LB...';
	$lb->destroy;
	
}

#
plan tests => $tests;
done_testing;

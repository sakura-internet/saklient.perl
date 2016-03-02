#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Cloud::API;
use Saklient::Cloud::Enums::EServerInstanceStatus;
use Saklient::Errors::HttpException;
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
use DateTime;
binmode STDOUT, ":utf8";

my $tests = 4;



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



# settings
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saklient.perl test';
my $tag = 'saklient-test';

# create a server
diag 'creating a server...';
my $server = $api->server->create;
$tests++; isa_ok $server, 'Saklient::Cloud::Resources::Server';
$server->name($name)
	->description($description)
	->tags([$tag])
	->plan($api->product->server->get_by_spec(1, 1))
	->save;

# create empty disks
diag 'creating empty disks...';
my $disks = [];
for (my $i=0; $i<3; $i++) {
	my $disk = $api->disk->create
		->name($name)
		->description($description)
		->tags([$tag])
		->plan($api->product->disk->ssd)
		->size_gib(20)
		->save;
	$tests++; is $disk->size_gib, 20;
	$disk->connect_to($server);
	push @$disks, $disk;
}
my $disk = $disks->[1]->disconnect;
splice @$disks, 1, 1;
$disk->connect_to($server);
push @$disks, $disk;


#
my $disks_after = $server->find_disks;
for (my $i=0; $i<3; $i++) {
	$tests++; is $disks_after->[$i]->id, $disks->[$i]->id;
}

foreach my $disk (@$disks) {
	$disk->disconnect->destroy;
}
$server->destroy;

plan tests => $tests;
done_testing;

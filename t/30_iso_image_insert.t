#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Cloud::API;
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 12;



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



# should be inserted and ejected
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saklient.perl test';
my $tag = 'saklient-test';

# search iso images
diag 'searching iso images...';
my $isos = $api->iso_image
	->with_name_like('CentOS 6.5 64bit')
	->with_shared_scope
	->limit(1)
	->find;
cmp_ok scalar(@$isos), '>', 0;
my $iso = $isos->[0];

# create a server
diag 'creating a server...';
my $server = $api->server->create;
isa_ok $server, 'Saklient::Cloud::Resources::Server';
$server
	->name($name)
	->description($description)
	->tags([$tag])
	->plan($api->product->server->get_by_spec(1, 1))
	->save;

# insert iso image while the server is down
diag 'inserting an ISO image to the server...';
$server->insert_iso_image($iso);
isa_ok $server->instance->iso_image, 'Saklient::Cloud::Resources::IsoImage';
is $server->instance->iso_image->id, $iso->id;

# eject iso image while the server is down
diag 'ejecting the ISO image from the server...';
$server->eject_iso_image;
is $server->instance->iso_image, undef;

# boot
diag 'booting the server...';
$server->boot;
sleep 3;

# insert iso image while the server is up
diag 'inserting an ISO image to the server...';
$server->insert_iso_image($iso);
isa_ok $server->instance->iso_image, 'Saklient::Cloud::Resources::IsoImage';
is $server->instance->iso_image->id, $iso->id;

# eject iso image while the server is up
diag 'ejecting the ISO image from the server...';
$server->eject_iso_image;
is $server->instance->iso_image, undef;

# stop
sleep 1;
diag 'stopping the server...';
$server->stop;
fail 'サーバが正常に停止しません' unless $server->sleep_until_down;

# delete the server
diag 'deleting the server...';
$server->destroy;




#
plan tests => $tests;
done_testing;


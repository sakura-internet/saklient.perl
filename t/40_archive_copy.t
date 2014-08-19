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
use POSIX qw(strftime tmpnam);
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 8;



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



# should be copied
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saklient.perl test';
my $tag = 'saklient-test';

my $disk = $api->disk->create;
$disk
	->name($name)
	->description($description)
	->tags([$tag])
	->size_gib(20)
	->save;

my $archive = $api->archive->create;
$archive
	->name($name)
	->description($description)
	->tags([$tag])
	->source($disk)
	->save;

fail 'ディスクからアーカイブへのコピーがタイムアウトまたは失敗しました' unless $archive->sleep_while_copying;

$disk->destroy;

my $ftp = $archive->open_ftp->ftp_info;
isa_ok $ftp, 'Saklient::Cloud::Resource::FtpInfo';
isnt $ftp->host_name, undef;
isnt $ftp->user, undef;
isnt $ftp->password, undef;

$archive->close_ftp;
$archive->destroy;




#
plan tests => $tests;
done_testing;


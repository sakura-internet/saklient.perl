#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saclient::Cloud::API;
use JSON;
use Data::Dumper;
use POSIX qw(strftime tmpnam);
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 14;



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
my $api = Saclient::Cloud::API::authorize($config{'SACLOUD_TOKEN'}, $config{'SACLOUD_SECRET'});
$api = $api->in_zone($config{'SACLOUD_ZONE'}) if $config{'SACLOUD_ZONE'};
isa_ok $api, 'Saclient::Cloud::API';



# should be CRUDed
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saclient.perl test';
my $tag = 'saclient-test';

my $iso = $api->iso_image->create;
isa_ok $iso, 'Saclient::Cloud::Resource::IsoImage';
$iso->name($name)
	->description($description)
	->tags([$tag])
	->size_mib(5120)
	->save;

#
my $ftp = $iso->ftp_info;
isa_ok $ftp, 'Saclient::Cloud::Resource::FtpInfo';
isnt $ftp->host_name, undef;
isnt $ftp->user, undef;
isnt $ftp->password, undef;
my $ftp2 = $iso->open_ftp(1)->ftp_info;
isa_ok $ftp2, 'Saclient::Cloud::Resource::FtpInfo';
isnt $ftp2->host_name, undef;
isnt $ftp2->user, undef;
isnt $ftp2->password, undef;
isnt $ftp2->password, $ftp->password;

#
my $temp = tmpnam;
my $cmd = "dd if=/dev/urandom bs=4096 count=64 > $temp; ls -l $temp";
print "$cmd\n";
print `( $cmd ) 2>&1`;
$cmd  = "set ftp:ssl-allow true;";
$cmd .= "set ftp:ssl-force true;";
$cmd .= "set ftp:ssl-protect-data true;";
$cmd .= "set ftp:ssl-protect-list true;";
$cmd .= "put $temp;";
$cmd .= "exit";
$cmd = sprintf(
	"lftp -u %s,%s -p 21 -e '%s' %s",
	$ftp2->user, $ftp2->password, $cmd, $ftp2->host_name
);
print "$cmd\n";
print `( $cmd ) 2>&1`;
$cmd = "rm -f $temp";
print "$cmd\n";
print `( $cmd ) 2>&1`;

$iso->close_ftp;

#
$iso->destroy;





#
plan tests => $tests;
done_testing;


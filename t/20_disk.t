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

my $tests = 5;



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



# should be create
my $archives = $api->archive
	->with_name_like('CentOS 6.5 64bit')
	->with_size_gib(20)
	->with_shared_scope
	->limit(1)
	->find;
my $archive = $archives->[0];

my $disk = $api->disk->create
	->name('!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}'))
	->description("This instance was created by saclient.perl test")
	->tags(["saclient-test"])
	->copy_from($archive)
	->save;
print Dumper $disk->dump();

diag 'アーカイブからディスクへのコピー完了を待機中…';
fail 'アーカイブからディスクへのコピーがタイムアウトしました' unless $disk->sleep_while_copying;
print Dumper $disk->dump();

$disk->destroy();

plan tests => $tests;
done_testing;


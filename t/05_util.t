#!perl

use strict;
use warnings;
use errors;
use Test::More tests => 47;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saklient::Util qw(get_by_path set_by_path exists_path ip2long long2ip);
use Saklient::Cloud::API;
use Saklient::Errors::SaklientException;
binmode STDOUT, ":utf8";


diag "test 1";
my $test = {};
eval {
	set_by_path($test, 'top', 123);
};
diag $@;

set_by_path($test, 'top', 123);
is $test->{top}, 123;
set_by_path($test, 'first.second', 456);
is $test->{first}->{second}, 456;
set_by_path($test, '.weird..path', 789);
is $test->{weird}->{path}, 789;
set_by_path($test, 'existing.undef', undef);
ok get_by_path($test, 'existing');
is get_by_path($test, 'existing.undef'), undef;
#
diag "test 2";
is get_by_path($test, 'top'), 123;
is get_by_path($test, 'first.second'), 456;
is get_by_path($test, '.weird..path'), 789;
#
diag "test 3";
is get_by_path($test, 'nothing'), undef;
is get_by_path($test, 'nothing.child'), undef;
is get_by_path($test, 'top.child'), undef;
#
diag "test 4";
ok exists_path($test, 'top');
ok ! exists_path($test, 'top.child');
ok exists_path($test, 'first.second');
ok exists_path($test, '.weird..path');
ok ! exists_path($test, 'nothing');
ok ! exists_path($test, 'nothing.child');
ok exists_path($test, 'existing');
ok exists_path($test, 'existing.undef');
#
diag "test 5";
$test->{first}->{second} *= 10;
is get_by_path($test, 'first.second'), 4560;



#
my $ok = 0;
try {
	Saklient::Cloud::API::authorize('abc');
}
catch Saklient::Errors::SaklientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'argument_count_mismatch';
	$ok = 1;
};
ok $ok, '引数の数が足りない時は SaklientException がスローされなければなりません';

#
$ok = 0;
try {
	Saklient::Cloud::API::authorize('abc', []);
}
catch Saklient::Errors::SaklientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'argument_type_mismatch';
	$ok = 1;
};
ok $ok, '引数の型が異なる時は SaklientException がスローされなければなりません';

#
$ok = 0;
try {
	my $server = Saklient::Cloud::API::authorize('a', 'a')->server->create;
	$server->availability('available');
}
catch Saklient::Errors::SaklientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'non_writable_field';
	$ok = 1;
};
ok $ok, '未定義または読み取り専用フィールドへのset時は SaklientException がスローされなければなりません';



#
is ip2long('0.0.0.0'), 0;
is ip2long('127.255.255.255'), 0x7FFFFFFF;
is ip2long('128.0.0.0'), 0x80000000;
is ip2long('255.255.255.255'), 0xFFFFFFFF;
is ip2long('222.173.190.239'), 0xDEADBEEF;
#
is long2ip(0), '0.0.0.0';
is long2ip(0x7FFFFFFF), '127.255.255.255';
is long2ip(0x80000000), '128.0.0.0';
is long2ip(0xFFFFFFFF), '255.255.255.255';
is long2ip(0xDEADBEEF), '222.173.190.239';
is long2ip(ip2long('127.255.255.255') + 1), '128.0.0.0';
#
is ip2long(undef), undef;
is ip2long(0), undef;
is ip2long(''), undef;
is ip2long('x'), undef;
is ip2long('0.0.0'), undef;
is ip2long('0.0.0.x'), undef;
is ip2long('0.0.0.0.0'), undef;
is ip2long('255.255.255.256'), undef;
is ip2long('256.255.255.255'), undef;
is long2ip(undef), undef;
is long2ip('0'), '0.0.0.0';
is long2ip(ip2long('0.0.0.0') - 1), '255.255.255.255';
is long2ip(ip2long('255.255.255.255') + 1), undef;



#
done_testing;

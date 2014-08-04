#!perl

use strict;
use warnings;
use errors;
use Test::More tests => 22;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saclient::Util qw(get_by_path set_by_path exists_path);
use Saclient::Cloud::API;
use Saclient::Errors::SaclientException;
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
	Saclient::Cloud::API::authorize('abc');
}
catch Saclient::Errors::SaclientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'argument_count_mismatch';
	$ok = 1;
};
ok $ok, '引数の数が足りない時は SaclientException がスローされなければなりません';

#
$ok = 0;
try {
	Saclient::Cloud::API::authorize('abc', []);
}
catch Saclient::Errors::SaclientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'argument_type_mismatch';
	$ok = 1;
};
ok $ok, '引数の型が異なる時は SaclientException がスローされなければなりません';



done_testing;

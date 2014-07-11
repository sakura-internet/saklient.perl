#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use lib "$FindBin::RealBin/../lib";

use_ok $_ for qw(
    Saclient::Cloud::API
);

done_testing;


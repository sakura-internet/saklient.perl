#!/usr/bin/perl

package Saclient::Cloud::Enums::EScope;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

=pod

=encoding utf8

=cut
our $_map = {
	"user" => 100,
	"shared" => 200
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"user"} = "user";
	$self->{"shared"} = "shared";
	return $self;
};


sub user { "user"; }

sub shared { "shared"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Enums::EScope';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

#!/usr/bin/perl

package Saclient::Cloud::Enums::EServerInstanceStatus;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

=pod

=encoding utf8

=cut
our $_map = {
	"down" => 0,
	"cleaning" => 5,
	"starting" => 10,
	"alive" => 49,
	"suspended" => 70,
	"running" => 80,
	"active" => 89,
	"migrating" => 90,
	"up" => 100
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"down"} = "down";
	$self->{"cleaning"} = "cleaning";
	$self->{"starting"} = "starting";
	$self->{"alive"} = "alive";
	$self->{"suspended"} = "suspended";
	$self->{"running"} = "running";
	$self->{"active"} = "active";
	$self->{"migrating"} = "migrating";
	$self->{"up"} = "up";
	return $self;
};


sub down { "down"; }

sub cleaning { "cleaning"; }

sub starting { "starting"; }

sub alive { "alive"; }

sub suspended { "suspended"; }

sub running { "running"; }

sub active { "active"; }

sub migrating { "migrating"; }

sub up { "up"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Enums::EServerInstanceStatus';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

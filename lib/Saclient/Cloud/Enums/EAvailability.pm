#!/usr/bin/perl

package Saclient::Cloud::Enums::EAvailability;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

=pod

=encoding utf8

=cut
our $_map = {
	"unavailable" => 0,
	"creating" => 10,
	"prepared" => 20,
	"discontinued" => 30,
	"visible" => 49,
	"abnormal" => 50,
	"recoverable" => 59,
	"disabled" => 60,
	"selectable" => 69,
	"migrating" => 70,
	"precreate" => 71,
	"replicating" => 72,
	"transfering" => 73,
	"stopped" => 75,
	"failed" => 78,
	"charged" => 79,
	"uploading" => 80,
	"available" => 100
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"unavailable"} = "unavailable";
	$self->{"creating"} = "creating";
	$self->{"prepared"} = "prepared";
	$self->{"discontinued"} = "discontinued";
	$self->{"visible"} = "visible";
	$self->{"abnormal"} = "abnormal";
	$self->{"recoverable"} = "recoverable";
	$self->{"disabled"} = "disabled";
	$self->{"selectable"} = "selectable";
	$self->{"migrating"} = "migrating";
	$self->{"precreate"} = "precreate";
	$self->{"replicating"} = "replicating";
	$self->{"transfering"} = "transfering";
	$self->{"stopped"} = "stopped";
	$self->{"failed"} = "failed";
	$self->{"charged"} = "charged";
	$self->{"uploading"} = "uploading";
	$self->{"available"} = "available";
	return $self;
};


sub unavailable { "unavailable"; }

sub creating { "creating"; }

sub prepared { "prepared"; }

sub discontinued { "discontinued"; }

sub visible { "visible"; }

sub abnormal { "abnormal"; }

sub recoverable { "recoverable"; }

sub disabled { "disabled"; }

sub selectable { "selectable"; }

sub migrating { "migrating"; }

sub precreate { "precreate"; }

sub replicating { "replicating"; }

sub transfering { "transfering"; }

sub stopped { "stopped"; }

sub failed { "failed"; }

sub charged { "charged"; }

sub uploading { "uploading"; }

sub available { "available"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Enums::EAvailability';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

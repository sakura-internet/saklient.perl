#!/usr/bin/perl

package Saklient::Cloud::Enums::EAvailability;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

=pod

=encoding utf8

=head1 Saklient::Cloud::Enums::EAvailability

リソースの有効性を表す列挙子。

=cut

our $_map = {
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
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EAvailability';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

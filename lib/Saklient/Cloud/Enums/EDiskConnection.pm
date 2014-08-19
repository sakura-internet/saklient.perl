#!/usr/bin/perl

package Saklient::Cloud::Enums::EDiskConnection;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

=pod

=encoding utf8

=head1 Saklient::Cloud::Enums::EDiskConnection

ディスクの接続方式を表す列挙子。

=cut

our $_map = {
	"ide" => 100,
	"virtio" => 300
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"ide"} = "ide";
	$self->{"virtio"} = "virtio";
	return $self;
};


sub ide { "ide"; }

sub virtio { "virtio"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EDiskConnection';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

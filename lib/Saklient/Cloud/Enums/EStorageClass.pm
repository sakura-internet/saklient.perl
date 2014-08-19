#!/usr/bin/perl

package Saklient::Cloud::Enums::EStorageClass;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

=pod

=encoding utf8

=head1 Saklient::Cloud::Enums::EStorageClass

ストレージのクラスを表す列挙子。

=cut

our $_map = {
	"iscsi1204" => 110
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"iscsi1204"} = "iscsi1204";
	return $self;
};


sub iscsi1204 { "iscsi1204"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EStorageClass';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

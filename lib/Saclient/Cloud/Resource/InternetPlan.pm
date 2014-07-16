#!/usr/bin/perl

package Saclient::Cloud::Resource::InternetPlan;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::InternetPlan

ルータのプラン情報へのアクセス機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_band_width_mbps;

my $m_service_class;

sub _id {
	my $self = shift;
	return $self->get_id();
}

sub new {
	my $class = shift;
	my $self;
	my $client = shift;
	my $r = shift;
	$self = $class->SUPER::new($client);
	$self->api_deserialize($r);
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	return $self->{'m_id'};
}

sub id {
	return $_[0]->get_id();
}

my $n_name = 0;

sub get_name {
	my $self = shift;
	return $self->{'m_name'};
}

sub name {
	return $_[0]->get_name();
}

my $n_band_width_mbps = 0;

sub get_band_width_mbps {
	my $self = shift;
	return $self->{'m_band_width_mbps'};
}

sub band_width_mbps {
	return $_[0]->get_band_width_mbps();
}

my $n_service_class = 0;

sub get_service_class {
	my $self = shift;
	return $self->{'m_service_class'};
}

sub service_class {
	return $_[0]->get_service_class();
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"ID"})) {
		$self->{'m_id'} = !defined($r->{"ID"}) ? undef : "" . $r->{"ID"};
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"Name"})) {
		$self->{'m_name'} = !defined($r->{"Name"}) ? undef : "" . $r->{"Name"};
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"BandWidthMbps"})) {
		$self->{'m_band_width_mbps'} = !defined($r->{"BandWidthMbps"}) ? undef : (0+("" . $r->{"BandWidthMbps"}));
	}
	else {
		$self->{'m_band_width_mbps'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_band_width_mbps'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"ServiceClass"})) {
		$self->{'m_service_class'} = !defined($r->{"ServiceClass"}) ? undef : "" . $r->{"ServiceClass"};
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_name'}) {
		$ret->{"Name"} = $self->{'m_name'};
	}
	if ($withClean || $self->{'n_band_width_mbps'}) {
		$ret->{"BandWidthMbps"} = $self->{'m_band_width_mbps'};
	}
	if ($withClean || $self->{'n_service_class'}) {
		$ret->{"ServiceClass"} = $self->{'m_service_class'};
	}
	return $ret;
}

1;

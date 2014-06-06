#!/usr/bin/perl

package Saclient::Cloud::Resource::ServerPlan;

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

=head1 Saclient::Cloud::Resource::ServerPlan

サーバのプラン情報へのアクセス機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_cpu;

my $m_memory_mib;

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

sub get_memory_gib {
	my $self = shift;
	return $self->get_memory_mib() >> 10;
}

sub memory_gib {
	return $_[0]->get_memory_gib();
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

my $n_cpu = 0;

sub get_cpu {
	my $self = shift;
	return $self->{'m_cpu'};
}

sub cpu {
	return $_[0]->get_cpu();
}

my $n_memory_mib = 0;

sub get_memory_mib {
	my $self = shift;
	return $self->{'m_memory_mib'};
}

sub memory_mib {
	return $_[0]->get_memory_mib();
}

my $n_service_class = 0;

sub get_service_class {
	my $self = shift;
	return $self->{'m_service_class'};
}

sub service_class {
	return $_[0]->get_service_class();
}

=head2 api_deserialize

(This method is generated in Translator_default#buildImpl)

=cut
sub api_deserialize {
	my $self = shift;
	my $r = shift;
	$self->{'is_incomplete'} = 1;
	if ((ref($r) eq 'HASH' && exists $r->{"ID"})) {
		$self->{'m_id'} = !defined($r->{"ID"}) ? undef : "" . $r->{"ID"};
		$self->{'n_id'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"Name"})) {
		$self->{'m_name'} = !defined($r->{"Name"}) ? undef : "" . $r->{"Name"};
		$self->{'n_name'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"CPU"})) {
		$self->{'m_cpu'} = !defined($r->{"CPU"}) ? undef : (0+("" . $r->{"CPU"}));
		$self->{'n_cpu'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"MemoryMB"})) {
		$self->{'m_memory_mib'} = !defined($r->{"MemoryMB"}) ? undef : (0+("" . $r->{"MemoryMB"}));
		$self->{'n_memory_mib'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"ServiceClass"})) {
		$self->{'m_service_class'} = !defined($r->{"ServiceClass"}) ? undef : "" . $r->{"ServiceClass"};
		$self->{'n_service_class'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
}

=head2 api_serialize

(This method is generated in Translator_default#buildImpl)

=cut
sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_name'}) {
		$ret->{"Name"} = $self->{'m_name'};
	}
	if ($withClean || $self->{'n_cpu'}) {
		$ret->{"CPU"} = $self->{'m_cpu'};
	}
	if ($withClean || $self->{'n_memory_mib'}) {
		$ret->{"MemoryMB"} = $self->{'m_memory_mib'};
	}
	if ($withClean || $self->{'n_service_class'}) {
		$ret->{"ServiceClass"} = $self->{'m_service_class'};
	}
	return $ret;
}

1;

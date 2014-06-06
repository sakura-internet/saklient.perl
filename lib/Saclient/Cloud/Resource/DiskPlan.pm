#!/usr/bin/perl

package Saclient::Cloud::Resource::DiskPlan;

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

=head1 Saclient::Cloud::Resource::DiskPlan

ディスクのプラン情報へのアクセス機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_storage_class;

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

my $n_storage_class = 0;

sub get_storage_class {
	my $self = shift;
	return $self->{'m_storage_class'};
}

sub storage_class {
	return $_[0]->get_storage_class();
}

=head2 api_deserialize($r)

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
	if ((ref($r) eq 'HASH' && exists $r->{"StorageClass"})) {
		$self->{'m_storage_class'} = !defined($r->{"StorageClass"}) ? undef : "" . $r->{"StorageClass"};
		$self->{'n_storage_class'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
}

=head2 api_serialize(bool $withClean=0) : any

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
	if ($withClean || $self->{'n_storage_class'}) {
		$ret->{"StorageClass"} = $self->{'m_storage_class'};
	}
	return $ret;
}

1;

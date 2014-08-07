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
	my $_argnum = scalar @_;
	return $self->get_id();
}

sub new {
	my $class = shift;
	my $self;
	my $_argnum = scalar @_;
	my $client = shift;
	my $r = shift;
	$self = $class->SUPER::new($client);
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($client, "Saclient::Cloud::Client");
	$self->api_deserialize($r);
	return $self;
}

sub get_memory_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_memory_mib() >> 10;
}

sub memory_gib {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::ServerPlan#memory_gib");
		throw $ex;
	}
	return $_[0]->get_memory_gib();
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::ServerPlan#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

my $n_name = 0;

sub get_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_name'};
}

sub name {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::ServerPlan#name");
		throw $ex;
	}
	return $_[0]->get_name();
}

my $n_cpu = 0;

sub get_cpu {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_cpu'};
}

sub cpu {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::ServerPlan#cpu");
		throw $ex;
	}
	return $_[0]->get_cpu();
}

my $n_memory_mib = 0;

sub get_memory_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_memory_mib'};
}

sub memory_mib {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::ServerPlan#memory_mib");
		throw $ex;
	}
	return $_[0]->get_memory_mib();
}

my $n_service_class = 0;

sub get_service_class {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_service_class'};
}

sub service_class {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::ServerPlan#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
}

sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saclient::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saclient::Util::get_by_path($r, "ID")) ? undef : "" . Saclient::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saclient::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saclient::Util::get_by_path($r, "Name")) ? undef : "" . Saclient::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saclient::Util::exists_path($r, "CPU")) {
		$self->{'m_cpu'} = !defined(Saclient::Util::get_by_path($r, "CPU")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "CPU")));
	}
	else {
		$self->{'m_cpu'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_cpu'} = 0;
	if (Saclient::Util::exists_path($r, "MemoryMB")) {
		$self->{'m_memory_mib'} = !defined(Saclient::Util::get_by_path($r, "MemoryMB")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "MemoryMB")));
	}
	else {
		$self->{'m_memory_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_memory_mib'} = 0;
	if (Saclient::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saclient::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saclient::Util::get_by_path($r, "ServiceClass");
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saclient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saclient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	if ($withClean || $self->{'n_cpu'}) {
		Saclient::Util::set_by_path($ret, "CPU", $self->{'m_cpu'});
	}
	if ($withClean || $self->{'n_memory_mib'}) {
		Saclient::Util::set_by_path($ret, "MemoryMB", $self->{'m_memory_mib'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saclient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	return $ret;
}

1;

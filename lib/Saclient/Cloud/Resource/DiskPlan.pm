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

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/product/disk";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "DiskPlan";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "DiskPlans";
}

sub class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "DiskPlan";
}

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
	my $obj = shift;
	my $wrapped = shift || (0);
	$self = $class->SUPER::new($client);
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($client, "Saclient::Cloud::Client");
	Saclient::Util::validate_type($wrapped, "bool");
	$self->api_deserialize($obj, $wrapped);
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::DiskPlan#id");
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::DiskPlan#name");
		throw $ex;
	}
	return $_[0]->get_name();
}

my $n_storage_class = 0;

sub get_storage_class {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_storage_class'};
}

sub storage_class {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::DiskPlan#storage_class");
		throw $ex;
	}
	return $_[0]->get_storage_class();
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
	if (Saclient::Util::exists_path($r, "StorageClass")) {
		$self->{'m_storage_class'} = !defined(Saclient::Util::get_by_path($r, "StorageClass")) ? undef : "" . Saclient::Util::get_by_path($r, "StorageClass");
	}
	else {
		$self->{'m_storage_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_storage_class'} = 0;
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
	if ($withClean || $self->{'n_storage_class'}) {
		Saclient::Util::set_by_path($ret, "StorageClass", $self->{'m_storage_class'});
	}
	return $ret;
}

1;

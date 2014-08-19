#!/usr/bin/perl

package Saklient::Cloud::Resource::DiskPlan;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Enums::EStorageClass;

use base qw(Saklient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::DiskPlan

ディスクプラン情報の1レコードに対応するクラス。

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

sub _class_name {
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
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	$self->api_deserialize($obj, $wrapped);
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

=head2 id

ID

=cut
sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::DiskPlan#id");
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

=head2 name

名前

=cut
sub name {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::DiskPlan#name");
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

=head2 storage_class

ストレージクラス {@link EStorageClass}

=cut
sub storage_class {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::DiskPlan#storage_class");
		throw $ex;
	}
	return $_[0]->get_storage_class();
}

sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saklient::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saklient::Util::get_by_path($r, "ID")) ? undef : "" . Saklient::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saklient::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saklient::Util::get_by_path($r, "Name")) ? undef : "" . Saklient::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saklient::Util::exists_path($r, "StorageClass")) {
		$self->{'m_storage_class'} = !defined(Saklient::Util::get_by_path($r, "StorageClass")) ? undef : "" . Saklient::Util::get_by_path($r, "StorageClass");
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
	Saklient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saklient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	if ($withClean || $self->{'n_storage_class'}) {
		Saklient::Util::set_by_path($ret, "StorageClass", $self->{'m_storage_class'});
	}
	return $ret;
}

1;

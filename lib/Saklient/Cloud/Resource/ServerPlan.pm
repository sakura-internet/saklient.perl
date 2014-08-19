#!/usr/bin/perl

package Saklient::Cloud::Resource::ServerPlan;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;

use base qw(Saklient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::ServerPlan

サーバプラン情報の1レコードに対応するクラス。

=cut


my $m_id;

my $m_name;

my $m_cpu;

my $m_memory_mib;

my $m_service_class;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/product/server";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlan";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlans";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlan";
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

sub get_memory_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_memory_mib() >> 10;
}

sub memory_gib {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerPlan#memory_gib");
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

=head2 id

ID

=cut
sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerPlan#id");
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerPlan#name");
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

=head2 cpu

仮想コア数

=cut
sub cpu {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerPlan#cpu");
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

=head2 memory_mib

メモリ容量[MiB]

=cut
sub memory_mib {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerPlan#memory_mib");
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

=head2 service_class

サービスクラス

=cut
sub service_class {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerPlan#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
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
	if (Saklient::Util::exists_path($r, "CPU")) {
		$self->{'m_cpu'} = !defined(Saklient::Util::get_by_path($r, "CPU")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "CPU")));
	}
	else {
		$self->{'m_cpu'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_cpu'} = 0;
	if (Saklient::Util::exists_path($r, "MemoryMB")) {
		$self->{'m_memory_mib'} = !defined(Saklient::Util::get_by_path($r, "MemoryMB")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "MemoryMB")));
	}
	else {
		$self->{'m_memory_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_memory_mib'} = 0;
	if (Saklient::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saklient::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saklient::Util::get_by_path($r, "ServiceClass");
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
	Saklient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saklient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	if ($withClean || $self->{'n_cpu'}) {
		Saklient::Util::set_by_path($ret, "CPU", $self->{'m_cpu'});
	}
	if ($withClean || $self->{'n_memory_mib'}) {
		Saklient::Util::set_by_path($ret, "MemoryMB", $self->{'m_memory_mib'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saklient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	return $ret;
}

1;

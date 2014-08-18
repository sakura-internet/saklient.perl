#!/usr/bin/perl

package Saclient::Cloud::Resource::Iface;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Errors::SaclientException;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Iface

インタフェースのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_mac_address;

my $m_ip_address;

my $m_user_ip_address;

my $m_server_id;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/interface";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Interface";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Interfaces";
}

sub class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Iface";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Iface

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Iface

最新のリソース情報を再取得します。

@return this

=cut
sub reload {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reload();
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

=head2 connect_to_shared_segment : Saclient::Cloud::Resource::Iface

共有セグメントに接続します。

=cut
sub connect_to_shared_segment {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/to/switch/shared");
	return $self->reload();
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Iface#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

my $n_mac_address = 0;

sub get_mac_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_mac_address'};
}

sub mac_address {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Iface#mac_address");
		throw $ex;
	}
	return $_[0]->get_mac_address();
}

my $n_ip_address = 0;

sub get_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_ip_address'};
}

sub ip_address {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Iface#ip_address");
		throw $ex;
	}
	return $_[0]->get_ip_address();
}

my $n_user_ip_address = 0;

sub get_user_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_user_ip_address'};
}

sub set_user_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	$self->{'m_user_ip_address'} = $v;
	$self->{'n_user_ip_address'} = 1;
	return $self->{'m_user_ip_address'};
}

sub user_ip_address {
	if (1 < scalar(@_)) {
		$_[0]->set_user_ip_address($_[1]);
		return $_[0];
	}
	return $_[0]->get_user_ip_address();
}

my $n_server_id = 0;

sub get_server_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_server_id'};
}

sub set_server_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saclient::Errors::SaclientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saclient::Cloud::Resource::Iface#server_id"); throw $ex; };
	}
	$self->{'m_server_id'} = $v;
	$self->{'n_server_id'} = 1;
	return $self->{'m_server_id'};
}

=head2 server_id

サーバ

=cut
sub server_id {
	if (1 < scalar(@_)) {
		$_[0]->set_server_id($_[1]);
		return $_[0];
	}
	return $_[0]->get_server_id();
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
	if (Saclient::Util::exists_path($r, "MACAddress")) {
		$self->{'m_mac_address'} = !defined(Saclient::Util::get_by_path($r, "MACAddress")) ? undef : "" . Saclient::Util::get_by_path($r, "MACAddress");
	}
	else {
		$self->{'m_mac_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mac_address'} = 0;
	if (Saclient::Util::exists_path($r, "IPAddress")) {
		$self->{'m_ip_address'} = !defined(Saclient::Util::get_by_path($r, "IPAddress")) ? undef : "" . Saclient::Util::get_by_path($r, "IPAddress");
	}
	else {
		$self->{'m_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ip_address'} = 0;
	if (Saclient::Util::exists_path($r, "UserIPAddress")) {
		$self->{'m_user_ip_address'} = !defined(Saclient::Util::get_by_path($r, "UserIPAddress")) ? undef : "" . Saclient::Util::get_by_path($r, "UserIPAddress");
	}
	else {
		$self->{'m_user_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_ip_address'} = 0;
	if (Saclient::Util::exists_path($r, "Server.ID")) {
		$self->{'m_server_id'} = !defined(Saclient::Util::get_by_path($r, "Server.ID")) ? undef : "" . Saclient::Util::get_by_path($r, "Server.ID");
	}
	else {
		$self->{'m_server_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_server_id'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saclient::Util::validate_type($withClean, "bool");
	my $missing = [];
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_mac_address'}) {
		Saclient::Util::set_by_path($ret, "MACAddress", $self->{'m_mac_address'});
	}
	if ($withClean || $self->{'n_ip_address'}) {
		Saclient::Util::set_by_path($ret, "IPAddress", $self->{'m_ip_address'});
	}
	if ($withClean || $self->{'n_user_ip_address'}) {
		Saclient::Util::set_by_path($ret, "UserIPAddress", $self->{'m_user_ip_address'});
	}
	if ($withClean || $self->{'n_server_id'}) {
		Saclient::Util::set_by_path($ret, "Server.ID", $self->{'m_server_id'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "serverId");
		}
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saclient::Errors::SaclientException("required_field", "Required fields must be set before the Iface creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

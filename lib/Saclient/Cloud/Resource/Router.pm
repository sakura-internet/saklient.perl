#!/usr/bin/perl

package Saclient::Cloud::Resource::Router;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Errors::SaclientException;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::Swytch;
use Saclient::Cloud::Resource::Ipv4Net;
use Saclient::Cloud::Resource::Ipv6Net;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Router

ルータのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_description;

my $m_network_mask_len;

my $m_band_width_mbps;

my $m_swytch_id;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/internet";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Internet";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Internet";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Router

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Router

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

=head2 after_create(int $timeoutSec, (Saclient::Cloud::Resource::Router, bool) => void $callback) : void

作成中のルータが利用可能になるまで待機します。

=cut
sub after_create {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($timeoutSec, "int");
	Saclient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_while_creating($timeoutSec);
	$callback->($self, $ret);
}

=head2 sleep_while_creating(int $timeoutSec=120) : bool

作成中のルータが利用可能になるまで待機します。

=cut
sub sleep_while_creating {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (120);
	Saclient::Util::validate_type($timeoutSec, "int");
	my $step = 3;
	while (0 < $timeoutSec) {
		if ($self->exists()) {
			$self->reload();
			return 1;
		}
		$timeoutSec -= $step;
		if (0 < $timeoutSec) {
			sleep $step;
		}
	}
	return 0;
}

=head2 get_swytch : Saclient::Cloud::Resource::Swytch

このルータが接続されているスイッチを取得します。

=cut
sub get_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	my $model = Saclient::Util::create_class_instance("saclient.cloud.model.Model_Swytch", [$self->{'_client'}]);
	my $id = $self->get_swytch_id();
	return $model->get_by_id($id);
}

=head2 add_ipv6_net : Saclient::Cloud::Resource::Ipv6Net

このルータ＋スイッチでIPv6アドレスを有効にします。

=cut
sub add_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	my $result = $self->{'_client'}->request("POST", $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/ipv6net");
	$self->reload();
	return new Saclient::Cloud::Resource::Ipv6Net($self->{'_client'}, $result->{"IPv6Net"});
}

=head2 remove_ipv6_net(Saclient::Cloud::Resource::Ipv6Net $ipv6Net) : Saclient::Cloud::Resource::Router

このルータ＋スイッチでIPv6アドレスを無効にします。

=cut
sub remove_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ipv6Net = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($ipv6Net, "Saclient::Cloud::Resource::Ipv6Net");
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/ipv6net/" . $ipv6Net->_id());
	$self->reload();
	return $self;
}

=head2 add_static_route(int $maskLen, string $nextHop) : Saclient::Cloud::Resource::Ipv4Net

このルータ＋スイッチにスタティックルートを追加します。

=cut
sub add_static_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $maskLen = shift;
	my $nextHop = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($maskLen, "int");
	Saclient::Util::validate_type($nextHop, "string");
	my $q = {};
	Saclient::Util::set_by_path($q, "NetworkMaskLen", $maskLen);
	Saclient::Util::set_by_path($q, "NextHop", $nextHop);
	my $result = $self->{'_client'}->request("POST", $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/subnet", $q);
	$self->reload();
	return new Saclient::Cloud::Resource::Ipv4Net($self->{'_client'}, $result->{"Subnet"});
}

=head2 remove_static_route(Saclient::Cloud::Resource::Ipv4Net $ipv4Net) : Saclient::Cloud::Resource::Router

このルータ＋スイッチからスタティックルートを削除します。

=cut
sub remove_static_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ipv4Net = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($ipv4Net, "Saclient::Cloud::Resource::Ipv4Net");
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/subnet/" . $ipv4Net->_id());
	$self->reload();
	return $self;
}

=head2 change_plan(int $bandWidthMbps) : Saclient::Cloud::Resource::Router

このルータ＋スイッチの帯域プランを変更します。

=cut
sub change_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $bandWidthMbps = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($bandWidthMbps, "int");
	my $path = $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/bandwidth";
	my $q = {};
	Saclient::Util::set_by_path($q, "Internet.BandWidthMbps", $bandWidthMbps);
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->api_deserialize($result, 1);
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Router#id");
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

sub set_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	$self->{'m_name'} = $v;
	$self->{'n_name'} = 1;
	return $self->{'m_name'};
}

=head2 name

名前

=cut
sub name {
	if (1 < scalar(@_)) {
		$_[0]->set_name($_[1]);
		return $_[0];
	}
	return $_[0]->get_name();
}

my $n_description = 0;

sub get_description {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_description'};
}

sub set_description {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	$self->{'m_description'} = $v;
	$self->{'n_description'} = 1;
	return $self->{'m_description'};
}

=head2 description

説明

=cut
sub description {
	if (1 < scalar(@_)) {
		$_[0]->set_description($_[1]);
		return $_[0];
	}
	return $_[0]->get_description();
}

my $n_network_mask_len = 0;

sub get_network_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_network_mask_len'};
}

sub set_network_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saclient::Errors::SaclientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saclient::Cloud::Resource::Router#network_mask_len"); throw $ex; };
	}
	$self->{'m_network_mask_len'} = $v;
	$self->{'n_network_mask_len'} = 1;
	return $self->{'m_network_mask_len'};
}

=head2 network_mask_len

ネットワークのマスク長

=cut
sub network_mask_len {
	if (1 < scalar(@_)) {
		$_[0]->set_network_mask_len($_[1]);
		return $_[0];
	}
	return $_[0]->get_network_mask_len();
}

my $n_band_width_mbps = 0;

sub get_band_width_mbps {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_band_width_mbps'};
}

sub set_band_width_mbps {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saclient::Errors::SaclientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saclient::Cloud::Resource::Router#band_width_mbps"); throw $ex; };
	}
	$self->{'m_band_width_mbps'} = $v;
	$self->{'n_band_width_mbps'} = 1;
	return $self->{'m_band_width_mbps'};
}

=head2 band_width_mbps

帯域幅

=cut
sub band_width_mbps {
	if (1 < scalar(@_)) {
		$_[0]->set_band_width_mbps($_[1]);
		return $_[0];
	}
	return $_[0]->get_band_width_mbps();
}

my $n_swytch_id = 0;

sub get_swytch_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_swytch_id'};
}

=head2 swytch_id

スイッチ

=cut
sub swytch_id {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Router#swytch_id");
		throw $ex;
	}
	return $_[0]->get_swytch_id();
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
	if (Saclient::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saclient::Util::get_by_path($r, "Description")) ? undef : "" . Saclient::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saclient::Util::exists_path($r, "NetworkMaskLen")) {
		$self->{'m_network_mask_len'} = !defined(Saclient::Util::get_by_path($r, "NetworkMaskLen")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "NetworkMaskLen")));
	}
	else {
		$self->{'m_network_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_network_mask_len'} = 0;
	if (Saclient::Util::exists_path($r, "BandWidthMbps")) {
		$self->{'m_band_width_mbps'} = !defined(Saclient::Util::get_by_path($r, "BandWidthMbps")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "BandWidthMbps")));
	}
	else {
		$self->{'m_band_width_mbps'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_band_width_mbps'} = 0;
	if (Saclient::Util::exists_path($r, "Switch.ID")) {
		$self->{'m_swytch_id'} = !defined(Saclient::Util::get_by_path($r, "Switch.ID")) ? undef : "" . Saclient::Util::get_by_path($r, "Switch.ID");
	}
	else {
		$self->{'m_swytch_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_swytch_id'} = 0;
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
	if ($withClean || $self->{'n_name'}) {
		Saclient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "name");
		}
	}
	if ($withClean || $self->{'n_description'}) {
		Saclient::Util::set_by_path($ret, "Description", $self->{'m_description'});
	}
	if ($withClean || $self->{'n_network_mask_len'}) {
		Saclient::Util::set_by_path($ret, "NetworkMaskLen", $self->{'m_network_mask_len'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "networkMaskLen");
		}
	}
	if ($withClean || $self->{'n_band_width_mbps'}) {
		Saclient::Util::set_by_path($ret, "BandWidthMbps", $self->{'m_band_width_mbps'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "bandWidthMbps");
		}
	}
	if ($withClean || $self->{'n_swytch_id'}) {
		Saclient::Util::set_by_path($ret, "Switch.ID", $self->{'m_swytch_id'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saclient::Errors::SaclientException("required_field", "Required fields must be set before the Router creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

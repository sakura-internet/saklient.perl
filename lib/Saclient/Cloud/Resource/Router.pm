#!/usr/bin/perl

package Saclient::Cloud::Resource::Router;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
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
	return "/internet";
}

sub _root_key {
	my $self = shift;
	return "Internet";
}

sub _root_key_m {
	my $self = shift;
	return "Internet";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Router

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Router

最新のリソース情報を再取得します。

@return this

=cut
sub reload {
	my $self = shift;
	return $self->_reload();
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

=head2 sleep_while_creating(int $timeoutSec=120) : bool

作成中のルータが利用可能になるまで待機します。

=cut
sub sleep_while_creating {
	my $self = shift;
	my $timeoutSec = shift || (120);
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
	my $model = Saclient::Cloud::Util::create_class_instance("saclient.cloud.model.Model_Swytch", [$self->{'_client'}]);
	my $id = $self->get_swytch_id();
	return $model->get_by_id($id);
}

=head2 add_ipv6_net : Saclient::Cloud::Resource::Ipv6Net

このルータ＋スイッチでIPv6アドレスを有効にします。

=cut
sub add_ipv6_net {
	my $self = shift;
	my $result = $self->{'_client'}->request("POST", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/ipv6net");
	$self->reload();
	return new Saclient::Cloud::Resource::Ipv6Net($self->{'_client'}, $result->{"IPv6Net"});
}

=head2 remove_ipv6_net(Saclient::Cloud::Resource::Ipv6Net $ipv6Net) : Saclient::Cloud::Resource::Router

このルータ＋スイッチでIPv6アドレスを無効にします。

=cut
sub remove_ipv6_net {
	my $self = shift;
	my $ipv6Net = shift;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/ipv6net/" . $ipv6Net->_id());
	$self->reload();
	return $self;
}

=head2 add_static_route(int $maskLen, string $nextHop) : Saclient::Cloud::Resource::Ipv4Net

このルータ＋スイッチにスタティックルートを追加します。

=cut
sub add_static_route {
	my $self = shift;
	my $maskLen = shift;
	my $nextHop = shift;
	my $q = {};
	Saclient::Cloud::Util::set_by_path($q, "NetworkMaskLen", $maskLen);
	Saclient::Cloud::Util::set_by_path($q, "NextHop", $nextHop);
	my $result = $self->{'_client'}->request("POST", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/subnet", $q);
	$self->reload();
	return new Saclient::Cloud::Resource::Ipv4Net($self->{'_client'}, $result->{"Subnet"});
}

=head2 remove_static_route(Saclient::Cloud::Resource::Ipv4Net $ipv4Net) : Saclient::Cloud::Resource::Router

このルータ＋スイッチからスタティックルートを削除します。

=cut
sub remove_static_route {
	my $self = shift;
	my $ipv4Net = shift;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/subnet/" . $ipv4Net->_id());
	$self->reload();
	return $self;
}

=head2 change_plan(int $bandWidthMbps) : Saclient::Cloud::Resource::Router

このルータ＋スイッチの帯域プランを変更します。

=cut
sub change_plan {
	my $self = shift;
	my $bandWidthMbps = shift;
	my $path = $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/bandwidth";
	my $q = {};
	Saclient::Cloud::Util::set_by_path($q, "Internet.BandWidthMbps", $bandWidthMbps);
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->api_deserialize($result->{$self->_root_key()});
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	return $self->{'m_id'};
}

=head2 id

ID

=cut
sub id {
	return $_[0]->get_id();
}

my $n_name = 0;

sub get_name {
	my $self = shift;
	return $self->{'m_name'};
}

sub set_name {
	my $self = shift;
	my $v = shift;
	$self->{'m_name'} = $v;
	$self->{'n_name'} = 1;
	return $self->{'m_name'};
}

=head2 name

名前

=cut
sub name {
	if (1 < scalar(@_)) { $_[0]->set_name($_[1]); return $_[0]; }
	return $_[0]->get_name();
}

my $n_description = 0;

sub get_description {
	my $self = shift;
	return $self->{'m_description'};
}

sub set_description {
	my $self = shift;
	my $v = shift;
	$self->{'m_description'} = $v;
	$self->{'n_description'} = 1;
	return $self->{'m_description'};
}

=head2 description

説明

=cut
sub description {
	if (1 < scalar(@_)) { $_[0]->set_description($_[1]); return $_[0]; }
	return $_[0]->get_description();
}

my $n_network_mask_len = 0;

sub get_network_mask_len {
	my $self = shift;
	return $self->{'m_network_mask_len'};
}

sub set_network_mask_len {
	my $self = shift;
	my $v = shift;
	$self->{'m_network_mask_len'} = $v;
	$self->{'n_network_mask_len'} = 1;
	return $self->{'m_network_mask_len'};
}

=head2 network_mask_len

ネットワークのマスク長

=cut
sub network_mask_len {
	if (1 < scalar(@_)) { $_[0]->set_network_mask_len($_[1]); return $_[0]; }
	return $_[0]->get_network_mask_len();
}

my $n_band_width_mbps = 0;

sub get_band_width_mbps {
	my $self = shift;
	return $self->{'m_band_width_mbps'};
}

sub set_band_width_mbps {
	my $self = shift;
	my $v = shift;
	$self->{'m_band_width_mbps'} = $v;
	$self->{'n_band_width_mbps'} = 1;
	return $self->{'m_band_width_mbps'};
}

=head2 band_width_mbps

帯域幅

=cut
sub band_width_mbps {
	if (1 < scalar(@_)) { $_[0]->set_band_width_mbps($_[1]); return $_[0]; }
	return $_[0]->get_band_width_mbps();
}

my $n_swytch_id = 0;

sub get_swytch_id {
	my $self = shift;
	return $self->{'m_swytch_id'};
}

=head2 swytch_id

スイッチ

=cut
sub swytch_id {
	return $_[0]->get_swytch_id();
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saclient::Cloud::Util::get_by_path($r, "ID")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Name")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Description")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "NetworkMaskLen")) {
		$self->{'m_network_mask_len'} = !defined(Saclient::Cloud::Util::get_by_path($r, "NetworkMaskLen")) ? undef : (0+("" . Saclient::Cloud::Util::get_by_path($r, "NetworkMaskLen")));
	}
	else {
		$self->{'m_network_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_network_mask_len'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "BandWidthMbps")) {
		$self->{'m_band_width_mbps'} = !defined(Saclient::Cloud::Util::get_by_path($r, "BandWidthMbps")) ? undef : (0+("" . Saclient::Cloud::Util::get_by_path($r, "BandWidthMbps")));
	}
	else {
		$self->{'m_band_width_mbps'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_band_width_mbps'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Switch.ID")) {
		$self->{'m_swytch_id'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Switch.ID")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Switch.ID");
	}
	else {
		$self->{'m_swytch_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_swytch_id'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Cloud::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saclient::Cloud::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	if ($withClean || $self->{'n_description'}) {
		Saclient::Cloud::Util::set_by_path($ret, "Description", $self->{'m_description'});
	}
	if ($withClean || $self->{'n_network_mask_len'}) {
		Saclient::Cloud::Util::set_by_path($ret, "NetworkMaskLen", $self->{'m_network_mask_len'});
	}
	if ($withClean || $self->{'n_band_width_mbps'}) {
		Saclient::Cloud::Util::set_by_path($ret, "BandWidthMbps", $self->{'m_band_width_mbps'});
	}
	if ($withClean || $self->{'n_swytch_id'}) {
		Saclient::Cloud::Util::set_by_path($ret, "Switch.ID", $self->{'m_swytch_id'});
	}
	return $ret;
}

1;

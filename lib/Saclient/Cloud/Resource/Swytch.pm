#!/usr/bin/perl

package Saclient::Cloud::Resource::Swytch;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::Router;
use Saclient::Cloud::Resource::Ipv4Net;
use Saclient::Cloud::Resource::Ipv6Net;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Swytch

スイッチのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_description;

my $m_user_default_route;

my $m_user_mask_len;

my $m_router;

my $m_ipv4_nets;

my $m_ipv6_nets;

sub _api_path {
	my $self = shift;
	return "/switch";
}

sub _root_key {
	my $self = shift;
	return "Switch";
}

sub _root_key_m {
	my $self = shift;
	return "Switches";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Swytch

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Swytch

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

=head2 add_ipv6_net : Saclient::Cloud::Resource::Ipv6Net

このルータ＋スイッチでIPv6アドレスを有効にします。

=cut
sub add_ipv6_net {
	my $self = shift;
	my $ret = $self->get_router()->add_ipv6_net();
	$self->reload();
	return $ret;
}

=head2 remove_ipv6_net : Saclient::Cloud::Resource::Swytch

このルータ＋スイッチでIPv6アドレスを無効にします。

=cut
sub remove_ipv6_net {
	my $self = shift;
	my $nets = $self->get_ipv6_nets();
	$self->get_router()->remove_ipv6_net($nets->[0]);
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
	my $ret = $self->get_router()->add_static_route($maskLen, $nextHop);
	$self->reload();
	return $ret;
}

=head2 remove_static_route(Saclient::Cloud::Resource::Ipv4Net $ipv4Net) : Saclient::Cloud::Resource::Swytch

このルータ＋スイッチからスタティックルートを削除します。

=cut
sub remove_static_route {
	my $self = shift;
	my $ipv4Net = shift;
	$self->get_router()->remove_static_route($ipv4Net);
	$self->reload();
	return $self;
}

=head2 change_plan(int $bandWidthMbps) : Saclient::Cloud::Resource::Swytch

このルータ＋スイッチの帯域プランを変更します。

=cut
sub change_plan {
	my $self = shift;
	my $bandWidthMbps = shift;
	$self->get_router()->change_plan($bandWidthMbps);
	$self->reload();
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

my $n_user_default_route = 0;

sub get_user_default_route {
	my $self = shift;
	return $self->{'m_user_default_route'};
}

=head2 user_default_route

ユーザ設定ネットワークのゲートウェイ

=cut
sub user_default_route {
	return $_[0]->get_user_default_route();
}

my $n_user_mask_len = 0;

sub get_user_mask_len {
	my $self = shift;
	return $self->{'m_user_mask_len'};
}

=head2 user_mask_len

ユーザ設定ネットワークのマスク長

=cut
sub user_mask_len {
	return $_[0]->get_user_mask_len();
}

my $n_router = 0;

sub get_router {
	my $self = shift;
	return $self->{'m_router'};
}

=head2 router

接続されているルータ

=cut
sub router {
	return $_[0]->get_router();
}

my $n_ipv4_nets = 0;

sub get_ipv4_nets {
	my $self = shift;
	return $self->{'m_ipv4_nets'};
}

=head2 ipv4_nets

IPv4ネットワーク

=cut
sub ipv4_nets {
	return $_[0]->get_ipv4_nets();
}

my $n_ipv6_nets = 0;

sub get_ipv6_nets {
	my $self = shift;
	return $self->{'m_ipv6_nets'};
}

=head2 ipv6_nets

IPv6ネットワーク

=cut
sub ipv6_nets {
	return $_[0]->get_ipv6_nets();
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
	if (Saclient::Cloud::Util::exists_path($r, "UserSubnet.DefaultRoute")) {
		$self->{'m_user_default_route'} = !defined(Saclient::Cloud::Util::get_by_path($r, "UserSubnet.DefaultRoute")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "UserSubnet.DefaultRoute");
	}
	else {
		$self->{'m_user_default_route'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_default_route'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "UserSubnet.NetworkMaskLen")) {
		$self->{'m_user_mask_len'} = !defined(Saclient::Cloud::Util::get_by_path($r, "UserSubnet.NetworkMaskLen")) ? undef : (0+("" . Saclient::Cloud::Util::get_by_path($r, "UserSubnet.NetworkMaskLen")));
	}
	else {
		$self->{'m_user_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_mask_len'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Internet")) {
		$self->{'m_router'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Internet")) ? undef : new Saclient::Cloud::Resource::Router($self->{'_client'}, Saclient::Cloud::Util::get_by_path($r, "Internet"));
	}
	else {
		$self->{'m_router'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_router'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Subnets")) {
		if (!defined(Saclient::Cloud::Util::get_by_path($r, "Subnets"))) {
			$self->{'m_ipv4_nets'} = [];
		}
		else {
			$self->{'m_ipv4_nets'} = [];
			foreach my $t (@{Saclient::Cloud::Util::get_by_path($r, "Subnets")}) {
				my $v1 = undef;
				$v1 = !defined($t) ? undef : new Saclient::Cloud::Resource::Ipv4Net($self->{'_client'}, $t);
				push(@{$self->{'m_ipv4_nets'}}, $v1);
			}
		}
	}
	else {
		$self->{'m_ipv4_nets'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ipv4_nets'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "IPv6Nets")) {
		if (!defined(Saclient::Cloud::Util::get_by_path($r, "IPv6Nets"))) {
			$self->{'m_ipv6_nets'} = [];
		}
		else {
			$self->{'m_ipv6_nets'} = [];
			foreach my $t (@{Saclient::Cloud::Util::get_by_path($r, "IPv6Nets")}) {
				my $v2 = undef;
				$v2 = !defined($t) ? undef : new Saclient::Cloud::Resource::Ipv6Net($self->{'_client'}, $t);
				push(@{$self->{'m_ipv6_nets'}}, $v2);
			}
		}
	}
	else {
		$self->{'m_ipv6_nets'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ipv6_nets'} = 0;
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
	if ($withClean || $self->{'n_user_default_route'}) {
		Saclient::Cloud::Util::set_by_path($ret, "UserSubnet.DefaultRoute", $self->{'m_user_default_route'});
	}
	if ($withClean || $self->{'n_user_mask_len'}) {
		Saclient::Cloud::Util::set_by_path($ret, "UserSubnet.NetworkMaskLen", $self->{'m_user_mask_len'});
	}
	if ($withClean || $self->{'n_router'}) {
		Saclient::Cloud::Util::set_by_path($ret, "Internet", $withClean ? (!defined($self->{'m_router'}) ? undef : $self->{'m_router'}->api_serialize($withClean)) : (!defined($self->{'m_router'}) ? {'ID' => "0"} : $self->{'m_router'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_ipv4_nets'}) {
		Saclient::Cloud::Util::set_by_path($ret, "Subnets", []);
		foreach my $r1 (@{$self->{'m_ipv4_nets'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r1) ? undef : $r1->api_serialize($withClean)) : (!defined($r1) ? {'ID' => "0"} : $r1->api_serialize_id());
			push(@{$ret->{"Subnets"}}, $v);
		}
	}
	if ($withClean || $self->{'n_ipv6_nets'}) {
		Saclient::Cloud::Util::set_by_path($ret, "IPv6Nets", []);
		foreach my $r2 (@{$self->{'m_ipv6_nets'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r2) ? undef : $r2->api_serialize($withClean)) : (!defined($r2) ? {'ID' => "0"} : $r2->api_serialize_id());
			push(@{$ret->{"IPv6Nets"}}, $v);
		}
	}
	return $ret;
}

1;

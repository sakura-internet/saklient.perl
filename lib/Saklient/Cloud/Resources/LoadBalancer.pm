#!/usr/bin/perl

package Saklient::Cloud::Resources::LoadBalancer;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Appliance;
use Saklient::Cloud::Resources::LbVirtualIp;
use Saklient::Cloud::Resources::Swytch;
use Saklient::Cloud::Resources::Ipv4Net;
use Saklient::Cloud::Enums::EApplianceClass;

use base qw(Saklient::Cloud::Resources::Appliance);

#** @class Saklient::Cloud::Resources::LoadBalancer
# 
# @brief ロードバランサの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private Saklient::Cloud::Resources::LbVirtualIp* Saklient::Cloud::Resources::LoadBalancer::$_virtual_ips 
# 
# @private
#*
my $_virtual_ips;

#** @method public Saklient::Cloud::Resources::LbVirtualIp[] get_virtual_ips 
# 
# @brief null
#*
sub get_virtual_ips {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_virtual_ips'};
}

#** @method public Saklient::Cloud::Resources::LbVirtualIp[] virtual_ips ()
# 
# @brief 仮想IPアドレス {@link LbVirtualIp} の配列
#*
sub virtual_ips {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LoadBalancer#virtual_ips");
		throw $ex;
	}
	return $_[0]->get_virtual_ips();
}

#** @method public string get_default_route 
# 
# @brief null
#*
sub get_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	return Saklient::Util::get_by_path($self->raw_annotation(), "Network.DefaultRoute");
}

#** @method public string set_default_route ($v)
# 
# @brief null@param {string} v
#*
sub set_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	Saklient::Util::set_by_path($self->raw_annotation(), "Network.DefaultRoute", $v);
	return $v;
}

#** @method public string default_route ()
# 
# @brief デフォルトルート
#*
sub default_route {
	if (1 < scalar(@_)) {
		$_[0]->set_default_route($_[1]);
		return $_[0];
	}
	return $_[0]->get_default_route();
}

#** @method public int get_mask_len 
# 
# @brief null
#*
sub get_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	my $maskLen = Saklient::Util::get_by_path($self->raw_annotation(), "Network.NetworkMaskLen");
	if (!defined($maskLen)) {
		{ my $ex = new Saklient::Errors::SaklientException("invalid_data", "Data of the resource is invalid"); throw $ex; };
	}
	return (0+($maskLen));
}

#** @method public int set_mask_len ($v)
# 
# @brief null@param {int} v
#*
sub set_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	Saklient::Util::set_by_path($self->raw_annotation(), "Network.NetworkMaskLen", $v);
	return $v;
}

#** @method public int mask_len ()
# 
# @brief マスク長
#*
sub mask_len {
	if (1 < scalar(@_)) {
		$_[0]->set_mask_len($_[1]);
		return $_[0];
	}
	return $_[0]->get_mask_len();
}

#** @method public int get_vrid 
# 
# @brief null
#*
sub get_vrid {
	my $self = shift;
	my $_argnum = scalar @_;
	my $vrid = Saklient::Util::get_by_path($self->raw_annotation(), "VRRP.VRID");
	if (!defined($vrid)) {
		{ my $ex = new Saklient::Errors::SaklientException("invalid_data", "Data of the resource is invalid"); throw $ex; };
	}
	return (0+($vrid));
}

#** @method public int set_vrid ($v)
# 
# @brief null@param {int} v
#*
sub set_vrid {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	Saklient::Util::set_by_path($self->raw_annotation(), "VRRP.VRID", $v);
	return $v;
}

#** @method public int vrid ()
# 
# @brief VRID
#*
sub vrid {
	if (1 < scalar(@_)) {
		$_[0]->set_vrid($_[1]);
		return $_[0];
	}
	return $_[0]->get_vrid();
}

#** @method public void new ($client, $obj, $wrapped)
# 
# @ignore @param {Saklient::Cloud::Client} client
# @param bool $wrapped
#*
sub new {
	my $class = shift;
	my $self;
	my $_argnum = scalar @_;
	my $client = shift;
	my $obj = shift;
	my $wrapped = shift || (0);
	$self = $class->SUPER::new($client, $obj, $wrapped);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	if (!defined($self->raw_annotation())) {
		$self->raw_annotation({});
	}
	return $self;
}

#** @method private void _on_after_api_deserialize ($r, $root)
# 
# @private
#*
sub _on_after_api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $root = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	if (!defined($self->raw_annotation())) {
		$self->raw_annotation({});
	}
	$self->{'_virtual_ips'} = [];
	my $settings = $self->raw_settings();
	if (defined($settings)) {
		my $lb = $settings->{"LoadBalancer"};
		if (!defined($lb)) {
			$lb = [];
		}
		my $vips = $lb;
		foreach my $vip (@{$vips}) {
			push(@{$self->{'_virtual_ips'}}, new Saklient::Cloud::Resources::LbVirtualIp($vip));
		}
	}
}

#** @method private void _on_before_api_serialize ($withClean)
# 
# @private@param {bool} withClean
#*
sub _on_before_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($withClean, "bool");
	my $lb = [];
	foreach my $vip (@{$self->{'_virtual_ips'}}) {
		push(@{$lb}, $vip->to_raw_settings());
	}
	if (!defined($self->raw_settings())) {
		$self->raw_settings({});
	}
	$self->raw_settings()->{"LoadBalancer"} = $lb;
	if ($self->{'is_new'}) {
		$self->clazz(Saklient::Cloud::Enums::EApplianceClass::loadbalancer);
	}
}

#** @method public Saklient::Cloud::Resources::LoadBalancer set_initial_params ($swytch, $vrid, @$realIps, $isHighSpec)
# 
# @ignore
# @param Swytch $swytch
# @param int $vrid
# @param string* $realIps
# @param bool $isHighSpec
#*
sub set_initial_params {
	my $self = shift;
	my $_argnum = scalar @_;
	my $swytch = shift;
	my $vrid = shift;
	my $realIps = shift;
	my $isHighSpec = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 3);
	Saklient::Util::validate_type($swytch, "Saklient::Cloud::Resources::Swytch");
	Saklient::Util::validate_type($vrid, "int");
	Saklient::Util::validate_type($realIps, "ARRAY");
	Saklient::Util::validate_type($isHighSpec, "bool");
	my $annot = $self->raw_annotation();
	$self->vrid($vrid);
	Saklient::Util::set_by_path($annot, "Switch.ID", $swytch->_id());
	if (defined($swytch->{'ipv4_nets'}) && 0 < scalar(@{$swytch->{'ipv4_nets'}})) {
		my $net = $swytch->{'ipv4_nets'}->[0];
		$self->default_route($net->default_route);
		$self->mask_len($net->mask_len);
	}
	else {
		$self->default_route($swytch->user_default_route);
		$self->mask_len($swytch->user_mask_len);
	}
	my $servers = [];
	foreach my $ip (@{$realIps}) {
		push(@{$servers}, {'IPAddress' => $ip});
	}
	Saklient::Util::set_by_path($annot, "Servers", $servers);
	$self->plan_id($isHighSpec ? 2 : 1);
	return $self;
}

#** @method public Saklient::Cloud::Resources::LoadBalancer clear_virtual_ips 
# 
# @brief null
#*
sub clear_virtual_ips {
	my $self = shift;
	my $_argnum = scalar @_;
	while (0 < scalar(@{$self->{'_virtual_ips'}})) {
		pop(@{$self->{'_virtual_ips'}});
	}
	return $self;
}

#** @method public Saklient::Cloud::Resources::LbVirtualIp add_virtual_ip ($settings)
# 
# @brief 仮想IPアドレス設定を追加します。
# 
# @param $settings 設定オブジェクト
#*
sub add_virtual_ip {
	my $self = shift;
	my $_argnum = scalar @_;
	my $settings = shift || (undef);
	my $ret = new Saklient::Cloud::Resources::LbVirtualIp($settings);
	push(@{$self->{'_virtual_ips'}}, $ret);
	return $ret;
}

#** @method public Saklient::Cloud::Resources::LbVirtualIp get_virtual_ip_by_address ($address)
# 
# @brief 指定したIPアドレスにマッチする仮想IPアドレス設定を取得します。
# 
# @param string $address
#*
sub get_virtual_ip_by_address {
	my $self = shift;
	my $_argnum = scalar @_;
	my $address = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($address, "string");
	foreach my $vip (@{$self->{'_virtual_ips'}}) {
		if ($vip->virtual_ip_address eq $address) {
			return $vip;
		}
	}
	return undef;
}

#** @method public Saklient::Cloud::Resources::LoadBalancer reload_status 
# 
# @brief 監視対象サーバのステータスを最新の状態に更新します。
#*
sub reload_status {
	my $self = shift;
	my $_argnum = scalar @_;
	my $result = $self->request_retry("GET", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/status");
	if ((ref($result) eq 'HASH' && exists $result->{"LoadBalancer"})) {
		my $vips = $result->{"LoadBalancer"};
		foreach my $vipDyn (@{$vips}) {
			my $vipStr = $vipDyn->{"VirtualIPAddress"};
			my $vip = $self->get_virtual_ip_by_address($vipStr);
			if (!defined($vip)) {
				next;
			}
			$vip->update_status($vipDyn->{"Servers"});
		}
	}
	return $self;
}

1;

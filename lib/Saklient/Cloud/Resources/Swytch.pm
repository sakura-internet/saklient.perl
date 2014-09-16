#!/usr/bin/perl

package Saklient::Cloud::Resources::Swytch;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Icon;
use Saklient::Cloud::Resources::Router;
use Saklient::Cloud::Resources::Ipv4Net;
use Saklient::Cloud::Resources::Ipv6Net;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Swytch
# 
# @brief スイッチの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Swytch::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Swytch::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::Swytch::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string Saklient::Cloud::Resources::Swytch::$m_user_default_route 
# 
# @brief ユーザ設定IPv4ネットワークのゲートウェイ
#*
my $m_user_default_route;

#** @var private int Saklient::Cloud::Resources::Swytch::$m_user_mask_len 
# 
# @brief ユーザ設定IPv4ネットワークのマスク長
#*
my $m_user_mask_len;

#** @var private Router Saklient::Cloud::Resources::Swytch::$m_router 
# 
# @brief 接続されているルータ
#*
my $m_router;

#** @var private Saklient::Cloud::Resources::Ipv4Net* Saklient::Cloud::Resources::Swytch::$m_ipv4_nets 
# 
# @brief IPv4ネットワーク（ルータによる自動割当）
#*
my $m_ipv4_nets;

#** @var private Saklient::Cloud::Resources::Ipv6Net* Saklient::Cloud::Resources::Swytch::$m_ipv6_nets 
# 
# @brief IPv6ネットワーク（ルータによる自動割当）
#*
my $m_ipv6_nets;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/switch";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Switch";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Switches";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Swytch";
}

#** @method public string _id 
# 
# @private
#*
sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

#** @method public Saklient::Cloud::Resources::Swytch save 
# 
# @brief このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新規作成または上書き保存します。
# 
# @retval this
#*
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

#** @method public Saklient::Cloud::Resources::Swytch reload 
# 
# @brief 最新のリソース情報を再取得します。
# 
# @retval this
#*
sub reload {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reload();
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
	$self = $class->SUPER::new($client);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	$self->api_deserialize($obj, $wrapped);
	return $self;
}

#** @method public Saklient::Cloud::Resources::Ipv6Net add_ipv6_net 
# 
# @brief このルータ＋スイッチでIPv6アドレスを有効にします。
# 
# @retval 有効化されたIPv6ネットワーク
#*
sub add_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ret = $self->get_router()->add_ipv6_net();
	$self->reload();
	return $ret;
}

#** @method public Saklient::Cloud::Resources::Swytch remove_ipv6_net 
# 
# @brief このルータ＋スイッチでIPv6アドレスを無効にします。
# 
# @retval this
#*
sub remove_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	my $nets = $self->get_ipv6_nets();
	$self->get_router()->remove_ipv6_net($nets->[0]);
	$self->reload();
	return $self;
}

#** @method public Saklient::Cloud::Resources::Ipv4Net add_static_route ($maskLen, $nextHop)
# 
# @brief このルータ＋スイッチにスタティックルートを追加します。
# 
# @param int $maskLen
# @param string $nextHop
# @retval 追加されたIPv4ネットワーク
#*
sub add_static_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $maskLen = shift;
	my $nextHop = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($maskLen, "int");
	Saklient::Util::validate_type($nextHop, "string");
	my $ret = $self->get_router()->add_static_route($maskLen, $nextHop);
	$self->reload();
	return $ret;
}

#** @method public Saklient::Cloud::Resources::Swytch remove_static_route ($ipv4Net)
# 
# @brief このルータ＋スイッチからスタティックルートを削除します。
# 
# @param Ipv4Net $ipv4Net
# @retval this
#*
sub remove_static_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ipv4Net = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($ipv4Net, "Saklient::Cloud::Resources::Ipv4Net");
	$self->get_router()->remove_static_route($ipv4Net);
	$self->reload();
	return $self;
}

#** @method public Saklient::Cloud::Resources::Swytch change_plan ($bandWidthMbps)
# 
# @brief このルータ＋スイッチの帯域プランを変更します。
# 
# @param int $bandWidthMbps
# @retval this
#*
sub change_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $bandWidthMbps = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($bandWidthMbps, "int");
	$self->get_router()->change_plan($bandWidthMbps);
	$self->reload();
	return $self;
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_id 
# 
# @brief null
#*
my $n_id = 0;

#** @method private string get_id 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

#** @method public string id ()
# 
# @brief ID
#*
sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_name 
# 
# @brief null
#*
my $n_name = 0;

#** @method private string get_name 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_name'};
}

#** @method private string set_name ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_name'} = $v;
	$self->{'n_name'} = 1;
	return $self->{'m_name'};
}

#** @method public string name ()
# 
# @brief 名前
#*
sub name {
	if (1 < scalar(@_)) {
		$_[0]->set_name($_[1]);
		return $_[0];
	}
	return $_[0]->get_name();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_description 
# 
# @brief null
#*
my $n_description = 0;

#** @method private string get_description 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_description {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_description'};
}

#** @method private string set_description ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_description {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_description'} = $v;
	$self->{'n_description'} = 1;
	return $self->{'m_description'};
}

#** @method public string description ()
# 
# @brief 説明
#*
sub description {
	if (1 < scalar(@_)) {
		$_[0]->set_description($_[1]);
		return $_[0];
	}
	return $_[0]->get_description();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_user_default_route 
# 
# @brief null
#*
my $n_user_default_route = 0;

#** @method private string get_user_default_route 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_user_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_user_default_route'};
}

#** @method public string user_default_route ()
# 
# @brief ユーザ設定IPv4ネットワークのゲートウェイ
#*
sub user_default_route {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#user_default_route");
		throw $ex;
	}
	return $_[0]->get_user_default_route();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_user_mask_len 
# 
# @brief null
#*
my $n_user_mask_len = 0;

#** @method private int get_user_mask_len 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_user_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_user_mask_len'};
}

#** @method public int user_mask_len ()
# 
# @brief ユーザ設定IPv4ネットワークのマスク長
#*
sub user_mask_len {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#user_mask_len");
		throw $ex;
	}
	return $_[0]->get_user_mask_len();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_router 
# 
# @brief null
#*
my $n_router = 0;

#** @method private Saklient::Cloud::Resources::Router get_router 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_router {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_router'};
}

#** @method public Saklient::Cloud::Resources::Router router ()
# 
# @brief 接続されているルータ
#*
sub router {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#router");
		throw $ex;
	}
	return $_[0]->get_router();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_ipv4_nets 
# 
# @brief null
#*
my $n_ipv4_nets = 0;

#** @method private Saklient::Cloud::Resources::Ipv4Net[] get_ipv4_nets 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_ipv4_nets {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_ipv4_nets'};
}

#** @method public Saklient::Cloud::Resources::Ipv4Net[] ipv4_nets ()
# 
# @brief IPv4ネットワーク（ルータによる自動割当）
#*
sub ipv4_nets {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#ipv4_nets");
		throw $ex;
	}
	return $_[0]->get_ipv4_nets();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_ipv6_nets 
# 
# @brief null
#*
my $n_ipv6_nets = 0;

#** @method private Saklient::Cloud::Resources::Ipv6Net[] get_ipv6_nets 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_ipv6_nets {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_ipv6_nets'};
}

#** @method public Saklient::Cloud::Resources::Ipv6Net[] ipv6_nets ()
# 
# @brief IPv6ネットワーク（ルータによる自動割当）
#*
sub ipv6_nets {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#ipv6_nets");
		throw $ex;
	}
	return $_[0]->get_ipv6_nets();
}

#** @method private void api_deserialize_impl ($r)
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
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
	if (Saklient::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saklient::Util::get_by_path($r, "Description")) ? undef : "" . Saklient::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saklient::Util::exists_path($r, "UserSubnet.DefaultRoute")) {
		$self->{'m_user_default_route'} = !defined(Saklient::Util::get_by_path($r, "UserSubnet.DefaultRoute")) ? undef : "" . Saklient::Util::get_by_path($r, "UserSubnet.DefaultRoute");
	}
	else {
		$self->{'m_user_default_route'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_default_route'} = 0;
	if (Saklient::Util::exists_path($r, "UserSubnet.NetworkMaskLen")) {
		$self->{'m_user_mask_len'} = !defined(Saklient::Util::get_by_path($r, "UserSubnet.NetworkMaskLen")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "UserSubnet.NetworkMaskLen")));
	}
	else {
		$self->{'m_user_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_mask_len'} = 0;
	if (Saklient::Util::exists_path($r, "Internet")) {
		$self->{'m_router'} = !defined(Saklient::Util::get_by_path($r, "Internet")) ? undef : new Saklient::Cloud::Resources::Router($self->{'_client'}, Saklient::Util::get_by_path($r, "Internet"));
	}
	else {
		$self->{'m_router'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_router'} = 0;
	if (Saklient::Util::exists_path($r, "Subnets")) {
		if (!defined(Saklient::Util::get_by_path($r, "Subnets"))) {
			$self->{'m_ipv4_nets'} = [];
		}
		else {
			$self->{'m_ipv4_nets'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Subnets")}) {
				my $v1 = undef;
				$v1 = !defined($t) ? undef : new Saklient::Cloud::Resources::Ipv4Net($self->{'_client'}, $t);
				push(@{$self->{'m_ipv4_nets'}}, $v1);
			}
		}
	}
	else {
		$self->{'m_ipv4_nets'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ipv4_nets'} = 0;
	if (Saklient::Util::exists_path($r, "IPv6Nets")) {
		if (!defined(Saklient::Util::get_by_path($r, "IPv6Nets"))) {
			$self->{'m_ipv6_nets'} = [];
		}
		else {
			$self->{'m_ipv6_nets'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "IPv6Nets")}) {
				my $v2 = undef;
				$v2 = !defined($t) ? undef : new Saklient::Cloud::Resources::Ipv6Net($self->{'_client'}, $t);
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

#** @method private any api_serialize_impl ($withClean)
# 
# @ignore@param {bool} withClean
#*
sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	my $missing = [];
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saklient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "name");
		}
	}
	if ($withClean || $self->{'n_description'}) {
		Saklient::Util::set_by_path($ret, "Description", $self->{'m_description'});
	}
	if ($withClean || $self->{'n_user_default_route'}) {
		Saklient::Util::set_by_path($ret, "UserSubnet.DefaultRoute", $self->{'m_user_default_route'});
	}
	if ($withClean || $self->{'n_user_mask_len'}) {
		Saklient::Util::set_by_path($ret, "UserSubnet.NetworkMaskLen", $self->{'m_user_mask_len'});
	}
	if ($withClean || $self->{'n_router'}) {
		Saklient::Util::set_by_path($ret, "Internet", $withClean ? (!defined($self->{'m_router'}) ? undef : $self->{'m_router'}->api_serialize($withClean)) : (!defined($self->{'m_router'}) ? {'ID' => "0"} : $self->{'m_router'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_ipv4_nets'}) {
		Saklient::Util::set_by_path($ret, "Subnets", []);
		foreach my $r1 (@{$self->{'m_ipv4_nets'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r1) ? undef : $r1->api_serialize($withClean)) : (!defined($r1) ? {'ID' => "0"} : $r1->api_serialize_id());
			push(@{$ret->{"Subnets"}}, $v);
		}
	}
	if ($withClean || $self->{'n_ipv6_nets'}) {
		Saklient::Util::set_by_path($ret, "IPv6Nets", []);
		foreach my $r2 (@{$self->{'m_ipv6_nets'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r2) ? undef : $r2->api_serialize($withClean)) : (!defined($r2) ? {'ID' => "0"} : $r2->api_serialize_id());
			push(@{$ret->{"IPv6Nets"}}, $v);
		}
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Swytch creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

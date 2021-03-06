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
use Saklient::Cloud::Resources::Bridge;

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

#** @var private string* Saklient::Cloud::Resources::Swytch::$m_tags 
# 
# @brief タグ文字列の配列
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resources::Swytch::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

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

#** @var private Bridge Saklient::Cloud::Resources::Swytch::$m_bridge 
# 
# @brief 接続されているブリッジ
#*
my $m_bridge;

#** @var private Saklient::Cloud::Resources::Ipv4Net* Saklient::Cloud::Resources::Swytch::$m_ipv4_nets 
# 
# @brief IPv4ネットワーク（ルータによる自動割当） {@link Ipv4Net} の配列
#*
my $m_ipv4_nets;

#** @var private Saklient::Cloud::Resources::Ipv6Net* Saklient::Cloud::Resources::Swytch::$m_ipv6_nets 
# 
# @brief IPv6ネットワーク（ルータによる自動割当） {@link Ipv6Net} の配列
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
# @param int $bandWidthMbps 帯域幅（api.product.router.find() から取得できる {@link RouterPlan} の bandWidthMbps を指定）。
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

#** @method public Saklient::Cloud::Resources::Swytch connect_to_bridge ($bridge)
# 
# @brief このルータ＋スイッチをブリッジに接続します。
# 
# @param $swytch 接続先のブリッジ。
# @param Bridge $bridge
# @retval this
#*
sub connect_to_bridge {
	my $self = shift;
	my $_argnum = scalar @_;
	my $bridge = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($bridge, "Saklient::Cloud::Resources::Bridge");
	my $result = $self->{'_client'}->request("PUT", $self->_api_path() . "/" . $self->_id() . "/to/bridge/" . $bridge->_id());
	$self->reload();
	return $self;
}

#** @method public Saklient::Cloud::Resources::Swytch disconnect_from_bridge 
# 
# @brief このルータ＋スイッチをブリッジから切断します。
# 
# @retval this
#*
sub disconnect_from_bridge {
	my $self = shift;
	my $_argnum = scalar @_;
	my $result = $self->{'_client'}->request("DELETE", $self->_api_path() . "/" . $self->_id() . "/to/bridge");
	$self->reload();
	return $self;
}

#** @method private any _used_ipv4_address_hash 
# 
# @private
# @ignore
#*
sub _used_ipv4_address_hash {
	my $self = shift;
	my $_argnum = scalar @_;
	my $filter = {};
	$filter->{"Switch" . ".ID"} = $self->_id();
	my $query = {};
	Saklient::Util::set_by_path($query, "Count", 0);
	Saklient::Util::set_by_path($query, "Filter", $filter);
	Saklient::Util::set_by_path($query, "Include", ["IPAddress", "UserIPAddress"]);
	my $result = $self->{'_client'}->request("GET", "/interface", $query);
	if (!defined($result)) {
		return undef;
	}
	$result = $result->{"Interfaces"};
	if (!defined($result)) {
		return undef;
	}
	my $ifaces = $result;
	if (!defined($ifaces)) {
		return undef;
	}
	my $found = {};
	foreach my $iface (@{$ifaces}) {
		my $ip = $iface->{"IPAddress"};
		my $userIp = $iface->{"UserIPAddress"};
		if (!defined($ip)) {
			$ip = $userIp;
		}
		if (defined($ip)) {
			$found->{$ip} = 1;
		}
	}
	return $found;
}

#** @method public string[] collect_used_ipv4_addresses 
# 
# @brief このルータ＋スイッチに接続中のインタフェースに割り当てられているIPアドレスを収集します。
#*
sub collect_used_ipv4_addresses {
	my $self = shift;
	my $_argnum = scalar @_;
	my $found = $self->_used_ipv4_address_hash();
	return [sort @{[keys %{$found}]}];
}

#** @method public string[] collect_unused_ipv4_addresses 
# 
# @brief このルータ＋スイッチで利用できる未使用のIPアドレスを収集します。
#*
sub collect_unused_ipv4_addresses {
	my $self = shift;
	my $_argnum = scalar @_;
	my $nets = $self->get_ipv4_nets();
	if (scalar(@{$nets}) < 1) {
		return undef;
	}
	my $used = $self->_used_ipv4_address_hash();
	my $ret = [];
	foreach my $ip (@{$nets->[0]->get_range()->get_as_array()}) {
		if (!(ref($used) eq 'HASH' && exists $used->{$ip})) {
			push(@{$ret}, $ip);
		}
	}
	return [sort @{$ret}];
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

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_tags 
# 
# @brief null
#*
my $n_tags = 0;

#** @method private string[] get_tags 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'n_tags'} = 1;
	return $self->{'m_tags'};
}

#** @method private string[] set_tags (@$v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string[]} v
#*
sub set_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "ARRAY");
	$self->{'m_tags'} = $v;
	$self->{'n_tags'} = 1;
	return $self->{'m_tags'};
}

#** @method public string[] tags ()
# 
# @brief タグ文字列の配列
#*
sub tags {
	if (1 < scalar(@_)) {
		$_[0]->set_tags($_[1]);
		return $_[0];
	}
	return $_[0]->get_tags();
}

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_icon 
# 
# @brief null
#*
my $n_icon = 0;

#** @method private Saklient::Cloud::Resources::Icon get_icon 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_icon'};
}

#** @method private Saklient::Cloud::Resources::Icon set_icon ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {Saklient::Cloud::Resources::Icon} v
#*
sub set_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resources::Icon");
	$self->{'m_icon'} = $v;
	$self->{'n_icon'} = 1;
	return $self->{'m_icon'};
}

#** @method public Saklient::Cloud::Resources::Icon icon ()
# 
# @brief アイコン
#*
sub icon {
	if (1 < scalar(@_)) {
		$_[0]->set_icon($_[1]);
		return $_[0];
	}
	return $_[0]->get_icon();
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

#** @var private bool Saklient::Cloud::Resources::Swytch::$n_bridge 
# 
# @brief null
#*
my $n_bridge = 0;

#** @method private Saklient::Cloud::Resources::Bridge get_bridge 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_bridge {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_bridge'};
}

#** @method public Saklient::Cloud::Resources::Bridge bridge ()
# 
# @brief 接続されているブリッジ
#*
sub bridge {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Swytch#bridge");
		throw $ex;
	}
	return $_[0]->get_bridge();
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
# @brief IPv4ネットワーク（ルータによる自動割当） {@link Ipv4Net} の配列
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
# @brief IPv6ネットワーク（ルータによる自動割当） {@link Ipv6Net} の配列
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
	if (Saklient::Util::exists_path($r, "Tags")) {
		if (!defined(Saklient::Util::get_by_path($r, "Tags"))) {
			$self->{'m_tags'} = [];
		}
		else {
			$self->{'m_tags'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Tags")}) {
				my $v1 = undef;
				$v1 = !defined($t) ? undef : "" . $t;
				push(@{$self->{'m_tags'}}, $v1);
			}
		}
	}
	else {
		$self->{'m_tags'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_tags'} = 0;
	if (Saklient::Util::exists_path($r, "Icon")) {
		$self->{'m_icon'} = !defined(Saklient::Util::get_by_path($r, "Icon")) ? undef : new Saklient::Cloud::Resources::Icon($self->{'_client'}, Saklient::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
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
	if (Saklient::Util::exists_path($r, "Bridge")) {
		$self->{'m_bridge'} = !defined(Saklient::Util::get_by_path($r, "Bridge")) ? undef : new Saklient::Cloud::Resources::Bridge($self->{'_client'}, Saklient::Util::get_by_path($r, "Bridge"));
	}
	else {
		$self->{'m_bridge'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_bridge'} = 0;
	if (Saklient::Util::exists_path($r, "Subnets")) {
		if (!defined(Saklient::Util::get_by_path($r, "Subnets"))) {
			$self->{'m_ipv4_nets'} = [];
		}
		else {
			$self->{'m_ipv4_nets'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Subnets")}) {
				my $v2 = undef;
				$v2 = !defined($t) ? undef : new Saklient::Cloud::Resources::Ipv4Net($self->{'_client'}, $t);
				push(@{$self->{'m_ipv4_nets'}}, $v2);
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
				my $v3 = undef;
				$v3 = !defined($t) ? undef : new Saklient::Cloud::Resources::Ipv6Net($self->{'_client'}, $t);
				push(@{$self->{'m_ipv6_nets'}}, $v3);
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
	if ($withClean || $self->{'n_tags'}) {
		Saklient::Util::set_by_path($ret, "Tags", []);
		foreach my $r1 (@{$self->{'m_tags'}}) {
			my $v = undef;
			$v = $r1;
			push(@{$ret->{"Tags"}}, $v);
		}
	}
	if ($withClean || $self->{'n_icon'}) {
		Saklient::Util::set_by_path($ret, "Icon", $withClean ? (!defined($self->{'m_icon'}) ? undef : $self->{'m_icon'}->api_serialize($withClean)) : (!defined($self->{'m_icon'}) ? {'ID' => "0"} : $self->{'m_icon'}->api_serialize_id()));
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
	if ($withClean || $self->{'n_bridge'}) {
		Saklient::Util::set_by_path($ret, "Bridge", $withClean ? (!defined($self->{'m_bridge'}) ? undef : $self->{'m_bridge'}->api_serialize($withClean)) : (!defined($self->{'m_bridge'}) ? {'ID' => "0"} : $self->{'m_bridge'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_ipv4_nets'}) {
		Saklient::Util::set_by_path($ret, "Subnets", []);
		foreach my $r2 (@{$self->{'m_ipv4_nets'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r2) ? undef : $r2->api_serialize($withClean)) : (!defined($r2) ? {'ID' => "0"} : $r2->api_serialize_id());
			push(@{$ret->{"Subnets"}}, $v);
		}
	}
	if ($withClean || $self->{'n_ipv6_nets'}) {
		Saklient::Util::set_by_path($ret, "IPv6Nets", []);
		foreach my $r3 (@{$self->{'m_ipv6_nets'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r3) ? undef : $r3->api_serialize($withClean)) : (!defined($r3) ? {'ID' => "0"} : $r3->api_serialize_id());
			push(@{$ret->{"IPv6Nets"}}, $v);
		}
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Swytch creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

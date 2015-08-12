#!/usr/bin/perl

package Saklient::Cloud::Resources::Iface;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Swytch;
use Saklient::Cloud::Resources::IfaceActivity;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Iface
# 
# @brief インタフェースの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Iface::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Iface::$m_mac_address 
# 
# @brief MACアドレス
#*
my $m_mac_address;

#** @var private string Saklient::Cloud::Resources::Iface::$m_ip_address 
# 
# @brief IPv4アドレス（共有セグメントによる自動割当）
#*
my $m_ip_address;

#** @var private string Saklient::Cloud::Resources::Iface::$m_user_ip_address 
# 
# @brief ユーザ設定IPv4アドレス
#*
my $m_user_ip_address;

#** @var private string Saklient::Cloud::Resources::Iface::$m_server_id 
# 
# @brief このインタフェースが取り付けられているサーバのID
#*
my $m_server_id;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/interface";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Interface";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Interfaces";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Iface";
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

#** @method public Saklient::Cloud::Resources::Iface save 
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

#** @method public Saklient::Cloud::Resources::Iface reload 
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

#** @var private IfaceActivity Saklient::Cloud::Resources::Iface::$_activity 
# 
# @private
#*
my $_activity;

#** @method public Saklient::Cloud::Resources::IfaceActivity get_activity 
# 
# @brief null
#*
sub get_activity {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_activity'};
}

#** @method public Saklient::Cloud::Resources::IfaceActivity activity ()
# 
# @brief アクティビティ
#*
sub activity {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Iface#activity");
		throw $ex;
	}
	return $_[0]->get_activity();
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
	$self->{'_activity'} = new Saklient::Cloud::Resources::IfaceActivity($client);
	$self->api_deserialize($obj, $wrapped);
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
	if (defined($r)) {
		$self->{'_activity'}->set_source_id($self->_id());
	}
}

#** @method public Saklient::Cloud::Resources::Iface connect_to_swytch ($swytch)
# 
# @brief スイッチに接続します。
# 
# @param Swytch $swytch 接続先のスイッチ。
# @retval this
#*
sub connect_to_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	my $swytch = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($swytch, "Saklient::Cloud::Resources::Swytch");
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/to/switch/" . Saklient::Util::url_encode($swytch->_id()));
	return $self->reload();
}

#** @method public Saklient::Cloud::Resources::Iface connect_to_shared_segment 
# 
# @brief 共有セグメントに接続します。
# 
# @retval this
#*
sub connect_to_shared_segment {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/to/switch/shared");
	return $self->reload();
}

#** @method public Saklient::Cloud::Resources::Iface disconnect_from_swytch 
# 
# @brief スイッチから切断します。
# 
# @retval this
#*
sub disconnect_from_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/to/switch");
	return $self->reload();
}

#** @var private bool Saklient::Cloud::Resources::Iface::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Iface#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Iface::$n_mac_address 
# 
# @brief null
#*
my $n_mac_address = 0;

#** @method private string get_mac_address 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_mac_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_mac_address'};
}

#** @method public string mac_address ()
# 
# @brief MACアドレス
#*
sub mac_address {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Iface#mac_address");
		throw $ex;
	}
	return $_[0]->get_mac_address();
}

#** @var private bool Saklient::Cloud::Resources::Iface::$n_ip_address 
# 
# @brief null
#*
my $n_ip_address = 0;

#** @method private string get_ip_address 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_ip_address'};
}

#** @method public string ip_address ()
# 
# @brief IPv4アドレス（共有セグメントによる自動割当）
#*
sub ip_address {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Iface#ip_address");
		throw $ex;
	}
	return $_[0]->get_ip_address();
}

#** @var private bool Saklient::Cloud::Resources::Iface::$n_user_ip_address 
# 
# @brief null
#*
my $n_user_ip_address = 0;

#** @method private string get_user_ip_address 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_user_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_user_ip_address'};
}

#** @method private string set_user_ip_address ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_user_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_user_ip_address'} = $v;
	$self->{'n_user_ip_address'} = 1;
	return $self->{'m_user_ip_address'};
}

#** @method public string user_ip_address ()
# 
# @brief ユーザ設定IPv4アドレス
#*
sub user_ip_address {
	if (1 < scalar(@_)) {
		$_[0]->set_user_ip_address($_[1]);
		return $_[0];
	}
	return $_[0]->get_user_ip_address();
}

#** @var private bool Saklient::Cloud::Resources::Iface::$n_server_id 
# 
# @brief null
#*
my $n_server_id = 0;

#** @method private string get_server_id 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_server_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_server_id'};
}

#** @method private string set_server_id ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_server_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Iface#server_id"); throw $ex; };
	}
	$self->{'m_server_id'} = $v;
	$self->{'n_server_id'} = 1;
	return $self->{'m_server_id'};
}

#** @method public string server_id ()
# 
# @brief このインタフェースが取り付けられているサーバのID
#*
sub server_id {
	if (1 < scalar(@_)) {
		$_[0]->set_server_id($_[1]);
		return $_[0];
	}
	return $_[0]->get_server_id();
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
	if (Saklient::Util::exists_path($r, "MACAddress")) {
		$self->{'m_mac_address'} = !defined(Saklient::Util::get_by_path($r, "MACAddress")) ? undef : "" . Saklient::Util::get_by_path($r, "MACAddress");
	}
	else {
		$self->{'m_mac_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mac_address'} = 0;
	if (Saklient::Util::exists_path($r, "IPAddress")) {
		$self->{'m_ip_address'} = !defined(Saklient::Util::get_by_path($r, "IPAddress")) ? undef : "" . Saklient::Util::get_by_path($r, "IPAddress");
	}
	else {
		$self->{'m_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ip_address'} = 0;
	if (Saklient::Util::exists_path($r, "UserIPAddress")) {
		$self->{'m_user_ip_address'} = !defined(Saklient::Util::get_by_path($r, "UserIPAddress")) ? undef : "" . Saklient::Util::get_by_path($r, "UserIPAddress");
	}
	else {
		$self->{'m_user_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_ip_address'} = 0;
	if (Saklient::Util::exists_path($r, "Server.ID")) {
		$self->{'m_server_id'} = !defined(Saklient::Util::get_by_path($r, "Server.ID")) ? undef : "" . Saklient::Util::get_by_path($r, "Server.ID");
	}
	else {
		$self->{'m_server_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_server_id'} = 0;
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
	if ($withClean || $self->{'n_mac_address'}) {
		Saklient::Util::set_by_path($ret, "MACAddress", $self->{'m_mac_address'});
	}
	if ($withClean || $self->{'n_ip_address'}) {
		Saklient::Util::set_by_path($ret, "IPAddress", $self->{'m_ip_address'});
	}
	if ($withClean || $self->{'n_user_ip_address'}) {
		Saklient::Util::set_by_path($ret, "UserIPAddress", $self->{'m_user_ip_address'});
	}
	if ($withClean || $self->{'n_server_id'}) {
		Saklient::Util::set_by_path($ret, "Server.ID", $self->{'m_server_id'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "server_id");
		}
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Iface creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

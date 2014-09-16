#!/usr/bin/perl

package Saklient::Cloud::Resource::Router;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::Icon;
use Saklient::Cloud::Resource::Swytch;
use Saklient::Cloud::Resource::Ipv4Net;
use Saklient::Cloud::Resource::Ipv6Net;

use base qw(Saklient::Cloud::Resource::Resource);

#** @class Saklient::Cloud::Resource::Router
# 
# @brief ルータの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resource::Router::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resource::Router::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resource::Router::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private int Saklient::Cloud::Resource::Router::$m_network_mask_len 
# 
# @brief ネットワークのマスク長
#*
my $m_network_mask_len;

#** @var private int Saklient::Cloud::Resource::Router::$m_band_width_mbps 
# 
# @brief 帯域幅
#*
my $m_band_width_mbps;

#** @var private string Saklient::Cloud::Resource::Router::$m_swytch_id 
# 
# @brief スイッチ
#*
my $m_swytch_id;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/internet";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Internet";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Internet";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Router";
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

#** @method public Saklient::Cloud::Resource::Router save 
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

#** @method public Saklient::Cloud::Resource::Router reload 
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

#** @method public void after_create ($timeoutSec, $callback)
# 
# @brief 作成中のルータが利用可能になるまで待機します。
# 
# @ignore
# @param int $timeoutSec
# @param (Saklient::Cloud::Resource::Router, bool) => void $callback
#*
sub after_create {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_while_creating($timeoutSec);
	$callback->($self, $ret);
}

#** @method public bool sleep_while_creating ($timeoutSec)
# 
# @brief 作成中のルータが利用可能になるまで待機します。
# 
# @param int $timeoutSec
# @retval 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。
#*
sub sleep_while_creating {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (120);
	Saklient::Util::validate_type($timeoutSec, "int");
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

#** @method public Saklient::Cloud::Resource::Swytch get_swytch 
# 
# @brief このルータが接続されているスイッチを取得します。
#*
sub get_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	my $model = Saklient::Util::create_class_instance("saklient.cloud.model.Model_Swytch", [$self->{'_client'}]);
	my $id = $self->get_swytch_id();
	return $model->get_by_id($id);
}

#** @method public Saklient::Cloud::Resource::Ipv6Net add_ipv6_net 
# 
# @brief このルータ＋スイッチでIPv6アドレスを有効にします。
# 
# @retval 有効化されたIPv6ネットワーク
#*
sub add_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	my $result = $self->{'_client'}->request("POST", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/ipv6net");
	$self->reload();
	return new Saklient::Cloud::Resource::Ipv6Net($self->{'_client'}, $result->{"IPv6Net"});
}

#** @method public Saklient::Cloud::Resource::Router remove_ipv6_net ($ipv6Net)
# 
# @brief このルータ＋スイッチでIPv6アドレスを無効にします。
# 
# @param Ipv6Net $ipv6Net
# @retval this
#*
sub remove_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ipv6Net = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($ipv6Net, "Saklient::Cloud::Resource::Ipv6Net");
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/ipv6net/" . $ipv6Net->_id());
	$self->reload();
	return $self;
}

#** @method public Saklient::Cloud::Resource::Ipv4Net add_static_route ($maskLen, $nextHop)
# 
# @brief このルータ＋スイッチにスタティックルートを追加します。
# 
# @param int $maskLen
# @param string $nextHop
# @retval 追加されたスタティックルート
#*
sub add_static_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $maskLen = shift;
	my $nextHop = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($maskLen, "int");
	Saklient::Util::validate_type($nextHop, "string");
	my $q = {};
	Saklient::Util::set_by_path($q, "NetworkMaskLen", $maskLen);
	Saklient::Util::set_by_path($q, "NextHop", $nextHop);
	my $result = $self->{'_client'}->request("POST", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/subnet", $q);
	$self->reload();
	return new Saklient::Cloud::Resource::Ipv4Net($self->{'_client'}, $result->{"Subnet"});
}

#** @method public Saklient::Cloud::Resource::Router remove_static_route ($ipv4Net)
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
	Saklient::Util::validate_type($ipv4Net, "Saklient::Cloud::Resource::Ipv4Net");
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/subnet/" . $ipv4Net->_id());
	$self->reload();
	return $self;
}

#** @method public Saklient::Cloud::Resource::Router change_plan ($bandWidthMbps)
# 
# @brief このルータ＋スイッチの帯域プランを変更します。
# 
# 成功時はリソースIDが変わることにご注意ください。
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
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/bandwidth";
	my $q = {};
	Saklient::Util::set_by_path($q, "Internet.BandWidthMbps", $bandWidthMbps);
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->api_deserialize($result, 1);
	return $self;
}

#** @var private bool Saklient::Cloud::Resource::Router::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Router#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resource::Router::$n_name 
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

#** @var private bool Saklient::Cloud::Resource::Router::$n_description 
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

#** @var private bool Saklient::Cloud::Resource::Router::$n_network_mask_len 
# 
# @brief null
#*
my $n_network_mask_len = 0;

#** @method private int get_network_mask_len 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_network_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_network_mask_len'};
}

#** @method private int set_network_mask_len ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {int} v
#*
sub set_network_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resource::Router#network_mask_len"); throw $ex; };
	}
	$self->{'m_network_mask_len'} = $v;
	$self->{'n_network_mask_len'} = 1;
	return $self->{'m_network_mask_len'};
}

#** @method public int network_mask_len ()
# 
# @brief ネットワークのマスク長
#*
sub network_mask_len {
	if (1 < scalar(@_)) {
		$_[0]->set_network_mask_len($_[1]);
		return $_[0];
	}
	return $_[0]->get_network_mask_len();
}

#** @var private bool Saklient::Cloud::Resource::Router::$n_band_width_mbps 
# 
# @brief null
#*
my $n_band_width_mbps = 0;

#** @method private int get_band_width_mbps 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_band_width_mbps {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_band_width_mbps'};
}

#** @method private int set_band_width_mbps ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {int} v
#*
sub set_band_width_mbps {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resource::Router#band_width_mbps"); throw $ex; };
	}
	$self->{'m_band_width_mbps'} = $v;
	$self->{'n_band_width_mbps'} = 1;
	return $self->{'m_band_width_mbps'};
}

#** @method public int band_width_mbps ()
# 
# @brief 帯域幅
#*
sub band_width_mbps {
	if (1 < scalar(@_)) {
		$_[0]->set_band_width_mbps($_[1]);
		return $_[0];
	}
	return $_[0]->get_band_width_mbps();
}

#** @var private bool Saklient::Cloud::Resource::Router::$n_swytch_id 
# 
# @brief null
#*
my $n_swytch_id = 0;

#** @method private string get_swytch_id 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_swytch_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_swytch_id'};
}

#** @method public string swytch_id ()
# 
# @brief スイッチ
#*
sub swytch_id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Router#swytch_id");
		throw $ex;
	}
	return $_[0]->get_swytch_id();
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
	if (Saklient::Util::exists_path($r, "NetworkMaskLen")) {
		$self->{'m_network_mask_len'} = !defined(Saklient::Util::get_by_path($r, "NetworkMaskLen")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "NetworkMaskLen")));
	}
	else {
		$self->{'m_network_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_network_mask_len'} = 0;
	if (Saklient::Util::exists_path($r, "BandWidthMbps")) {
		$self->{'m_band_width_mbps'} = !defined(Saklient::Util::get_by_path($r, "BandWidthMbps")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "BandWidthMbps")));
	}
	else {
		$self->{'m_band_width_mbps'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_band_width_mbps'} = 0;
	if (Saklient::Util::exists_path($r, "Switch.ID")) {
		$self->{'m_swytch_id'} = !defined(Saklient::Util::get_by_path($r, "Switch.ID")) ? undef : "" . Saklient::Util::get_by_path($r, "Switch.ID");
	}
	else {
		$self->{'m_swytch_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_swytch_id'} = 0;
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
	if ($withClean || $self->{'n_network_mask_len'}) {
		Saklient::Util::set_by_path($ret, "NetworkMaskLen", $self->{'m_network_mask_len'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "network_mask_len");
		}
	}
	if ($withClean || $self->{'n_band_width_mbps'}) {
		Saklient::Util::set_by_path($ret, "BandWidthMbps", $self->{'m_band_width_mbps'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "band_width_mbps");
		}
	}
	if ($withClean || $self->{'n_swytch_id'}) {
		Saklient::Util::set_by_path($ret, "Switch.ID", $self->{'m_swytch_id'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Router creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

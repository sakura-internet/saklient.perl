#!/usr/bin/perl

package Saklient::Cloud::Resources::Appliance;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Icon;
use Saklient::Cloud::Resources::Iface;
use Saklient::Cloud::Enums::EApplianceClass;
use Saklient::Cloud::Enums::EAvailability;
use Saklient::Cloud::Enums::EServerInstanceStatus;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Appliance
# 
# @brief アプライアンスの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Appliance::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_clazz 
# 
# @brief クラス {@link EApplianceClass}
#*
my $m_clazz;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string* Saklient::Cloud::Resources::Appliance::$m_tags 
# 
# @brief タグ
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resources::Appliance::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

#** @var private int Saklient::Cloud::Resources::Appliance::$m_plan_id 
# 
# @brief プラン
#*
my $m_plan_id;

#** @var private Saklient::Cloud::Resources::Iface* Saklient::Cloud::Resources::Appliance::$m_ifaces 
# 
# @brief インタフェース
#*
my $m_ifaces;

#** @var private any Saklient::Cloud::Resources::Appliance::$m_raw_annotation 
# 
# @brief 注釈
#*
my $m_raw_annotation;

#** @var private any Saklient::Cloud::Resources::Appliance::$m_raw_settings 
# 
# @brief 設定の生データ
#*
my $m_raw_settings;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_raw_settings_hash 
# 
# @ignore
#*
my $m_raw_settings_hash;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_status 
# 
# @brief 起動状態 {@link EServerInstanceStatus}
#*
my $m_status;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_service_class 
# 
# @brief サービスクラス
#*
my $m_service_class;

#** @var private string Saklient::Cloud::Resources::Appliance::$m_availability 
# 
# @brief 有効状態 {@link EAvailability}
#*
my $m_availability;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/appliance";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Appliance";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Appliances";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Appliance";
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

#** @method public Saklient::Cloud::Resources::Appliance save 
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

#** @method public Saklient::Cloud::Resources::Appliance reload 
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

#** @method public string true_class_name 
# 
# @ignore
#*
sub true_class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	if (!defined($self->clazz())) {
		return undef;
	}
	if ($self->clazz() eq "loadbalancer") {
		return "LoadBalancer";
	}
	elsif ($self->clazz() eq "vpcrouter") {
		return "VpcRouter";
	}
	return undef;
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

#** @method private void _on_before_save ($query)
# 
# @private
#*
sub _on_before_save {
	my $self = shift;
	my $_argnum = scalar @_;
	my $query = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::set_by_path($query, "OriginalSettingsHash", $self->get_raw_settings_hash());
}

#** @method public Saklient::Cloud::Resources::Appliance boot 
# 
# @brief アプライアンスを起動します。
# 
# @retval this
#*
sub boot {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power");
	return $self;
}

#** @method public Saklient::Cloud::Resources::Appliance shutdown 
# 
# @brief アプライアンスをシャットダウンします。
# 
# @retval this
#*
sub shutdown {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power");
	return $self;
}

#** @method public Saklient::Cloud::Resources::Appliance stop 
# 
# @brief アプライアンスを強制停止します。
# 
# @retval this
#*
sub stop {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power", {'Force' => 1});
	return $self;
}

#** @method public Saklient::Cloud::Resources::Appliance reboot 
# 
# @brief アプライアンスを強制再起動します。
# 
# @retval this
#*
sub reboot {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/reset");
	return $self;
}

#** @method public bool sleep_while_creating ($timeoutSec)
# 
# @brief 作成中のアプライアンスが利用可能になるまで待機します。
# 
# @param int $timeoutSec
# @retval 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。
#*
sub sleep_while_creating {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (600);
	Saklient::Util::validate_type($timeoutSec, "int");
	my $step = 10;
	while (0 < $timeoutSec) {
		$self->reload();
		my $a = $self->get_availability();
		if ($a eq Saklient::Cloud::Enums::EAvailability::available) {
			return 1;
		}
		if ($a ne Saklient::Cloud::Enums::EAvailability::migrating) {
			$timeoutSec = 0;
		}
		$timeoutSec -= $step;
		if (0 < $timeoutSec) {
			sleep $step;
		}
	}
	return 0;
}

#** @method public bool sleep_until_up ($timeoutSec)
# 
# @brief アプライアンスが起動するまで待機します。
# 
# @param int $timeoutSec
#*
sub sleep_until_up {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (600);
	Saklient::Util::validate_type($timeoutSec, "int");
	return $self->sleep_until(Saklient::Cloud::Enums::EServerInstanceStatus::up, $timeoutSec);
}

#** @method public bool sleep_until_down ($timeoutSec)
# 
# @brief アプライアンスが停止するまで待機します。
# 
# @param int $timeoutSec
# @retval 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。
#*
sub sleep_until_down {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (600);
	Saklient::Util::validate_type($timeoutSec, "int");
	return $self->sleep_until(Saklient::Cloud::Enums::EServerInstanceStatus::down, $timeoutSec);
}

#** @method private bool sleep_until ($status, $timeoutSec)
# 
# @brief アプライアンスが指定のステータスに遷移するまで待機します。
# 
# @ignore
# @param string $status
# @param int $timeoutSec
#*
sub sleep_until {
	my $self = shift;
	my $_argnum = scalar @_;
	my $status = shift;
	my $timeoutSec = shift || (600);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($status, "string");
	Saklient::Util::validate_type($timeoutSec, "int");
	my $step = 10;
	while (0 < $timeoutSec) {
		$self->reload();
		my $s = $self->get_status();
		if (!defined($s)) {
			$s = Saklient::Cloud::Enums::EServerInstanceStatus::down;
		}
		if ($s eq $status) {
			return 1;
		}
		$timeoutSec -= $step;
		if (0 < $timeoutSec) {
			sleep $step;
		}
	}
	return 0;
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Appliance#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_clazz 
# 
# @brief null
#*
my $n_clazz = 0;

#** @method private string get_clazz 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_clazz {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_clazz'};
}

#** @method private string set_clazz ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_clazz {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Appliance#clazz"); throw $ex; };
	}
	$self->{'m_clazz'} = $v;
	$self->{'n_clazz'} = 1;
	return $self->{'m_clazz'};
}

#** @method public string clazz ()
# 
# @brief クラス {@link EApplianceClass}
#*
sub clazz {
	if (1 < scalar(@_)) {
		$_[0]->set_clazz($_[1]);
		return $_[0];
	}
	return $_[0]->get_clazz();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_name 
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

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_description 
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

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_tags 
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
# @brief タグ
#*
sub tags {
	if (1 < scalar(@_)) {
		$_[0]->set_tags($_[1]);
		return $_[0];
	}
	return $_[0]->get_tags();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_icon 
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

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_plan_id 
# 
# @brief null
#*
my $n_plan_id = 0;

#** @method private int get_plan_id 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_plan_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_plan_id'};
}

#** @method private int set_plan_id ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {int} v
#*
sub set_plan_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Appliance#plan_id"); throw $ex; };
	}
	$self->{'m_plan_id'} = $v;
	$self->{'n_plan_id'} = 1;
	return $self->{'m_plan_id'};
}

#** @method public int plan_id ()
# 
# @brief プラン
#*
sub plan_id {
	if (1 < scalar(@_)) {
		$_[0]->set_plan_id($_[1]);
		return $_[0];
	}
	return $_[0]->get_plan_id();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_ifaces 
# 
# @brief null
#*
my $n_ifaces = 0;

#** @method private Saklient::Cloud::Resources::Iface[] get_ifaces 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_ifaces {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_ifaces'};
}

#** @method public Saklient::Cloud::Resources::Iface[] ifaces ()
# 
# @brief インタフェース
#*
sub ifaces {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Appliance#ifaces");
		throw $ex;
	}
	return $_[0]->get_ifaces();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_raw_annotation 
# 
# @brief null
#*
my $n_raw_annotation = 0;

#** @method private any get_raw_annotation 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_raw_annotation {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_raw_annotation'};
}

#** @method private any set_raw_annotation ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub set_raw_annotation {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Appliance#raw_annotation"); throw $ex; };
	}
	$self->{'m_raw_annotation'} = $v;
	$self->{'n_raw_annotation'} = 1;
	return $self->{'m_raw_annotation'};
}

#** @method public any raw_annotation ()
# 
# @brief 注釈
#*
sub raw_annotation {
	if (1 < scalar(@_)) {
		$_[0]->set_raw_annotation($_[1]);
		return $_[0];
	}
	return $_[0]->get_raw_annotation();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_raw_settings 
# 
# @brief null
#*
my $n_raw_settings = 0;

#** @method private any get_raw_settings 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_raw_settings {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'n_raw_settings'} = 1;
	return $self->{'m_raw_settings'};
}

#** @method private any set_raw_settings ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub set_raw_settings {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	$self->{'m_raw_settings'} = $v;
	$self->{'n_raw_settings'} = 1;
	return $self->{'m_raw_settings'};
}

#** @method public any raw_settings ()
# 
# @brief 設定の生データ
#*
sub raw_settings {
	if (1 < scalar(@_)) {
		$_[0]->set_raw_settings($_[1]);
		return $_[0];
	}
	return $_[0]->get_raw_settings();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_raw_settings_hash 
# 
# @brief null
#*
my $n_raw_settings_hash = 0;

#** @method private string get_raw_settings_hash 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_raw_settings_hash {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_raw_settings_hash'};
}

#** @method public string raw_settings_hash ()
# 
# @ignore
#*
sub raw_settings_hash {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Appliance#raw_settings_hash");
		throw $ex;
	}
	return $_[0]->get_raw_settings_hash();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_status 
# 
# @brief null
#*
my $n_status = 0;

#** @method private string get_status 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_status'};
}

#** @method public string status ()
# 
# @brief 起動状態 {@link EServerInstanceStatus}
#*
sub status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Appliance#status");
		throw $ex;
	}
	return $_[0]->get_status();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_service_class 
# 
# @brief null
#*
my $n_service_class = 0;

#** @method private string get_service_class 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_service_class {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_service_class'};
}

#** @method public string service_class ()
# 
# @brief サービスクラス
#*
sub service_class {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Appliance#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
}

#** @var private bool Saklient::Cloud::Resources::Appliance::$n_availability 
# 
# @brief null
#*
my $n_availability = 0;

#** @method private string get_availability 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_availability {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_availability'};
}

#** @method public string availability ()
# 
# @brief 有効状態 {@link EAvailability}
#*
sub availability {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Appliance#availability");
		throw $ex;
	}
	return $_[0]->get_availability();
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
	if (Saklient::Util::exists_path($r, "Class")) {
		$self->{'m_clazz'} = !defined(Saklient::Util::get_by_path($r, "Class")) ? undef : "" . Saklient::Util::get_by_path($r, "Class");
	}
	else {
		$self->{'m_clazz'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_clazz'} = 0;
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
	if (Saklient::Util::exists_path($r, "Plan.ID")) {
		$self->{'m_plan_id'} = !defined(Saklient::Util::get_by_path($r, "Plan.ID")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "Plan.ID")));
	}
	else {
		$self->{'m_plan_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan_id'} = 0;
	if (Saklient::Util::exists_path($r, "Interfaces")) {
		if (!defined(Saklient::Util::get_by_path($r, "Interfaces"))) {
			$self->{'m_ifaces'} = [];
		}
		else {
			$self->{'m_ifaces'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Interfaces")}) {
				my $v2 = undef;
				$v2 = !defined($t) ? undef : new Saklient::Cloud::Resources::Iface($self->{'_client'}, $t);
				push(@{$self->{'m_ifaces'}}, $v2);
			}
		}
	}
	else {
		$self->{'m_ifaces'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ifaces'} = 0;
	if (Saklient::Util::exists_path($r, "Remark")) {
		$self->{'m_raw_annotation'} = Saklient::Util::get_by_path($r, "Remark");
	}
	else {
		$self->{'m_raw_annotation'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_raw_annotation'} = 0;
	if (Saklient::Util::exists_path($r, "Settings")) {
		$self->{'m_raw_settings'} = Saklient::Util::get_by_path($r, "Settings");
	}
	else {
		$self->{'m_raw_settings'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_raw_settings'} = 0;
	if (Saklient::Util::exists_path($r, "SettingsHash")) {
		$self->{'m_raw_settings_hash'} = !defined(Saklient::Util::get_by_path($r, "SettingsHash")) ? undef : "" . Saklient::Util::get_by_path($r, "SettingsHash");
	}
	else {
		$self->{'m_raw_settings_hash'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_raw_settings_hash'} = 0;
	if (Saklient::Util::exists_path($r, "Instance.Status")) {
		$self->{'m_status'} = !defined(Saklient::Util::get_by_path($r, "Instance.Status")) ? undef : "" . Saklient::Util::get_by_path($r, "Instance.Status");
	}
	else {
		$self->{'m_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status'} = 0;
	if (Saklient::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saklient::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saklient::Util::get_by_path($r, "ServiceClass");
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
	if (Saklient::Util::exists_path($r, "Availability")) {
		$self->{'m_availability'} = !defined(Saklient::Util::get_by_path($r, "Availability")) ? undef : "" . Saklient::Util::get_by_path($r, "Availability");
	}
	else {
		$self->{'m_availability'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_availability'} = 0;
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
	if ($withClean || $self->{'n_clazz'}) {
		Saklient::Util::set_by_path($ret, "Class", $self->{'m_clazz'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "clazz");
		}
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
	if ($withClean || $self->{'n_plan_id'}) {
		Saklient::Util::set_by_path($ret, "Plan.ID", $self->{'m_plan_id'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "plan_id");
		}
	}
	if ($withClean || $self->{'n_ifaces'}) {
		Saklient::Util::set_by_path($ret, "Interfaces", []);
		foreach my $r2 (@{$self->{'m_ifaces'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r2) ? undef : $r2->api_serialize($withClean)) : (!defined($r2) ? {'ID' => "0"} : $r2->api_serialize_id());
			push(@{$ret->{"Interfaces"}}, $v);
		}
	}
	if ($withClean || $self->{'n_raw_annotation'}) {
		Saklient::Util::set_by_path($ret, "Remark", $self->{'m_raw_annotation'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "raw_annotation");
		}
	}
	if ($withClean || $self->{'n_raw_settings'}) {
		Saklient::Util::set_by_path($ret, "Settings", $self->{'m_raw_settings'});
	}
	if ($withClean || $self->{'n_raw_settings_hash'}) {
		Saklient::Util::set_by_path($ret, "SettingsHash", $self->{'m_raw_settings_hash'});
	}
	if ($withClean || $self->{'n_status'}) {
		Saklient::Util::set_by_path($ret, "Instance.Status", $self->{'m_status'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saklient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	if ($withClean || $self->{'n_availability'}) {
		Saklient::Util::set_by_path($ret, "Availability", $self->{'m_availability'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Appliance creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

#!/usr/bin/perl

package Saklient::Cloud::Resources::Server;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Icon;
use Saklient::Cloud::Resources::Disk;
use Saklient::Cloud::Resources::Iface;
use Saklient::Cloud::Resources::ServerPlan;
use Saklient::Cloud::Resources::ServerInstance;
use Saklient::Cloud::Resources::IsoImage;
use Saklient::Cloud::Enums::EServerInstanceStatus;
use Saklient::Cloud::Enums::EAvailability;
use Saklient::Cloud::Models::Model_Disk;
use Saklient::Cloud::Models::Model_Iface;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Server
# 
# @brief サーバの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Server::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Server::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::Server::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string* Saklient::Cloud::Resources::Server::$m_tags 
# 
# @brief タグ
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resources::Server::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

#** @var private ServerPlan Saklient::Cloud::Resources::Server::$m_plan 
# 
# @brief プラン
#*
my $m_plan;

#** @var private Saklient::Cloud::Resources::Iface* Saklient::Cloud::Resources::Server::$m_ifaces 
# 
# @brief インタフェース
#*
my $m_ifaces;

#** @var private ServerInstance Saklient::Cloud::Resources::Server::$m_instance 
# 
# @brief インスタンス情報
#*
my $m_instance;

#** @var private string Saklient::Cloud::Resources::Server::$m_availability 
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
	return "/server";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Server";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Servers";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Server";
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

#** @method public Saklient::Cloud::Resources::Server save 
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

#** @method public Saklient::Cloud::Resources::Server reload 
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

#** @method public bool is_up 
# 
# @brief サーバが起動しているときtrueを返します。
#*
sub is_up {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_instance()->is_up();
}

#** @method public bool is_down 
# 
# @brief サーバが停止しているときtrueを返します。
#*
sub is_down {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_instance()->is_down();
}

#** @method public Saklient::Cloud::Resources::Server boot 
# 
# @brief サーバを起動します。
# 
# @retval this
#*
sub boot {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power");
	return $self->reload();
}

#** @method public Saklient::Cloud::Resources::Server shutdown 
# 
# @brief サーバをシャットダウンします。
# 
# @retval this
#*
sub shutdown {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power");
	return $self->reload();
}

#** @method public Saklient::Cloud::Resources::Server stop 
# 
# @brief サーバを強制停止します。
# 
# @retval this
#*
sub stop {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power", {'Force' => 1});
	return $self->reload();
}

#** @method public Saklient::Cloud::Resources::Server reboot 
# 
# @brief サーバを強制再起動します。
# 
# @retval this
#*
sub reboot {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/reset");
	return $self->reload();
}

#** @method public void after_down ($timeoutSec, $callback)
# 
# @brief サーバが停止するまで待機します。
# 
# @param int $timeoutSec
# @param (Saklient::Cloud::Resources::Server, bool) => void $callback
# @retval 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。
#*
sub after_down {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	$self->after_status(Saklient::Cloud::Enums::EServerInstanceStatus::down, $timeoutSec, $callback);
}

#** @method private void after_status ($status, $timeoutSec, $callback)
# 
# @brief サーバが指定のステータスに遷移するまで待機します。
# 
# @ignore
# @param string $status
# @param int $timeoutSec
# @param (Saklient::Cloud::Resources::Server, bool) => void $callback
#*
sub after_status {
	my $self = shift;
	my $_argnum = scalar @_;
	my $status = shift;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 3);
	Saklient::Util::validate_type($status, "string");
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_until($status, $timeoutSec);
	$callback->($self, $ret);
}

#** @method public bool sleep_until_down ($timeoutSec)
# 
# @brief サーバが停止するまで待機します。
# 
# @param int $timeoutSec
# @retval 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。
#*
sub sleep_until_down {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (180);
	Saklient::Util::validate_type($timeoutSec, "int");
	return $self->sleep_until(Saklient::Cloud::Enums::EServerInstanceStatus::down, $timeoutSec);
}

#** @method private bool sleep_until ($status, $timeoutSec)
# 
# @brief サーバが指定のステータスに遷移するまで待機します。
# 
# @ignore
# @param string $status
# @param int $timeoutSec
#*
sub sleep_until {
	my $self = shift;
	my $_argnum = scalar @_;
	my $status = shift;
	my $timeoutSec = shift || (180);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($status, "string");
	Saklient::Util::validate_type($timeoutSec, "int");
	my $step = 3;
	while (0 < $timeoutSec) {
		$self->reload();
		my $s = $self->get_instance()->get_property("status");
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

#** @method public Saklient::Cloud::Resources::Server change_plan ($planTo)
# 
# @brief サーバプランを変更します。
# 
# 成功時はリソースIDが変わることにご注意ください。
# 
# @param ServerPlan $planTo
# @retval this
#*
sub change_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $planTo = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($planTo, "Saklient::Cloud::Resources::ServerPlan");
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/to/plan/" . Saklient::Util::url_encode($planTo->_id());
	my $result = $self->{'_client'}->request("PUT", $path);
	$self->api_deserialize($result, 1);
	return $self;
}

#** @method public Saklient::Cloud::Resources::Disk[] find_disks 
# 
# @brief サーバに接続されているディスクのリストを取得します。
#*
sub find_disks {
	my $self = shift;
	my $_argnum = scalar @_;
	my $model = Saklient::Util::create_class_instance("saklient.cloud.models.Model_Disk", [$self->{'_client'}]);
	return $model->with_server_id($self->_id())->find();
}

#** @method public Saklient::Cloud::Resources::Iface add_iface 
# 
# @brief サーバにインタフェースを1つ増設し、それを取得します。
# 
# @retval 増設されたインタフェース
#*
sub add_iface {
	my $self = shift;
	my $_argnum = scalar @_;
	my $model = Saklient::Util::create_class_instance("saklient.cloud.models.Model_Iface", [$self->{'_client'}]);
	my $res = $model->create();
	$res->set_property("serverId", $self->_id());
	return $res->save();
}

#** @method public Saklient::Cloud::Resources::Server insert_iso_image ($iso)
# 
# @brief サーバにISOイメージを挿入します。
# 
# @param IsoImage $iso
# @retval this
#*
sub insert_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	my $iso = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($iso, "Saklient::Cloud::Resources::IsoImage");
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/cdrom";
	my $q = {'CDROM' => {'ID' => $iso->_id()}};
	$self->{'_client'}->request("PUT", $path, $q);
	$self->reload();
	return $self;
}

#** @method public Saklient::Cloud::Resources::Server eject_iso_image 
# 
# @brief サーバに挿入されているISOイメージを排出します。
# 
# @retval this
#*
sub eject_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/cdrom";
	$self->{'_client'}->request("DELETE", $path);
	$self->reload();
	return $self;
}

#** @var private bool Saklient::Cloud::Resources::Server::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Server#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Server::$n_name 
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

#** @var private bool Saklient::Cloud::Resources::Server::$n_description 
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

#** @var private bool Saklient::Cloud::Resources::Server::$n_tags 
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

#** @var private bool Saklient::Cloud::Resources::Server::$n_icon 
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

#** @var private bool Saklient::Cloud::Resources::Server::$n_plan 
# 
# @brief null
#*
my $n_plan = 0;

#** @method private Saklient::Cloud::Resources::ServerPlan get_plan 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_plan'};
}

#** @method private Saklient::Cloud::Resources::ServerPlan set_plan ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {Saklient::Cloud::Resources::ServerPlan} v
#*
sub set_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resources::ServerPlan");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Server#plan"); throw $ex; };
	}
	$self->{'m_plan'} = $v;
	$self->{'n_plan'} = 1;
	return $self->{'m_plan'};
}

#** @method public Saklient::Cloud::Resources::ServerPlan plan ()
# 
# @brief プラン
#*
sub plan {
	if (1 < scalar(@_)) {
		$_[0]->set_plan($_[1]);
		return $_[0];
	}
	return $_[0]->get_plan();
}

#** @var private bool Saklient::Cloud::Resources::Server::$n_ifaces 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Server#ifaces");
		throw $ex;
	}
	return $_[0]->get_ifaces();
}

#** @var private bool Saklient::Cloud::Resources::Server::$n_instance 
# 
# @brief null
#*
my $n_instance = 0;

#** @method private Saklient::Cloud::Resources::ServerInstance get_instance 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_instance {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_instance'};
}

#** @method public Saklient::Cloud::Resources::ServerInstance instance ()
# 
# @brief インスタンス情報
#*
sub instance {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Server#instance");
		throw $ex;
	}
	return $_[0]->get_instance();
}

#** @var private bool Saklient::Cloud::Resources::Server::$n_availability 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Server#availability");
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
	if (Saklient::Util::exists_path($r, "ServerPlan")) {
		$self->{'m_plan'} = !defined(Saklient::Util::get_by_path($r, "ServerPlan")) ? undef : new Saklient::Cloud::Resources::ServerPlan($self->{'_client'}, Saklient::Util::get_by_path($r, "ServerPlan"));
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
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
	if (Saklient::Util::exists_path($r, "Instance")) {
		$self->{'m_instance'} = !defined(Saklient::Util::get_by_path($r, "Instance")) ? undef : new Saklient::Cloud::Resources::ServerInstance($self->{'_client'}, Saklient::Util::get_by_path($r, "Instance"));
	}
	else {
		$self->{'m_instance'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_instance'} = 0;
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
	if ($withClean || $self->{'n_plan'}) {
		Saklient::Util::set_by_path($ret, "ServerPlan", $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id()));
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "plan");
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
	if ($withClean || $self->{'n_instance'}) {
		Saklient::Util::set_by_path($ret, "Instance", $withClean ? (!defined($self->{'m_instance'}) ? undef : $self->{'m_instance'}->api_serialize($withClean)) : (!defined($self->{'m_instance'}) ? {'ID' => "0"} : $self->{'m_instance'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_availability'}) {
		Saklient::Util::set_by_path($ret, "Availability", $self->{'m_availability'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Server creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

#!/usr/bin/perl

package Saklient::Cloud::Resources::Disk;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Icon;
use Saklient::Cloud::Resources::DiskPlan;
use Saklient::Cloud::Resources::Server;
use Saklient::Cloud::Resources::DiskConfig;
use Saklient::Cloud::Enums::EAvailability;
use Saklient::Cloud::Enums::EDiskConnection;
use Saklient::Cloud::Enums::EStorageClass;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Disk
# 
# @brief ディスクの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Disk::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Disk::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::Disk::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string* Saklient::Cloud::Resources::Disk::$m_tags 
# 
# @brief タグ
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resources::Disk::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

#** @var private int Saklient::Cloud::Resources::Disk::$m_size_mib 
# 
# @brief サイズ[MiB]
#*
my $m_size_mib;

#** @var private string Saklient::Cloud::Resources::Disk::$m_service_class 
# 
# @brief サービスクラス
#*
my $m_service_class;

#** @var private DiskPlan Saklient::Cloud::Resources::Disk::$m_plan 
# 
# @brief プラン
#*
my $m_plan;

#** @var private Server Saklient::Cloud::Resources::Disk::$m_server 
# 
# @brief 接続先のサーバ
#*
my $m_server;

#** @var private string Saklient::Cloud::Resources::Disk::$m_availability 
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
	return "/disk";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Disk";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Disks";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Disk";
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

#** @method public Saklient::Cloud::Resources::Disk save 
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

#** @method public Saklient::Cloud::Resources::Disk reload 
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

#** @method private bool get_is_available 
# 
# @brief null
#*
sub get_is_available {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_availability() eq Saklient::Cloud::Enums::EAvailability::available;
}

#** @method public bool is_available ()
# 
# @brief ディスクが利用可能なときtrueを返します。
#*
sub is_available {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Disk#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

#** @method private int get_size_gib 
# 
# @brief null
#*
sub get_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_size_mib() >> 10;
}

#** @method private int set_size_gib ($sizeGib)
# 
# @brief null@param {int} sizeGib
#*
sub set_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $sizeGib = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($sizeGib, "int");
	$self->set_size_mib($sizeGib * 1024);
	return $sizeGib;
}

#** @method public int size_gib ()
# 
# @brief サイズ[GiB]
#*
sub size_gib {
	if (1 < scalar(@_)) {
		$_[0]->set_size_gib($_[1]);
		return $_[0];
	}
	return $_[0]->get_size_gib();
}

#** @var private Resource Saklient::Cloud::Resources::Disk::$_source 
# 
# @private
#*
my $_source;

#** @method public Saklient::Cloud::Resources::Resource get_source 
# 
# @brief null
#*
sub get_source {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_source'};
}

#** @method public Saklient::Cloud::Resources::Resource set_source ($source)
# 
# @brief null@param {Saklient::Cloud::Resources::Resource} source
#*
sub set_source {
	my $self = shift;
	my $_argnum = scalar @_;
	my $source = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($source, "Saklient::Cloud::Resources::Resource");
	$self->{'_source'} = $source;
	return $source;
}

#** @method public Saklient::Cloud::Resources::Resource source ()
# 
# @brief ディスクのコピー元
#*
sub source {
	if (1 < scalar(@_)) {
		$_[0]->set_source($_[1]);
		return $_[0];
	}
	return $_[0]->get_source();
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
		if ((ref($r) eq 'HASH' && exists $r->{"SourceDisk"})) {
			my $s = $r->{"SourceDisk"};
			if (defined($s)) {
				my $id = $s->{"ID"};
				if (defined($id)) {
					$self->{'_source'} = new Saklient::Cloud::Resources::Disk($self->{'_client'}, $s);
				}
			}
		}
		if ((ref($r) eq 'HASH' && exists $r->{"SourceArchive"})) {
			my $s = $r->{"SourceArchive"};
			if (defined($s)) {
				my $id = $s->{"ID"};
				if (defined($id)) {
					my $obj = Saklient::Util::create_class_instance("saklient.cloud.resources.Archive", [$self->{'_client'}, $s]);
					$self->{'_source'} = $obj;
				}
			}
		}
	}
}

#** @method private void _on_after_api_serialize ($r, $withClean)
# 
# @private@param {bool} withClean
#*
sub _on_after_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($withClean, "bool");
	if (!defined($r)) {
		return;
	}
	if (defined($self->{'_source'})) {
		if ($self->{'_source'}->_class_name() eq "Disk") {
			my $s = $withClean ? $self->{'_source'}->api_serialize(1) : {'ID' => $self->{'_source'}->_id()};
			$r->{"SourceDisk"} = $s;
		}
		else {
			if ($self->{'_source'}->_class_name() eq "Archive") {
				my $s = $withClean ? $self->{'_source'}->api_serialize(1) : {'ID' => $self->{'_source'}->_id()};
				$r->{"SourceArchive"} = $s;
			}
			else {
				$self->{'_source'} = undef;
				Saklient::Util::validate_type($self->{'_source'}, "Disk or Archive", 1);
			}
		}
	}
}

#** @method public Saklient::Cloud::Resources::Disk connect_to ($server)
# 
# @brief ディスクをサーバに取り付けます。
# 
# @param Server $server
# @retval this
#*
sub connect_to {
	my $self = shift;
	my $_argnum = scalar @_;
	my $server = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($server, "Saklient::Cloud::Resources::Server");
	$self->{'_client'}->request("PUT", "/disk/" . $self->_id() . "/to/server/" . $server->_id());
	return $self;
}

#** @method public Saklient::Cloud::Resources::Disk disconnect 
# 
# @brief ディスクをサーバから取り外します。
# 
# @retval this
#*
sub disconnect {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", "/disk/" . $self->_id() . "/to/server");
	return $self;
}

#** @method public Saklient::Cloud::Resources::DiskConfig create_config 
# 
# @brief ディスク修正を行うためのオブジェクトを用意します。
# 
# 返り値のオブジェクトにパラメータを設定し、write() を呼ぶことで修正を行います。
#*
sub create_config {
	my $self = shift;
	my $_argnum = scalar @_;
	return new Saklient::Cloud::Resources::DiskConfig($self->{'_client'}, $self->_id());
}

#** @method public void after_copy ($timeoutSec, $callback)
# 
# @brief コピー中のディスクが利用可能になるまで待機します。
# 
# @ignore
# @param int $timeoutSec
# @param (Saklient::Cloud::Resources::Disk, bool) => void $callback
#*
sub after_copy {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_while_copying($timeoutSec);
	$callback->($self, $ret);
}

#** @method public bool sleep_while_copying ($timeoutSec)
# 
# @brief コピー中のディスクが利用可能になるまで待機します。
# 
# @param int $timeoutSec
# @retval 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。
#*
sub sleep_while_copying {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (3600);
	Saklient::Util::validate_type($timeoutSec, "int");
	my $step = 3;
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

#** @var private bool Saklient::Cloud::Resources::Disk::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Disk#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Disk::$n_name 
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

#** @var private bool Saklient::Cloud::Resources::Disk::$n_description 
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

#** @var private bool Saklient::Cloud::Resources::Disk::$n_tags 
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

#** @var private bool Saklient::Cloud::Resources::Disk::$n_icon 
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

#** @var private bool Saklient::Cloud::Resources::Disk::$n_size_mib 
# 
# @brief null
#*
my $n_size_mib = 0;

#** @method private int get_size_mib 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_size_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_size_mib'};
}

#** @method private int set_size_mib ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {int} v
#*
sub set_size_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Disk#size_mib"); throw $ex; };
	}
	$self->{'m_size_mib'} = $v;
	$self->{'n_size_mib'} = 1;
	return $self->{'m_size_mib'};
}

#** @method public int size_mib ()
# 
# @brief サイズ[MiB]
#*
sub size_mib {
	if (1 < scalar(@_)) {
		$_[0]->set_size_mib($_[1]);
		return $_[0];
	}
	return $_[0]->get_size_mib();
}

#** @var private bool Saklient::Cloud::Resources::Disk::$n_service_class 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Disk#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
}

#** @var private bool Saklient::Cloud::Resources::Disk::$n_plan 
# 
# @brief null
#*
my $n_plan = 0;

#** @method private Saklient::Cloud::Resources::DiskPlan get_plan 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_plan'};
}

#** @method private Saklient::Cloud::Resources::DiskPlan set_plan ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {Saklient::Cloud::Resources::DiskPlan} v
#*
sub set_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resources::DiskPlan");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resources::Disk#plan"); throw $ex; };
	}
	$self->{'m_plan'} = $v;
	$self->{'n_plan'} = 1;
	return $self->{'m_plan'};
}

#** @method public Saklient::Cloud::Resources::DiskPlan plan ()
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

#** @var private bool Saklient::Cloud::Resources::Disk::$n_server 
# 
# @brief null
#*
my $n_server = 0;

#** @method private Saklient::Cloud::Resources::Server get_server 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_server {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_server'};
}

#** @method public Saklient::Cloud::Resources::Server server ()
# 
# @brief 接続先のサーバ
#*
sub server {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Disk#server");
		throw $ex;
	}
	return $_[0]->get_server();
}

#** @var private bool Saklient::Cloud::Resources::Disk::$n_availability 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Disk#availability");
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
	if (Saklient::Util::exists_path($r, "SizeMB")) {
		$self->{'m_size_mib'} = !defined(Saklient::Util::get_by_path($r, "SizeMB")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "SizeMB")));
	}
	else {
		$self->{'m_size_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_size_mib'} = 0;
	if (Saklient::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saklient::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saklient::Util::get_by_path($r, "ServiceClass");
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
	if (Saklient::Util::exists_path($r, "Plan")) {
		$self->{'m_plan'} = !defined(Saklient::Util::get_by_path($r, "Plan")) ? undef : new Saklient::Cloud::Resources::DiskPlan($self->{'_client'}, Saklient::Util::get_by_path($r, "Plan"));
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
	if (Saklient::Util::exists_path($r, "Server")) {
		$self->{'m_server'} = !defined(Saklient::Util::get_by_path($r, "Server")) ? undef : new Saklient::Cloud::Resources::Server($self->{'_client'}, Saklient::Util::get_by_path($r, "Server"));
	}
	else {
		$self->{'m_server'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_server'} = 0;
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
	if ($withClean || $self->{'n_size_mib'}) {
		Saklient::Util::set_by_path($ret, "SizeMB", $self->{'m_size_mib'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saklient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	if ($withClean || $self->{'n_plan'}) {
		Saklient::Util::set_by_path($ret, "Plan", $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id()));
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "plan");
		}
	}
	if ($withClean || $self->{'n_server'}) {
		Saklient::Util::set_by_path($ret, "Server", $withClean ? (!defined($self->{'m_server'}) ? undef : $self->{'m_server'}->api_serialize($withClean)) : (!defined($self->{'m_server'}) ? {'ID' => "0"} : $self->{'m_server'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_availability'}) {
		Saklient::Util::set_by_path($ret, "Availability", $self->{'m_availability'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Disk creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

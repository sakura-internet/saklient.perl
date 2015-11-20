#!/usr/bin/perl

package Saklient::Cloud::Resources::CommonServiceItem;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::CommonServiceProvider;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::CommonServiceItem
# 
# @brief 共通サービス契約の実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::CommonServiceItem::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::CommonServiceItem::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::CommonServiceItem::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string* Saklient::Cloud::Resources::CommonServiceItem::$m_tags 
# 
# @brief タグ文字列の配列
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resources::CommonServiceItem::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

#** @var private CommonServiceProvider Saklient::Cloud::Resources::CommonServiceItem::$m_provider 
# 
# @brief 共通サービスプロバイダ情報
#*
my $m_provider;

#** @var private any Saklient::Cloud::Resources::CommonServiceItem::$m_raw_settings 
# 
# @brief 設定の生データ
#*
my $m_raw_settings;

#** @var private any Saklient::Cloud::Resources::CommonServiceItem::$m_raw_status 
# 
# @brief ステータスの生データ
#*
my $m_raw_status;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/commonserviceitem";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CommonServiceItem";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CommonServiceItems";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CommonServiceItem";
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

#** @method public Saklient::Cloud::Resources::CommonServiceItem save 
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

#** @method public Saklient::Cloud::Resources::CommonServiceItem reload 
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

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::CommonServiceItem#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_name 
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

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_description 
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

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_tags 
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

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_icon 
# 
# @brief null
#*
my $n_icon = 0;

#** @method private Icon get_icon 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_icon'};
}

#** @method private Icon set_icon ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {Icon} v
#*
sub set_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Icon");
	$self->{'m_icon'} = $v;
	$self->{'n_icon'} = 1;
	return $self->{'m_icon'};
}

#** @method public Icon icon ()
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

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_provider 
# 
# @brief null
#*
my $n_provider = 0;

#** @method private Saklient::Cloud::Resources::CommonServiceProvider get_provider 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_provider {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_provider'};
}

#** @method public Saklient::Cloud::Resources::CommonServiceProvider provider ()
# 
# @brief 共通サービスプロバイダ情報
#*
sub provider {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::CommonServiceItem#provider");
		throw $ex;
	}
	return $_[0]->get_provider();
}

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_raw_settings 
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

#** @var private bool Saklient::Cloud::Resources::CommonServiceItem::$n_raw_status 
# 
# @brief null
#*
my $n_raw_status = 0;

#** @method private any get_raw_status 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_raw_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_raw_status'};
}

#** @method public any raw_status ()
# 
# @brief ステータスの生データ
#*
sub raw_status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::CommonServiceItem#raw_status");
		throw $ex;
	}
	return $_[0]->get_raw_status();
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
		$self->{'m_icon'} = !defined(Saklient::Util::get_by_path($r, "Icon")) ? undef : new Icon($self->{'_client'}, Saklient::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if (Saklient::Util::exists_path($r, "CommonServiceProvider")) {
		$self->{'m_provider'} = !defined(Saklient::Util::get_by_path($r, "CommonServiceProvider")) ? undef : new Saklient::Cloud::Resources::CommonServiceProvider($self->{'_client'}, Saklient::Util::get_by_path($r, "CommonServiceProvider"));
	}
	else {
		$self->{'m_provider'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_provider'} = 0;
	if (Saklient::Util::exists_path($r, "Settings")) {
		$self->{'m_raw_settings'} = Saklient::Util::get_by_path($r, "Settings");
	}
	else {
		$self->{'m_raw_settings'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_raw_settings'} = 0;
	if (Saklient::Util::exists_path($r, "Status")) {
		$self->{'m_raw_status'} = Saklient::Util::get_by_path($r, "Status");
	}
	else {
		$self->{'m_raw_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_raw_status'} = 0;
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
	if ($withClean || $self->{'n_provider'}) {
		Saklient::Util::set_by_path($ret, "CommonServiceProvider", $withClean ? (!defined($self->{'m_provider'}) ? undef : $self->{'m_provider'}->api_serialize($withClean)) : (!defined($self->{'m_provider'}) ? {'ID' => "0"} : $self->{'m_provider'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_raw_settings'}) {
		Saklient::Util::set_by_path($ret, "Settings", $self->{'m_raw_settings'});
	}
	if ($withClean || $self->{'n_raw_status'}) {
		Saklient::Util::set_by_path($ret, "Status", $self->{'m_raw_status'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the CommonServiceItem creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

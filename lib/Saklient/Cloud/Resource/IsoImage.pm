#!/usr/bin/perl

package Saklient::Cloud::Resource::IsoImage;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::Icon;
use Saklient::Cloud::Resource::FtpInfo;
use Saklient::Cloud::Enums::EScope;
use Saklient::Errors::SaklientException;

use base qw(Saklient::Cloud::Resource::Resource);

#** @class Saklient::Cloud::Resource::IsoImage
# 
# @brief ISOイメージの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resource::IsoImage::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resource::IsoImage::$m_scope 
# 
# @brief スコープ {@link EScope}
#*
my $m_scope;

#** @var private string Saklient::Cloud::Resource::IsoImage::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resource::IsoImage::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string* Saklient::Cloud::Resource::IsoImage::$m_tags 
# 
# @brief タグ
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resource::IsoImage::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

#** @var private int Saklient::Cloud::Resource::IsoImage::$m_display_order 
# 
# @brief 表示順序
#*
my $m_display_order;

#** @var private int Saklient::Cloud::Resource::IsoImage::$m_size_mib 
# 
# @brief サイズ[MiB]
#*
my $m_size_mib;

#** @var private string Saklient::Cloud::Resource::IsoImage::$m_service_class 
# 
# @brief サービスクラス
#*
my $m_service_class;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/cdrom";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CDROM";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CDROMs";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "IsoImage";
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

#** @method public Saklient::Cloud::Resource::IsoImage save 
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

#** @method public Saklient::Cloud::Resource::IsoImage reload 
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
	if (!defined($root)) {
		return;
	}
	if ((ref($root) eq 'HASH' && exists $root->{"FTPServer"})) {
		my $ftp = $root->{"FTPServer"};
		if (defined($ftp)) {
			$self->{'_ftp_info'} = new Saklient::Cloud::Resource::FtpInfo($ftp);
		}
	}
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

#** @method public int size_gib ()
# 
# @brief サイズ[GiB]
#*
sub size_gib {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::IsoImage#size_gib");
		throw $ex;
	}
	return $_[0]->get_size_gib();
}

#** @var private FtpInfo Saklient::Cloud::Resource::IsoImage::$_ftp_info 
# 
# @private
#*
my $_ftp_info;

#** @method public Saklient::Cloud::Resource::FtpInfo get_ftp_info 
# 
# @brief null
#*
sub get_ftp_info {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ftp_info'};
}

#** @method public Saklient::Cloud::Resource::FtpInfo ftp_info ()
# 
# @brief FTP情報
#*
sub ftp_info {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::IsoImage#ftp_info");
		throw $ex;
	}
	return $_[0]->get_ftp_info();
}

#** @method public Saklient::Cloud::Resource::IsoImage open_ftp ($reset)
# 
# @brief FTPSを開始し、イメージファイルをアップロード・ダウンロードできる状態にします。
# 
# アカウント情報は、ftpInfo プロパティから取得することができます。
# 
# @param bool $reset 既にFTPSが開始されているとき、trueを指定してこのメソッドを呼ぶことでパスワードを再設定します。
# @retval this
#*
sub open_ftp {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reset = shift || (0);
	Saklient::Util::validate_type($reset, "bool");
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/ftp";
	my $q = {};
	Saklient::Util::set_by_path($q, "ChangePassword", $reset);
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->_on_after_api_deserialize(undef, $result);
	return $self;
}

#** @method public Saklient::Cloud::Resource::IsoImage close_ftp 
# 
# @brief FTPSを終了し、ISOイメージを利用可能な状態にします。
# 
# @retval this
#*
sub close_ftp {
	my $self = shift;
	my $_argnum = scalar @_;
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/ftp";
	my $result = $self->{'_client'}->request("DELETE", $path);
	$self->{'_ftp_info'} = undef;
	return $self;
}

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::IsoImage#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_scope 
# 
# @brief null
#*
my $n_scope = 0;

#** @method private string get_scope 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_scope'};
}

#** @method private string set_scope ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_scope'} = $v;
	$self->{'n_scope'} = 1;
	return $self->{'m_scope'};
}

#** @method public string scope ()
# 
# @brief スコープ {@link EScope}
#*
sub scope {
	if (1 < scalar(@_)) {
		$_[0]->set_scope($_[1]);
		return $_[0];
	}
	return $_[0]->get_scope();
}

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_name 
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

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_description 
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

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_tags 
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

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_icon 
# 
# @brief null
#*
my $n_icon = 0;

#** @method private Saklient::Cloud::Resource::Icon get_icon 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_icon'};
}

#** @method private Saklient::Cloud::Resource::Icon set_icon ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {Saklient::Cloud::Resource::Icon} v
#*
sub set_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resource::Icon");
	$self->{'m_icon'} = $v;
	$self->{'n_icon'} = 1;
	return $self->{'m_icon'};
}

#** @method public Saklient::Cloud::Resource::Icon icon ()
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

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_display_order 
# 
# @brief null
#*
my $n_display_order = 0;

#** @method private int get_display_order 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_display_order {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_display_order'};
}

#** @method private int set_display_order ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {int} v
#*
sub set_display_order {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	$self->{'m_display_order'} = $v;
	$self->{'n_display_order'} = 1;
	return $self->{'m_display_order'};
}

#** @method public int display_order ()
# 
# @brief 表示順序
#*
sub display_order {
	if (1 < scalar(@_)) {
		$_[0]->set_display_order($_[1]);
		return $_[0];
	}
	return $_[0]->get_display_order();
}

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_size_mib 
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
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resource::IsoImage#size_mib"); throw $ex; };
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

#** @var private bool Saklient::Cloud::Resource::IsoImage::$n_service_class 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::IsoImage#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
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
	if (Saklient::Util::exists_path($r, "Scope")) {
		$self->{'m_scope'} = !defined(Saklient::Util::get_by_path($r, "Scope")) ? undef : "" . Saklient::Util::get_by_path($r, "Scope");
	}
	else {
		$self->{'m_scope'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_scope'} = 0;
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
		$self->{'m_icon'} = !defined(Saklient::Util::get_by_path($r, "Icon")) ? undef : new Saklient::Cloud::Resource::Icon($self->{'_client'}, Saklient::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if (Saklient::Util::exists_path($r, "DisplayOrder")) {
		$self->{'m_display_order'} = !defined(Saklient::Util::get_by_path($r, "DisplayOrder")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "DisplayOrder")));
	}
	else {
		$self->{'m_display_order'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_display_order'} = 0;
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
	if ($withClean || $self->{'n_scope'}) {
		Saklient::Util::set_by_path($ret, "Scope", $self->{'m_scope'});
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
	if ($withClean || $self->{'n_display_order'}) {
		Saklient::Util::set_by_path($ret, "DisplayOrder", $self->{'m_display_order'});
	}
	if ($withClean || $self->{'n_size_mib'}) {
		Saklient::Util::set_by_path($ret, "SizeMB", $self->{'m_size_mib'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "size_mib");
		}
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saklient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the IsoImage creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

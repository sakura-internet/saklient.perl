#!/usr/bin/perl

package Saklient::Cloud::Resources::Script;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Icon;
use Saklient::Cloud::Enums::EScope;
use Saklient::Cloud::Enums::EScriptClass;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Script
# 
# @brief スクリプトの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Script::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Script::$m_scope 
# 
# @brief スコープ {@link EScope}
#*
my $m_scope;

#** @var private string Saklient::Cloud::Resources::Script::$m_clazz 
# 
# @brief クラス {@link EScriptClass}
#*
my $m_clazz;

#** @var private string Saklient::Cloud::Resources::Script::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::Script::$m_description 
# 
# @brief 説明
#*
my $m_description;

#** @var private string* Saklient::Cloud::Resources::Script::$m_tags 
# 
# @brief タグ
#*
my $m_tags;

#** @var private Icon Saklient::Cloud::Resources::Script::$m_icon 
# 
# @brief アイコン
#*
my $m_icon;

#** @var private string Saklient::Cloud::Resources::Script::$m_content 
# 
# @brief 内容
#*
my $m_content;

#** @var private any Saklient::Cloud::Resources::Script::$m_annotation 
# 
# @brief 注釈
#*
my $m_annotation;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/note";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Note";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Notes";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Script";
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

#** @method public Saklient::Cloud::Resources::Script save 
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

#** @method public Saklient::Cloud::Resources::Script reload 
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

#** @var private bool Saklient::Cloud::Resources::Script::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Script#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Script::$n_scope 
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

#** @method public string scope ()
# 
# @brief スコープ {@link EScope}
#*
sub scope {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Script#scope");
		throw $ex;
	}
	return $_[0]->get_scope();
}

#** @var private bool Saklient::Cloud::Resources::Script::$n_clazz 
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
	$self->{'m_clazz'} = $v;
	$self->{'n_clazz'} = 1;
	return $self->{'m_clazz'};
}

#** @method public string clazz ()
# 
# @brief クラス {@link EScriptClass}
#*
sub clazz {
	if (1 < scalar(@_)) {
		$_[0]->set_clazz($_[1]);
		return $_[0];
	}
	return $_[0]->get_clazz();
}

#** @var private bool Saklient::Cloud::Resources::Script::$n_name 
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

#** @method public string name ()
# 
# @brief 名前
#*
sub name {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Script#name");
		throw $ex;
	}
	return $_[0]->get_name();
}

#** @var private bool Saklient::Cloud::Resources::Script::$n_description 
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

#** @var private bool Saklient::Cloud::Resources::Script::$n_tags 
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

#** @var private bool Saklient::Cloud::Resources::Script::$n_icon 
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

#** @var private bool Saklient::Cloud::Resources::Script::$n_content 
# 
# @brief null
#*
my $n_content = 0;

#** @method private string get_content 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_content {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_content'};
}

#** @method private string set_content ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)@param {string} v
#*
sub set_content {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_content'} = $v;
	$self->{'n_content'} = 1;
	return $self->{'m_content'};
}

#** @method public string content ()
# 
# @brief 内容
#*
sub content {
	if (1 < scalar(@_)) {
		$_[0]->set_content($_[1]);
		return $_[0];
	}
	return $_[0]->get_content();
}

#** @var private bool Saklient::Cloud::Resources::Script::$n_annotation 
# 
# @brief null
#*
my $n_annotation = 0;

#** @method private any get_annotation 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_annotation {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_annotation'};
}

#** @method private any set_annotation ($v)
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub set_annotation {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	$self->{'m_annotation'} = $v;
	$self->{'n_annotation'} = 1;
	return $self->{'m_annotation'};
}

#** @method public any annotation ()
# 
# @brief 注釈
#*
sub annotation {
	if (1 < scalar(@_)) {
		$_[0]->set_annotation($_[1]);
		return $_[0];
	}
	return $_[0]->get_annotation();
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
	if (Saklient::Util::exists_path($r, "Content")) {
		$self->{'m_content'} = !defined(Saklient::Util::get_by_path($r, "Content")) ? undef : "" . Saklient::Util::get_by_path($r, "Content");
	}
	else {
		$self->{'m_content'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_content'} = 0;
	if (Saklient::Util::exists_path($r, "Remark")) {
		$self->{'m_annotation'} = Saklient::Util::get_by_path($r, "Remark");
	}
	else {
		$self->{'m_annotation'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_annotation'} = 0;
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
	if ($withClean || $self->{'n_clazz'}) {
		Saklient::Util::set_by_path($ret, "Class", $self->{'m_clazz'});
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
	if ($withClean || $self->{'n_content'}) {
		Saklient::Util::set_by_path($ret, "Content", $self->{'m_content'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "content");
		}
	}
	if ($withClean || $self->{'n_annotation'}) {
		Saklient::Util::set_by_path($ret, "Remark", $self->{'m_annotation'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Script creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

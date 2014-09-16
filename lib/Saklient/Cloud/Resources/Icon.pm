#!/usr/bin/perl

package Saklient::Cloud::Resources::Icon;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Enums::EScope;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Icon
# 
# @brief アイコンの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Icon::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Icon::$m_scope 
# 
# @brief スコープ {@link EScope}
#*
my $m_scope;

#** @var private string Saklient::Cloud::Resources::Icon::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private string Saklient::Cloud::Resources::Icon::$m_url 
# 
# @brief URL
#*
my $m_url;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/icon";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Icon";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Icons";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Icon";
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

#** @method public Saklient::Cloud::Resources::Icon save 
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

#** @method public Saklient::Cloud::Resources::Icon reload 
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

#** @var private bool Saklient::Cloud::Resources::Icon::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Icon#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Icon::$n_scope 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Icon#scope");
		throw $ex;
	}
	return $_[0]->get_scope();
}

#** @var private bool Saklient::Cloud::Resources::Icon::$n_name 
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

#** @var private bool Saklient::Cloud::Resources::Icon::$n_url 
# 
# @brief null
#*
my $n_url = 0;

#** @method private string get_url 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_url {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_url'};
}

#** @method public string url ()
# 
# @brief URL
#*
sub url {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Icon#url");
		throw $ex;
	}
	return $_[0]->get_url();
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
	if (Saklient::Util::exists_path($r, "URL")) {
		$self->{'m_url'} = !defined(Saklient::Util::get_by_path($r, "URL")) ? undef : "" . Saklient::Util::get_by_path($r, "URL");
	}
	else {
		$self->{'m_url'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_url'} = 0;
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
	if ($withClean || $self->{'n_url'}) {
		Saklient::Util::set_by_path($ret, "URL", $self->{'m_url'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Icon creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

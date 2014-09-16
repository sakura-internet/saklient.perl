#!/usr/bin/perl

package Saklient::Cloud::Resources::Ipv6Net;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Swytch;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Ipv6Net
# 
# @brief IPv6ネットワークの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Ipv6Net::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Ipv6Net::$m_prefix 
# 
# @brief ネットワークプレフィックス
#*
my $m_prefix;

#** @var private int Saklient::Cloud::Resources::Ipv6Net::$m_prefix_len 
# 
# @brief ネットワークプレフィックス長
#*
my $m_prefix_len;

#** @var private string Saklient::Cloud::Resources::Ipv6Net::$m_prefix_tail 
# 
# @brief このネットワーク範囲における最後のIPv6アドレス
#*
my $m_prefix_tail;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/ipv6net";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "IPv6Net";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "IPv6Nets";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Ipv6Net";
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

#** @var private bool Saklient::Cloud::Resources::Ipv6Net::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv6Net#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Ipv6Net::$n_prefix 
# 
# @brief null
#*
my $n_prefix = 0;

#** @method private string get_prefix 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_prefix {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix'};
}

#** @method public string prefix ()
# 
# @brief ネットワークプレフィックス
#*
sub prefix {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv6Net#prefix");
		throw $ex;
	}
	return $_[0]->get_prefix();
}

#** @var private bool Saklient::Cloud::Resources::Ipv6Net::$n_prefix_len 
# 
# @brief null
#*
my $n_prefix_len = 0;

#** @method private int get_prefix_len 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_prefix_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix_len'};
}

#** @method public int prefix_len ()
# 
# @brief ネットワークプレフィックス長
#*
sub prefix_len {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv6Net#prefix_len");
		throw $ex;
	}
	return $_[0]->get_prefix_len();
}

#** @var private bool Saklient::Cloud::Resources::Ipv6Net::$n_prefix_tail 
# 
# @brief null
#*
my $n_prefix_tail = 0;

#** @method private string get_prefix_tail 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_prefix_tail {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix_tail'};
}

#** @method public string prefix_tail ()
# 
# @brief このネットワーク範囲における最後のIPv6アドレス
#*
sub prefix_tail {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv6Net#prefix_tail");
		throw $ex;
	}
	return $_[0]->get_prefix_tail();
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
	if (Saklient::Util::exists_path($r, "IPv6Prefix")) {
		$self->{'m_prefix'} = !defined(Saklient::Util::get_by_path($r, "IPv6Prefix")) ? undef : "" . Saklient::Util::get_by_path($r, "IPv6Prefix");
	}
	else {
		$self->{'m_prefix'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix'} = 0;
	if (Saklient::Util::exists_path($r, "IPv6PrefixLen")) {
		$self->{'m_prefix_len'} = !defined(Saklient::Util::get_by_path($r, "IPv6PrefixLen")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "IPv6PrefixLen")));
	}
	else {
		$self->{'m_prefix_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_len'} = 0;
	if (Saklient::Util::exists_path($r, "IPv6PrefixTail")) {
		$self->{'m_prefix_tail'} = !defined(Saklient::Util::get_by_path($r, "IPv6PrefixTail")) ? undef : "" . Saklient::Util::get_by_path($r, "IPv6PrefixTail");
	}
	else {
		$self->{'m_prefix_tail'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_tail'} = 0;
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
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_prefix'}) {
		Saklient::Util::set_by_path($ret, "IPv6Prefix", $self->{'m_prefix'});
	}
	if ($withClean || $self->{'n_prefix_len'}) {
		Saklient::Util::set_by_path($ret, "IPv6PrefixLen", $self->{'m_prefix_len'});
	}
	if ($withClean || $self->{'n_prefix_tail'}) {
		Saklient::Util::set_by_path($ret, "IPv6PrefixTail", $self->{'m_prefix_tail'});
	}
	return $ret;
}

1;

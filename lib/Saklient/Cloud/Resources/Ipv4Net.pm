#!/usr/bin/perl

package Saklient::Cloud::Resources::Ipv4Net;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Swytch;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::Ipv4Net
# 
# @brief IPv4ネットワークの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resources::Ipv4Net::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::Ipv4Net::$m_address 
# 
# @brief ネットワークアドレス
#*
my $m_address;

#** @var private int Saklient::Cloud::Resources::Ipv4Net::$m_mask_len 
# 
# @brief マスク長
#*
my $m_mask_len;

#** @var private string Saklient::Cloud::Resources::Ipv4Net::$m_default_route 
# 
# @brief デフォルトルート
#*
my $m_default_route;

#** @var private string Saklient::Cloud::Resources::Ipv4Net::$m_next_hop 
# 
# @brief ネクストホップ
#*
my $m_next_hop;

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/subnet";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Subnet";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Subnets";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Ipv4Net";
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

#** @var private bool Saklient::Cloud::Resources::Ipv4Net::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Net#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::Ipv4Net::$n_address 
# 
# @brief null
#*
my $n_address = 0;

#** @method private string get_address 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_address'};
}

#** @method public string address ()
# 
# @brief ネットワークアドレス
#*
sub address {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Net#address");
		throw $ex;
	}
	return $_[0]->get_address();
}

#** @var private bool Saklient::Cloud::Resources::Ipv4Net::$n_mask_len 
# 
# @brief null
#*
my $n_mask_len = 0;

#** @method private int get_mask_len 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_mask_len'};
}

#** @method public int mask_len ()
# 
# @brief マスク長
#*
sub mask_len {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Net#mask_len");
		throw $ex;
	}
	return $_[0]->get_mask_len();
}

#** @var private bool Saklient::Cloud::Resources::Ipv4Net::$n_default_route 
# 
# @brief null
#*
my $n_default_route = 0;

#** @method private string get_default_route 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_default_route'};
}

#** @method public string default_route ()
# 
# @brief デフォルトルート
#*
sub default_route {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Net#default_route");
		throw $ex;
	}
	return $_[0]->get_default_route();
}

#** @var private bool Saklient::Cloud::Resources::Ipv4Net::$n_next_hop 
# 
# @brief null
#*
my $n_next_hop = 0;

#** @method private string get_next_hop 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_next_hop {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_next_hop'};
}

#** @method public string next_hop ()
# 
# @brief ネクストホップ
#*
sub next_hop {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Net#next_hop");
		throw $ex;
	}
	return $_[0]->get_next_hop();
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
	if (Saklient::Util::exists_path($r, "NetworkAddress")) {
		$self->{'m_address'} = !defined(Saklient::Util::get_by_path($r, "NetworkAddress")) ? undef : "" . Saklient::Util::get_by_path($r, "NetworkAddress");
	}
	else {
		$self->{'m_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_address'} = 0;
	if (Saklient::Util::exists_path($r, "NetworkMaskLen")) {
		$self->{'m_mask_len'} = !defined(Saklient::Util::get_by_path($r, "NetworkMaskLen")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "NetworkMaskLen")));
	}
	else {
		$self->{'m_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mask_len'} = 0;
	if (Saklient::Util::exists_path($r, "DefaultRoute")) {
		$self->{'m_default_route'} = !defined(Saklient::Util::get_by_path($r, "DefaultRoute")) ? undef : "" . Saklient::Util::get_by_path($r, "DefaultRoute");
	}
	else {
		$self->{'m_default_route'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_default_route'} = 0;
	if (Saklient::Util::exists_path($r, "NextHop")) {
		$self->{'m_next_hop'} = !defined(Saklient::Util::get_by_path($r, "NextHop")) ? undef : "" . Saklient::Util::get_by_path($r, "NextHop");
	}
	else {
		$self->{'m_next_hop'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_next_hop'} = 0;
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
	if ($withClean || $self->{'n_address'}) {
		Saklient::Util::set_by_path($ret, "NetworkAddress", $self->{'m_address'});
	}
	if ($withClean || $self->{'n_mask_len'}) {
		Saklient::Util::set_by_path($ret, "NetworkMaskLen", $self->{'m_mask_len'});
	}
	if ($withClean || $self->{'n_default_route'}) {
		Saklient::Util::set_by_path($ret, "DefaultRoute", $self->{'m_default_route'});
	}
	if ($withClean || $self->{'n_next_hop'}) {
		Saklient::Util::set_by_path($ret, "NextHop", $self->{'m_next_hop'});
	}
	return $ret;
}

1;

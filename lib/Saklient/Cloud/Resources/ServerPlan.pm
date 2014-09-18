#!/usr/bin/perl

package Saklient::Cloud::Resources::ServerPlan;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Resource;

use base qw(Saklient::Cloud::Resources::Resource);

#** @class Saklient::Cloud::Resources::ServerPlan
# 
# @brief サーバプラン情報の1レコードに対応するクラス。
#*


#** @var private string Saklient::Cloud::Resources::ServerPlan::$m_id 
# 
# @brief ID
#*
my $m_id;

#** @var private string Saklient::Cloud::Resources::ServerPlan::$m_name 
# 
# @brief 名前
#*
my $m_name;

#** @var private int Saklient::Cloud::Resources::ServerPlan::$m_cpu 
# 
# @brief 仮想コア数
#*
my $m_cpu;

#** @var private int Saklient::Cloud::Resources::ServerPlan::$m_memory_mib 
# 
# @brief メモリ容量[MiB]
#*
my $m_memory_mib;

#** @var private string Saklient::Cloud::Resources::ServerPlan::$m_service_class 
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
	return "/product/server";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlan";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlans";
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlan";
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

#** @method private int get_memory_gib 
# 
# @brief null
#*
sub get_memory_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $memoryMib = $self->get_memory_mib();
	return !defined($memoryMib) ? undef : $memoryMib >> 10;
}

#** @method public int memory_gib ()
# 
# @brief null
#*
sub memory_gib {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerPlan#memory_gib");
		throw $ex;
	}
	return $_[0]->get_memory_gib();
}

#** @var private bool Saklient::Cloud::Resources::ServerPlan::$n_id 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerPlan#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

#** @var private bool Saklient::Cloud::Resources::ServerPlan::$n_name 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerPlan#name");
		throw $ex;
	}
	return $_[0]->get_name();
}

#** @var private bool Saklient::Cloud::Resources::ServerPlan::$n_cpu 
# 
# @brief null
#*
my $n_cpu = 0;

#** @method private int get_cpu 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_cpu {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_cpu'};
}

#** @method public int cpu ()
# 
# @brief 仮想コア数
#*
sub cpu {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerPlan#cpu");
		throw $ex;
	}
	return $_[0]->get_cpu();
}

#** @var private bool Saklient::Cloud::Resources::ServerPlan::$n_memory_mib 
# 
# @brief null
#*
my $n_memory_mib = 0;

#** @method private int get_memory_mib 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_memory_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_memory_mib'};
}

#** @method public int memory_mib ()
# 
# @brief メモリ容量[MiB]
#*
sub memory_mib {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerPlan#memory_mib");
		throw $ex;
	}
	return $_[0]->get_memory_mib();
}

#** @var private bool Saklient::Cloud::Resources::ServerPlan::$n_service_class 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerPlan#service_class");
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
	if (Saklient::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saklient::Util::get_by_path($r, "Name")) ? undef : "" . Saklient::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saklient::Util::exists_path($r, "CPU")) {
		$self->{'m_cpu'} = !defined(Saklient::Util::get_by_path($r, "CPU")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "CPU")));
	}
	else {
		$self->{'m_cpu'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_cpu'} = 0;
	if (Saklient::Util::exists_path($r, "MemoryMB")) {
		$self->{'m_memory_mib'} = !defined(Saklient::Util::get_by_path($r, "MemoryMB")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "MemoryMB")));
	}
	else {
		$self->{'m_memory_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_memory_mib'} = 0;
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
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saklient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	if ($withClean || $self->{'n_cpu'}) {
		Saklient::Util::set_by_path($ret, "CPU", $self->{'m_cpu'});
	}
	if ($withClean || $self->{'n_memory_mib'}) {
		Saklient::Util::set_by_path($ret, "MemoryMB", $self->{'m_memory_mib'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saklient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	return $ret;
}

1;

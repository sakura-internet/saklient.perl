#!/usr/bin/perl

package Saklient::Cloud::Resources::GslbServer;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;


#** @class Saklient::Cloud::Resources::GslbServer
# 
# @brief GSLBの監視対象サーバ設定。
#*


#** @var private bool Saklient::Cloud::Resources::GslbServer::$_enabled 
# 
# @private
#*
my $_enabled;

#** @method public bool get_enabled 
# 
# @brief null
#*
sub get_enabled {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_enabled'};
}

#** @method public bool set_enabled ($v)
# 
# @brief null@param {bool} v
#*
sub set_enabled {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "bool");
	$self->{'_enabled'} = $v;
	return $self->{'_enabled'};
}

#** @method public bool enabled ()
# 
# @brief 有効状態
#*
sub enabled {
	if (1 < scalar(@_)) {
		$_[0]->set_enabled($_[1]);
		return $_[0];
	}
	return $_[0]->get_enabled();
}

#** @var private string Saklient::Cloud::Resources::GslbServer::$_ip_address 
# 
# @private
#*
my $_ip_address;

#** @method public string get_ip_address 
# 
# @brief null
#*
sub get_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ip_address'};
}

#** @method public string set_ip_address ($v)
# 
# @brief null@param {string} v
#*
sub set_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_ip_address'} = $v;
	return $self->{'_ip_address'};
}

#** @method public string ip_address ()
# 
# @brief IPアドレス
#*
sub ip_address {
	if (1 < scalar(@_)) {
		$_[0]->set_ip_address($_[1]);
		return $_[0];
	}
	return $_[0]->get_ip_address();
}

#** @var private int Saklient::Cloud::Resources::GslbServer::$_weight 
# 
# @private
#*
my $_weight;

#** @method public int get_weight 
# 
# @brief null
#*
sub get_weight {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_weight'};
}

#** @method public int set_weight ($v)
# 
# @brief null@param {int} v
#*
sub set_weight {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	$self->{'_weight'} = $v;
	return $self->{'_weight'};
}

#** @method public int weight ()
# 
# @brief 重み値
#*
sub weight {
	if (1 < scalar(@_)) {
		$_[0]->set_weight($_[1]);
		return $_[0];
	}
	return $_[0]->get_weight();
}

#** @method public void new ($obj)
# 
# @ignore
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $obj = shift || (undef);
	if (!defined($obj)) {
		$obj = {};
	}
	my $enabled = Saklient::Util::get_by_path_any([$obj], ["Enabled", "enabled"]);
	$self->{'_enabled'} = undef;
	if (defined($enabled)) {
		my $enabledStr = $enabled;
		$self->{'_enabled'} = lc($enabledStr) eq "true";
	}
	$self->{'_ip_address'} = Saklient::Util::get_by_path_any([$obj], [
		"IPAddress",
		"ipAddress",
		"ip_address",
		"ip"
	]);
	my $weight = Saklient::Util::get_by_path_any([$obj], ["Weight", "weight"]);
	$self->{'_weight'} = undef;
	if (defined($weight)) {
		$self->{'_weight'} = (0+($weight));
	}
	if (Saklient::Util::num_eq($self->{'_weight'}, 0)) {
		$self->{'_weight'} = undef;
	}
	return $self;
}

#** @method public any to_raw_settings 
# 
# @brief null
#*
sub to_raw_settings {
	my $self = shift;
	my $_argnum = scalar @_;
	return {
		'Enabled' => !defined($self->{'_enabled'}) ? undef : ($self->{'_enabled'} ? "True" : "False"),
		'IPAddress' => $self->{'_ip_address'},
		'Weight' => $self->{'_weight'}
	};
}

1;

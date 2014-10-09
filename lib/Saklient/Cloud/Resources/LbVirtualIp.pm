#!/usr/bin/perl

package Saklient::Cloud::Resources::LbVirtualIp;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Resources::LbServer;


#** @class Saklient::Cloud::Resources::LbVirtualIp
# 
# @brief ロードバランサの仮想IPアドレス。
#*


#** @var private string Saklient::Cloud::Resources::LbVirtualIp::$_virtual_ip_address 
# 
# @private
#*
my $_virtual_ip_address;

#** @method public string get_virtual_ip_address 
# 
# @brief null
#*
sub get_virtual_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_virtual_ip_address'};
}

#** @method public string virtual_ip_address ()
# 
# @brief VIPアドレス
#*
sub virtual_ip_address {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbVirtualIp#virtual_ip_address");
		throw $ex;
	}
	return $_[0]->get_virtual_ip_address();
}

#** @var private int Saklient::Cloud::Resources::LbVirtualIp::$_port 
# 
# @private
#*
my $_port;

#** @method public int get_port 
# 
# @brief null
#*
sub get_port {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_port'};
}

#** @method public int port ()
# 
# @brief ポート番号
#*
sub port {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbVirtualIp#port");
		throw $ex;
	}
	return $_[0]->get_port();
}

#** @var private int Saklient::Cloud::Resources::LbVirtualIp::$_delay_loop 
# 
# @private
#*
my $_delay_loop;

#** @method public int get_delay_loop 
# 
# @brief null
#*
sub get_delay_loop {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_delay_loop'};
}

#** @method public int delay_loop ()
# 
# @brief チェック間隔 [秒]
#*
sub delay_loop {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbVirtualIp#delay_loop");
		throw $ex;
	}
	return $_[0]->get_delay_loop();
}

#** @var private Saklient::Cloud::Resources::LbServer* Saklient::Cloud::Resources::LbVirtualIp::$_servers 
# 
# @private
#*
my $_servers;

#** @method public Saklient::Cloud::Resources::LbServer[] get_servers 
# 
# @brief null
#*
sub get_servers {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_servers'};
}

#** @method public Saklient::Cloud::Resources::LbServer[] servers ()
# 
# @brief 実サーバ
#*
sub servers {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbVirtualIp#servers");
		throw $ex;
	}
	return $_[0]->get_servers();
}

#** @method public void new ($obj)
# 
# @ignore
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $obj = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	my $vip = Saklient::Util::get_by_path_any([$obj], [
		"VirtualIPAddress",
		"virtualIpAddress",
		"virtual_ip_address",
		"vip"
	]);
	$self->{'_virtual_ip_address'} = $vip;
	my $port = Saklient::Util::get_by_path_any([$obj], ["Port", "port"]);
	$self->{'_port'} = !defined($port) ? undef : (0+($port));
	if ($self->{'_port'} == 0) {
		$self->{'_port'} = undef;
	}
	my $delayLoop = Saklient::Util::get_by_path_any([$obj], [
		"DelayLoop",
		"delayLoop",
		"delay_loop",
		"delay"
	]);
	$self->{'_delay_loop'} = !defined($delayLoop) ? undef : (0+($delayLoop));
	if ($self->{'_delay_loop'} == 0) {
		$self->{'_delay_loop'} = undef;
	}
	$self->{'_servers'} = [];
	my $serversDyn = Saklient::Util::get_by_path_any([$obj], ["Servers", "servers"]);
	if (defined($serversDyn)) {
		my $servers = $serversDyn;
		foreach my $server (@{$servers}) {
			push(@{$self->{'_servers'}}, new Saklient::Cloud::Resources::LbServer($server));
		}
	}
	return $self;
}

#** @method public Saklient::Cloud::Resources::LbVirtualIp add_server ($settings)
# 
# @brief null
#*
sub add_server {
	my $self = shift;
	my $_argnum = scalar @_;
	my $settings = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	push(@{$self->{'_servers'}}, new Saklient::Cloud::Resources::LbServer($settings));
	return $self;
}

#** @method public any to_raw_settings 
# 
# @brief null
#*
sub to_raw_settings {
	my $self = shift;
	my $_argnum = scalar @_;
	my $servers = [];
	foreach my $server (@{$self->{'_servers'}}) {
		push(@{$servers}, $server->to_raw_settings());
	}
	return {
		'VirtualIPAddress' => $self->{'_virtual_ip_address'},
		'Port' => $self->{'_port'},
		'DelayLoop' => $self->{'_delay_loop'},
		'Servers' => $servers
	};
}

1;

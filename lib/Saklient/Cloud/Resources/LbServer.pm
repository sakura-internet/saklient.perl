#!/usr/bin/perl

package Saklient::Cloud::Resources::LbServer;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;


#** @class Saklient::Cloud::Resources::LbServer
# 
# @brief ロードバランサの監視対象サーバ。
#*


#** @var private string Saklient::Cloud::Resources::LbServer::$_ip_address 
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

#** @method public string ip_address ()
# 
# @brief IPアドレス
#*
sub ip_address {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#ip_address");
		throw $ex;
	}
	return $_[0]->get_ip_address();
}

#** @var private int Saklient::Cloud::Resources::LbServer::$_port 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#port");
		throw $ex;
	}
	return $_[0]->get_port();
}

#** @var private string Saklient::Cloud::Resources::LbServer::$_protocol 
# 
# @private
#*
my $_protocol;

#** @method public string get_protocol 
# 
# @brief null
#*
sub get_protocol {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_protocol'};
}

#** @method public string protocol ()
# 
# @brief 監視方法
#*
sub protocol {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#protocol");
		throw $ex;
	}
	return $_[0]->get_protocol();
}

#** @var private string Saklient::Cloud::Resources::LbServer::$_path_to_check 
# 
# @private
#*
my $_path_to_check;

#** @method public string get_path_to_check 
# 
# @brief null
#*
sub get_path_to_check {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_path_to_check'};
}

#** @method public string path_to_check ()
# 
# @brief パス
#*
sub path_to_check {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#path_to_check");
		throw $ex;
	}
	return $_[0]->get_path_to_check();
}

#** @var private int Saklient::Cloud::Resources::LbServer::$_expected_status 
# 
# @private
#*
my $_expected_status;

#** @method public int get_expected_status 
# 
# @brief null
#*
sub get_expected_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_expected_status'};
}

#** @method public int expected_status ()
# 
# @brief レスポンスコード
#*
sub expected_status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#expected_status");
		throw $ex;
	}
	return $_[0]->get_expected_status();
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
	my $health = Saklient::Util::get_by_path_any([$obj], [
		"HealthCheck",
		"healthCheck",
		"health_check",
		"health"
	]);
	$self->{'_ip_address'} = Saklient::Util::get_by_path_any([$obj], [
		"IPAddress",
		"ipAddress",
		"ip_address",
		"ip"
	]);
	$self->{'_protocol'} = Saklient::Util::get_by_path_any([$health, $obj], ["Protocol", "protocol"]);
	$self->{'_path_to_check'} = Saklient::Util::get_by_path_any([$health, $obj], ["Path", "path"]);
	my $port = Saklient::Util::get_by_path_any([$obj], ["Port", "port"]);
	$self->{'_port'} = !defined($port) ? undef : (0+($port));
	if ($self->{'_port'} == 0) {
		$self->{'_port'} = undef;
	}
	my $status = Saklient::Util::get_by_path_any([$health, $obj], ["Status", "status"]);
	$self->{'_expected_status'} = !defined($status) ? undef : (0+($status));
	if ($self->{'_expected_status'} == 0) {
		$self->{'_expected_status'} = undef;
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
		'IPAddress' => $self->{'_ip_address'},
		'Port' => $self->{'_port'},
		'HealthCheck' => {
			'Protocol' => $self->{'_protocol'},
			'Path' => $self->{'_path_to_check'},
			'Status' => $self->{'_expected_status'}
		}
	};
}

1;

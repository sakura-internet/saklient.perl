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
# @brief ロードバランサの監視対象サーバ設定。
#*


#** @var private bool Saklient::Cloud::Resources::LbServer::$_enabled 
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

#** @method public int set_port ($v)
# 
# @brief null@param {int} v
#*
sub set_port {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	$self->{'_port'} = $v;
	return $self->{'_port'};
}

#** @method public int port ()
# 
# @brief ポート番号
#*
sub port {
	if (1 < scalar(@_)) {
		$_[0]->set_port($_[1]);
		return $_[0];
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

#** @method public string set_protocol ($v)
# 
# @brief null@param {string} v
#*
sub set_protocol {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_protocol'} = $v;
	return $self->{'_protocol'};
}

#** @method public string protocol ()
# 
# @brief 監視方法
#*
sub protocol {
	if (1 < scalar(@_)) {
		$_[0]->set_protocol($_[1]);
		return $_[0];
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

#** @method public string set_path_to_check ($v)
# 
# @brief null@param {string} v
#*
sub set_path_to_check {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_path_to_check'} = $v;
	return $self->{'_path_to_check'};
}

#** @method public string path_to_check ()
# 
# @brief 監視対象パス
#*
sub path_to_check {
	if (1 < scalar(@_)) {
		$_[0]->set_path_to_check($_[1]);
		return $_[0];
	}
	return $_[0]->get_path_to_check();
}

#** @var private int Saklient::Cloud::Resources::LbServer::$_response_expected 
# 
# @private
#*
my $_response_expected;

#** @method public int get_response_expected 
# 
# @brief null
#*
sub get_response_expected {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_response_expected'};
}

#** @method public int set_response_expected ($v)
# 
# @brief null@param {int} v
#*
sub set_response_expected {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	$self->{'_response_expected'} = $v;
	return $self->{'_response_expected'};
}

#** @method public int response_expected ()
# 
# @brief 監視時に期待されるレスポンスコード
#*
sub response_expected {
	if (1 < scalar(@_)) {
		$_[0]->set_response_expected($_[1]);
		return $_[0];
	}
	return $_[0]->get_response_expected();
}

#** @var private int Saklient::Cloud::Resources::LbServer::$_active_connections 
# 
# @private
#*
my $_active_connections;

#** @method public int get_active_connections 
# 
# @brief null
#*
sub get_active_connections {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_active_connections'};
}

#** @method public int active_connections ()
# 
# @brief 現在の接続数
#*
sub active_connections {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#active_connections");
		throw $ex;
	}
	return $_[0]->get_active_connections();
}

#** @var private string Saklient::Cloud::Resources::LbServer::$_status 
# 
# @private
#*
my $_status;

#** @method public string get_status 
# 
# @brief null
#*
sub get_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_status'};
}

#** @method public string status ()
# 
# @brief 現在の状態
#*
sub status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::LbServer#status");
		throw $ex;
	}
	return $_[0]->get_status();
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
	my $health = Saklient::Util::get_by_path_any([$obj], [
		"HealthCheck",
		"healthCheck",
		"health_check",
		"health"
	]);
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
	$self->{'_protocol'} = Saklient::Util::get_by_path_any([$health, $obj], ["Protocol", "protocol"]);
	$self->{'_path_to_check'} = Saklient::Util::get_by_path_any([$health, $obj], [
		"Path",
		"path",
		"pathToCheck",
		"path_to_check"
	]);
	my $port = Saklient::Util::get_by_path_any([$obj], ["Port", "port"]);
	$self->{'_port'} = undef;
	if (defined($port)) {
		$self->{'_port'} = (0+($port));
	}
	if (Saklient::Util::num_eq($self->{'_port'}, 0)) {
		$self->{'_port'} = undef;
	}
	my $responseExpected = Saklient::Util::get_by_path_any([$health, $obj], [
		"Status",
		"status",
		"responseExpected",
		"response_expected"
	]);
	$self->{'_response_expected'} = undef;
	if (defined($responseExpected)) {
		$self->{'_response_expected'} = (0+($responseExpected));
	}
	if (Saklient::Util::num_eq($self->{'_response_expected'}, 0)) {
		$self->{'_response_expected'} = undef;
	}
	$self->{'_active_connections'} = 0;
	$self->{'_status'} = undef;
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
		'Port' => $self->{'_port'},
		'HealthCheck' => {
			'Protocol' => $self->{'_protocol'},
			'Path' => $self->{'_path_to_check'},
			'Status' => $self->{'_response_expected'}
		}
	};
}

#** @method public Saklient::Cloud::Resources::LbServer update_status ($obj)
# 
# @ignore
#*
sub update_status {
	my $self = shift;
	my $_argnum = scalar @_;
	my $obj = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	my $connStr = $obj->{"ActiveConn"};
	$self->{'_active_connections'} = 0;
	if (defined($connStr)) {
		$self->{'_active_connections'} = (0+($connStr));
	}
	my $status = $obj->{"Status"};
	$self->{'_status'} = !defined($status) ? undef : lc($status);
	return $self;
}

1;

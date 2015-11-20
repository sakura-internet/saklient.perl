#!/usr/bin/perl

package Saklient::Cloud::Resources::Gslb;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::CommonServiceItem;
use Saklient::Cloud::Resources::GslbServer;

use base qw(Saklient::Cloud::Resources::CommonServiceItem);

#** @class Saklient::Cloud::Resources::Gslb
# 
# @brief GSLBの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private Saklient::Cloud::Resources::GslbServer* Saklient::Cloud::Resources::Gslb::$_servers 
# 
# @private
#*
my $_servers;

#** @method public Saklient::Cloud::Resources::GslbServer[] get_servers 
# 
# @brief null
#*
sub get_servers {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_servers'};
}

#** @method public Saklient::Cloud::Resources::GslbServer[] servers ()
# 
# @brief 仮想IPアドレス {@link GslbServer} の配列
#*
sub servers {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Gslb#servers");
		throw $ex;
	}
	return $_[0]->get_servers();
}

#** @method public string get_protocol 
# 
# @brief null
#*
sub get_protocol {
	my $self = shift;
	my $_argnum = scalar @_;
	my $raw = Saklient::Util::get_by_path($self->raw_settings(), "GSLB.HealthCheck.Protocol");
	if (!defined($raw)) {
		{ my $ex = new Saklient::Errors::SaklientException("invalid_data", "Data of the resource is invalid"); throw $ex; };
	}
	return $raw;
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
	$self->_normalize();
	Saklient::Util::set_by_path($self->raw_settings(), "GSLB.HealthCheck.Protocol", $v);
	return $v;
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

#** @method public string get_path_to_check 
# 
# @brief null
#*
sub get_path_to_check {
	my $self = shift;
	my $_argnum = scalar @_;
	if (!Saklient::Util::exists_path($self->raw_settings(), "GSLB.HealthCheck.Path")) {
		return undef;
	}
	my $raw = Saklient::Util::get_by_path($self->raw_settings(), "GSLB.HealthCheck.Path");
	return $raw;
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
	$self->_normalize();
	Saklient::Util::set_by_path($self->raw_settings(), "GSLB.HealthCheck.Path", $v);
	return $v;
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

#** @method public int get_response_expected 
# 
# @brief null
#*
sub get_response_expected {
	my $self = shift;
	my $_argnum = scalar @_;
	my $raw = Saklient::Util::get_by_path($self->raw_settings(), "GSLB.HealthCheck.Status");
	if (!defined($raw)) {
		{ my $ex = new Saklient::Errors::SaklientException("invalid_data", "Data of the resource is invalid"); throw $ex; };
	}
	return (0+($raw));
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
	$self->_normalize();
	Saklient::Util::set_by_path($self->raw_settings(), "GSLB.HealthCheck.Status", $v);
	return $v;
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

#** @method public int get_delay_loop 
# 
# @brief null
#*
sub get_delay_loop {
	my $self = shift;
	my $_argnum = scalar @_;
	my $delayLoop = Saklient::Util::get_by_path($self->raw_settings(), "GSLB.DelayLoop");
	if (!defined($delayLoop)) {
		{ my $ex = new Saklient::Errors::SaklientException("invalid_data", "Data of the resource is invalid"); throw $ex; };
	}
	return (0+($delayLoop));
}

#** @method public int set_delay_loop ($v)
# 
# @brief null@param {int} v
#*
sub set_delay_loop {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	$self->_normalize();
	Saklient::Util::set_by_path($self->raw_settings(), "GSLB.DelayLoop", $v);
	return $v;
}

#** @method public int delay_loop ()
# 
# @brief チェック間隔(秒)
#*
sub delay_loop {
	if (1 < scalar(@_)) {
		$_[0]->set_delay_loop($_[1]);
		return $_[0];
	}
	return $_[0]->get_delay_loop();
}

#** @method public bool get_weighted 
# 
# @brief null
#*
sub get_weighted {
	my $self = shift;
	my $_argnum = scalar @_;
	my $weighted = Saklient::Util::get_by_path($self->raw_settings(), "GSLB.Weighted");
	if (!defined($weighted)) {
		{ my $ex = new Saklient::Errors::SaklientException("invalid_data", "Data of the resource is invalid"); throw $ex; };
	}
	return lc($weighted) eq "true";
}

#** @method public bool set_weighted ($v)
# 
# @brief null@param {bool} v
#*
sub set_weighted {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "bool");
	$self->_normalize();
	Saklient::Util::set_by_path($self->raw_settings(), "GSLB.Weighted", $v ? "True" : "False");
	return $v;
}

#** @method public bool weighted ()
# 
# @brief 重み付け応答
#*
sub weighted {
	if (1 < scalar(@_)) {
		$_[0]->set_weighted($_[1]);
		return $_[0];
	}
	return $_[0]->get_weighted();
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
	$self = $class->SUPER::new($client, $obj, $wrapped);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	$self->_normalize();
	return $self;
}

#** @method private void _normalize 
# 
# @private
# @ignore 
#*
sub _normalize {
	my $self = shift;
	my $_argnum = scalar @_;
	if (!defined($self->{'_servers'})) {
		$self->{'_servers'} = [];
	}
	if (!defined($self->raw_settings())) {
		$self->raw_settings({});
	}
	if (!Saklient::Util::exists_path($self->raw_settings(), "GSLB")) {
		Saklient::Util::set_by_path($self->raw_settings(), "GSLB", {});
	}
	if (!Saklient::Util::exists_path($self->raw_settings(), "GSLB.HealthCheck")) {
		Saklient::Util::set_by_path($self->raw_settings(), "GSLB.HealthCheck", {});
	}
	if (!Saklient::Util::exists_path($self->raw_settings(), "GSLB.Servers")) {
		Saklient::Util::set_by_path($self->raw_settings(), "GSLB.Servers", []);
	}
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
	$self->_normalize();
	$self->{'_servers'} = [];
	my $settings = $self->raw_settings();
	if (defined($settings)) {
		my $raw = Saklient::Util::get_by_path($settings, "GSLB.Servers");
		if (!defined($raw)) {
			$raw = [];
		}
		my $servers = $raw;
		foreach my $server (@{$servers}) {
			push(@{$self->{'_servers'}}, new Saklient::Cloud::Resources::GslbServer($server));
		}
	}
}

#** @method private void _on_before_api_serialize ($withClean)
# 
# @private@param {bool} withClean
#*
sub _on_before_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($withClean, "bool");
	$self->_normalize();
	my $servers = [];
	foreach my $server (@{$self->{'_servers'}}) {
		push(@{$servers}, $server->to_raw_settings());
	}
	Saklient::Util::set_by_path($self->raw_settings(), "GSLB.Servers", $servers);
}

#** @method private void _on_after_api_serialize ($r, $withClean)
# 
# @private@param {bool} withClean
#*
sub _on_after_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($withClean, "bool");
	if (!defined($r)) {
		return;
	}
	Saklient::Util::set_by_path($r, "Provider", {});
	Saklient::Util::set_by_path($r, "Provider.Class", "gslb");
}

#** @method public Saklient::Cloud::Resources::Gslb set_initial_params ($protocol, $delayLoop, $weighted)
# 
# @ignore
# @param string $protocol
# @param int $delayLoop
# @param bool $weighted
#*
sub set_initial_params {
	my $self = shift;
	my $_argnum = scalar @_;
	my $protocol = shift;
	my $delayLoop = shift || (10);
	my $weighted = shift || (1);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($protocol, "string");
	Saklient::Util::validate_type($delayLoop, "int");
	Saklient::Util::validate_type($weighted, "bool");
	my $settings = $self->raw_settings();
	$self->protocol($protocol);
	$self->delay_loop($delayLoop);
	$self->weighted($weighted);
	return $self;
}

#** @method public Saklient::Cloud::Resources::GslbServer add_server ($settings)
# 
# @brief 監視対象サーバ設定を追加します。
# 
# @param $settings 設定オブジェクト
#*
sub add_server {
	my $self = shift;
	my $_argnum = scalar @_;
	my $settings = shift || (undef);
	my $ret = new Saklient::Cloud::Resources::GslbServer($settings);
	push(@{$self->{'_servers'}}, $ret);
	return $ret;
}

1;

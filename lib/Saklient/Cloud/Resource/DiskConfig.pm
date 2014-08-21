#!/usr/bin/perl

package Saklient::Cloud::Resource::DiskConfig;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Script;


#** @class Saklient::Cloud::Resource::DiskConfig
# 
# @brief ディスク修正のパラメータ。
#*


#** @var private Saklient::Cloud::Client Saklient::Cloud::Resource::DiskConfig::$_client 
# 
# @private
#*
my $_client;

#** @method private Saklient::Cloud::Client get_client 
# 
# @brief null
#*
sub get_client {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_client'};
}

#** @method public Saklient::Cloud::Client client ()
# 
# @ignore
#*
sub client {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::DiskConfig#client");
		throw $ex;
	}
	return $_[0]->get_client();
}

#** @var private string Saklient::Cloud::Resource::DiskConfig::$_disk_id 
# 
# @private
#*
my $_disk_id;

#** @method private string get_disk_id 
# 
# @brief null
#*
sub get_disk_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_disk_id'};
}

#** @method public string disk_id ()
# 
# @ignore
#*
sub disk_id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::DiskConfig#disk_id");
		throw $ex;
	}
	return $_[0]->get_disk_id();
}

#** @var private string Saklient::Cloud::Resource::DiskConfig::$_host_name 
# 
# @private
#*
my $_host_name;

#** @method private string get_host_name 
# 
# @brief null
#*
sub get_host_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_host_name'};
}

#** @method private string set_host_name ($v)
# 
# @brief null@param {string} v
#*
sub set_host_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_host_name'} = $v;
	return $v;
}

#** @method public string host_name ()
# 
# @brief ホスト名
#*
sub host_name {
	if (1 < scalar(@_)) {
		$_[0]->set_host_name($_[1]);
		return $_[0];
	}
	return $_[0]->get_host_name();
}

#** @var private string Saklient::Cloud::Resource::DiskConfig::$_password 
# 
# @private
#*
my $_password;

#** @method private string get_password 
# 
# @brief null
#*
sub get_password {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_password'};
}

#** @method private string set_password ($v)
# 
# @brief null@param {string} v
#*
sub set_password {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_password'} = $v;
	return $v;
}

#** @method public string password ()
# 
# @brief ログインパスワード
#*
sub password {
	if (1 < scalar(@_)) {
		$_[0]->set_password($_[1]);
		return $_[0];
	}
	return $_[0]->get_password();
}

#** @var private string Saklient::Cloud::Resource::DiskConfig::$_ssh_key 
# 
# @private
#*
my $_ssh_key;

#** @method private string get_ssh_key 
# 
# @brief null
#*
sub get_ssh_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ssh_key'};
}

#** @method private string set_ssh_key ($v)
# 
# @brief null@param {string} v
#*
sub set_ssh_key {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_ssh_key'} = $v;
	return $v;
}

#** @method public string ssh_key ()
# 
# @brief SSHキー
#*
sub ssh_key {
	if (1 < scalar(@_)) {
		$_[0]->set_ssh_key($_[1]);
		return $_[0];
	}
	return $_[0]->get_ssh_key();
}

#** @var private string Saklient::Cloud::Resource::DiskConfig::$_ip_address 
# 
# @private
#*
my $_ip_address;

#** @method private string get_ip_address 
# 
# @brief null
#*
sub get_ip_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ip_address'};
}

#** @method private string set_ip_address ($v)
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
	return $v;
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

#** @var private string Saklient::Cloud::Resource::DiskConfig::$_default_route 
# 
# @private
#*
my $_default_route;

#** @method private string get_default_route 
# 
# @brief null
#*
sub get_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_default_route'};
}

#** @method private string set_default_route ($v)
# 
# @brief null@param {string} v
#*
sub set_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'_default_route'} = $v;
	return $v;
}

#** @method public string default_route ()
# 
# @brief デフォルトルート
#*
sub default_route {
	if (1 < scalar(@_)) {
		$_[0]->set_default_route($_[1]);
		return $_[0];
	}
	return $_[0]->get_default_route();
}

#** @var private int Saklient::Cloud::Resource::DiskConfig::$_network_mask_len 
# 
# @private
#*
my $_network_mask_len;

#** @method private int get_network_mask_len 
# 
# @brief null
#*
sub get_network_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_network_mask_len'};
}

#** @method private int set_network_mask_len ($v)
# 
# @brief null@param {int} v
#*
sub set_network_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	$self->{'_network_mask_len'} = $v;
	return $v;
}

#** @method public int network_mask_len ()
# 
# @brief ネットワークマスク長
#*
sub network_mask_len {
	if (1 < scalar(@_)) {
		$_[0]->set_network_mask_len($_[1]);
		return $_[0];
	}
	return $_[0]->get_network_mask_len();
}

#** @var private Saklient::Cloud::Resource::Script* Saklient::Cloud::Resource::DiskConfig::$_scripts 
# 
# @private
#*
my $_scripts;

#** @method private Saklient::Cloud::Resource::Script[] get_scripts 
# 
# @brief null
#*
sub get_scripts {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_scripts'};
}

#** @method public Saklient::Cloud::Resource::Script[] scripts ()
# 
# @brief スタートアップスクリプト（pushによりスクリプトを追加できます）
#*
sub scripts {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::DiskConfig#scripts");
		throw $ex;
	}
	return $_[0]->get_scripts();
}

#** @method public void new ($client, $diskId)
# 
# @ignore @param {Saklient::Cloud::Client} client
# @param string $diskId
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	my $diskId = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($diskId, "string");
	$self->{'_client'} = $client;
	$self->{'_disk_id'} = $diskId;
	$self->{'_host_name'} = undef;
	$self->{'_password'} = undef;
	$self->{'_ssh_key'} = undef;
	$self->{'_ip_address'} = undef;
	$self->{'_default_route'} = undef;
	$self->{'_network_mask_len'} = undef;
	$self->{'_scripts'} = [];
	return $self;
}

#** @method public Saklient::Cloud::Resource::DiskConfig add_script ($script)
# 
# @brief スタートアップスクリプトを追加します。
# 
# diskConfig.addScript(script) と diskConfig.scripts.push(script) の効果は同等です。
# 
# @param Script $script
# @retval this
#*
sub add_script {
	my $self = shift;
	my $_argnum = scalar @_;
	my $script = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($script, "Saklient::Cloud::Resource::Script");
	push(@{$self->{'_scripts'}}, $script);
	return $self;
}

#** @method public Saklient::Cloud::Resource::DiskConfig write 
# 
# @brief 修正内容を実際のディスクに書き込みます。
# 
# @retval this
#*
sub write {
	my $self = shift;
	my $_argnum = scalar @_;
	my $q = {};
	if (defined($self->{'_host_name'})) {
		Saklient::Util::set_by_path($q, "HostName", $self->{'_host_name'});
	}
	if (defined($self->{'_password'})) {
		Saklient::Util::set_by_path($q, "Password", $self->{'_password'});
	}
	if (defined($self->{'_ssh_key'})) {
		Saklient::Util::set_by_path($q, "SSHKey.PublicKey", $self->{'_ssh_key'});
	}
	if (defined($self->{'_ip_address'})) {
		Saklient::Util::set_by_path($q, "UserIPAddress", $self->{'_ip_address'});
	}
	if (defined($self->{'_default_route'})) {
		Saklient::Util::set_by_path($q, "UserSubnet.DefaultRoute", $self->{'_default_route'});
	}
	if (defined($self->{'_network_mask_len'})) {
		Saklient::Util::set_by_path($q, "UserSubnet.NetworkMaskLen", $self->{'_network_mask_len'});
	}
	if (0 < scalar(@{$self->{'_scripts'}})) {
		my $notes = [];
		foreach my $script (@{$self->{'_scripts'}}) {
			push(@{$notes}, {'ID' => $script->_id()});
		}
		Saklient::Util::set_by_path($q, "Notes", $notes);
	}
	my $path = "/disk/" . $self->{'_disk_id'} . "/config";
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	return $self;
}

1;

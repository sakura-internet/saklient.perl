#!/usr/bin/perl

package Saklient::Cloud::Product;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Models::Model_ServerPlan;
use Saklient::Cloud::Models::Model_DiskPlan;
use Saklient::Cloud::Models::Model_RouterPlan;
use Saklient::Cloud::Client;


#** @class Saklient::Cloud::Product
# 
# @brief 商品情報にアクセスするためのモデルを集めたクラス。
#*


#** @var private Saklient::Cloud::Models::Model_ServerPlan Saklient::Cloud::Product::$_server 
# 
# @private
#*
my $_server;

#** @method private Saklient::Cloud::Models::Model_ServerPlan get_server 
# 
# @brief null
#*
sub get_server {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_server'};
}

#** @method public Saklient::Cloud::Models::Model_ServerPlan server ()
# 
# @brief サーバプラン情報。
#*
sub server {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Product#server");
		throw $ex;
	}
	return $_[0]->get_server();
}

#** @var private Saklient::Cloud::Models::Model_DiskPlan Saklient::Cloud::Product::$_disk 
# 
# @private
#*
my $_disk;

#** @method private Saklient::Cloud::Models::Model_DiskPlan get_disk 
# 
# @brief null
#*
sub get_disk {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_disk'};
}

#** @method public Saklient::Cloud::Models::Model_DiskPlan disk ()
# 
# @brief ディスクプラン情報。
#*
sub disk {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Product#disk");
		throw $ex;
	}
	return $_[0]->get_disk();
}

#** @var private Saklient::Cloud::Models::Model_RouterPlan Saklient::Cloud::Product::$_router 
# 
# @private
#*
my $_router;

#** @method private Saklient::Cloud::Models::Model_RouterPlan get_router 
# 
# @brief null
#*
sub get_router {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_router'};
}

#** @method public Saklient::Cloud::Models::Model_RouterPlan router ()
# 
# @brief ルータ帯域プラン情報。
#*
sub router {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Product#router");
		throw $ex;
	}
	return $_[0]->get_router();
}

#** @method public void new ($client)
# 
# @ignore
# @param Client $client
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_server'} = new Saklient::Cloud::Models::Model_ServerPlan($client);
	$self->{'_disk'} = new Saklient::Cloud::Models::Model_DiskPlan($client);
	$self->{'_router'} = new Saklient::Cloud::Models::Model_RouterPlan($client);
	return $self;
}

1;

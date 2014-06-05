#!/usr/bin/perl

package Saclient::Cloud::API;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Product;
use Saclient::Cloud::Model::Model_Icon;
use Saclient::Cloud::Model::Model_Server;
use Saclient::Cloud::Model::Model_Disk;
use Saclient::Cloud::Model::Model_Appliance;
use Saclient::Cloud::Model::Model_Archive;
use Saclient::Cloud::Model::Model_IPv6Net;

## @class Saclient::Cloud::API
#

## @var private Saclient::Cloud::Client $_client
# @private
#
my $_client;

sub get_client {
	my $self = shift;
	{
		return $self->{'_client'};
	}
}

sub client {
	return $_[0]->get_client();
}

## @var private Saclient::Cloud::Product $_product
# @private
#
my $_product;

sub get_product {
	my $self = shift;
	{
		return $self->{'_product'};
	}
}

sub product {
	return $_[0]->get_product();
}

## @var private Saclient::Cloud::Model::Model_Icon $_icon
# @private
#
my $_icon;

sub get_icon {
	my $self = shift;
	{
		return $self->{'_icon'};
	}
}

sub icon {
	return $_[0]->get_icon();
}

## @var private Saclient::Cloud::Model::Model_Server $_server
# @private
#
my $_server;

sub get_server {
	my $self = shift;
	{
		return $self->{'_server'};
	}
}

sub server {
	return $_[0]->get_server();
}

## @var private Saclient::Cloud::Model::Model_Disk $_disk
# @private
#
my $_disk;

sub get_disk {
	my $self = shift;
	{
		return $self->{'_disk'};
	}
}

sub disk {
	return $_[0]->get_disk();
}

## @var private Saclient::Cloud::Model::Model_Appliance $_appliance
# @private
#
my $_appliance;

sub get_appliance {
	my $self = shift;
	{
		return $self->{'_appliance'};
	}
}

sub appliance {
	return $_[0]->get_appliance();
}

## @var private Saclient::Cloud::Model::Model_Archive $_archive
# @private
#
my $_archive;

sub get_archive {
	my $self = shift;
	{
		return $self->{'_archive'};
	}
}

sub archive {
	return $_[0]->get_archive();
}

## @var private Saclient::Cloud::Model::Model_IPv6Net $_ipv6net
# @private
#
my $_ipv6net;

sub get_ipv6net {
	my $self = shift;
	{
		return $self->{'_ipv6net'};
	}
}

sub ipv6net {
	return $_[0]->get_ipv6net();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	{
		$self->{'_client'} = $client;
		$self->{'_product'} = new Saclient::Cloud::Product($client);
		$self->{'_icon'} = new Saclient::Cloud::Model::Model_Icon($client);
		$self->{'_server'} = new Saclient::Cloud::Model::Model_Server($client);
		$self->{'_disk'} = new Saclient::Cloud::Model::Model_Disk($client);
		$self->{'_appliance'} = new Saclient::Cloud::Model::Model_Appliance($client);
		$self->{'_archive'} = new Saclient::Cloud::Model::Model_Archive($client);
		$self->{'_ipv6net'} = new Saclient::Cloud::Model::Model_IPv6Net($client);
	}
	return $self;
}

## @method static public Saclient::Cloud::API authorize()
# 指定した認証情報を用いてアクセスを行うAPIクライアントを作成します。
# 必要な認証情報は、コントロールパネル右上にあるアカウントのプルダウンから
# 「設定」を選択し、「APIキー」のページにて作成できます。
# 
# @param token ACCESS TOKEN
# @param secret ACCESS TOKEN SECRET
# @return APIクライアント
#
sub authorize {
	my $class = shift;
	my $token = shift;
	my $secret = shift;
	{
		my $c = new Saclient::Cloud::Client($token, $secret);
		return new Saclient::Cloud::API($c);
	}
}

## @method public Saclient::Cloud::API in_zone()
# 認証情報を引き継ぎ、指定したゾーンへのアクセスを行うAPIクライアントを作成します。
# 
# @param name ゾーン名
# @return APIクライアント
#
sub in_zone {
	my $self = shift;
	my $name = shift;
	{
		my $ret = new Saclient::Cloud::API($self->{'_client'}->clone_instance());
		$ret->{'_client'}->set_api_root_suffix("zone/" . $name);
		return $ret;
	}
}

1;

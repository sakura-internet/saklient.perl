#!/usr/bin/perl

package Saclient::Cloud::Resource::Resource;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Util;

## @class Saclient::Cloud::Resource::Resource
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

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return undef;
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return undef;
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return undef;
	}
}

## @method public string _id()
# @private
#
sub _id {
	my $self = shift;
	{
		return undef;
	}
}

## @method public Void new()
# @private
#
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	{
		$self->{'_client'} = $client;
	}
	return $self;
}

my $is_incomplete;

sub api_deserialize {
	my $self = shift;
	my $r = shift;
	{}
}

sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	{
		return undef;
	}
}

sub api_serialize_id {
	my $self = shift;
	{
		my $id = $self->_id();
		if (!defined($id)) {
			return undef;
		};
		my $r = {};
		$r->{"ID"} = $id;
		return $r;
	}
}

## @method private Saclient::Cloud::Resource::Resource _create()
# このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新しいインスタンスを作成します。
# 
# @private
# @return this
#
sub _create {
	my $self = shift;
	{
		return $self;
	}
}

## @method private Saclient::Cloud::Resource::Resource _save()
# このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。
# 
# @private
# @return this
#
sub _save {
	my $self = shift;
	{
		my $r = {};
		$r->{$self->_root_key()} = $self->api_serialize();
		my $result = $self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()), $r);
		$self->api_deserialize($result->{$self->_root_key()});
		return $self;
	}
}

## @method private Saclient::Cloud::Resource::Resource _reload()
# 最新のリソース情報を再取得します。
# 
# @private
# @return this
#
sub _reload {
	my $self = shift;
	{
		my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()));
		$self->api_deserialize($result->{$self->_root_key()});
		return $self;
	}
}

sub dump {
	my $self = shift;
	{
		return $self->api_serialize();
	}
}

1;

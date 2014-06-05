#!/usr/bin/perl

package Saclient::Cloud::Model::Model;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

## @class Saclient::Cloud::Model::Model
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

## @var private TQueryParams $_params
# @private
#
my $_params;

sub get_params {
	my $self = shift;
	{
		return $self->{'_params'};
	}
}

sub params {
	return $_[0]->get_params();
}

## @var private int $_total
# @private
#
my $_total;

sub get_total {
	my $self = shift;
	{
		return $self->{'_total'};
	}
}

sub total {
	return $_[0]->get_total();
}

## @var private int $_count
# @private
#
my $_count;

sub get_count {
	my $self = shift;
	{
		return $self->{'_count'};
	}
}

sub count {
	return $_[0]->get_count();
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

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	{
		$self->{'_client'} = $client;
		$self->{'_params'} = {};
		$self->{'_total'} = undef;
		$self->{'_count'} = undef;
	}
	return $self;
}

## @method private Saclient::Cloud::Model::Model _offset()
# 次に取得するリストの開始オフセットを指定します。
# 
# @private
# @param offset オフセット
# @return this
#
sub _offset {
	my $self = shift;
	my $offset = shift;
	{
		$self->{'_params'}->{'_begin'} = $offset;
		return $self;
	}
}

## @method private Saclient::Cloud::Model::Model _limit()
# 次に取得するリストの上限レコード数を指定します。
# 
# @private
# @param count 上限レコード数
# @return this
#
sub _limit {
	my $self = shift;
	my $count = shift;
	{
		$self->{'_params'}->{'_count'} = $count;
		return $self;
	}
}

## @method private Saclient::Cloud::Model::Model _reset()
# 次のリクエストのために設定されているステートをすべて破棄します。
# 
# @private
# @return this
#
sub _reset {
	my $self = shift;
	{
		$self->{'_params'} = {};
		$self->{'_total'} = 0;
		$self->{'_count'} = 0;
		return $self;
	}
}

## @method private Saclient::Cloud::Resource::Resource _get()
# 指定したIDを持つ唯一のリソースを取得します。
# 
# @private
# @return リソースオブジェクト
#
sub _get {
	my $self = shift;
	my $id = shift;
	{
		my $params = $self->{'_params'};
		$self->_reset();
		my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($id), $params);
		$self->{'_total'} = 1;
		$self->{'_count'} = 1;
		my $record = $result->{$self->_root_key()};
		return Saclient::Cloud::Util->create_class_instance("saclient.cloud.resource." . $self->_root_key(), [$self->{'_client'}, $record]);
	}
}

## @method private Saclient::Cloud::Resource::Resource[] _find()
# リソースの検索リクエストを実行し、結果をリストで取得します。
# 
# @private
# @return リソースオブジェクトの配列
#
sub _find {
	my $self = shift;
	{
		my $params = $self->{'_params'};
		$self->_reset();
		my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
		$self->{'_total'} = $result->{"Total"};
		$self->{'_count'} = $result->{"Count"};
		my $records = $result->{$self->_root_key_m()};
		my $data = [];
		foreach my $record (@{$records}) {
			{
				my $i = Saclient::Cloud::Util->create_class_instance("saclient.cloud.resource." . $self->_root_key(), [$self->{'_client'}, $record]);
				push(@{$data}, $i);
			}
		};
		return $data;
	}
}

## @method private Saclient::Cloud::Resource::Resource _find_one()
# リソースの検索リクエストを実行し、唯一のリソースを取得します。
# 
# @private
# @return リソースオブジェクト
#
sub _find_one {
	my $self = shift;
	{
		my $params = $self->{'_params'};
		$self->_reset();
		my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
		$self->{'_total'} = $result->{"Total"};
		$self->{'_count'} = $result->{"Count"};
		if ($self->{'_total'} eq 0) {
			return undef;
		};
		my $records = $result->{$self->_root_key_m()};
		return Saclient::Cloud::Util->create_class_instance("saclient.cloud.resource." . $self->_root_key(), [$self->{'_client'}, $records->[0]]);
	}
}

## @method private void _filter_by()
# @private
#
sub _filter_by {
	my $self = shift;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	{
		if (!(ref($self->{'_params'}) eq 'HASH' && exists $self->{'_params'}->{"Filter"})) {
			{
				$self->{'_params'}->{"Filter"} = {};
			};
		};
		my $filter = $self->{'_params'}->{"Filter"};
		if ($multiple) {
			{
				if (!(ref($filter) eq 'HASH' && exists $filter->{$key})) {
					{
						$filter->{$key} = [];
					};
				};
				my $values = $filter->{$key};
				push(@{$values}, $value);
			};
		}
		else {
			{
				$filter->{$key} = $value;
			};
		};
	}
}

1;

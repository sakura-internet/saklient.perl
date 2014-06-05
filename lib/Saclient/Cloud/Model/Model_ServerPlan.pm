#!/usr/bin/perl

package Saclient::Cloud::Model::Model_ServerPlan;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model;
use Saclient::Cloud::Resource::ServerPlan;

use base qw(Saclient::Cloud::Model::Model);

## @class Saclient::Cloud::Model::Model_ServerPlan
#

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return "/product/server";
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return "ServerPlan";
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return "ServerPlans";
	}
}

## @method public Saclient::Cloud::Model::Model_ServerPlan offset()
# 次に取得するリストの開始オフセットを指定します。
# 
# @param offset オフセット
# @return this
#
sub offset {
	my $self = shift;
	my $offset = shift;
	{
		return $self->_offset($offset);
	}
}

## @method public Saclient::Cloud::Model::Model_ServerPlan limit()
# 次に取得するリストの上限レコード数を指定します。
# 
# @param count 上限レコード数
# @return this
#
sub limit {
	my $self = shift;
	my $count = shift;
	{
		return $self->_limit($count);
	}
}

## @method public Saclient::Cloud::Model::Model_ServerPlan reset()
# 次のリクエストのために設定されているステートをすべて破棄します。
# 
# @return this
#
sub reset {
	my $self = shift;
	{
		return $self->_reset();
	}
}

## @method public Saclient::Cloud::Resource::ServerPlan get()
# 指定したIDを持つ唯一のリソースを取得します。
# 
# @return リソースオブジェクト
#
sub get {
	my $self = shift;
	my $id = shift;
	{
		return $self->_get($id);
	}
}

## @method public Saclient::Cloud::Resource::ServerPlan[] find()
# リソースの検索リクエストを実行し、結果をリストで取得します。
# 
# @return リソースオブジェクトの配列
#
sub find {
	my $self = shift;
	{
		return $self->_find();
	}
}

## @method public Saclient::Cloud::Resource::ServerPlan get_by_spec()
# 指定したスペックのプランを取得します。
#
sub get_by_spec {
	my $self = shift;
	my $cores = shift;
	my $memoryGib = shift;
	{
		$self->_filter_by("CPU", $cores, 1);
		$self->_filter_by("MemoryMB", $memoryGib * 1024, 1);
		return $self->_find_one();
	}
}

1;

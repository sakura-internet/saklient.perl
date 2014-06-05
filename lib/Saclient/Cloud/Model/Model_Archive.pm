#!/usr/bin/perl

package Saclient::Cloud::Model::Model_Archive;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model;
use Saclient::Cloud::Resource::Archive;

use base qw(Saclient::Cloud::Model::Model);

## @class Saclient::Cloud::Model::Model_Archive
#

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return "/archive";
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return "Archive";
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return "Archives";
	}
}

## @method public Saclient::Cloud::Model::Model_Archive offset()
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

## @method public Saclient::Cloud::Model::Model_Archive limit()
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

## @method public Saclient::Cloud::Model::Model_Archive reset()
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

## @method public Saclient::Cloud::Resource::Archive get()
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

## @method public Saclient::Cloud::Resource::Archive[] find()
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

## @method public Saclient::Cloud::Model::Model_Archive with_name_like()
# 指定した文字列を名前に含むアーカイブに絞り込みます。
#
sub with_name_like {
	my $self = shift;
	my $name = shift;
	{
		$self->_filter_by("Name", $name);
		return $self;
	}
}

## @method public Saclient::Cloud::Model::Model_Archive with_tag()
# 指定したタグを持つアーカイブに絞り込みます。
#
sub with_tag {
	my $self = shift;
	my $tag = shift;
	{
		$self->_filter_by("Tags.Name", $tag, 1);
		return $self;
	}
}

1;

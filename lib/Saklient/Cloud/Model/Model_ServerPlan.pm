#!/usr/bin/perl

package Saklient::Cloud::Model::Model_ServerPlan;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Model::Model;
use Saklient::Cloud::Resource::ServerPlan;

use base qw(Saklient::Cloud::Model::Model);

#** @class Saklient::Cloud::Model::Model_ServerPlan
# 
# @brief サーバプランを検索するための機能を備えたクラス。
#*


#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/product/server";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlan";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlans";
}

#** @method private string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "ServerPlan";
}

#** @method public Saklient::Cloud::Model::Model_ServerPlan offset ($offset)
# 
# @brief 次に取得するリストの開始オフセットを指定します。
# 
# @param int $offset オフセット
# @retval this
#*
sub offset {
	my $self = shift;
	my $_argnum = scalar @_;
	my $offset = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($offset, "int");
	return $self->_offset($offset);
}

#** @method public Saklient::Cloud::Model::Model_ServerPlan limit ($count)
# 
# @brief 次に取得するリストの上限レコード数を指定します。
# 
# @param int $count 上限レコード数
# @retval this
#*
sub limit {
	my $self = shift;
	my $_argnum = scalar @_;
	my $count = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($count, "int");
	return $self->_limit($count);
}

#** @method public Saklient::Cloud::Model::Model_ServerPlan filter_by ($key, $value, $multiple)
# 
# @brief Web APIのフィルタリング設定を直接指定します。
# 
# @param string $key キー
# @param $value 値
# @param bool $multiple valueに配列を与え、OR条件で完全一致検索する場合にtrueを指定します。通常、valueはスカラ値であいまい検索されます。
#*
sub filter_by {
	my $self = shift;
	my $_argnum = scalar @_;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($key, "string");
	Saklient::Util::validate_type($multiple, "bool");
	return $self->_filter_by($key, $value, $multiple);
}

#** @method public Saklient::Cloud::Model::Model_ServerPlan reset 
# 
# @brief 次のリクエストのために設定されているステートをすべて破棄します。
# 
# @retval this
#*
sub reset {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reset();
}

#** @method public Saklient::Cloud::Resource::ServerPlan get_by_id ($id)
# 
# @brief 指定したIDを持つ唯一のリソースを取得します。
# 
# @param string $id
# @retval リソースオブジェクト
#*
sub get_by_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($id, "string");
	return $self->_get_by_id($id);
}

#** @method public Saklient::Cloud::Resource::ServerPlan[] find 
# 
# @brief リソースの検索リクエストを実行し、結果をリストで取得します。
# 
# @retval リソースオブジェクトの配列
#*
sub find {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_find();
}

#** @method public Saklient::Cloud::Resource::ServerPlan get_by_spec ($cores, $memoryGib)
# 
# @brief 指定したスペックのプランを取得します。
# 
# @param int $cores
# @param int $memoryGib
#*
sub get_by_spec {
	my $self = shift;
	my $_argnum = scalar @_;
	my $cores = shift;
	my $memoryGib = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($cores, "int");
	Saklient::Util::validate_type($memoryGib, "int");
	$self->_filter_by("CPU", [$cores]);
	$self->_filter_by("MemoryMB", [$memoryGib * 1024]);
	return $self->_find_one();
}

1;

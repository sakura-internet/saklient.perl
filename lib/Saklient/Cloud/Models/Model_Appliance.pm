#!/usr/bin/perl

package Saklient::Cloud::Models::Model_Appliance;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Models::Model;
use Saklient::Cloud::Resources::Resource;
use Saklient::Cloud::Resources::Appliance;
use Saklient::Cloud::Resources::LoadBalancer;
use Saklient::Cloud::Resources::VpcRouter;
use Saklient::Cloud::Resources::Swytch;

use base qw(Saklient::Cloud::Models::Model);

#** @class Saklient::Cloud::Models::Model_Appliance
# 
# @brief アプライアンスを検索・作成するための機能を備えたクラス。
#*


#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/appliance";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Appliance";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Appliances";
}

#** @method private string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Appliance";
}

#** @method private Saklient::Cloud::Resources::Resource _create_resource_impl ($obj, $wrapped)
# 
# @private@param {bool} wrapped
#*
sub _create_resource_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $obj = shift;
	my $wrapped = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($wrapped, "bool");
	my $ret = new Saklient::Cloud::Resources::Appliance($self->{'_client'}, $obj, $wrapped);
	my $clazz = $ret->clazz;
	if ($clazz eq "loadbalancer") {
		return new Saklient::Cloud::Resources::LoadBalancer($self->{'_client'}, $obj, $wrapped);
	}
	if ($clazz eq "vpcrouter") {
		return new Saklient::Cloud::Resources::VpcRouter($self->{'_client'}, $obj, $wrapped);
	}
	return $ret;
}

#** @method public Saklient::Cloud::Models::Model_Appliance offset ($offset)
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

#** @method public Saklient::Cloud::Models::Model_Appliance limit ($count)
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

#** @method public Saklient::Cloud::Models::Model_Appliance filter_by ($key, $value, $multiple)
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

#** @method public Saklient::Cloud::Models::Model_Appliance reset 
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

#** @method public Saklient::Cloud::Resources::LoadBalancer create_load_balancer ($swytch, $vrid, @$realIps, $isHighSpec)
# 
# @brief null@param {Saklient::Cloud::Resources::Swytch} swytch
# 
# @param int $vrid
# @param string* $realIps
# @param bool $isHighSpec
#*
sub create_load_balancer {
	my $self = shift;
	my $_argnum = scalar @_;
	my $swytch = shift;
	my $vrid = shift;
	my $realIps = shift;
	my $isHighSpec = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 3);
	Saklient::Util::validate_type($swytch, "Saklient::Cloud::Resources::Swytch");
	Saklient::Util::validate_type($vrid, "int");
	Saklient::Util::validate_type($realIps, "ARRAY");
	Saklient::Util::validate_type($isHighSpec, "bool");
	my $ret = new Saklient::Cloud::Resources::LoadBalancer($self->{'_client'}, undef);
	return $ret->set_initial_params($swytch, $vrid, $realIps, $isHighSpec);
}

#** @method public Saklient::Cloud::Resources::VpcRouter create_vpc_router 
# 
# @brief null
#*
sub create_vpc_router {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ret = new Saklient::Cloud::Resources::VpcRouter($self->{'_client'}, undef);
	return $ret;
}

#** @method public Saklient::Cloud::Resources::Appliance get_by_id ($id)
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

#** @method public Saklient::Cloud::Resources::Appliance[] find 
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

#** @method public Saklient::Cloud::Models::Model_Appliance with_name_like ($name)
# 
# @brief 指定した文字列を名前に含むリソースに絞り込みます。
# 
# 大文字・小文字は区別されません。
# 半角スペースで区切られた複数の文字列は、それらをすべて含むことが条件とみなされます。
# 
# @todo Implement test case
# @param string $name
#*
sub with_name_like {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	return $self->_with_name_like($name);
}

#** @method public Saklient::Cloud::Models::Model_Appliance with_tag ($tag)
# 
# @brief 指定したタグを持つリソースに絞り込みます。
# 
# 複数のタグを指定する場合は withTags() を利用してください。
# 
# @todo Implement test case
# @param string $tag
#*
sub with_tag {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tag = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tag, "string");
	return $self->_with_tag($tag);
}

#** @method public Saklient::Cloud::Models::Model_Appliance with_tags (@$tags)
# 
# @brief 指定したすべてのタグを持つリソースに絞り込みます。
# 
# @todo Implement test case
# @param string* $tags
#*
sub with_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tags = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tags, "ARRAY");
	return $self->_with_tags($tags);
}

#** @method public Saklient::Cloud::Models::Model_Appliance with_tag_dnf (@$dnf)
# 
# @brief 指定したDNFに合致するタグを持つリソースに絞り込みます。
# 
# @todo Implement test case
# @param string[]* $dnf
#*
sub with_tag_dnf {
	my $self = shift;
	my $_argnum = scalar @_;
	my $dnf = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($dnf, "ARRAY");
	return $self->_with_tag_dnf($dnf);
}

#** @method public Saklient::Cloud::Models::Model_Appliance sort_by_name ($reverse)
# 
# @brief 名前でソートします。
# 
# @todo Implement test case
# @param bool $reverse
#*
sub sort_by_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	return $self->_sort_by_name($reverse);
}

#** @method public void new ($client)
# 
# @ignore @param {Saklient::Cloud::Client} client
#*
sub new {
	my $class = shift;
	my $self;
	my $_argnum = scalar @_;
	my $client = shift;
	$self = $class->SUPER::new($client);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	return $self;
}

1;

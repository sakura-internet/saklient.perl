#!/usr/bin/perl

package Saklient::Cloud::Model::Model_Server;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Model::Model;
use Saklient::Cloud::Resource::Server;
use Saklient::Cloud::Resource::ServerPlan;
use Saklient::Cloud::Resource::IsoImage;
use Saklient::Cloud::Enums::EServerInstanceStatus;

use base qw(Saklient::Cloud::Model::Model);

#** @class Saklient::Cloud::Model::Model_Server
# 
# @brief サーバを検索・作成するための機能を備えたクラス。
#*


#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/server";
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Server";
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Servers";
}

#** @method private string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Server";
}

#** @method public Saklient::Cloud::Model::Model_Server offset ($offset)
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

#** @method public Saklient::Cloud::Model::Model_Server limit ($count)
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

#** @method public Saklient::Cloud::Model::Model_Server filter_by ($key, $value, $multiple)
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

#** @method public Saklient::Cloud::Model::Model_Server reset 
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

#** @method public Saklient::Cloud::Resource::Server create 
# 
# @brief 新規リソース作成用のオブジェクトを用意します。
# 
# 返り値のオブジェクトにパラメータを設定し、save() を呼ぶことで実際のリソースが作成されます。
# 
# @retval リソースオブジェクト
#*
sub create {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_create();
}

#** @method public Saklient::Cloud::Resource::Server get_by_id ($id)
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

#** @method public Saklient::Cloud::Resource::Server[] find 
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

#** @method public Saklient::Cloud::Model::Model_Server with_name_like ($name)
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

#** @method public Saklient::Cloud::Model::Model_Server with_tag ($tag)
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

#** @method public Saklient::Cloud::Model::Model_Server with_tags (@$tags)
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

#** @method public Saklient::Cloud::Model::Model_Server with_tag_dnf (@$dnf)
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

#** @method public Saklient::Cloud::Model::Model_Server sort_by_name ($reverse)
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

#** @method public Saklient::Cloud::Model::Model_Server with_plan ($plan)
# 
# @brief 指定したプランのサーバに絞り込みます。
# 
# @param Saklient::Cloud::Resource::ServerPlan $plan
#*
sub with_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $plan = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($plan, "Saklient::Cloud::Resource::ServerPlan");
	$self->_filter_by("ServerPlan.ID", [$plan->_id()]);
	return $self;
}

#** @method public Saklient::Cloud::Model::Model_Server with_status ($status)
# 
# @brief インスタンスが指定した状態にあるサーバに絞り込みます。
# 
# @param string $status
#*
sub with_status {
	my $self = shift;
	my $_argnum = scalar @_;
	my $status = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($status, "string");
	$self->_filter_by("Instance.Status", [$status]);
	return $self;
}

#** @method public Saklient::Cloud::Model::Model_Server with_status_up 
# 
# @brief インスタンスが起動中のサーバに絞り込みます。
#*
sub with_status_up {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->with_status(Saklient::Cloud::Enums::EServerInstanceStatus::up);
}

#** @method public Saklient::Cloud::Model::Model_Server with_status_down 
# 
# @brief インスタンスが停止中のサーバに絞り込みます。
#*
sub with_status_down {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->with_status(Saklient::Cloud::Enums::EServerInstanceStatus::down);
}

#** @method public Saklient::Cloud::Model::Model_Server with_iso_image ($iso)
# 
# @brief 指定したISOイメージが挿入されているサーバに絞り込みます。
# 
# @param Saklient::Cloud::Resource::IsoImage $iso
#*
sub with_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	my $iso = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($iso, "Saklient::Cloud::Resource::IsoImage");
	$self->_filter_by("Instance.CDROM.ID", [$iso->_id()]);
	return $self;
}

#** @method public Saklient::Cloud::Model::Model_Server sort_by_cpu ($reverse)
# 
# @brief 仮想コア数でソートします。
# 
# @param bool $reverse
#*
sub sort_by_cpu {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	$self->_sort("ServerPlan.CPU", $reverse);
	return $self;
}

#** @method public Saklient::Cloud::Model::Model_Server sort_by_memory ($reverse)
# 
# @brief メモリ容量でソートします。
# 
# @param bool $reverse
#*
sub sort_by_memory {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	$self->_sort("ServerPlan.MemoryMB", $reverse);
	return $self;
}

1;

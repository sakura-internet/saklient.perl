#!/usr/bin/perl

package Saklient::Cloud::Model::Model;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;



#** @var private Saklient::Cloud::Client Saklient::Cloud::Model::Model::$_client 
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
# @brief null
#*
sub client {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#client");
		throw $ex;
	}
	return $_[0]->get_client();
}

#** @var private TQueryParams Saklient::Cloud::Model::Model::$_params 
# 
# @private
#*
my $_params;

#** @method private TQueryParams get_params 
# 
# @brief null
#*
sub get_params {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_params'};
}

#** @method public TQueryParams params ()
# 
# @brief null
#*
sub params {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#params");
		throw $ex;
	}
	return $_[0]->get_params();
}

#** @var private int Saklient::Cloud::Model::Model::$_total 
# 
# @private
#*
my $_total;

#** @method private int get_total 
# 
# @brief null
#*
sub get_total {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_total'};
}

#** @method public int total ()
# 
# @brief null
#*
sub total {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#total");
		throw $ex;
	}
	return $_[0]->get_total();
}

#** @var private int Saklient::Cloud::Model::Model::$_count 
# 
# @private
#*
my $_count;

#** @method private int get_count 
# 
# @brief null
#*
sub get_count {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_count'};
}

#** @method public int count ()
# 
# @brief null
#*
sub count {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#count");
		throw $ex;
	}
	return $_[0]->get_count();
}

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method private string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method public void new ($client)
# 
# @brief null@param {Saklient::Cloud::Client} client
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_client'} = $client;
	$self->_reset();
	return $self;
}

#** @method private Saklient::Cloud::Model::Model _offset ($offset)
# 
# @brief 次に取得するリストの開始オフセットを指定します。
# 
# @private
# @param int $offset オフセット
# @retval this
#*
sub _offset {
	my $self = shift;
	my $_argnum = scalar @_;
	my $offset = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($offset, "int");
	$self->{'_params'}->{"Begin"} = $offset;
	return $self;
}

#** @method private Saklient::Cloud::Model::Model _limit ($count)
# 
# @brief 次に取得するリストの上限レコード数を指定します。
# 
# @private
# @param int $count 上限レコード数
# @retval this
#*
sub _limit {
	my $self = shift;
	my $_argnum = scalar @_;
	my $count = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($count, "int");
	$self->{'_params'}->{"Count"} = $count;
	return $self;
}

#** @method private Saklient::Cloud::Model::Model _sort ($column, $reverse)
# 
# @brief 次に取得するリストのソートカラムを指定します。
# 
# @private
# @param string $column カラム名
# @param bool $reverse
# @retval this
#*
sub _sort {
	my $self = shift;
	my $_argnum = scalar @_;
	my $column = shift;
	my $reverse = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($column, "string");
	Saklient::Util::validate_type($reverse, "bool");
	if (!(ref($self->{'_params'}) eq 'HASH' && exists $self->{'_params'}->{"Sort"})) {
		$self->{'_params'}->{"Sort"} = [];
	}
	my $sort = $self->{'_params'}->{"Sort"};
	my $op = $reverse ? "-" : "";
	push(@{$sort}, $op . $column);
	return $self;
}

#** @method private Saklient::Cloud::Model::Model _filter_by ($key, $value, $multiple)
# 
# @brief Web APIのフィルタリング設定を直接指定します。
# 
# @private
# @param string $key キー
# @param $value 値
# @param bool $multiple valueに配列を与え、OR条件で完全一致検索する場合にtrueを指定します。通常、valueはスカラ値であいまい検索されます。
#*
sub _filter_by {
	my $self = shift;
	my $_argnum = scalar @_;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($key, "string");
	Saklient::Util::validate_type($multiple, "bool");
	if (!(ref($self->{'_params'}) eq 'HASH' && exists $self->{'_params'}->{"Filter"})) {
		$self->{'_params'}->{"Filter"} = {};
	}
	my $filter = $self->{'_params'}->{"Filter"};
	if ($multiple) {
		if (!(ref($filter) eq 'HASH' && exists $filter->{$key})) {
			$filter->{$key} = [];
		}
		my $values = $filter->{$key};
		push(@{$values}, $value);
	}
	else {
		$filter->{$key} = $value;
	}
	return $self;
}

#** @method private Saklient::Cloud::Model::Model _reset 
# 
# @brief 次のリクエストのために設定されているステートをすべて破棄します。
# 
# @private
# @retval this
#*
sub _reset {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_params'} = {'Count' => 0};
	$self->{'_total'} = 0;
	$self->{'_count'} = 0;
	return $self;
}

#** @method private Saklient::Cloud::Resource::Resource _create 
# 
# @brief 新規リソース作成用のオブジェクトを用意します。
# 
# 返り値のオブジェクトにパラメータを設定し、save() を呼ぶことで実際のリソースが作成されます。
# 
# @private
# @retval リソースオブジェクト
#*
sub _create {
	my $self = shift;
	my $_argnum = scalar @_;
	return Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, undef]);
}

#** @method private Saklient::Cloud::Resource::Resource _get_by_id ($id)
# 
# @brief 指定したIDを持つ唯一のリソースを取得します。
# 
# @private
# @param string $id
# @retval リソースオブジェクト
#*
sub _get_by_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($id, "string");
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saklient::Util::url_encode($id), $params);
	$self->{'_total'} = 1;
	$self->{'_count'} = 1;
	return Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [
		$self->{'_client'},
		$result,
		1
	]);
}

#** @method private Saklient::Cloud::Resource::Resource[] _find 
# 
# @brief リソースの検索リクエストを実行し、結果をリストで取得します。
# 
# @private
# @retval リソースオブジェクトの配列
#*
sub _find {
	my $self = shift;
	my $_argnum = scalar @_;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	$self->{'_total'} = $result->{"Total"};
	$self->{'_count'} = $result->{"Count"};
	my $records = $result->{$self->_root_key_m()};
	my $data = [];
	foreach my $record (@{$records}) {
		my $i = Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $record]);
		push(@{$data}, $i);
	}
	return $data;
}

#** @method private Saklient::Cloud::Resource::Resource _find_one 
# 
# @brief リソースの検索リクエストを実行し、唯一のリソースを取得します。
# 
# @private
# @retval リソースオブジェクト
#*
sub _find_one {
	my $self = shift;
	my $_argnum = scalar @_;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	$self->{'_total'} = $result->{"Total"};
	$self->{'_count'} = $result->{"Count"};
	if ($self->{'_total'} == 0) {
		return undef;
	}
	my $records = $result->{$self->_root_key_m()};
	return Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $records->[0]]);
}

#** @method private Saklient::Cloud::Model::Model _with_name_like ($name)
# 
# @brief 指定した文字列を名前に含むリソースに絞り込みます。
# 
# 大文字・小文字は区別されません。
# 半角スペースで区切られた複数の文字列は、それらをすべて含むことが条件とみなされます。
# 
# @private
# @param string $name
#*
sub _with_name_like {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	return $self->_filter_by("Name", $name);
}

#** @method private Saklient::Cloud::Model::Model _with_tag ($tag)
# 
# @brief 指定したタグを持つリソースに絞り込みます。
# 
# 複数のタグを指定する場合は withTags() を利用してください。
# 
# @private
# @param string $tag
#*
sub _with_tag {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tag = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tag, "string");
	return $self->_filter_by("Tags.Name", $tag, 1);
}

#** @method private Saklient::Cloud::Model::Model _with_tags (@$tags)
# 
# @brief 指定したすべてのタグを持つリソースに絞り込みます。
# 
# @private
# @param string* $tags
#*
sub _with_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tags = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tags, "ARRAY");
	return $self->_filter_by("Tags.Name", $tags, 1);
}

#** @method private Saklient::Cloud::Model::Model _sort_by_name ($reverse)
# 
# @brief 名前でソートします。
# 
# @private
# @param bool $reverse
#*
sub _sort_by_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	return $self->_sort("Name", $reverse);
}

1;

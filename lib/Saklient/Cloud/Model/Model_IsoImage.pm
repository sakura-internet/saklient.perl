#!/usr/bin/perl

package Saklient::Cloud::Model::Model_IsoImage;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Model::Model;
use Saklient::Cloud::Resource::IsoImage;
use Saklient::Cloud::Enums::EScope;

use base qw(Saklient::Cloud::Model::Model);

=pod

=encoding utf8

=head1 Saklient::Cloud::Model::Model_IsoImage

ISOイメージを検索・作成するための機能を備えたクラス。

=cut


sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/cdrom";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CDROM";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CDROMs";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "IsoImage";
}

=head2 offset(int $offset) : Saklient::Cloud::Model::Model_IsoImage

次に取得するリストの開始オフセットを指定します。

@param offset オフセット
@return this

=cut
sub offset {
	my $self = shift;
	my $_argnum = scalar @_;
	my $offset = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($offset, "int");
	return $self->_offset($offset);
}

=head2 limit(int $count) : Saklient::Cloud::Model::Model_IsoImage

次に取得するリストの上限レコード数を指定します。

@param count 上限レコード数
@return this

=cut
sub limit {
	my $self = shift;
	my $_argnum = scalar @_;
	my $count = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($count, "int");
	return $self->_limit($count);
}

=head2 filter_by(string $key, $value, bool $multiple=0) : Saklient::Cloud::Model::Model_IsoImage

APIのフィルタリング設定を直接指定します。

=cut
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

=head2 reset : Saklient::Cloud::Model::Model_IsoImage

次のリクエストのために設定されているステートをすべて破棄します。

@return this

=cut
sub reset {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reset();
}

=head2 create : Saklient::Cloud::Resource::IsoImage

新規リソース作成用のオブジェクトを用意します。

返り値のオブジェクトにパラメータを設定し、save() を呼ぶことで実際のリソースが作成されます。

@return リソースオブジェクト

=cut
sub create {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_create();
}

=head2 get_by_id(string $id) : Saklient::Cloud::Resource::IsoImage

指定したIDを持つ唯一のリソースを取得します。

@return リソースオブジェクト

=cut
sub get_by_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($id, "string");
	return $self->_get_by_id($id);
}

=head2 find : Saklient::Cloud::Resource::IsoImage[]

リソースの検索リクエストを実行し、結果をリストで取得します。

@return リソースオブジェクトの配列

=cut
sub find {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_find();
}

=head2 with_name_like(string $name) : Saklient::Cloud::Model::Model_IsoImage

指定した文字列を名前に含むリソースに絞り込みます。
大文字・小文字は区別されません。
半角スペースで区切られた複数の文字列は、それらをすべて含むことが条件とみなされます。

=cut
sub with_name_like {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	return $self->_with_name_like($name);
}

=head2 with_tag(string $tag) : Saklient::Cloud::Model::Model_IsoImage

指定したタグを持つリソースに絞り込みます。
複数のタグを指定する場合は withTags() を利用してください。

=cut
sub with_tag {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tag = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tag, "string");
	return $self->_with_tag($tag);
}

=head2 with_tags(string[] $tags) : Saklient::Cloud::Model::Model_IsoImage

指定したすべてのタグを持つリソースに絞り込みます。

=cut
sub with_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tags = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tags, "ARRAY");
	return $self->_with_tags($tags);
}

=head2 sort_by_name(bool $reverse=0) : Saklient::Cloud::Model::Model_IsoImage

名前でソートします。

=cut
sub sort_by_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	return $self->_sort_by_name($reverse);
}

=head2 with_size_gib(int $sizeGib) : Saklient::Cloud::Model::Model_IsoImage

指定したサイズのISOイメージに絞り込みます。

=cut
sub with_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $sizeGib = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($sizeGib, "int");
	$self->_filter_by("SizeMB", $sizeGib * 1024);
	return $self;
}

=head2 with_shared_scope : Saklient::Cloud::Model::Model_IsoImage

パブリックISOイメージに絞り込みます。

=cut
sub with_shared_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->_filter_by("Scope", Saklient::Cloud::Enums::EScope::shared);
	return $self;
}

=head2 with_user_scope : Saklient::Cloud::Model::Model_IsoImage

プライベートISOイメージに絞り込みます。

=cut
sub with_user_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->_filter_by("Scope", Saklient::Cloud::Enums::EScope::user);
	return $self;
}

=head2 sort_by_size(bool $reverse=0) : Saklient::Cloud::Model::Model_IsoImage

サイズでソートします。

=cut
sub sort_by_size {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	$self->_sort("SizeMB", $reverse);
	return $self;
}

1;

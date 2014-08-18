#!/usr/bin/perl

package Saclient::Cloud::Model::Model_Archive;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model;
use Saclient::Cloud::Resource::Archive;
use Saclient::Cloud::Enums::EScope;

use base qw(Saclient::Cloud::Model::Model);

=pod

=encoding utf8

=head1 Saclient::Cloud::Model::Model_Archive

アーカイブを検索するための機能を備えたクラス。

=cut


sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/archive";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archive";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archives";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archive";
}

=head2 offset(int $offset) : Saclient::Cloud::Model::Model_Archive

次に取得するリストの開始オフセットを指定します。

@param offset オフセット
@return this

=cut
sub offset {
	my $self = shift;
	my $_argnum = scalar @_;
	my $offset = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($offset, "int");
	return $self->_offset($offset);
}

=head2 limit(int $count) : Saclient::Cloud::Model::Model_Archive

次に取得するリストの上限レコード数を指定します。

@param count 上限レコード数
@return this

=cut
sub limit {
	my $self = shift;
	my $_argnum = scalar @_;
	my $count = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($count, "int");
	return $self->_limit($count);
}

=head2 filter_by(string $key, $value, bool $multiple=0) : Saclient::Cloud::Model::Model_Archive

APIのフィルタリング設定を直接指定します。

=cut
sub filter_by {
	my $self = shift;
	my $_argnum = scalar @_;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($key, "string");
	Saclient::Util::validate_type($multiple, "bool");
	return $self->_filter_by($key, $value, $multiple);
}

=head2 reset : Saclient::Cloud::Model::Model_Archive

次のリクエストのために設定されているステートをすべて破棄します。

@return this

=cut
sub reset {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reset();
}

=head2 create : Saclient::Cloud::Resource::Archive

*

=cut
sub create {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_create();
}

=head2 get_by_id(string $id) : Saclient::Cloud::Resource::Archive

指定したIDを持つ唯一のリソースを取得します。

@return リソースオブジェクト

=cut
sub get_by_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($id, "string");
	return $self->_get_by_id($id);
}

=head2 find : Saclient::Cloud::Resource::Archive[]

リソースの検索リクエストを実行し、結果をリストで取得します。

@return リソースオブジェクトの配列

=cut
sub find {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_find();
}

=head2 with_name_like(string $name) : Saclient::Cloud::Model::Model_Archive

指定した文字列を名前に含むアーカイブに絞り込みます。

=cut
sub with_name_like {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($name, "string");
	$self->_filter_by("Name", $name);
	return $self;
}

=head2 with_tag(string $tag) : Saclient::Cloud::Model::Model_Archive

指定したタグを持つアーカイブに絞り込みます。

=cut
sub with_tag {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tag = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($tag, "string");
	$self->_filter_by("Tags.Name", $tag, 1);
	return $self;
}

=head2 with_tags(string[] $tags) : Saclient::Cloud::Model::Model_Archive

指定したタグを持つアーカイブに絞り込みます。

=cut
sub with_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tags = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($tags, "ARRAY");
	$self->_filter_by("Tags.Name", $tags, 1);
	return $self;
}

=head2 with_size_gib(int $sizeGib) : Saclient::Cloud::Model::Model_Archive

指定したサイズのアーカイブに絞り込みます。

=cut
sub with_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $sizeGib = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($sizeGib, "int");
	$self->_filter_by("SizeMB", $sizeGib * 1024);
	return $self;
}

=head2 with_shared_scope : Saclient::Cloud::Model::Model_Archive

パブリックアーカイブに絞り込みます。

=cut
sub with_shared_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->_filter_by("Scope", Saclient::Cloud::Enums::EScope::shared);
	return $self;
}

=head2 with_user_scope : Saclient::Cloud::Model::Model_Archive

プライベートアーカイブに絞り込みます。

=cut
sub with_user_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->_filter_by("Scope", Saclient::Cloud::Enums::EScope::user);
	return $self;
}

=head2 sort_by_name(bool $reverse=0) : Saclient::Cloud::Model::Model_Archive

名前でソートします。

=cut
sub sort_by_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saclient::Util::validate_type($reverse, "bool");
	$self->_sort("Name", $reverse);
	return $self;
}

=head2 sort_by_size(bool $reverse=0) : Saclient::Cloud::Model::Model_Archive

サイズでソートします。

=cut
sub sort_by_size {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saclient::Util::validate_type($reverse, "bool");
	$self->_sort("SizeMB", $reverse);
	return $self;
}

1;

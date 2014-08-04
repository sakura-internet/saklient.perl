#!/usr/bin/perl

package Saclient::Cloud::Model::Model_IsoImage;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model;
use Saclient::Cloud::Resource::IsoImage;
use Saclient::Cloud::Enums::EScope;

use base qw(Saclient::Cloud::Model::Model);

=pod

=encoding utf8

=head1 Saclient::Cloud::Model::Model_IsoImage

ISOイメージを検索するための機能を備えたクラス。

=cut


sub _api_path {
	my $self = shift;
	return "/cdrom";
}

sub _root_key {
	my $self = shift;
	return "CDROM";
}

sub _root_key_m {
	my $self = shift;
	return "CDROMs";
}

sub _class_name {
	my $self = shift;
	return "IsoImage";
}

=head2 offset(int $offset) : Saclient::Cloud::Model::Model_IsoImage

次に取得するリストの開始オフセットを指定します。

@param offset オフセット
@return this

=cut
sub offset {
	my $self = shift;
	my $offset = shift;
	return $self->_offset($offset);
}

=head2 limit(int $count) : Saclient::Cloud::Model::Model_IsoImage

次に取得するリストの上限レコード数を指定します。

@param count 上限レコード数
@return this

=cut
sub limit {
	my $self = shift;
	my $count = shift;
	return $self->_limit($count);
}

=head2 filter_by(string $key, $value, bool $multiple=0) : Saclient::Cloud::Model::Model_IsoImage

APIのフィルタリング設定を直接指定します。

=cut
sub filter_by {
	my $self = shift;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	return $self->_filter_by($key, $value, $multiple);
}

=head2 reset : Saclient::Cloud::Model::Model_IsoImage

次のリクエストのために設定されているステートをすべて破棄します。

@return this

=cut
sub reset {
	my $self = shift;
	return $self->_reset();
}

=head2 get_by_id(string $id) : Saclient::Cloud::Resource::IsoImage

指定したIDを持つ唯一のリソースを取得します。

@return リソースオブジェクト

=cut
sub get_by_id {
	my $self = shift;
	my $id = shift;
	return $self->_get_by_id($id);
}

=head2 find : Saclient::Cloud::Resource::IsoImage[]

リソースの検索リクエストを実行し、結果をリストで取得します。

@return リソースオブジェクトの配列

=cut
sub find {
	my $self = shift;
	return $self->_find();
}

=head2 with_name_like(string $name) : Saclient::Cloud::Model::Model_IsoImage

指定した文字列を名前に含むISOイメージに絞り込みます。

=cut
sub with_name_like {
	my $self = shift;
	my $name = shift;
	$self->_filter_by("Name", $name);
	return $self;
}

=head2 with_tag(string $tag) : Saclient::Cloud::Model::Model_IsoImage

指定したタグを持つISOイメージに絞り込みます。

=cut
sub with_tag {
	my $self = shift;
	my $tag = shift;
	$self->_filter_by("Tags.Name", $tag, 1);
	return $self;
}

=head2 with_size_gib(int $sizeGib) : Saclient::Cloud::Model::Model_IsoImage

指定したサイズのISOイメージに絞り込みます。

=cut
sub with_size_gib {
	my $self = shift;
	my $sizeGib = shift;
	$self->_filter_by("SizeMB", $sizeGib * 1024);
	return $self;
}

=head2 with_shared_scope : Saclient::Cloud::Model::Model_IsoImage

パブリックISOイメージに絞り込みます。

=cut
sub with_shared_scope {
	my $self = shift;
	$self->_filter_by("Scope", Saclient::Cloud::Enums::EScope::shared);
	return $self;
}

=head2 with_user_scope : Saclient::Cloud::Model::Model_IsoImage

プライベートISOイメージに絞り込みます。

=cut
sub with_user_scope {
	my $self = shift;
	$self->_filter_by("Scope", Saclient::Cloud::Enums::EScope::user);
	return $self;
}

1;

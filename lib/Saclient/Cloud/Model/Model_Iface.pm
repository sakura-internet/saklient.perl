#!/usr/bin/perl

package Saclient::Cloud::Model::Model_Iface;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model;
use Saclient::Cloud::Resource::Iface;

use base qw(Saclient::Cloud::Model::Model);

=pod

=encoding utf8

=head1 Saclient::Cloud::Model::Model_Iface

インタフェースを検索するための機能を備えたクラス。

=cut


sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/interface";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Interface";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Interfaces";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Iface";
}

=head2 offset(int $offset) : Saclient::Cloud::Model::Model_Iface

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

=head2 limit(int $count) : Saclient::Cloud::Model::Model_Iface

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

=head2 filter_by(string $key, $value, bool $multiple=0) : Saclient::Cloud::Model::Model_Iface

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

=head2 reset : Saclient::Cloud::Model::Model_Iface

次のリクエストのために設定されているステートをすべて破棄します。

@return this

=cut
sub reset {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reset();
}

=head2 create : Saclient::Cloud::Resource::Iface

*

=cut
sub create {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_create();
}

=head2 get_by_id(string $id) : Saclient::Cloud::Resource::Iface

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

=head2 find : Saclient::Cloud::Resource::Iface[]

リソースの検索リクエストを実行し、結果をリストで取得します。

@return リソースオブジェクトの配列

=cut
sub find {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_find();
}

1;
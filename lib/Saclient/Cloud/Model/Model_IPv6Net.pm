#!/usr/bin/perl

package Saclient::Cloud::Model::Model_IPv6Net;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model;
use Saclient::Cloud::Resource::IPv6Net;

use base qw(Saclient::Cloud::Model::Model);

=pod

=encoding utf8

=head1 Saclient::Cloud::Model::Model_IPv6Net

IPv6ネットワークを検索するための機能を備えたクラス。

=cut


sub _api_path {
	my $self = shift;
	return "/ipv6net";
}

sub _root_key {
	my $self = shift;
	return "IPv6Net";
}

sub _root_key_m {
	my $self = shift;
	return "IPv6Nets";
}

sub _class_name {
	my $self = shift;
	return "IPv6Net";
}

=head2 offset(int $offset) : Saclient::Cloud::Model::Model_IPv6Net

次に取得するリストの開始オフセットを指定します。

@param offset オフセット
@return this

=cut
sub offset {
	my $self = shift;
	my $offset = shift;
	return $self->_offset($offset);
}

=head2 limit(int $count) : Saclient::Cloud::Model::Model_IPv6Net

次に取得するリストの上限レコード数を指定します。

@param count 上限レコード数
@return this

=cut
sub limit {
	my $self = shift;
	my $count = shift;
	return $self->_limit($count);
}

=head2 reset : Saclient::Cloud::Model::Model_IPv6Net

次のリクエストのために設定されているステートをすべて破棄します。

@return this

=cut
sub reset {
	my $self = shift;
	return $self->_reset();
}

=head2 get_by_id(string $id) : Saclient::Cloud::Resource::IPv6Net

指定したIDを持つ唯一のリソースを取得します。

@return リソースオブジェクト

=cut
sub get_by_id {
	my $self = shift;
	my $id = shift;
	return $self->_get_by_id($id);
}

=head2 find : Saclient::Cloud::Resource::IPv6Net[]

リソースの検索リクエストを実行し、結果をリストで取得します。

@return リソースオブジェクトの配列

=cut
sub find {
	my $self = shift;
	return $self->_find();
}

1;

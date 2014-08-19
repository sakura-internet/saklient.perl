#!/usr/bin/perl

package Saklient::Cloud::API;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;
use Saklient::Cloud::Product;
use Saklient::Cloud::Model::Model_Icon;
use Saklient::Cloud::Model::Model_Server;
use Saklient::Cloud::Model::Model_Disk;
use Saklient::Cloud::Model::Model_Appliance;
use Saklient::Cloud::Model::Model_Archive;
use Saklient::Cloud::Model::Model_IsoImage;
use Saklient::Cloud::Model::Model_Iface;
use Saklient::Cloud::Model::Model_Swytch;
use Saklient::Cloud::Model::Model_Router;
use Saklient::Cloud::Model::Model_Ipv6Net;
use Saklient::Cloud::Model::Model_Script;


=pod

=encoding utf8

=head1 Saklient::Cloud::API

さくらのクラウドAPIクライアントを利用する際、最初にアクセスすべきルートとなるクラス。

@see API.authorize

=cut


my $_client;

sub get_client {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_client'};
}

sub client {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#client");
		throw $ex;
	}
	return $_[0]->get_client();
}

my $_product;

sub get_product {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_product'};
}

=head2 product

商品情報にアクセスするためのモデルを集めたオブジェクト。

=cut
sub product {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#product");
		throw $ex;
	}
	return $_[0]->get_product();
}

my $_icon;

sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_icon'};
}

=head2 icon

アイコンにアクセスするためのモデル。

=cut
sub icon {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#icon");
		throw $ex;
	}
	return $_[0]->get_icon();
}

my $_server;

sub get_server {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_server'};
}

=head2 server

サーバにアクセスするためのモデル。

=cut
sub server {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#server");
		throw $ex;
	}
	return $_[0]->get_server();
}

my $_disk;

sub get_disk {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_disk'};
}

=head2 disk

ディスクにアクセスするためのモデル。

=cut
sub disk {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#disk");
		throw $ex;
	}
	return $_[0]->get_disk();
}

my $_appliance;

sub get_appliance {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_appliance'};
}

=head2 appliance

アプライアンスにアクセスするためのモデル。

=cut
sub appliance {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#appliance");
		throw $ex;
	}
	return $_[0]->get_appliance();
}

my $_archive;

sub get_archive {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_archive'};
}

=head2 archive

アーカイブにアクセスするためのモデル。

=cut
sub archive {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#archive");
		throw $ex;
	}
	return $_[0]->get_archive();
}

my $_iso_image;

sub get_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_iso_image'};
}

=head2 iso_image

ISOイメージにアクセスするためのモデル。

=cut
sub iso_image {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#iso_image");
		throw $ex;
	}
	return $_[0]->get_iso_image();
}

my $_iface;

sub get_iface {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_iface'};
}

=head2 iface

インタフェースにアクセスするためのモデル。

=cut
sub iface {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#iface");
		throw $ex;
	}
	return $_[0]->get_iface();
}

my $_swytch;

sub get_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_swytch'};
}

=head2 swytch

スイッチにアクセスするためのモデル。

=cut
sub swytch {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#swytch");
		throw $ex;
	}
	return $_[0]->get_swytch();
}

my $_router;

sub get_router {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_router'};
}

=head2 router

ルータにアクセスするためのモデル。

=cut
sub router {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#router");
		throw $ex;
	}
	return $_[0]->get_router();
}

my $_ipv6_net;

sub get_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ipv6_net'};
}

=head2 ipv6_net

IPv6ネットワークにアクセスするためのモデル。

=cut
sub ipv6_net {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#ipv6_net");
		throw $ex;
	}
	return $_[0]->get_ipv6_net();
}

my $_script;

sub get_script {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_script'};
}

=head2 script

スクリプトにアクセスするためのモデル。

=cut
sub script {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#script");
		throw $ex;
	}
	return $_[0]->get_script();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_client'} = $client;
	$self->{'_product'} = new Saklient::Cloud::Product($client);
	$self->{'_icon'} = new Saklient::Cloud::Model::Model_Icon($client);
	$self->{'_server'} = new Saklient::Cloud::Model::Model_Server($client);
	$self->{'_disk'} = new Saklient::Cloud::Model::Model_Disk($client);
	$self->{'_appliance'} = new Saklient::Cloud::Model::Model_Appliance($client);
	$self->{'_archive'} = new Saklient::Cloud::Model::Model_Archive($client);
	$self->{'_iso_image'} = new Saklient::Cloud::Model::Model_IsoImage($client);
	$self->{'_iface'} = new Saklient::Cloud::Model::Model_Iface($client);
	$self->{'_swytch'} = new Saklient::Cloud::Model::Model_Swytch($client);
	$self->{'_router'} = new Saklient::Cloud::Model::Model_Router($client);
	$self->{'_ipv6_net'} = new Saklient::Cloud::Model::Model_Ipv6Net($client);
	$self->{'_script'} = new Saklient::Cloud::Model::Model_Script($client);
	return $self;
}

=head2 authorize(string $token, string $secret) : Saklient::Cloud::API

指定した認証情報を用いてアクセスを行うAPIクライアントを作成します。

必要な認証情報は、コントロールパネル右上にあるアカウントのプルダウンから
「設定」を選択し、「APIキー」のページにて作成できます。

@param token ACCESS TOKEN
@param secret ACCESS TOKEN SECRET
@return APIクライアント

=cut
sub authorize {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::API';
	my $_argnum = scalar @_;
	my $token = shift;
	my $secret = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($token, "string");
	Saklient::Util::validate_type($secret, "string");
	my $c = new Saklient::Cloud::Client($token, $secret);
	return new Saklient::Cloud::API($c);
}

=head2 in_zone(string $name) : Saklient::Cloud::API

認証情報を引き継ぎ、指定したゾーンへのアクセスを行うAPIクライアントを作成します。

@param name ゾーン名
@return APIクライアント

=cut
sub in_zone {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	my $ret = new Saklient::Cloud::API($self->{'_client'}->clone_instance());
	$ret->{'_client'}->set_api_root_suffix("zone/" . $name);
	return $ret;
}

1;

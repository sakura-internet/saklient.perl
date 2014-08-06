#!/usr/bin/perl

package Saclient::Cloud::API;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Util;
use Saclient::Cloud::Client;
use Saclient::Cloud::Product;
use Saclient::Cloud::Model::Model_Icon;
use Saclient::Cloud::Model::Model_Server;
use Saclient::Cloud::Model::Model_Disk;
use Saclient::Cloud::Model::Model_Appliance;
use Saclient::Cloud::Model::Model_Archive;
use Saclient::Cloud::Model::Model_IsoImage;
use Saclient::Cloud::Model::Model_Iface;
use Saclient::Cloud::Model::Model_Swytch;
use Saclient::Cloud::Model::Model_Router;
use Saclient::Cloud::Model::Model_Ipv6Net;
use Saclient::Cloud::Model::Model_Script;


=pod

=encoding utf8

=head1 Saclient::Cloud::API

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
	return $_[0]->get_client();
}

my $_product;

sub get_product {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_product'};
}

sub product {
	return $_[0]->get_product();
}

my $_icon;

sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_icon'};
}

sub icon {
	return $_[0]->get_icon();
}

my $_server;

sub get_server {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_server'};
}

sub server {
	return $_[0]->get_server();
}

my $_disk;

sub get_disk {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_disk'};
}

sub disk {
	return $_[0]->get_disk();
}

my $_appliance;

sub get_appliance {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_appliance'};
}

sub appliance {
	return $_[0]->get_appliance();
}

my $_archive;

sub get_archive {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_archive'};
}

sub archive {
	return $_[0]->get_archive();
}

my $_iso_image;

sub get_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_iso_image'};
}

sub iso_image {
	return $_[0]->get_iso_image();
}

my $_iface;

sub get_iface {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_iface'};
}

sub iface {
	return $_[0]->get_iface();
}

my $_swytch;

sub get_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_swytch'};
}

sub swytch {
	return $_[0]->get_swytch();
}

my $_router;

sub get_router {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_router'};
}

sub router {
	return $_[0]->get_router();
}

my $_ipv6_net;

sub get_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ipv6_net'};
}

sub ipv6_net {
	return $_[0]->get_ipv6_net();
}

my $_script;

sub get_script {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_script'};
}

sub script {
	return $_[0]->get_script();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($client, "Saclient::Cloud::Client");
	$self->{'_client'} = $client;
	$self->{'_product'} = new Saclient::Cloud::Product($client);
	$self->{'_icon'} = new Saclient::Cloud::Model::Model_Icon($client);
	$self->{'_server'} = new Saclient::Cloud::Model::Model_Server($client);
	$self->{'_disk'} = new Saclient::Cloud::Model::Model_Disk($client);
	$self->{'_appliance'} = new Saclient::Cloud::Model::Model_Appliance($client);
	$self->{'_archive'} = new Saclient::Cloud::Model::Model_Archive($client);
	$self->{'_iso_image'} = new Saclient::Cloud::Model::Model_IsoImage($client);
	$self->{'_iface'} = new Saclient::Cloud::Model::Model_Iface($client);
	$self->{'_swytch'} = new Saclient::Cloud::Model::Model_Swytch($client);
	$self->{'_router'} = new Saclient::Cloud::Model::Model_Router($client);
	$self->{'_ipv6_net'} = new Saclient::Cloud::Model::Model_Ipv6Net($client);
	$self->{'_script'} = new Saclient::Cloud::Model::Model_Script($client);
	return $self;
}

=head2 authorize(string $token, string $secret) : Saclient::Cloud::API

指定した認証情報を用いてアクセスを行うAPIクライアントを作成します。
必要な認証情報は、コントロールパネル右上にあるアカウントのプルダウンから
「設定」を選択し、「APIキー」のページにて作成できます。

@param token ACCESS TOKEN
@param secret ACCESS TOKEN SECRET
@return APIクライアント

=cut
sub authorize {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::API';
	my $_argnum = scalar @_;
	my $token = shift;
	my $secret = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($token, "string");
	Saclient::Util::validate_type($secret, "string");
	my $c = new Saclient::Cloud::Client($token, $secret);
	return new Saclient::Cloud::API($c);
}

=head2 in_zone(string $name) : Saclient::Cloud::API

認証情報を引き継ぎ、指定したゾーンへのアクセスを行うAPIクライアントを作成します。

@param name ゾーン名
@return APIクライアント

=cut
sub in_zone {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($name, "string");
	my $ret = new Saclient::Cloud::API($self->{'_client'}->clone_instance());
	$ret->{'_client'}->set_api_root("https://secure.sakura.ad.jp/cloud/");
	$ret->{'_client'}->set_api_root_suffix("zone/" . $name);
	return $ret;
}

sub sleep {
	my $self = shift;
	my $_argnum = scalar @_;
	my $sec = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($sec, "int");
	sleep $sec;
}

1;

#!/usr/bin/perl

package Saclient::Cloud::API;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Product;
use Saclient::Cloud::Model::Model_Icon;
use Saclient::Cloud::Model::Model_Server;
use Saclient::Cloud::Model::Model_Disk;
use Saclient::Cloud::Model::Model_Appliance;
use Saclient::Cloud::Model::Model_Archive;
use Saclient::Cloud::Model::Model_IPv6Net;


=pod

=encoding utf8

=head1 Saclient::Cloud::API

さくらのクラウドAPIクライアントを利用する際、最初にアクセスすべきルートとなるクラス。

@see API.authorize

=cut


my $_client;

sub get_client {
	my $self = shift;
	return $self->{'_client'};
}

sub client {
	return $_[0]->get_client();
}

my $_product;

sub get_product {
	my $self = shift;
	return $self->{'_product'};
}

sub product {
	return $_[0]->get_product();
}

my $_icon;

sub get_icon {
	my $self = shift;
	return $self->{'_icon'};
}

sub icon {
	return $_[0]->get_icon();
}

my $_server;

sub get_server {
	my $self = shift;
	return $self->{'_server'};
}

sub server {
	return $_[0]->get_server();
}

my $_disk;

sub get_disk {
	my $self = shift;
	return $self->{'_disk'};
}

sub disk {
	return $_[0]->get_disk();
}

my $_appliance;

sub get_appliance {
	my $self = shift;
	return $self->{'_appliance'};
}

sub appliance {
	return $_[0]->get_appliance();
}

my $_archive;

sub get_archive {
	my $self = shift;
	return $self->{'_archive'};
}

sub archive {
	return $_[0]->get_archive();
}

my $_ipv6net;

sub get_ipv6net {
	my $self = shift;
	return $self->{'_ipv6net'};
}

sub ipv6net {
	return $_[0]->get_ipv6net();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	$self->{'_client'} = $client;
	$self->{'_product'} = new Saclient::Cloud::Product($client);
	$self->{'_icon'} = new Saclient::Cloud::Model::Model_Icon($client);
	$self->{'_server'} = new Saclient::Cloud::Model::Model_Server($client);
	$self->{'_disk'} = new Saclient::Cloud::Model::Model_Disk($client);
	$self->{'_appliance'} = new Saclient::Cloud::Model::Model_Appliance($client);
	$self->{'_archive'} = new Saclient::Cloud::Model::Model_Archive($client);
	$self->{'_ipv6net'} = new Saclient::Cloud::Model::Model_IPv6Net($client);
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
	my $token = shift;
	my $secret = shift;
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
	my $name = shift;
	my $ret = new Saclient::Cloud::API($self->{'_client'}->clone_instance());
	$ret->{'_client'}->set_api_root_suffix("zone/" . $name);
	return $ret;
}

1;

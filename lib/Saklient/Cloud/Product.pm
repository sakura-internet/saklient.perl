#!/usr/bin/perl

package Saklient::Cloud::Product;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Model::Model_ServerPlan;
use Saklient::Cloud::Model::Model_DiskPlan;
use Saklient::Cloud::Model::Model_RouterPlan;
use Saklient::Cloud::Client;


=pod

=encoding utf8

=head1 Saklient::Cloud::Product

商品情報にアクセスするためのモデルを集めたクラス。

=cut


my $_server;

sub get_server {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_server'};
}

=head2 server

サーバプラン情報。

=cut
sub server {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Product#server");
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

ディスクプラン情報。

=cut
sub disk {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Product#disk");
		throw $ex;
	}
	return $_[0]->get_disk();
}

my $_router;

sub get_router {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_router'};
}

=head2 router

ルータ帯域プラン情報。

=cut
sub router {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Product#router");
		throw $ex;
	}
	return $_[0]->get_router();
}

=head2 new(Saklient::Cloud::Client $client)

@ignore

=cut
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_server'} = new Saklient::Cloud::Model::Model_ServerPlan($client);
	$self->{'_disk'} = new Saklient::Cloud::Model::Model_DiskPlan($client);
	$self->{'_router'} = new Saklient::Cloud::Model::Model_RouterPlan($client);
	return $self;
}

1;

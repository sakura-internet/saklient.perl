#!/usr/bin/perl

package Saclient::Cloud::Product;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model_ServerPlan;
use Saclient::Cloud::Model::Model_DiskPlan;
use Saclient::Cloud::Model::Model_RouterPlan;
use Saclient::Cloud::Client;


=pod

=encoding utf8

=cut

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

my $_router;

sub get_router {
	my $self = shift;
	return $self->{'_router'};
}

sub router {
	return $_[0]->get_router();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	$self->{'_server'} = new Saclient::Cloud::Model::Model_ServerPlan($client);
	$self->{'_disk'} = new Saclient::Cloud::Model::Model_DiskPlan($client);
	$self->{'_router'} = new Saclient::Cloud::Model::Model_RouterPlan($client);
	return $self;
}

1;

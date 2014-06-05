#!/usr/bin/perl

package Saclient::Cloud::Product;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Model::Model_ServerPlan;
use Saclient::Cloud::Model::Model_DiskPlan;
use Saclient::Cloud::Model::Model_InternetPlan;
use Saclient::Cloud::Client;

## @class Saclient::Cloud::Product
#

## @var private Saclient::Cloud::Model::Model_ServerPlan $_server
# @private
#
my $_server;

sub get_server {
	my $self = shift;
	{
		return $self->{'_server'};
	}
}

sub server {
	return $_[0]->get_server();
}

## @var private Saclient::Cloud::Model::Model_DiskPlan $_disk
# @private
#
my $_disk;

sub get_disk {
	my $self = shift;
	{
		return $self->{'_disk'};
	}
}

sub disk {
	return $_[0]->get_disk();
}

## @var private Saclient::Cloud::Model::Model_InternetPlan $_internet
# @private
#
my $_internet;

sub get_internet {
	my $self = shift;
	{
		return $self->{'_internet'};
	}
}

sub internet {
	return $_[0]->get_internet();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	{
		$self->{'_server'} = new Saclient::Cloud::Model::Model_ServerPlan($client);
		$self->{'_disk'} = new Saclient::Cloud::Model::Model_DiskPlan($client);
		$self->{'_internet'} = new Saclient::Cloud::Model::Model_InternetPlan($client);
	}
	return $self;
}

1;

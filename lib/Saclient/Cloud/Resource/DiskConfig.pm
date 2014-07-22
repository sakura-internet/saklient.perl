#!/usr/bin/perl

package Saclient::Cloud::Resource::DiskConfig;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Util;


=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::DiskConfig

ディスク修正のパラメータ

=cut


my $_client;

sub get_client {
	my $self = shift;
	return $self->{'_client'};
}

sub client {
	return $_[0]->get_client();
}

my $_disk_id;

sub get_disk_id {
	my $self = shift;
	return $self->{'_disk_id'};
}

sub disk_id {
	return $_[0]->get_disk_id();
}

my $_host_name;

sub get_host_name {
	my $self = shift;
	return $self->{'_host_name'};
}

sub set_host_name {
	my $self = shift;
	my $v = shift;
	$self->{'_host_name'} = $v;
	return $v;
}

sub host_name {
	if (1 < scalar(@_)) { $_[0]->set_host_name($_[1]); return $_[0]; }
	return $_[0]->get_host_name();
}

my $_password;

sub get_password {
	my $self = shift;
	return $self->{'_password'};
}

sub set_password {
	my $self = shift;
	my $v = shift;
	$self->{'_password'} = $v;
	return $v;
}

sub password {
	if (1 < scalar(@_)) { $_[0]->set_password($_[1]); return $_[0]; }
	return $_[0]->get_password();
}

my $_ssh_key;

sub get_ssh_key {
	my $self = shift;
	return $self->{'_ssh_key'};
}

sub set_ssh_key {
	my $self = shift;
	my $v = shift;
	$self->{'_ssh_key'} = $v;
	return $v;
}

sub ssh_key {
	if (1 < scalar(@_)) { $_[0]->set_ssh_key($_[1]); return $_[0]; }
	return $_[0]->get_ssh_key();
}

my $_ip_address;

sub get_ip_address {
	my $self = shift;
	return $self->{'_ip_address'};
}

sub set_ip_address {
	my $self = shift;
	my $v = shift;
	$self->{'_ip_address'} = $v;
	return $v;
}

sub ip_address {
	if (1 < scalar(@_)) { $_[0]->set_ip_address($_[1]); return $_[0]; }
	return $_[0]->get_ip_address();
}

my $_gateway;

sub get_gateway {
	my $self = shift;
	return $self->{'_gateway'};
}

sub set_gateway {
	my $self = shift;
	my $v = shift;
	$self->{'_gateway'} = $v;
	return $v;
}

sub gateway {
	if (1 < scalar(@_)) { $_[0]->set_gateway($_[1]); return $_[0]; }
	return $_[0]->get_gateway();
}

my $_network_mask_len;

sub get_network_mask_len {
	my $self = shift;
	return $self->{'_network_mask_len'};
}

sub set_network_mask_len {
	my $self = shift;
	my $v = shift;
	$self->{'_network_mask_len'} = $v;
	return $v;
}

sub network_mask_len {
	if (1 < scalar(@_)) { $_[0]->set_network_mask_len($_[1]); return $_[0]; }
	return $_[0]->get_network_mask_len();
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	my $diskId = shift;
	$self->{'_client'} = $client;
	$self->{'_disk_id'} = $diskId;
	$self->{'_host_name'} = undef;
	$self->{'_password'} = undef;
	$self->{'_ssh_key'} = undef;
	$self->{'_ip_address'} = undef;
	$self->{'_gateway'} = undef;
	$self->{'_network_mask_len'} = undef;
	return $self;
}

=head2 write : Saclient::Cloud::Resource::DiskConfig

*

=cut
sub write {
	my $self = shift;
	my $q = {};
	if (defined($self->{'_host_name'})) {
		Saclient::Cloud::Util::set_by_path($q, "HostName", $self->{'_host_name'});
	}
	if (defined($self->{'_password'})) {
		Saclient::Cloud::Util::set_by_path($q, "Password", $self->{'_password'});
	}
	if (defined($self->{'_ssh_key'})) {
		Saclient::Cloud::Util::set_by_path($q, "SSHKey.PublicKey", $self->{'_ssh_key'});
	}
	if (defined($self->{'_ip_address'})) {
		Saclient::Cloud::Util::set_by_path($q, "UserIPAddress", $self->{'_ip_address'});
	}
	if (defined($self->{'_gateway'})) {
		Saclient::Cloud::Util::set_by_path($q, "UserSubnet.DefaultRoute", $self->{'_gateway'});
	}
	if (defined($self->{'_network_mask_len'})) {
		Saclient::Cloud::Util::set_by_path($q, "UserSubnet.NetworkMaskLen", $self->{'_network_mask_len'});
	}
	my $path = "/disk/" . $self->{'_disk_id'} . "/config";
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	return $self;
}

1;

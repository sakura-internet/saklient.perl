#!/usr/bin/perl

package Saclient::Cloud::Resource::Ipv4Net;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Swytch;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Ipv4Net

IPv4ネットワークのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_address;

my $m_mask_len;

my $m_default_route;

my $m_next_hop;

sub _api_path {
	my $self = shift;
	return "/subnet";
}

sub _root_key {
	my $self = shift;
	return "Subnet";
}

sub _root_key_m {
	my $self = shift;
	return "Subnets";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 reload : Saclient::Cloud::Resource::Swytch

最新のリソース情報を再取得します。

@return this

=cut
sub reload {
	my $self = shift;
	return $self->_reload();
}

sub new {
	my $class = shift;
	my $self;
	my $client = shift;
	my $r = shift;
	$self = $class->SUPER::new($client);
	$self->api_deserialize($r);
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	return $self->{'m_id'};
}

sub id {
	return $_[0]->get_id();
}

my $n_address = 0;

sub get_address {
	my $self = shift;
	return $self->{'m_address'};
}

sub address {
	return $_[0]->get_address();
}

my $n_mask_len = 0;

sub get_mask_len {
	my $self = shift;
	return $self->{'m_mask_len'};
}

sub mask_len {
	return $_[0]->get_mask_len();
}

my $n_default_route = 0;

sub get_default_route {
	my $self = shift;
	return $self->{'m_default_route'};
}

sub default_route {
	return $_[0]->get_default_route();
}

my $n_next_hop = 0;

sub get_next_hop {
	my $self = shift;
	return $self->{'m_next_hop'};
}

sub next_hop {
	return $_[0]->get_next_hop();
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saclient::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saclient::Util::get_by_path($r, "ID")) ? undef : "" . Saclient::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saclient::Util::exists_path($r, "NetworkAddress")) {
		$self->{'m_address'} = !defined(Saclient::Util::get_by_path($r, "NetworkAddress")) ? undef : "" . Saclient::Util::get_by_path($r, "NetworkAddress");
	}
	else {
		$self->{'m_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_address'} = 0;
	if (Saclient::Util::exists_path($r, "NetworkMaskLen")) {
		$self->{'m_mask_len'} = !defined(Saclient::Util::get_by_path($r, "NetworkMaskLen")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "NetworkMaskLen")));
	}
	else {
		$self->{'m_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mask_len'} = 0;
	if (Saclient::Util::exists_path($r, "DefaultRoute")) {
		$self->{'m_default_route'} = !defined(Saclient::Util::get_by_path($r, "DefaultRoute")) ? undef : "" . Saclient::Util::get_by_path($r, "DefaultRoute");
	}
	else {
		$self->{'m_default_route'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_default_route'} = 0;
	if (Saclient::Util::exists_path($r, "NextHop")) {
		$self->{'m_next_hop'} = !defined(Saclient::Util::get_by_path($r, "NextHop")) ? undef : "" . Saclient::Util::get_by_path($r, "NextHop");
	}
	else {
		$self->{'m_next_hop'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_next_hop'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_address'}) {
		Saclient::Util::set_by_path($ret, "NetworkAddress", $self->{'m_address'});
	}
	if ($withClean || $self->{'n_mask_len'}) {
		Saclient::Util::set_by_path($ret, "NetworkMaskLen", $self->{'m_mask_len'});
	}
	if ($withClean || $self->{'n_default_route'}) {
		Saclient::Util::set_by_path($ret, "DefaultRoute", $self->{'m_default_route'});
	}
	if ($withClean || $self->{'n_next_hop'}) {
		Saclient::Util::set_by_path($ret, "NextHop", $self->{'m_next_hop'});
	}
	return $ret;
}

1;

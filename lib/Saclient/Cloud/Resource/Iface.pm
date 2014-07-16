#!/usr/bin/perl

package Saclient::Cloud::Resource::Iface;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Iface

インタフェースのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_mac_address;

my $m_ip_address;

my $m_user_ip_address;

sub _api_path {
	my $self = shift;
	return "/interface";
}

sub _root_key {
	my $self = shift;
	return "Interface";
}

sub _root_key_m {
	my $self = shift;
	return "Interfaces";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Iface

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Iface

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

my $n_mac_address = 0;

sub get_mac_address {
	my $self = shift;
	return $self->{'m_mac_address'};
}

sub mac_address {
	return $_[0]->get_mac_address();
}

my $n_ip_address = 0;

sub get_ip_address {
	my $self = shift;
	return $self->{'m_ip_address'};
}

sub ip_address {
	return $_[0]->get_ip_address();
}

my $n_user_ip_address = 0;

sub get_user_ip_address {
	my $self = shift;
	return $self->{'m_user_ip_address'};
}

sub set_user_ip_address {
	my $self = shift;
	my $v = shift;
	$self->{'m_user_ip_address'} = $v;
	$self->{'n_user_ip_address'} = 1;
	return $self->{'m_user_ip_address'};
}

sub user_ip_address {
	if (1 < scalar(@_)) { $_[0]->set_user_ip_address($_[1]); return $_[0]; }
	return $_[0]->get_user_ip_address();
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"ID"})) {
		$self->{'m_id'} = !defined($r->{"ID"}) ? undef : "" . $r->{"ID"};
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"MACAddress"})) {
		$self->{'m_mac_address'} = !defined($r->{"MACAddress"}) ? undef : "" . $r->{"MACAddress"};
	}
	else {
		$self->{'m_mac_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mac_address'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"IPAddress"})) {
		$self->{'m_ip_address'} = !defined($r->{"IPAddress"}) ? undef : "" . $r->{"IPAddress"};
	}
	else {
		$self->{'m_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ip_address'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"UserIPAddress"})) {
		$self->{'m_user_ip_address'} = !defined($r->{"UserIPAddress"}) ? undef : "" . $r->{"UserIPAddress"};
	}
	else {
		$self->{'m_user_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_ip_address'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_mac_address'}) {
		$ret->{"MACAddress"} = $self->{'m_mac_address'};
	}
	if ($withClean || $self->{'n_ip_address'}) {
		$ret->{"IPAddress"} = $self->{'m_ip_address'};
	}
	if ($withClean || $self->{'n_user_ip_address'}) {
		$ret->{"UserIPAddress"} = $self->{'m_user_ip_address'};
	}
	return $ret;
}

1;

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

my $m_server_id;

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

my $n_server_id = 0;

sub get_server_id {
	my $self = shift;
	return $self->{'m_server_id'};
}

sub set_server_id {
	my $self = shift;
	my $v = shift;
	$self->{'m_server_id'} = $v;
	$self->{'n_server_id'} = 1;
	return $self->{'m_server_id'};
}

=head2 server_id

サーバ

=cut
sub server_id {
	if (1 < scalar(@_)) { $_[0]->set_server_id($_[1]); return $_[0]; }
	return $_[0]->get_server_id();
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saclient::Cloud::Util::get_by_path($r, "ID")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "MACAddress")) {
		$self->{'m_mac_address'} = !defined(Saclient::Cloud::Util::get_by_path($r, "MACAddress")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "MACAddress");
	}
	else {
		$self->{'m_mac_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mac_address'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "IPAddress")) {
		$self->{'m_ip_address'} = !defined(Saclient::Cloud::Util::get_by_path($r, "IPAddress")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "IPAddress");
	}
	else {
		$self->{'m_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ip_address'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "UserIPAddress")) {
		$self->{'m_user_ip_address'} = !defined(Saclient::Cloud::Util::get_by_path($r, "UserIPAddress")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "UserIPAddress");
	}
	else {
		$self->{'m_user_ip_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_user_ip_address'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Server.ID")) {
		$self->{'m_server_id'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Server.ID")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Server.ID");
	}
	else {
		$self->{'m_server_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_server_id'} = 0;
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
	if ($withClean || $self->{'n_server_id'}) {
		$ret->{"Server.ID"} = $self->{'m_server_id'};
	}
	return $ret;
}

1;

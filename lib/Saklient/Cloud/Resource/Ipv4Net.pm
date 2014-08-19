#!/usr/bin/perl

package Saklient::Cloud::Resource::Ipv4Net;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::Swytch;

use base qw(Saklient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::Ipv4Net

IPv4ネットワークの実体1つに対応し、属性の取得や操作を行うためのクラス。

=cut


my $m_id;

my $m_address;

my $m_mask_len;

my $m_default_route;

my $m_next_hop;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/subnet";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Subnet";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Subnets";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Ipv4Net";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 reload : Saklient::Cloud::Resource::Swytch

最新のリソース情報を再取得します。

@return this

=cut
sub reload {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reload();
}

sub new {
	my $class = shift;
	my $self;
	my $_argnum = scalar @_;
	my $client = shift;
	my $obj = shift;
	my $wrapped = shift || (0);
	$self = $class->SUPER::new($client);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	$self->api_deserialize($obj, $wrapped);
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

=head2 id

ID

=cut
sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv4Net#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

my $n_address = 0;

sub get_address {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_address'};
}

=head2 address

ネットワークアドレス

=cut
sub address {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv4Net#address");
		throw $ex;
	}
	return $_[0]->get_address();
}

my $n_mask_len = 0;

sub get_mask_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_mask_len'};
}

=head2 mask_len

マスク長

=cut
sub mask_len {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv4Net#mask_len");
		throw $ex;
	}
	return $_[0]->get_mask_len();
}

my $n_default_route = 0;

sub get_default_route {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_default_route'};
}

=head2 default_route

デフォルトルート

=cut
sub default_route {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv4Net#default_route");
		throw $ex;
	}
	return $_[0]->get_default_route();
}

my $n_next_hop = 0;

sub get_next_hop {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_next_hop'};
}

=head2 next_hop

ネクストホップ

=cut
sub next_hop {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv4Net#next_hop");
		throw $ex;
	}
	return $_[0]->get_next_hop();
}

sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saklient::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saklient::Util::get_by_path($r, "ID")) ? undef : "" . Saklient::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saklient::Util::exists_path($r, "NetworkAddress")) {
		$self->{'m_address'} = !defined(Saklient::Util::get_by_path($r, "NetworkAddress")) ? undef : "" . Saklient::Util::get_by_path($r, "NetworkAddress");
	}
	else {
		$self->{'m_address'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_address'} = 0;
	if (Saklient::Util::exists_path($r, "NetworkMaskLen")) {
		$self->{'m_mask_len'} = !defined(Saklient::Util::get_by_path($r, "NetworkMaskLen")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "NetworkMaskLen")));
	}
	else {
		$self->{'m_mask_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_mask_len'} = 0;
	if (Saklient::Util::exists_path($r, "DefaultRoute")) {
		$self->{'m_default_route'} = !defined(Saklient::Util::get_by_path($r, "DefaultRoute")) ? undef : "" . Saklient::Util::get_by_path($r, "DefaultRoute");
	}
	else {
		$self->{'m_default_route'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_default_route'} = 0;
	if (Saklient::Util::exists_path($r, "NextHop")) {
		$self->{'m_next_hop'} = !defined(Saklient::Util::get_by_path($r, "NextHop")) ? undef : "" . Saklient::Util::get_by_path($r, "NextHop");
	}
	else {
		$self->{'m_next_hop'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_next_hop'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_address'}) {
		Saklient::Util::set_by_path($ret, "NetworkAddress", $self->{'m_address'});
	}
	if ($withClean || $self->{'n_mask_len'}) {
		Saklient::Util::set_by_path($ret, "NetworkMaskLen", $self->{'m_mask_len'});
	}
	if ($withClean || $self->{'n_default_route'}) {
		Saklient::Util::set_by_path($ret, "DefaultRoute", $self->{'m_default_route'});
	}
	if ($withClean || $self->{'n_next_hop'}) {
		Saklient::Util::set_by_path($ret, "NextHop", $self->{'m_next_hop'});
	}
	return $ret;
}

1;

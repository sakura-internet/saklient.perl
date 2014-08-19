#!/usr/bin/perl

package Saklient::Cloud::Resource::Ipv6Net;

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

=head1 Saklient::Cloud::Resource::Ipv6Net

IPv6ネットワークの実体1つに対応し、属性の取得や操作を行うためのクラス。

=cut


my $m_id;

my $m_prefix;

my $m_prefix_len;

my $m_prefix_tail;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/ipv6net";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "IPv6Net";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "IPv6Nets";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Ipv6Net";
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv6Net#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

my $n_prefix = 0;

sub get_prefix {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix'};
}

=head2 prefix

ネットワークプレフィックス

=cut
sub prefix {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv6Net#prefix");
		throw $ex;
	}
	return $_[0]->get_prefix();
}

my $n_prefix_len = 0;

sub get_prefix_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix_len'};
}

=head2 prefix_len

ネットワークプレフィックス長

=cut
sub prefix_len {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv6Net#prefix_len");
		throw $ex;
	}
	return $_[0]->get_prefix_len();
}

my $n_prefix_tail = 0;

sub get_prefix_tail {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix_tail'};
}

=head2 prefix_tail

このネットワーク範囲における最後のIPv6アドレス

=cut
sub prefix_tail {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Ipv6Net#prefix_tail");
		throw $ex;
	}
	return $_[0]->get_prefix_tail();
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
	if (Saklient::Util::exists_path($r, "IPv6Prefix")) {
		$self->{'m_prefix'} = !defined(Saklient::Util::get_by_path($r, "IPv6Prefix")) ? undef : "" . Saklient::Util::get_by_path($r, "IPv6Prefix");
	}
	else {
		$self->{'m_prefix'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix'} = 0;
	if (Saklient::Util::exists_path($r, "IPv6PrefixLen")) {
		$self->{'m_prefix_len'} = !defined(Saklient::Util::get_by_path($r, "IPv6PrefixLen")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "IPv6PrefixLen")));
	}
	else {
		$self->{'m_prefix_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_len'} = 0;
	if (Saklient::Util::exists_path($r, "IPv6PrefixTail")) {
		$self->{'m_prefix_tail'} = !defined(Saklient::Util::get_by_path($r, "IPv6PrefixTail")) ? undef : "" . Saklient::Util::get_by_path($r, "IPv6PrefixTail");
	}
	else {
		$self->{'m_prefix_tail'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_tail'} = 0;
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
	if ($withClean || $self->{'n_prefix'}) {
		Saklient::Util::set_by_path($ret, "IPv6Prefix", $self->{'m_prefix'});
	}
	if ($withClean || $self->{'n_prefix_len'}) {
		Saklient::Util::set_by_path($ret, "IPv6PrefixLen", $self->{'m_prefix_len'});
	}
	if ($withClean || $self->{'n_prefix_tail'}) {
		Saklient::Util::set_by_path($ret, "IPv6PrefixTail", $self->{'m_prefix_tail'});
	}
	return $ret;
}

1;

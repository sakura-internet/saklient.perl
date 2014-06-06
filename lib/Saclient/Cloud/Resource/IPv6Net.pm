#!/usr/bin/perl

package Saclient::Cloud::Resource::IPv6Net;

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

=head1 Saclient::Cloud::Resource::IPv6Net

IPv6ネットワークのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_ipv6_prefix;

my $m_ipv6_prefix_len;

my $m_ipv6_prefix_tail;

sub _id {
	my $self = shift;
	{
		return $self->get_id();
	}
}

sub new {
	my $class = shift;
	my $self;
	my $client = shift;
	my $r = shift;
	{
		$self = $class->SUPER::new($client);
		$self->api_deserialize($r);
	}
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	{
		return $self->{'m_id'};
	}
}

sub id {
	return $_[0]->get_id();
}

my $n_ipv6_prefix = 0;

sub get_ipv6_prefix {
	my $self = shift;
	{
		return $self->{'m_ipv6_prefix'};
	}
}

sub ipv6_prefix {
	return $_[0]->get_ipv6_prefix();
}

my $n_ipv6_prefix_len = 0;

sub get_ipv6_prefix_len {
	my $self = shift;
	{
		return $self->{'m_ipv6_prefix_len'};
	}
}

sub ipv6_prefix_len {
	return $_[0]->get_ipv6_prefix_len();
}

my $n_ipv6_prefix_tail = 0;

sub get_ipv6_prefix_tail {
	my $self = shift;
	{
		return $self->{'m_ipv6_prefix_tail'};
	}
}

sub ipv6_prefix_tail {
	return $_[0]->get_ipv6_prefix_tail();
}

=head2 api_deserialize

(This method is generated in Translator_default#buildImpl)

=cut
sub api_deserialize {
	my $self = shift;
	my $r = shift;
	{
		$self->{'is_incomplete'} = 1;
		if ((ref($r) eq 'HASH' && exists $r->{"ID"})) {
			{
				$self->{'m_id'} = !defined($r->{"ID"}) ? undef : "" . $r->{"ID"};
				$self->{'n_id'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"IPv6Prefix"})) {
			{
				$self->{'m_ipv6_prefix'} = !defined($r->{"IPv6Prefix"}) ? undef : "" . $r->{"IPv6Prefix"};
				$self->{'n_ipv6_prefix'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"IPv6PrefixLen"})) {
			{
				$self->{'m_ipv6_prefix_len'} = !defined($r->{"IPv6PrefixLen"}) ? undef : (0+("" . $r->{"IPv6PrefixLen"}));
				$self->{'n_ipv6_prefix_len'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"IPv6PrefixTail"})) {
			{
				$self->{'m_ipv6_prefix_tail'} = !defined($r->{"IPv6PrefixTail"}) ? undef : "" . $r->{"IPv6PrefixTail"};
				$self->{'n_ipv6_prefix_tail'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
	}
}

=head2 api_serialize

(This method is generated in Translator_default#buildImpl)

=cut
sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	{
		my $ret = {};
		if ($withClean || $self->{'n_id'}) {
			{
				$ret->{"ID"} = $self->{'m_id'};
			};
		};
		if ($withClean || $self->{'n_ipv6_prefix'}) {
			{
				$ret->{"IPv6Prefix"} = $self->{'m_ipv6_prefix'};
			};
		};
		if ($withClean || $self->{'n_ipv6_prefix_len'}) {
			{
				$ret->{"IPv6PrefixLen"} = $self->{'m_ipv6_prefix_len'};
			};
		};
		if ($withClean || $self->{'n_ipv6_prefix_tail'}) {
			{
				$ret->{"IPv6PrefixTail"} = $self->{'m_ipv6_prefix_tail'};
			};
		};
		return $ret;
	}
}

1;

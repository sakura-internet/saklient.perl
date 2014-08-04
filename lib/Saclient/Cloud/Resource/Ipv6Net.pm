#!/usr/bin/perl

package Saclient::Cloud::Resource::Ipv6Net;

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

=head1 Saclient::Cloud::Resource::Ipv6Net

IPv6ネットワークのリソース情報へのアクセス機能や操作機能を備えたクラス。

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

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 reload : Saclient::Cloud::Resource::Swytch

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
	my $r = shift;
	$self = $class->SUPER::new($client);
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($client, "Saclient::Cloud::Client");
	$self->api_deserialize($r);
	return $self;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

sub id {
	return $_[0]->get_id();
}

my $n_prefix = 0;

sub get_prefix {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix'};
}

sub prefix {
	return $_[0]->get_prefix();
}

my $n_prefix_len = 0;

sub get_prefix_len {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix_len'};
}

sub prefix_len {
	return $_[0]->get_prefix_len();
}

my $n_prefix_tail = 0;

sub get_prefix_tail {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_prefix_tail'};
}

sub prefix_tail {
	return $_[0]->get_prefix_tail();
}

sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
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
	if (Saclient::Util::exists_path($r, "IPv6Prefix")) {
		$self->{'m_prefix'} = !defined(Saclient::Util::get_by_path($r, "IPv6Prefix")) ? undef : "" . Saclient::Util::get_by_path($r, "IPv6Prefix");
	}
	else {
		$self->{'m_prefix'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix'} = 0;
	if (Saclient::Util::exists_path($r, "IPv6PrefixLen")) {
		$self->{'m_prefix_len'} = !defined(Saclient::Util::get_by_path($r, "IPv6PrefixLen")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "IPv6PrefixLen")));
	}
	else {
		$self->{'m_prefix_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_len'} = 0;
	if (Saclient::Util::exists_path($r, "IPv6PrefixTail")) {
		$self->{'m_prefix_tail'} = !defined(Saclient::Util::get_by_path($r, "IPv6PrefixTail")) ? undef : "" . Saclient::Util::get_by_path($r, "IPv6PrefixTail");
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
	Saclient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_prefix'}) {
		Saclient::Util::set_by_path($ret, "IPv6Prefix", $self->{'m_prefix'});
	}
	if ($withClean || $self->{'n_prefix_len'}) {
		Saclient::Util::set_by_path($ret, "IPv6PrefixLen", $self->{'m_prefix_len'});
	}
	if ($withClean || $self->{'n_prefix_tail'}) {
		Saclient::Util::set_by_path($ret, "IPv6PrefixTail", $self->{'m_prefix_tail'});
	}
	return $ret;
}

1;

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
	return "/ipv6net";
}

sub _root_key {
	my $self = shift;
	return "IPv6Net";
}

sub _root_key_m {
	my $self = shift;
	return "IPv6Nets";
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

my $n_prefix = 0;

sub get_prefix {
	my $self = shift;
	return $self->{'m_prefix'};
}

sub prefix {
	return $_[0]->get_prefix();
}

my $n_prefix_len = 0;

sub get_prefix_len {
	my $self = shift;
	return $self->{'m_prefix_len'};
}

sub prefix_len {
	return $_[0]->get_prefix_len();
}

my $n_prefix_tail = 0;

sub get_prefix_tail {
	my $self = shift;
	return $self->{'m_prefix_tail'};
}

sub prefix_tail {
	return $_[0]->get_prefix_tail();
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
	if (Saclient::Cloud::Util::exists_path($r, "IPv6Prefix")) {
		$self->{'m_prefix'} = !defined(Saclient::Cloud::Util::get_by_path($r, "IPv6Prefix")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "IPv6Prefix");
	}
	else {
		$self->{'m_prefix'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "IPv6PrefixLen")) {
		$self->{'m_prefix_len'} = !defined(Saclient::Cloud::Util::get_by_path($r, "IPv6PrefixLen")) ? undef : (0+("" . Saclient::Cloud::Util::get_by_path($r, "IPv6PrefixLen")));
	}
	else {
		$self->{'m_prefix_len'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_len'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "IPv6PrefixTail")) {
		$self->{'m_prefix_tail'} = !defined(Saclient::Cloud::Util::get_by_path($r, "IPv6PrefixTail")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "IPv6PrefixTail");
	}
	else {
		$self->{'m_prefix_tail'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_prefix_tail'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Cloud::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_prefix'}) {
		Saclient::Cloud::Util::set_by_path($ret, "IPv6Prefix", $self->{'m_prefix'});
	}
	if ($withClean || $self->{'n_prefix_len'}) {
		Saclient::Cloud::Util::set_by_path($ret, "IPv6PrefixLen", $self->{'m_prefix_len'});
	}
	if ($withClean || $self->{'n_prefix_tail'}) {
		Saclient::Cloud::Util::set_by_path($ret, "IPv6PrefixTail", $self->{'m_prefix_tail'});
	}
	return $ret;
}

1;

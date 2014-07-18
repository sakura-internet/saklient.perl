#!/usr/bin/perl

package Saclient::Cloud::Resource::ServerInstance;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Util;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Enums::EServerInstanceStatus;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::ServerInstance

サーバインスタンスのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_status;

my $m_before_status;

my $m_status_changed_at;

sub new {
	my $class = shift;
	my $self;
	my $client = shift;
	my $r = shift;
	$self = $class->SUPER::new($client);
	$self->api_deserialize($r);
	return $self;
}

=head2 is_up : bool

サーバが起動しているときtrueを返します。

=cut
sub is_up {
	my $self = shift;
	return defined($self->get_status()) && Saclient::Cloud::Enums::EServerInstanceStatus::compare($self->get_status(), Saclient::Cloud::Enums::EServerInstanceStatus::up) == 0;
}

=head2 is_down : bool

サーバが停止しているときtrueを返します。

=cut
sub is_down {
	my $self = shift;
	return !defined($self->get_status()) || Saclient::Cloud::Enums::EServerInstanceStatus::compare($self->get_status(), Saclient::Cloud::Enums::EServerInstanceStatus::down) == 0;
}

my $n_status = 0;

sub get_status {
	my $self = shift;
	return $self->{'m_status'};
}

sub status {
	return $_[0]->get_status();
}

my $n_before_status = 0;

sub get_before_status {
	my $self = shift;
	return $self->{'m_before_status'};
}

sub before_status {
	return $_[0]->get_before_status();
}

my $n_status_changed_at = 0;

sub get_status_changed_at {
	my $self = shift;
	return $self->{'m_status_changed_at'};
}

sub status_changed_at {
	return $_[0]->get_status_changed_at();
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Status")) {
		$self->{'m_status'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Status")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Status");
	}
	else {
		$self->{'m_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "BeforeStatus")) {
		$self->{'m_before_status'} = !defined(Saclient::Cloud::Util::get_by_path($r, "BeforeStatus")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "BeforeStatus");
	}
	else {
		$self->{'m_before_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_before_status'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "StatusChangedAt")) {
		$self->{'m_status_changed_at'} = !defined(Saclient::Cloud::Util::get_by_path($r, "StatusChangedAt")) ? undef : Saclient::Cloud::Util::str2date("" . Saclient::Cloud::Util::get_by_path($r, "StatusChangedAt"));
	}
	else {
		$self->{'m_status_changed_at'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status_changed_at'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_status'}) {
		$ret->{"Status"} = $self->{'m_status'};
	}
	if ($withClean || $self->{'n_before_status'}) {
		$ret->{"BeforeStatus"} = $self->{'m_before_status'};
	}
	if ($withClean || $self->{'n_status_changed_at'}) {
		$ret->{"StatusChangedAt"} = !defined($self->{'m_status_changed_at'}) ? undef : Saclient::Cloud::Util::date2str($self->{'m_status_changed_at'});
	}
	return $ret;
}

1;

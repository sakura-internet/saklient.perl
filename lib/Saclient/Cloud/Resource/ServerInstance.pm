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

=head2 api_deserialize($r)

(This method is generated in Translator_default#buildImpl)

=cut
sub api_deserialize {
	my $self = shift;
	my $r = shift;
	$self->{'is_incomplete'} = 1;
	if ((ref($r) eq 'HASH' && exists $r->{"Status"})) {
		$self->{'m_status'} = !defined($r->{"Status"}) ? undef : "" . $r->{"Status"};
		$self->{'n_status'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"BeforeStatus"})) {
		$self->{'m_before_status'} = !defined($r->{"BeforeStatus"}) ? undef : "" . $r->{"BeforeStatus"};
		$self->{'n_before_status'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"StatusChangedAt"})) {
		$self->{'m_status_changed_at'} = !defined($r->{"StatusChangedAt"}) ? undef : Saclient::Cloud::Util->str2date("" . $r->{"StatusChangedAt"});
		$self->{'n_status_changed_at'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
}

=head2 api_serialize(bool $withClean=0) : any

(This method is generated in Translator_default#buildImpl)

=cut
sub api_serialize {
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
		$ret->{"StatusChangedAt"} = !defined($self->{'m_status_changed_at'}) ? undef : Saclient::Cloud::Util->date2str($self->{'m_status_changed_at'});
	}
	return $ret;
}

1;

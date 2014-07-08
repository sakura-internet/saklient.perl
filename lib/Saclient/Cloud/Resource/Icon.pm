#!/usr/bin/perl

package Saclient::Cloud::Resource::Icon;

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

=head1 Saclient::Cloud::Resource::Icon

アイコンのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_url;

sub _api_path {
	my $self = shift;
	return "/icon";
}

sub _root_key {
	my $self = shift;
	return "Icon";
}

sub _root_key_m {
	my $self = shift;
	return "Icons";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Icon

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Icon

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

my $n_name = 0;

sub get_name {
	my $self = shift;
	return $self->{'m_name'};
}

sub name {
	return $_[0]->get_name();
}

my $n_url = 0;

sub get_url {
	my $self = shift;
	return $self->{'m_url'};
}

sub url {
	return $_[0]->get_url();
}

=head2 api_deserialize($r)

(This method is generated in Translator_default#buildImpl)

=cut
sub api_deserialize {
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
	if ((ref($r) eq 'HASH' && exists $r->{"Name"})) {
		$self->{'m_name'} = !defined($r->{"Name"}) ? undef : "" . $r->{"Name"};
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"URL"})) {
		$self->{'m_url'} = !defined($r->{"URL"}) ? undef : "" . $r->{"URL"};
	}
	else {
		$self->{'m_url'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_url'} = 0;
}

=head2 api_serialize(bool $withClean=0) : any

(This method is generated in Translator_default#buildImpl)

=cut
sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_name'}) {
		$ret->{"Name"} = $self->{'m_name'};
	}
	if ($withClean || $self->{'n_url'}) {
		$ret->{"URL"} = $self->{'m_url'};
	}
	return $ret;
}

1;

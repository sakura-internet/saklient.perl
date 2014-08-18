#!/usr/bin/perl

package Saclient::Cloud::Resource::Icon;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Errors::SaclientException;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Icon

アイコンのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_scope;

my $m_name;

my $m_url;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/icon";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Icon";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Icons";
}

sub class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Icon";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Icon

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Icon

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
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($client, "Saclient::Cloud::Client");
	Saclient::Util::validate_type($wrapped, "bool");
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Icon#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

my $n_scope = 0;

sub get_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_scope'};
}

=head2 scope

スコープ

=cut
sub scope {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Icon#scope");
		throw $ex;
	}
	return $_[0]->get_scope();
}

my $n_name = 0;

sub get_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_name'};
}

sub set_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	$self->{'m_name'} = $v;
	$self->{'n_name'} = 1;
	return $self->{'m_name'};
}

=head2 name

名前

=cut
sub name {
	if (1 < scalar(@_)) {
		$_[0]->set_name($_[1]);
		return $_[0];
	}
	return $_[0]->get_name();
}

my $n_url = 0;

sub get_url {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_url'};
}

=head2 url

URL

=cut
sub url {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Icon#url");
		throw $ex;
	}
	return $_[0]->get_url();
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
	if (Saclient::Util::exists_path($r, "Scope")) {
		$self->{'m_scope'} = !defined(Saclient::Util::get_by_path($r, "Scope")) ? undef : "" . Saclient::Util::get_by_path($r, "Scope");
	}
	else {
		$self->{'m_scope'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_scope'} = 0;
	if (Saclient::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saclient::Util::get_by_path($r, "Name")) ? undef : "" . Saclient::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saclient::Util::exists_path($r, "URL")) {
		$self->{'m_url'} = !defined(Saclient::Util::get_by_path($r, "URL")) ? undef : "" . Saclient::Util::get_by_path($r, "URL");
	}
	else {
		$self->{'m_url'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_url'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saclient::Util::validate_type($withClean, "bool");
	my $missing = [];
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saclient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_scope'}) {
		Saclient::Util::set_by_path($ret, "Scope", $self->{'m_scope'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saclient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "name");
		}
	}
	if ($withClean || $self->{'n_url'}) {
		Saclient::Util::set_by_path($ret, "URL", $self->{'m_url'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saclient::Errors::SaclientException("required_field", "Required fields must be set before the Icon creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

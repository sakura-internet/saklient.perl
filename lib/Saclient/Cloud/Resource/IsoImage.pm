#!/usr/bin/perl

package Saclient::Cloud::Resource::IsoImage;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Enums::EScope;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::IsoImage

ISOイメージのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_scope;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_size_mib;

my $m_service_class;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/cdrom";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CDROM";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "CDROMs";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::IsoImage

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::IsoImage

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

sub get_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_size_mib() >> 10;
}

=head2 size_gib

サイズ[GiB]

=cut
sub size_gib {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::IsoImage#size_gib");
		throw $ex;
	}
	return $_[0]->get_size_gib();
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::IsoImage#id");
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

sub set_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	$self->{'m_scope'} = $v;
	$self->{'n_scope'} = 1;
	return $self->{'m_scope'};
}

=head2 scope

スコープ

=cut
sub scope {
	if (1 < scalar(@_)) {
		$_[0]->set_scope($_[1]);
		return $_[0];
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

my $n_description = 0;

sub get_description {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_description'};
}

sub set_description {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "string");
	$self->{'m_description'} = $v;
	$self->{'n_description'} = 1;
	return $self->{'m_description'};
}

=head2 description

説明

=cut
sub description {
	if (1 < scalar(@_)) {
		$_[0]->set_description($_[1]);
		return $_[0];
	}
	return $_[0]->get_description();
}

my $n_tags = 0;

sub get_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_tags'};
}

sub set_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "ARRAY");
	$self->{'m_tags'} = $v;
	$self->{'n_tags'} = 1;
	return $self->{'m_tags'};
}

=head2 tags

タグ

=cut
sub tags {
	if (1 < scalar(@_)) {
		$_[0]->set_tags($_[1]);
		return $_[0];
	}
	return $_[0]->get_tags();
}

my $n_icon = 0;

sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_icon'};
}

sub set_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "Saclient::Cloud::Resource::Icon");
	$self->{'m_icon'} = $v;
	$self->{'n_icon'} = 1;
	return $self->{'m_icon'};
}

=head2 icon

アイコン

=cut
sub icon {
	if (1 < scalar(@_)) {
		$_[0]->set_icon($_[1]);
		return $_[0];
	}
	return $_[0]->get_icon();
}

my $n_size_mib = 0;

sub get_size_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_size_mib'};
}

=head2 size_mib

サイズ[MiB]

=cut
sub size_mib {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::IsoImage#size_mib");
		throw $ex;
	}
	return $_[0]->get_size_mib();
}

my $n_service_class = 0;

sub get_service_class {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_service_class'};
}

=head2 service_class

サービスクラス

=cut
sub service_class {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::IsoImage#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
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
	if (Saclient::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saclient::Util::get_by_path($r, "Description")) ? undef : "" . Saclient::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saclient::Util::exists_path($r, "Tags")) {
		if (!defined(Saclient::Util::get_by_path($r, "Tags"))) {
			$self->{'m_tags'} = [];
		}
		else {
			$self->{'m_tags'} = [];
			foreach my $t (@{Saclient::Util::get_by_path($r, "Tags")}) {
				my $v1 = undef;
				$v1 = !defined($t) ? undef : "" . $t;
				push(@{$self->{'m_tags'}}, $v1);
			}
		}
	}
	else {
		$self->{'m_tags'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_tags'} = 0;
	if (Saclient::Util::exists_path($r, "Icon")) {
		$self->{'m_icon'} = !defined(Saclient::Util::get_by_path($r, "Icon")) ? undef : new Saclient::Cloud::Resource::Icon($self->{'_client'}, Saclient::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if (Saclient::Util::exists_path($r, "SizeMB")) {
		$self->{'m_size_mib'} = !defined(Saclient::Util::get_by_path($r, "SizeMB")) ? undef : (0+("" . Saclient::Util::get_by_path($r, "SizeMB")));
	}
	else {
		$self->{'m_size_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_size_mib'} = 0;
	if (Saclient::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saclient::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saclient::Util::get_by_path($r, "ServiceClass");
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
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
	if ($withClean || $self->{'n_scope'}) {
		Saclient::Util::set_by_path($ret, "Scope", $self->{'m_scope'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saclient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	if ($withClean || $self->{'n_description'}) {
		Saclient::Util::set_by_path($ret, "Description", $self->{'m_description'});
	}
	if ($withClean || $self->{'n_tags'}) {
		Saclient::Util::set_by_path($ret, "Tags", []);
		foreach my $r1 (@{$self->{'m_tags'}}) {
			my $v = undef;
			$v = $r1;
			push(@{$ret->{"Tags"}}, $v);
		}
	}
	if ($withClean || $self->{'n_icon'}) {
		Saclient::Util::set_by_path($ret, "Icon", $withClean ? (!defined($self->{'m_icon'}) ? undef : $self->{'m_icon'}->api_serialize($withClean)) : (!defined($self->{'m_icon'}) ? {'ID' => "0"} : $self->{'m_icon'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_size_mib'}) {
		Saclient::Util::set_by_path($ret, "SizeMB", $self->{'m_size_mib'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saclient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	return $ret;
}

1;

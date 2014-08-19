#!/usr/bin/perl

package Saklient::Cloud::Resource::ServerInstance;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::IsoImage;
use Saklient::Cloud::Enums::EServerInstanceStatus;

use base qw(Saklient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::ServerInstance

サーバインスタンスの実体1つに対応し、属性の取得や操作を行うためのクラス。

=cut


my $m_status;

my $m_before_status;

my $m_status_changed_at;

my $m_iso_image;

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

=head2 is_up : bool

サーバが起動しているときtrueを返します。

=cut
sub is_up {
	my $self = shift;
	my $_argnum = scalar @_;
	return defined($self->get_status()) && Saklient::Cloud::Enums::EServerInstanceStatus::compare($self->get_status(), Saklient::Cloud::Enums::EServerInstanceStatus::up) == 0;
}

=head2 is_down : bool

サーバが停止しているときtrueを返します。

=cut
sub is_down {
	my $self = shift;
	my $_argnum = scalar @_;
	return !defined($self->get_status()) || Saklient::Cloud::Enums::EServerInstanceStatus::compare($self->get_status(), Saklient::Cloud::Enums::EServerInstanceStatus::down) == 0;
}

my $n_status = 0;

sub get_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_status'};
}

=head2 status

起動状態 {@link EServerInstanceStatus}

=cut
sub status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#status");
		throw $ex;
	}
	return $_[0]->get_status();
}

my $n_before_status = 0;

sub get_before_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_before_status'};
}

=head2 before_status

前回の起動状態 {@link EServerInstanceStatus}

=cut
sub before_status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#before_status");
		throw $ex;
	}
	return $_[0]->get_before_status();
}

my $n_status_changed_at = 0;

sub get_status_changed_at {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_status_changed_at'};
}

=head2 status_changed_at

現在の起動状態に変化した日時

=cut
sub status_changed_at {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#status_changed_at");
		throw $ex;
	}
	return $_[0]->get_status_changed_at();
}

my $n_iso_image = 0;

sub get_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_iso_image'};
}

=head2 iso_image

挿入されているISOイメージ

=cut
sub iso_image {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#iso_image");
		throw $ex;
	}
	return $_[0]->get_iso_image();
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
	if (Saklient::Util::exists_path($r, "Status")) {
		$self->{'m_status'} = !defined(Saklient::Util::get_by_path($r, "Status")) ? undef : "" . Saklient::Util::get_by_path($r, "Status");
	}
	else {
		$self->{'m_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status'} = 0;
	if (Saklient::Util::exists_path($r, "BeforeStatus")) {
		$self->{'m_before_status'} = !defined(Saklient::Util::get_by_path($r, "BeforeStatus")) ? undef : "" . Saklient::Util::get_by_path($r, "BeforeStatus");
	}
	else {
		$self->{'m_before_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_before_status'} = 0;
	if (Saklient::Util::exists_path($r, "StatusChangedAt")) {
		$self->{'m_status_changed_at'} = !defined(Saklient::Util::get_by_path($r, "StatusChangedAt")) ? undef : Saklient::Util::str2date("" . Saklient::Util::get_by_path($r, "StatusChangedAt"));
	}
	else {
		$self->{'m_status_changed_at'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status_changed_at'} = 0;
	if (Saklient::Util::exists_path($r, "CDROM")) {
		$self->{'m_iso_image'} = !defined(Saklient::Util::get_by_path($r, "CDROM")) ? undef : new Saklient::Cloud::Resource::IsoImage($self->{'_client'}, Saklient::Util::get_by_path($r, "CDROM"));
	}
	else {
		$self->{'m_iso_image'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_iso_image'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_status'}) {
		Saklient::Util::set_by_path($ret, "Status", $self->{'m_status'});
	}
	if ($withClean || $self->{'n_before_status'}) {
		Saklient::Util::set_by_path($ret, "BeforeStatus", $self->{'m_before_status'});
	}
	if ($withClean || $self->{'n_status_changed_at'}) {
		Saklient::Util::set_by_path($ret, "StatusChangedAt", !defined($self->{'m_status_changed_at'}) ? undef : Saklient::Util::date2str($self->{'m_status_changed_at'}));
	}
	if ($withClean || $self->{'n_iso_image'}) {
		Saklient::Util::set_by_path($ret, "CDROM", $withClean ? (!defined($self->{'m_iso_image'}) ? undef : $self->{'m_iso_image'}->api_serialize($withClean)) : (!defined($self->{'m_iso_image'}) ? {'ID' => "0"} : $self->{'m_iso_image'}->api_serialize_id()));
	}
	return $ret;
}

1;

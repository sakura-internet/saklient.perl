#!/usr/bin/perl

package Saclient::Cloud::Resource::Archive;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::FtpInfo;
use Saclient::Cloud::Resource::DiskPlan;
use Saclient::Cloud::Resource::Server;
use Saclient::Cloud::Resource::Archive;
use Saclient::Cloud::Resource::Disk;
use Saclient::Cloud::Enums::EScope;
use Saclient::Cloud::Enums::EAvailability;
use Saclient::Errors::SaclientException;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Archive

アーカイブのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_scope;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_size_mib;

my $m_service_class;

my $m_plan;

my $m_availability;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/archive";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archive";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archives";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Archive

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Archive

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

sub get_is_available {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_availability() eq Saclient::Cloud::Enums::EAvailability::available;
}

=head2 is_available

ディスクが利用可能なときtrueを返します。

=cut
sub is_available {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

sub get_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_size_mib() >> 10;
}

sub set_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $sizeGib = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($sizeGib, "int");
	$self->set_size_mib($sizeGib * 1024);
	return $sizeGib;
}

=head2 size_gib

サイズ[GiB]

=cut
sub size_gib {
	if (1 < scalar(@_)) {
		$_[0]->set_size_gib($_[1]);
		return $_[0];
	}
	return $_[0]->get_size_gib();
}

my $_source;

sub get_source {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_source'};
}

sub set_source {
	my $self = shift;
	my $_argnum = scalar @_;
	my $source = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	$self->{'_source'} = $source;
	return $source;
}

=head2 source

アーカイブのコピー元

=cut
sub source {
	if (1 < scalar(@_)) {
		$_[0]->set_source($_[1]);
		return $_[0];
	}
	return $_[0]->get_source();
}

my $_ftp_info;

sub get_ftp_info {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ftp_info'};
}

=head2 ftp_info

FTP情報

=cut
sub ftp_info {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#ftp_info");
		throw $ex;
	}
	return $_[0]->get_ftp_info();
}

sub _on_after_api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $root = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	if (defined($root)) {
		if ((ref($root) eq 'HASH' && exists $root->{"FTPServer"})) {
			my $ftp = $root->{"FTPServer"};
			if (defined($ftp)) {
				$self->{'_ftp_info'} = new Saclient::Cloud::Resource::FtpInfo($ftp);
			}
		}
	}
	if (defined($r)) {
		if ((ref($r) eq 'HASH' && exists $r->{"SourceArchive"})) {
			my $s = $r->{"SourceArchive"};
			if (defined($s)) {
				my $id = $s->{"ID"};
				if (defined($id)) {
					$self->{'_source'} = new Saclient::Cloud::Resource::Archive($self->{'_client'}, $s);
				}
			}
		}
		if ((ref($r) eq 'HASH' && exists $r->{"SourceDisk"})) {
			my $s = $r->{"SourceDisk"};
			if (defined($s)) {
				my $id = $s->{"ID"};
				if (defined($id)) {
					$self->{'_source'} = new Saclient::Cloud::Resource::Disk($self->{'_client'}, $s);
				}
			}
		}
	}
}

sub _on_after_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $withClean = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($withClean, "bool");
	if (!defined($r)) {
		return;
	}
	if (defined($self->{'_source'})) {
		if ($self->{'_source'}->isa("Saclient::Cloud::Resource::Archive")) {
			my $archive = $self->{'_source'};
			my $s = $withClean ? $archive->api_serialize(1) : {'ID' => $archive->_id()};
			$r->{"SourceArchive"} = $s;
		}
		else {
			if ($self->{'_source'}->isa("Saclient::Cloud::Resource::Disk")) {
				my $disk = $self->{'_source'};
				my $s = $withClean ? $disk->api_serialize(1) : {'ID' => $disk->_id()};
				$r->{"SourceDisk"} = $s;
			}
			else {
				$self->{'_source'} = undef;
				Saclient::Util::validate_type($self->{'_source'}, "Disk or Archive", 1);
			}
		}
	}
}

sub open_ftp {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reset = shift || (0);
	Saclient::Util::validate_type($reset, "bool");
	my $path = $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/ftp";
	my $q = {};
	Saclient::Util::set_by_path($q, "ChangePassword", $reset);
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->_on_after_api_deserialize(undef, $result);
	return $self;
}

sub close_ftp {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reset = shift || (0);
	Saclient::Util::validate_type($reset, "bool");
	my $path = $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()) . "/ftp";
	my $result = $self->{'_client'}->request("DELETE", $path);
	$self->{'_ftp_info'} = undef;
	return $self;
}

=head2 after_copy(int $timeoutSec, (Saclient::Cloud::Resource::Archive, bool) => void $callback) : void

コピー中のアーカイブが利用可能になるまで待機します。

=cut
sub after_copy {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($timeoutSec, "int");
	Saclient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_while_copying($timeoutSec);
	$callback->($self, $ret);
}

=head2 sleep_while_copying(int $timeoutSec=3600) : bool

コピー中のアーカイブが利用可能になるまで待機します。

=cut
sub sleep_while_copying {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (3600);
	Saclient::Util::validate_type($timeoutSec, "int");
	my $step = 3;
	while (0 < $timeoutSec) {
		$self->reload();
		my $a = $self->get_availability();
		if ($a eq Saclient::Cloud::Enums::EAvailability::available) {
			return 1;
		}
		if ($a ne Saclient::Cloud::Enums::EAvailability::migrating) {
			$timeoutSec = 0;
		}
		$timeoutSec -= $step;
		if (0 < $timeoutSec) {
			sleep $step;
		}
	}
	return 0;
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#id");
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#scope");
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

sub set_size_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saclient::Errors::SaclientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saclient::Cloud::Resource::Archive#size_mib"); throw $ex; };
	}
	$self->{'m_size_mib'} = $v;
	$self->{'n_size_mib'} = 1;
	return $self->{'m_size_mib'};
}

=head2 size_mib

サイズ[MiB]

=cut
sub size_mib {
	if (1 < scalar(@_)) {
		$_[0]->set_size_mib($_[1]);
		return $_[0];
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
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
}

my $n_plan = 0;

sub get_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_plan'};
}

=head2 plan

プラン

=cut
sub plan {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#plan");
		throw $ex;
	}
	return $_[0]->get_plan();
}

my $n_availability = 0;

sub get_availability {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_availability'};
}

=head2 availability

有効状態

=cut
sub availability {
	if (1 < scalar(@_)) {
		my $ex = new Saclient::Errors::SaclientException('non_writable_field', "Non-writable field: Saclient::Cloud::Resource::Archive#availability");
		throw $ex;
	}
	return $_[0]->get_availability();
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
	if (Saclient::Util::exists_path($r, "Plan")) {
		$self->{'m_plan'} = !defined(Saclient::Util::get_by_path($r, "Plan")) ? undef : new Saclient::Cloud::Resource::DiskPlan($self->{'_client'}, Saclient::Util::get_by_path($r, "Plan"));
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
	if (Saclient::Util::exists_path($r, "Availability")) {
		$self->{'m_availability'} = !defined(Saclient::Util::get_by_path($r, "Availability")) ? undef : "" . Saclient::Util::get_by_path($r, "Availability");
	}
	else {
		$self->{'m_availability'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_availability'} = 0;
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
	if ($withClean || $self->{'n_plan'}) {
		Saclient::Util::set_by_path($ret, "Plan", $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_availability'}) {
		Saclient::Util::set_by_path($ret, "Availability", $self->{'m_availability'});
	}
	return $ret;
}

1;

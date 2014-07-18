#!/usr/bin/perl

package Saclient::Cloud::Resource::Disk;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::DiskPlan;
use Saclient::Cloud::Resource::Server;
use Saclient::Cloud::Resource::Archive;
use Saclient::Cloud::Enums::EAvailability;
use Saclient::Cloud::Enums::EDiskConnection;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Disk

ディスクのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_size_mib;

my $m_service_class;

my $m_plan;

my $m_server;

my $m_availability;

sub _api_path {
	my $self = shift;
	return "/disk";
}

sub _root_key {
	my $self = shift;
	return "Disk";
}

sub _root_key_m {
	my $self = shift;
	return "Disks";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Disk

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Disk

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

sub get_is_available {
	my $self = shift;
	return $self->get_availability() eq Saclient::Cloud::Enums::EAvailability::available;
}

=head2 is_available

ディスクが利用可能なときtrueを返します。

=cut
sub is_available {
	return $_[0]->get_is_available();
}

sub get_size_gib {
	my $self = shift;
	return $self->get_size_mib() >> 10;
}

sub set_size_gib {
	my $self = shift;
	my $sizeGib = shift;
	$self->set_size_mib($sizeGib * 1024);
	return $sizeGib;
}

=head2 size_gib

サイズ[GiB]

=cut
sub size_gib {
	if (1 < scalar(@_)) { $_[0]->set_size_gib($_[1]); return $_[0]; }
	return $_[0]->get_size_gib();
}

my $_source;

sub get_source {
	my $self = shift;
	return $self->{'_source'};
}

sub set_source {
	my $self = shift;
	my $source = shift;
	$self->{'_source'} = $source;
	return $source;
}

=head2 source

ディスクのコピー元

=cut
sub source {
	if (1 < scalar(@_)) { $_[0]->set_source($_[1]); return $_[0]; }
	return $_[0]->get_source();
}

sub _on_after_api_deserialize {
	my $self = shift;
	my $r = shift;
	if (!defined($r)) {
		return;
	}
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

sub _on_after_api_serialize {
	my $self = shift;
	my $r = shift;
	my $withClean = shift;
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
				$r->{"SourceArchive"} = {'ID' => 1};
			}
		}
	}
}

=head2 connect_to(Saclient::Cloud::Resource::Server $server) : Saclient::Cloud::Resource::Disk

ディスクをサーバに取り付けます。

=cut
sub connect_to {
	my $self = shift;
	my $server = shift;
	$self->{'_client'}->request("PUT", "/disk/" . $self->_id() . "/to/server/" . $server->_id());
	return $self;
}

=head2 disconnect : Saclient::Cloud::Resource::Disk

ディスクをサーバから取り外します。

=cut
sub disconnect {
	my $self = shift;
	$self->{'_client'}->request("DELETE", "/disk/" . $self->_id() . "/to/server");
	return $self;
}

=head2 after_copy(int $timeoutSec, (Saclient::Cloud::Resource::Disk, bool) => void $callback) : void

コピー中のディスクが利用可能になるまで待機します。

=cut
sub after_copy {
	my $self = shift;
	my $timeoutSec = shift;
	my $callback = shift;
	my $ret = $self->sleep_while_copying($timeoutSec);
	$callback->($self, $ret);
}

=head2 sleep_while_copying(int $timeoutSec=3600) : bool

コピー中のディスクが利用可能になるまで待機します。

=cut
sub sleep_while_copying {
	my $self = shift;
	my $timeoutSec = shift || (3600);
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
	return $self->{'m_id'};
}

=head2 id

ID

=cut
sub id {
	return $_[0]->get_id();
}

my $n_name = 0;

sub get_name {
	my $self = shift;
	return $self->{'m_name'};
}

sub set_name {
	my $self = shift;
	my $v = shift;
	$self->{'m_name'} = $v;
	$self->{'n_name'} = 1;
	return $self->{'m_name'};
}

=head2 name

名前

=cut
sub name {
	if (1 < scalar(@_)) { $_[0]->set_name($_[1]); return $_[0]; }
	return $_[0]->get_name();
}

my $n_description = 0;

sub get_description {
	my $self = shift;
	return $self->{'m_description'};
}

sub set_description {
	my $self = shift;
	my $v = shift;
	$self->{'m_description'} = $v;
	$self->{'n_description'} = 1;
	return $self->{'m_description'};
}

=head2 description

説明

=cut
sub description {
	if (1 < scalar(@_)) { $_[0]->set_description($_[1]); return $_[0]; }
	return $_[0]->get_description();
}

my $n_tags = 0;

sub get_tags {
	my $self = shift;
	return $self->{'m_tags'};
}

sub set_tags {
	my $self = shift;
	my $v = shift;
	$self->{'m_tags'} = $v;
	$self->{'n_tags'} = 1;
	return $self->{'m_tags'};
}

=head2 tags

タグ

=cut
sub tags {
	if (1 < scalar(@_)) { $_[0]->set_tags($_[1]); return $_[0]; }
	return $_[0]->get_tags();
}

my $n_icon = 0;

sub get_icon {
	my $self = shift;
	return $self->{'m_icon'};
}

sub set_icon {
	my $self = shift;
	my $v = shift;
	$self->{'m_icon'} = $v;
	$self->{'n_icon'} = 1;
	return $self->{'m_icon'};
}

=head2 icon

アイコン

=cut
sub icon {
	if (1 < scalar(@_)) { $_[0]->set_icon($_[1]); return $_[0]; }
	return $_[0]->get_icon();
}

my $n_size_mib = 0;

sub get_size_mib {
	my $self = shift;
	return $self->{'m_size_mib'};
}

sub set_size_mib {
	my $self = shift;
	my $v = shift;
	$self->{'m_size_mib'} = $v;
	$self->{'n_size_mib'} = 1;
	return $self->{'m_size_mib'};
}

=head2 size_mib

サイズ[MiB]

=cut
sub size_mib {
	if (1 < scalar(@_)) { $_[0]->set_size_mib($_[1]); return $_[0]; }
	return $_[0]->get_size_mib();
}

my $n_service_class = 0;

sub get_service_class {
	my $self = shift;
	return $self->{'m_service_class'};
}

=head2 service_class

サービスクラス

=cut
sub service_class {
	return $_[0]->get_service_class();
}

my $n_plan = 0;

sub get_plan {
	my $self = shift;
	return $self->{'m_plan'};
}

=head2 plan

プラン

=cut
sub plan {
	return $_[0]->get_plan();
}

my $n_server = 0;

sub get_server {
	my $self = shift;
	return $self->{'m_server'};
}

=head2 server

接続先のサーバ

=cut
sub server {
	return $_[0]->get_server();
}

my $n_availability = 0;

sub get_availability {
	my $self = shift;
	return $self->{'m_availability'};
}

=head2 availability

有効状態

=cut
sub availability {
	return $_[0]->get_availability();
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
	if (Saclient::Cloud::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Name")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Description")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Tags")) {
		if (!defined(Saclient::Cloud::Util::get_by_path($r, "Tags"))) {
			$self->{'m_tags'} = [];
		}
		else {
			$self->{'m_tags'} = [];
			foreach my $t (@{Saclient::Cloud::Util::get_by_path($r, "Tags")}) {
				my $v = undef;
				$v = !defined($t) ? undef : "" . $t;
				push(@{$self->{'m_tags'}}, $v);
			}
		}
	}
	else {
		$self->{'m_tags'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_tags'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Icon")) {
		$self->{'m_icon'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Icon")) ? undef : new Saclient::Cloud::Resource::Icon($self->{'_client'}, Saclient::Cloud::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "SizeMB")) {
		$self->{'m_size_mib'} = !defined(Saclient::Cloud::Util::get_by_path($r, "SizeMB")) ? undef : (0+("" . Saclient::Cloud::Util::get_by_path($r, "SizeMB")));
	}
	else {
		$self->{'m_size_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_size_mib'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saclient::Cloud::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "ServiceClass");
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Plan")) {
		$self->{'m_plan'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Plan")) ? undef : new Saclient::Cloud::Resource::DiskPlan($self->{'_client'}, Saclient::Cloud::Util::get_by_path($r, "Plan"));
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Server")) {
		$self->{'m_server'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Server")) ? undef : new Saclient::Cloud::Resource::Server($self->{'_client'}, Saclient::Cloud::Util::get_by_path($r, "Server"));
	}
	else {
		$self->{'m_server'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_server'} = 0;
	if (Saclient::Cloud::Util::exists_path($r, "Availability")) {
		$self->{'m_availability'} = !defined(Saclient::Cloud::Util::get_by_path($r, "Availability")) ? undef : "" . Saclient::Cloud::Util::get_by_path($r, "Availability");
	}
	else {
		$self->{'m_availability'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_availability'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_name'}) {
		$ret->{"Name"} = $self->{'m_name'};
	}
	if ($withClean || $self->{'n_description'}) {
		$ret->{"Description"} = $self->{'m_description'};
	}
	if ($withClean || $self->{'n_tags'}) {
		$ret->{"Tags"} = [];
		foreach my $r (@{$self->{'m_tags'}}) {
			my $v = undef;
			$v = $r;
			push(@{$ret->{"Tags"}}, $v);
		}
	}
	if ($withClean || $self->{'n_icon'}) {
		$ret->{"Icon"} = $withClean ? (!defined($self->{'m_icon'}) ? undef : $self->{'m_icon'}->api_serialize($withClean)) : (!defined($self->{'m_icon'}) ? {'ID' => "0"} : $self->{'m_icon'}->api_serialize_id());
	}
	if ($withClean || $self->{'n_size_mib'}) {
		$ret->{"SizeMB"} = $self->{'m_size_mib'};
	}
	if ($withClean || $self->{'n_service_class'}) {
		$ret->{"ServiceClass"} = $self->{'m_service_class'};
	}
	if ($withClean || $self->{'n_plan'}) {
		$ret->{"Plan"} = $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id());
	}
	if ($withClean || $self->{'n_server'}) {
		$ret->{"Server"} = $withClean ? (!defined($self->{'m_server'}) ? undef : $self->{'m_server'}->api_serialize($withClean)) : (!defined($self->{'m_server'}) ? {'ID' => "0"} : $self->{'m_server'}->api_serialize_id());
	}
	if ($withClean || $self->{'n_availability'}) {
		$ret->{"Availability"} = $self->{'m_availability'};
	}
	return $ret;
}

1;

#!/usr/bin/perl

package Saklient::Cloud::Resource::Server;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::Icon;
use Saklient::Cloud::Resource::Disk;
use Saklient::Cloud::Resource::Iface;
use Saklient::Cloud::Resource::ServerPlan;
use Saklient::Cloud::Resource::ServerInstance;
use Saklient::Cloud::Resource::IsoImage;
use Saklient::Cloud::Enums::EServerInstanceStatus;
use Saklient::Cloud::Enums::EAvailability;

use base qw(Saklient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::Server

サーバの実体1つに対応し、属性の取得や操作を行うためのクラス。

=cut


my $m_id;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_plan;

my $m_ifaces;

my $m_instance;

my $m_availability;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/server";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Server";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Servers";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Server";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saklient::Cloud::Resource::Server

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新規作成または上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saklient::Cloud::Resource::Server

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
	return $self->get_instance()->is_up();
}

=head2 is_down : bool

サーバが停止しているときtrueを返します。

=cut
sub is_down {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_instance()->is_down();
}

=head2 boot : Saklient::Cloud::Resource::Server

サーバを起動します。

@return this

=cut
sub boot {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power");
	return $self->reload();
}

=head2 shutdown : Saklient::Cloud::Resource::Server

サーバをシャットダウンします。

@return this

=cut
sub shutdown {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power");
	return $self->reload();
}

=head2 stop : Saklient::Cloud::Resource::Server

サーバを強制停止します。

@return this

=cut
sub stop {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/power", {'Force' => 1});
	return $self->reload();
}

=head2 reboot : Saklient::Cloud::Resource::Server

サーバを強制再起動します。

@return this

=cut
sub reboot {
	my $self = shift;
	my $_argnum = scalar @_;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/reset");
	return $self->reload();
}

=head2 after_down(int $timeoutSec, (Saklient::Cloud::Resource::Server, bool) => void $callback) : void

サーバが停止するまで待機します。

@return 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。

=cut
sub after_down {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	$self->after_status(Saklient::Cloud::Enums::EServerInstanceStatus::down, $timeoutSec, $callback);
}

sub after_status {
	my $self = shift;
	my $_argnum = scalar @_;
	my $status = shift;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 3);
	Saklient::Util::validate_type($status, "string");
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_until($status, $timeoutSec);
	$callback->($self, $ret);
}

=head2 sleep_until_down(int $timeoutSec=180) : bool

サーバが停止するまで待機します。

@return 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。

=cut
sub sleep_until_down {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (180);
	Saklient::Util::validate_type($timeoutSec, "int");
	return $self->sleep_until(Saklient::Cloud::Enums::EServerInstanceStatus::down, $timeoutSec);
}

sub sleep_until {
	my $self = shift;
	my $_argnum = scalar @_;
	my $status = shift;
	my $timeoutSec = shift || (180);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($status, "string");
	Saklient::Util::validate_type($timeoutSec, "int");
	my $step = 3;
	while (0 < $timeoutSec) {
		$self->reload();
		my $s = $self->get_instance()->status;
		if (!defined($s)) {
			$s = Saklient::Cloud::Enums::EServerInstanceStatus::down;
		}
		if ($s eq $status) {
			return 1;
		}
		$timeoutSec -= $step;
		if (0 < $timeoutSec) {
			sleep $step;
		}
	}
	return 0;
}

=head2 change_plan(Saklient::Cloud::Resource::ServerPlan $planTo) : Saklient::Cloud::Resource::Server

サーバプランを変更します。

成功時はリソースIDが変わることにご注意ください。

@return this

=cut
sub change_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $planTo = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($planTo, "Saklient::Cloud::Resource::ServerPlan");
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/to/plan/" . Saklient::Util::url_encode($planTo->_id());
	my $result = $self->{'_client'}->request("PUT", $path);
	$self->api_deserialize($result, 1);
	return $self;
}

=head2 find_disks : Saklient::Cloud::Resource::Disk[]

サーバに接続されているディスクのリストを取得します。

=cut
sub find_disks {
	my $self = shift;
	my $_argnum = scalar @_;
	my $model = Saklient::Util::create_class_instance("saklient.cloud.model.Model_Disk", [$self->{'_client'}]);
	return $model->with_server_id($self->_id())->find();
}

=head2 add_iface : Saklient::Cloud::Resource::Iface

サーバにインタフェースを1つ増設し、それを取得します。

@return 増設されたインタフェース

=cut
sub add_iface {
	my $self = shift;
	my $_argnum = scalar @_;
	my $model = Saklient::Util::create_class_instance("saklient.cloud.model.Model_Iface", [$self->{'_client'}]);
	my $res = $model->create();
	$res->set_property("serverId", $self->_id());
	return $res->save();
}

=head2 insert_iso_image(Saklient::Cloud::Resource::IsoImage $iso) : Saklient::Cloud::Resource::Server

サーバにISOイメージを挿入します。

@return this

=cut
sub insert_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	my $iso = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($iso, "Saklient::Cloud::Resource::IsoImage");
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/cdrom";
	my $q = {'CDROM' => {'ID' => $iso->_id()}};
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->reload();
	return $self;
}

=head2 eject_iso_image : Saklient::Cloud::Resource::Server

サーバに挿入されているISOイメージを排出します。

@return this

=cut
sub eject_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/cdrom";
	my $result = $self->{'_client'}->request("DELETE", $path);
	$self->reload();
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Server#id");
		throw $ex;
	}
	return $_[0]->get_id();
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
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
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
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
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
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "ARRAY");
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
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resource::Icon");
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

my $n_plan = 0;

sub get_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_plan'};
}

sub set_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resource::ServerPlan");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resource::Server#plan"); throw $ex; };
	}
	$self->{'m_plan'} = $v;
	$self->{'n_plan'} = 1;
	return $self->{'m_plan'};
}

=head2 plan

プラン

=cut
sub plan {
	if (1 < scalar(@_)) {
		$_[0]->set_plan($_[1]);
		return $_[0];
	}
	return $_[0]->get_plan();
}

my $n_ifaces = 0;

sub get_ifaces {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_ifaces'};
}

=head2 ifaces

インタフェース

=cut
sub ifaces {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Server#ifaces");
		throw $ex;
	}
	return $_[0]->get_ifaces();
}

my $n_instance = 0;

sub get_instance {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_instance'};
}

=head2 instance

インスタンス情報

=cut
sub instance {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Server#instance");
		throw $ex;
	}
	return $_[0]->get_instance();
}

my $n_availability = 0;

sub get_availability {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_availability'};
}

=head2 availability

有効状態 {@link EAvailability}

=cut
sub availability {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Server#availability");
		throw $ex;
	}
	return $_[0]->get_availability();
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
	if (Saklient::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saklient::Util::get_by_path($r, "ID")) ? undef : "" . Saklient::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saklient::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saklient::Util::get_by_path($r, "Name")) ? undef : "" . Saklient::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saklient::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saklient::Util::get_by_path($r, "Description")) ? undef : "" . Saklient::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saklient::Util::exists_path($r, "Tags")) {
		if (!defined(Saklient::Util::get_by_path($r, "Tags"))) {
			$self->{'m_tags'} = [];
		}
		else {
			$self->{'m_tags'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Tags")}) {
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
	if (Saklient::Util::exists_path($r, "Icon")) {
		$self->{'m_icon'} = !defined(Saklient::Util::get_by_path($r, "Icon")) ? undef : new Saklient::Cloud::Resource::Icon($self->{'_client'}, Saklient::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if (Saklient::Util::exists_path($r, "ServerPlan")) {
		$self->{'m_plan'} = !defined(Saklient::Util::get_by_path($r, "ServerPlan")) ? undef : new Saklient::Cloud::Resource::ServerPlan($self->{'_client'}, Saklient::Util::get_by_path($r, "ServerPlan"));
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
	if (Saklient::Util::exists_path($r, "Interfaces")) {
		if (!defined(Saklient::Util::get_by_path($r, "Interfaces"))) {
			$self->{'m_ifaces'} = [];
		}
		else {
			$self->{'m_ifaces'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Interfaces")}) {
				my $v2 = undef;
				$v2 = !defined($t) ? undef : new Saklient::Cloud::Resource::Iface($self->{'_client'}, $t);
				push(@{$self->{'m_ifaces'}}, $v2);
			}
		}
	}
	else {
		$self->{'m_ifaces'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ifaces'} = 0;
	if (Saklient::Util::exists_path($r, "Instance")) {
		$self->{'m_instance'} = !defined(Saklient::Util::get_by_path($r, "Instance")) ? undef : new Saklient::Cloud::Resource::ServerInstance($self->{'_client'}, Saklient::Util::get_by_path($r, "Instance"));
	}
	else {
		$self->{'m_instance'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_instance'} = 0;
	if (Saklient::Util::exists_path($r, "Availability")) {
		$self->{'m_availability'} = !defined(Saklient::Util::get_by_path($r, "Availability")) ? undef : "" . Saklient::Util::get_by_path($r, "Availability");
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
	Saklient::Util::validate_type($withClean, "bool");
	my $missing = [];
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saklient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "name");
		}
	}
	if ($withClean || $self->{'n_description'}) {
		Saklient::Util::set_by_path($ret, "Description", $self->{'m_description'});
	}
	if ($withClean || $self->{'n_tags'}) {
		Saklient::Util::set_by_path($ret, "Tags", []);
		foreach my $r1 (@{$self->{'m_tags'}}) {
			my $v = undef;
			$v = $r1;
			push(@{$ret->{"Tags"}}, $v);
		}
	}
	if ($withClean || $self->{'n_icon'}) {
		Saklient::Util::set_by_path($ret, "Icon", $withClean ? (!defined($self->{'m_icon'}) ? undef : $self->{'m_icon'}->api_serialize($withClean)) : (!defined($self->{'m_icon'}) ? {'ID' => "0"} : $self->{'m_icon'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_plan'}) {
		Saklient::Util::set_by_path($ret, "ServerPlan", $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id()));
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "plan");
		}
	}
	if ($withClean || $self->{'n_ifaces'}) {
		Saklient::Util::set_by_path($ret, "Interfaces", []);
		foreach my $r2 (@{$self->{'m_ifaces'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r2) ? undef : $r2->api_serialize($withClean)) : (!defined($r2) ? {'ID' => "0"} : $r2->api_serialize_id());
			push(@{$ret->{"Interfaces"}}, $v);
		}
	}
	if ($withClean || $self->{'n_instance'}) {
		Saklient::Util::set_by_path($ret, "Instance", $withClean ? (!defined($self->{'m_instance'}) ? undef : $self->{'m_instance'}->api_serialize($withClean)) : (!defined($self->{'m_instance'}) ? {'ID' => "0"} : $self->{'m_instance'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_availability'}) {
		Saklient::Util::set_by_path($ret, "Availability", $self->{'m_availability'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Server creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

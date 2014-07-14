#!/usr/bin/perl

package Saclient::Cloud::Resource::Server;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::Disk;
use Saclient::Cloud::Resource::Iface;
use Saclient::Cloud::Resource::ServerPlan;
use Saclient::Cloud::Resource::ServerInstance;
use Saclient::Cloud::Enums::EServerInstanceStatus;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Server

サーバのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_plan;

my $m_ifaces;

my $m_instance;

sub _api_path {
	my $self = shift;
	return "/server";
}

sub _root_key {
	my $self = shift;
	return "Server";
}

sub _root_key_m {
	my $self = shift;
	return "Servers";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Server

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Server

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

=head2 is_up : bool

サーバが起動しているときtrueを返します。

=cut
sub is_up {
	my $self = shift;
	return $self->get_instance()->is_up();
}

=head2 is_down : bool

サーバが停止しているときtrueを返します。

=cut
sub is_down {
	my $self = shift;
	return $self->get_instance()->is_down();
}

=head2 boot : Saclient::Cloud::Resource::Server

サーバを起動します。

=cut
sub boot {
	my $self = shift;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/power");
	return $self->reload();
}

=head2 shutdown : Saclient::Cloud::Resource::Server

サーバをシャットダウンします。

=cut
sub shutdown {
	my $self = shift;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/power");
	return $self->reload();
}

=head2 stop : Saclient::Cloud::Resource::Server

サーバを強制停止します。

=cut
sub stop {
	my $self = shift;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/power", {'Force' => 1});
	return $self->reload();
}

=head2 reboot : Saclient::Cloud::Resource::Server

サーバを強制再起動します。

=cut
sub reboot {
	my $self = shift;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/reset");
	return $self->reload();
}

sub sleep_until {
	my $self = shift;
	my $status = shift;
	my $timeout = shift || (60);
	my $step = 3;
	while (0 < $timeout) {
		$self->reload();
		my $s = $self->get_instance()->status;
		if (!defined($s)) {
			$s = Saclient::Cloud::Enums::EServerInstanceStatus::down;
		}
		if ($s eq $status) {
			return 1;
		}
		$timeout -= $step;
		if (0 < $timeout) {
			sleep $step;
		}
	}
	return 0;
}

=head2 sleep_until_up(int $timeout=60) : bool

サーバが起動するまで待機します。

=cut
sub sleep_until_up {
	my $self = shift;
	my $timeout = shift || (60);
	return $self->sleep_until(Saclient::Cloud::Enums::EServerInstanceStatus::up, $timeout);
}

=head2 sleep_until_down(int $timeout=60) : bool

サーバが停止するまで待機します。

=cut
sub sleep_until_down {
	my $self = shift;
	my $timeout = shift || (60);
	return $self->sleep_until(Saclient::Cloud::Enums::EServerInstanceStatus::down, $timeout);
}

=head2 change_plan(Saclient::Cloud::Resource::ServerPlan $planTo) : Saclient::Cloud::Resource::Server

サーバのプランを変更します。

=cut
sub change_plan {
	my $self = shift;
	my $planTo = shift;
	my $path = $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/to/plan/" . Saclient::Cloud::Util::url_encode($planTo->_id());
	my $result = $self->{'_client'}->request("PUT", $path);
	$self->api_deserialize($result->{$self->_root_key()});
	return $self;
}

=head2 find_disks : Saclient::Cloud::Resource::Disk[]

サーバに接続されているディスクのリストを取得します。

=cut
sub find_disks {
	my $self = shift;
	my $model = Saclient::Cloud::Util::create_class_instance("saclient.cloud.model.Model_Disk", [$self->{'_client'}]);
	return $model->with_server_id($self->_id())->find();
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

my $n_plan = 0;

sub get_plan {
	my $self = shift;
	return $self->{'m_plan'};
}

sub set_plan {
	my $self = shift;
	my $v = shift;
	$self->{'m_plan'} = $v;
	$self->{'n_plan'} = 1;
	return $self->{'m_plan'};
}

=head2 plan

プラン

=cut
sub plan {
	if (1 < scalar(@_)) { $_[0]->set_plan($_[1]); return $_[0]; }
	return $_[0]->get_plan();
}

my $n_ifaces = 0;

sub get_ifaces {
	my $self = shift;
	return $self->{'m_ifaces'};
}

=head2 ifaces

インタフェース

=cut
sub ifaces {
	return $_[0]->get_ifaces();
}

my $n_instance = 0;

sub get_instance {
	my $self = shift;
	return $self->{'m_instance'};
}

=head2 instance

インスタンス情報

=cut
sub instance {
	return $_[0]->get_instance();
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
	if ((ref($r) eq 'HASH' && exists $r->{"Description"})) {
		$self->{'m_description'} = !defined($r->{"Description"}) ? undef : "" . $r->{"Description"};
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"Tags"})) {
		if (!defined($r->{"Tags"})) {
			$self->{'m_tags'} = [];
		}
		else {
			$self->{'m_tags'} = [];
			foreach my $t (@{$r->{"Tags"}}) {
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
	if ((ref($r) eq 'HASH' && exists $r->{"Icon"})) {
		$self->{'m_icon'} = !defined($r->{"Icon"}) ? undef : new Saclient::Cloud::Resource::Icon($self->{'_client'}, $r->{"Icon"});
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"ServerPlan"})) {
		$self->{'m_plan'} = !defined($r->{"ServerPlan"}) ? undef : new Saclient::Cloud::Resource::ServerPlan($self->{'_client'}, $r->{"ServerPlan"});
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"Interfaces"})) {
		if (!defined($r->{"Interfaces"})) {
			$self->{'m_ifaces'} = [];
		}
		else {
			$self->{'m_ifaces'} = [];
			foreach my $t (@{$r->{"Interfaces"}}) {
				my $v = undef;
				$v = !defined($t) ? undef : new Saclient::Cloud::Resource::Iface($self->{'_client'}, $t);
				push(@{$self->{'m_ifaces'}}, $v);
			}
		}
	}
	else {
		$self->{'m_ifaces'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_ifaces'} = 0;
	if ((ref($r) eq 'HASH' && exists $r->{"Instance"})) {
		$self->{'m_instance'} = !defined($r->{"Instance"}) ? undef : new Saclient::Cloud::Resource::ServerInstance($self->{'_client'}, $r->{"Instance"});
	}
	else {
		$self->{'m_instance'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_instance'} = 0;
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
	if ($withClean || $self->{'n_plan'}) {
		$ret->{"ServerPlan"} = $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id());
	}
	if ($withClean || $self->{'n_ifaces'}) {
		$ret->{"Interfaces"} = [];
		foreach my $r (@{$self->{'m_ifaces'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r) ? undef : $r->api_serialize($withClean)) : (!defined($r) ? {'ID' => "0"} : $r->api_serialize_id());
			push(@{$ret->{"Interfaces"}}, $v);
		}
	}
	if ($withClean || $self->{'n_instance'}) {
		$ret->{"Instance"} = $withClean ? (!defined($self->{'m_instance'}) ? undef : $self->{'m_instance'}->api_serialize($withClean)) : (!defined($self->{'m_instance'}) ? {'ID' => "0"} : $self->{'m_instance'}->api_serialize_id());
	}
	return $ret;
}

1;

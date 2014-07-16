#!/usr/bin/perl

package Saclient::Cloud::Resource::Appliance;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::Iface;
use Saclient::Cloud::Enums::EApplianceClass;

use base qw(Saclient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Appliance

アプライアンスのリソース情報へのアクセス機能や操作機能を備えたクラス。

=cut


my $m_id;

my $m_clazz;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_ifaces;

my $m_service_class;

sub _api_path {
	my $self = shift;
	return "/appliance";
}

sub _root_key {
	my $self = shift;
	return "Appliance";
}

sub _root_key_m {
	my $self = shift;
	return "Appliances";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 save : Saclient::Cloud::Resource::Appliance

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload : Saclient::Cloud::Resource::Appliance

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

=head2 boot : Saclient::Cloud::Resource::Appliance

アプライアンスを起動します。

=cut
sub boot {
	my $self = shift;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/power");
	return $self;
}

=head2 shutdown : Saclient::Cloud::Resource::Appliance

アプライアンスをシャットダウンします。

=cut
sub shutdown {
	my $self = shift;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/power");
	return $self;
}

=head2 stop : Saclient::Cloud::Resource::Appliance

アプライアンスを強制停止します。

=cut
sub stop {
	my $self = shift;
	$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/power", {'Force' => 1});
	return $self;
}

=head2 reboot : Saclient::Cloud::Resource::Appliance

アプライアンスを強制再起動します。

=cut
sub reboot {
	my $self = shift;
	$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()) . "/reset");
	return $self;
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

my $n_clazz = 0;

sub get_clazz {
	my $self = shift;
	return $self->{'m_clazz'};
}

sub set_clazz {
	my $self = shift;
	my $v = shift;
	$self->{'m_clazz'} = $v;
	$self->{'n_clazz'} = 1;
	return $self->{'m_clazz'};
}

=head2 clazz

クラス

=cut
sub clazz {
	if (1 < scalar(@_)) { $_[0]->set_clazz($_[1]); return $_[0]; }
	return $_[0]->get_clazz();
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

my $n_ifaces = 0;

sub get_ifaces {
	my $self = shift;
	return $self->{'m_ifaces'};
}

=head2 ifaces

プラン

=cut
sub ifaces {
	return $_[0]->get_ifaces();
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

sub api_deserialize_impl {
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
	if ((ref($r) eq 'HASH' && exists $r->{"Class"})) {
		$self->{'m_clazz'} = !defined($r->{"Class"}) ? undef : "" . $r->{"Class"};
	}
	else {
		$self->{'m_clazz'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_clazz'} = 0;
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
	if ((ref($r) eq 'HASH' && exists $r->{"ServiceClass"})) {
		$self->{'m_service_class'} = !defined($r->{"ServiceClass"}) ? undef : "" . $r->{"ServiceClass"};
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_clazz'}) {
		$ret->{"Class"} = $self->{'m_clazz'};
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
	if ($withClean || $self->{'n_ifaces'}) {
		$ret->{"Interfaces"} = [];
		foreach my $r (@{$self->{'m_ifaces'}}) {
			my $v = undef;
			$v = $withClean ? (!defined($r) ? undef : $r->api_serialize($withClean)) : (!defined($r) ? {'ID' => "0"} : $r->api_serialize_id());
			push(@{$ret->{"Interfaces"}}, $v);
		}
	}
	if ($withClean || $self->{'n_service_class'}) {
		$ret->{"ServiceClass"} = $self->{'m_service_class'};
	}
	return $ret;
}

1;

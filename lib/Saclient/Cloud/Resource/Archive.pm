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
use Saclient::Cloud::Resource::DiskPlan;
use Saclient::Cloud::Resource::Server;

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

sub _api_path {
	my $self = shift;
	return "/archive";
}

sub _root_key {
	my $self = shift;
	return "Archive";
}

sub _root_key_m {
	my $self = shift;
	return "Archives";
}

sub _id {
	my $self = shift;
	return $self->get_id();
}

=head2 create

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新しいインスタンスを作成します。

@return this

=cut
sub create {
	my $self = shift;
	return $self->_create();
}

=head2 save

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	return $self->_save();
}

=head2 reload

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

sub get_size_gib {
	my $self = shift;
	return $self->get_size_mib() >> 10;
}

=head2 size_gib

サイズ[GiB]

=cut
sub size_gib {
	return $_[0]->get_size_gib();
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

my $n_scope = 0;

sub get_scope {
	my $self = shift;
	return $self->{'m_scope'};
}

sub set_scope {
	my $self = shift;
	my $v = shift;
	$self->{'m_scope'} = $v;
	$self->{'n_scope'} = 1;
	return $self->{'m_scope'};
}

=head2 scope

スコープ

=cut
sub scope {
	if (1 < scalar(@_)) { $_[0]->set_scope($_[1]); return $_[0]; }
	return $_[0]->get_scope();
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

=head2 size_mib

サイズ[MiB]

=cut
sub size_mib {
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

=head2 api_deserialize

(This method is generated in Translator_default#buildImpl)

=cut
sub api_deserialize {
	my $self = shift;
	my $r = shift;
	$self->{'is_incomplete'} = 1;
	if ((ref($r) eq 'HASH' && exists $r->{"ID"})) {
		$self->{'m_id'} = !defined($r->{"ID"}) ? undef : "" . $r->{"ID"};
		$self->{'n_id'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"Scope"})) {
		$self->{'m_scope'} = !defined($r->{"Scope"}) ? undef : "" . $r->{"Scope"};
		$self->{'n_scope'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"Name"})) {
		$self->{'m_name'} = !defined($r->{"Name"}) ? undef : "" . $r->{"Name"};
		$self->{'n_name'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"Description"})) {
		$self->{'m_description'} = !defined($r->{"Description"}) ? undef : "" . $r->{"Description"};
		$self->{'n_description'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
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
		$self->{'n_tags'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"Icon"})) {
		$self->{'m_icon'} = !defined($r->{"Icon"}) ? undef : new Saclient::Cloud::Resource::Icon($self->{'_client'}, $r->{"Icon"});
		$self->{'n_icon'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"SizeMB"})) {
		$self->{'m_size_mib'} = !defined($r->{"SizeMB"}) ? undef : (0+("" . $r->{"SizeMB"}));
		$self->{'n_size_mib'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"ServiceClass"})) {
		$self->{'m_service_class'} = !defined($r->{"ServiceClass"}) ? undef : "" . $r->{"ServiceClass"};
		$self->{'n_service_class'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
	if ((ref($r) eq 'HASH' && exists $r->{"Plan"})) {
		$self->{'m_plan'} = !defined($r->{"Plan"}) ? undef : new Saclient::Cloud::Resource::DiskPlan($self->{'_client'}, $r->{"Plan"});
		$self->{'n_plan'} = 0;
	}
	else {
		$self->{'is_incomplete'} = 0;
	}
}

=head2 api_serialize

(This method is generated in Translator_default#buildImpl)

=cut
sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		$ret->{"ID"} = $self->{'m_id'};
	}
	if ($withClean || $self->{'n_scope'}) {
		$ret->{"Scope"} = $self->{'m_scope'};
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
	return $ret;
}

1;

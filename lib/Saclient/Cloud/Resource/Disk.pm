#!/usr/bin/perl

package Saclient::Cloud::Resource::Disk;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::DiskPlan;
use Saclient::Cloud::Resource::Server;

use base qw(Saclient::Cloud::Resource::Resource);

## @class Saclient::Cloud::Resource::Disk
#

## @var private string $m_id
# ID
#
my $m_id;

## @var private string $m_name
# 名前
#
my $m_name;

## @var private string $m_description
# 説明
#
my $m_description;

## @var private string[] $m_tags
# タグ
#
my $m_tags;

## @var private Saclient::Cloud::Resource::Icon $m_icon
# アイコン
#
my $m_icon;

## @var private int $m_size_mib
# サイズ[MiB]
#
my $m_size_mib;

## @var private string $m_service_class
# サービスクラス
#
my $m_service_class;

## @var private Saclient::Cloud::Resource::DiskPlan $m_plan
# プラン
#
my $m_plan;

## @var private Saclient::Cloud::Resource::Server $m_server
# 接続先のサーバ
#
my $m_server;

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return "/disk";
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return "Disk";
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return "Disks";
	}
}

## @method public string _id()
# @private
#
sub _id {
	my $self = shift;
	{
		return $self->get_id();
	}
}

## @method public Saclient::Cloud::Resource::Disk create()
# このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新しいインスタンスを作成します。
# 
# @return this
#
sub create {
	my $self = shift;
	{
		return $self->_create();
	}
}

## @method public Saclient::Cloud::Resource::Disk save()
# このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、上書き保存します。
# 
# @return this
#
sub save {
	my $self = shift;
	{
		return $self->_save();
	}
}

## @method public Saclient::Cloud::Resource::Disk reload()
# 最新のリソース情報を再取得します。
# 
# @return this
#
sub reload {
	my $self = shift;
	{
		return $self->_reload();
	}
}

## @method public Void new()
# @private
#
sub new {
	my $class = shift;
	my $self;
	my $client = shift;
	my $r = shift;
	{
		$self = $class->SUPER::new($client);
		$self->api_deserialize($r);
	}
	return $self;
}

sub get_size_gib {
	my $self = shift;
	{
		return $self->get_size_mib() >> 10;
	}
}

## @method public int size_gib()
# サイズ[GiB]
#
sub size_gib {
	return $_[0]->get_size_gib();
}

## @method public Saclient::Cloud::Resource::Disk attach_to()
# ディスクをサーバに取り付けます。
#
sub attach_to {
	my $self = shift;
	my $serverId = shift;
	{
		$self->{'_client'}->request("PUT", "/disk/" . $self->_id() . "/to/server/" . $serverId);
		return $self;
	}
}

## @method public Saclient::Cloud::Resource::Disk detach()
# ディスクをサーバから取り外します。
#
sub detach {
	my $self = shift;
	{
		$self->{'_client'}->request("DELETE", "/disk/" . $self->_id() . "/to/server");
		return $self;
	}
}

my $n_id = 0;

## @method private string get_id()
# (This method is generated in Translator_default#buildImpl)
#
sub get_id {
	my $self = shift;
	{
		return $self->{'m_id'};
	}
}

## @method public string id()
# ID
#
sub id {
	return $_[0]->get_id();
}

my $n_name = 0;

## @method private string get_name()
# (This method is generated in Translator_default#buildImpl)
#
sub get_name {
	my $self = shift;
	{
		return $self->{'m_name'};
	}
}

## @method private string set_name()
# (This method is generated in Translator_default#buildImpl)
#
sub set_name {
	my $self = shift;
	my $v = shift;
	{
		$self->{'m_name'} = $v;
		$self->{'n_name'} = 1;
		return $self->{'m_name'};
	}
}

## @method public string name()
# 名前
#
sub name {
	if (1 < scalar(@_)) { $_[0]->set_name($_[1]); return $_[0]; }
	return $_[0]->get_name();
}

my $n_description = 0;

## @method private string get_description()
# (This method is generated in Translator_default#buildImpl)
#
sub get_description {
	my $self = shift;
	{
		return $self->{'m_description'};
	}
}

## @method private string set_description()
# (This method is generated in Translator_default#buildImpl)
#
sub set_description {
	my $self = shift;
	my $v = shift;
	{
		$self->{'m_description'} = $v;
		$self->{'n_description'} = 1;
		return $self->{'m_description'};
	}
}

## @method public string description()
# 説明
#
sub description {
	if (1 < scalar(@_)) { $_[0]->set_description($_[1]); return $_[0]; }
	return $_[0]->get_description();
}

my $n_tags = 0;

## @method private string[] get_tags()
# (This method is generated in Translator_default#buildImpl)
#
sub get_tags {
	my $self = shift;
	{
		return $self->{'m_tags'};
	}
}

## @method private string[] set_tags()
# (This method is generated in Translator_default#buildImpl)
#
sub set_tags {
	my $self = shift;
	my $v = shift;
	{
		$self->{'m_tags'} = $v;
		$self->{'n_tags'} = 1;
		return $self->{'m_tags'};
	}
}

## @method public string[] tags()
# タグ
#
sub tags {
	if (1 < scalar(@_)) { $_[0]->set_tags($_[1]); return $_[0]; }
	return $_[0]->get_tags();
}

my $n_icon = 0;

## @method private Saclient::Cloud::Resource::Icon get_icon()
# (This method is generated in Translator_default#buildImpl)
#
sub get_icon {
	my $self = shift;
	{
		return $self->{'m_icon'};
	}
}

## @method private Saclient::Cloud::Resource::Icon set_icon()
# (This method is generated in Translator_default#buildImpl)
#
sub set_icon {
	my $self = shift;
	my $v = shift;
	{
		$self->{'m_icon'} = $v;
		$self->{'n_icon'} = 1;
		return $self->{'m_icon'};
	}
}

## @method public Saclient::Cloud::Resource::Icon icon()
# アイコン
#
sub icon {
	if (1 < scalar(@_)) { $_[0]->set_icon($_[1]); return $_[0]; }
	return $_[0]->get_icon();
}

my $n_size_mib = 0;

## @method private int get_size_mib()
# (This method is generated in Translator_default#buildImpl)
#
sub get_size_mib {
	my $self = shift;
	{
		return $self->{'m_size_mib'};
	}
}

## @method public int size_mib()
# サイズ[MiB]
#
sub size_mib {
	return $_[0]->get_size_mib();
}

my $n_service_class = 0;

## @method private string get_service_class()
# (This method is generated in Translator_default#buildImpl)
#
sub get_service_class {
	my $self = shift;
	{
		return $self->{'m_service_class'};
	}
}

## @method public string service_class()
# サービスクラス
#
sub service_class {
	return $_[0]->get_service_class();
}

my $n_plan = 0;

## @method private Saclient::Cloud::Resource::DiskPlan get_plan()
# (This method is generated in Translator_default#buildImpl)
#
sub get_plan {
	my $self = shift;
	{
		return $self->{'m_plan'};
	}
}

## @method public Saclient::Cloud::Resource::DiskPlan plan()
# プラン
#
sub plan {
	return $_[0]->get_plan();
}

my $n_server = 0;

## @method private Saclient::Cloud::Resource::Server get_server()
# (This method is generated in Translator_default#buildImpl)
#
sub get_server {
	my $self = shift;
	{
		return $self->{'m_server'};
	}
}

## @method public Saclient::Cloud::Resource::Server server()
# 接続先のサーバ
#
sub server {
	return $_[0]->get_server();
}

## @method public Void api_deserialize()
# (This method is generated in Translator_default#buildImpl)
#
sub api_deserialize {
	my $self = shift;
	my $r = shift;
	{
		$self->{'is_incomplete'} = 1;
		if ((ref($r) eq 'HASH' && exists $r->{"ID"})) {
			{
				$self->{'m_id'} = !defined($r->{"ID"}) ? undef : "" . $r->{"ID"};
				$self->{'n_id'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Name"})) {
			{
				$self->{'m_name'} = !defined($r->{"Name"}) ? undef : "" . $r->{"Name"};
				$self->{'n_name'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Description"})) {
			{
				$self->{'m_description'} = !defined($r->{"Description"}) ? undef : "" . $r->{"Description"};
				$self->{'n_description'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Tags"})) {
			{
				if (!defined($r->{"Tags"})) {
					{
						$self->{'m_tags'} = [];
					};
				}
				else {
					{
						$self->{'m_tags'} = [];
						foreach my $t (@{$r->{"Tags"}}) {
							{
								my $v = undef;
								$v = !defined($t) ? undef : "" . $t;
								push(@{$self->{'m_tags'}}, $v);
							}
						};
					};
				};
				$self->{'n_tags'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Icon"})) {
			{
				$self->{'m_icon'} = !defined($r->{"Icon"}) ? undef : new Saclient::Cloud::Resource::Icon($self->{'_client'}, $r->{"Icon"});
				$self->{'n_icon'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"SizeMB"})) {
			{
				$self->{'m_size_mib'} = !defined($r->{"SizeMB"}) ? undef : (0+("" . $r->{"SizeMB"}));
				$self->{'n_size_mib'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"ServiceClass"})) {
			{
				$self->{'m_service_class'} = !defined($r->{"ServiceClass"}) ? undef : "" . $r->{"ServiceClass"};
				$self->{'n_service_class'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Plan"})) {
			{
				$self->{'m_plan'} = !defined($r->{"Plan"}) ? undef : new Saclient::Cloud::Resource::DiskPlan($self->{'_client'}, $r->{"Plan"});
				$self->{'n_plan'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Server"})) {
			{
				$self->{'m_server'} = !defined($r->{"Server"}) ? undef : new Saclient::Cloud::Resource::Server($self->{'_client'}, $r->{"Server"});
				$self->{'n_server'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
	}
}

## @method public any api_serialize()
# (This method is generated in Translator_default#buildImpl)
#
sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	{
		my $ret = {};
		if ($withClean || $self->{'n_id'}) {
			{
				$ret->{"ID"} = $self->{'m_id'};
			};
		};
		if ($withClean || $self->{'n_name'}) {
			{
				$ret->{"Name"} = $self->{'m_name'};
			};
		};
		if ($withClean || $self->{'n_description'}) {
			{
				$ret->{"Description"} = $self->{'m_description'};
			};
		};
		if ($withClean || $self->{'n_tags'}) {
			{
				$ret->{"Tags"} = [];
				foreach my $r (@{$self->{'m_tags'}}) {
					{
						my $v = undef;
						$v = $r;
						push(@{$ret->{"Tags"}}, $v);
					}
				};
			};
		};
		if ($withClean || $self->{'n_icon'}) {
			{
				$ret->{"Icon"} = $withClean ? (!defined($self->{'m_icon'}) ? undef : $self->{'m_icon'}->api_serialize($withClean)) : (!defined($self->{'m_icon'}) ? {'ID' => "0"} : $self->{'m_icon'}->api_serialize_id());
			};
		};
		if ($withClean || $self->{'n_size_mib'}) {
			{
				$ret->{"SizeMB"} = $self->{'m_size_mib'};
			};
		};
		if ($withClean || $self->{'n_service_class'}) {
			{
				$ret->{"ServiceClass"} = $self->{'m_service_class'};
			};
		};
		if ($withClean || $self->{'n_plan'}) {
			{
				$ret->{"Plan"} = $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id());
			};
		};
		if ($withClean || $self->{'n_server'}) {
			{
				$ret->{"Server"} = $withClean ? (!defined($self->{'m_server'}) ? undef : $self->{'m_server'}->api_serialize($withClean)) : (!defined($self->{'m_server'}) ? {'ID' => "0"} : $self->{'m_server'}->api_serialize_id());
			};
		};
		return $ret;
	}
}

1;

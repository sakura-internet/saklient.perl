#!/usr/bin/perl

package Saclient::Cloud::Resource::Server;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;
use Saclient::Cloud::Resource::Icon;
use Saclient::Cloud::Resource::Disk;
use Saclient::Cloud::Resource::Iface;
use Saclient::Cloud::Resource::ServerPlan;
use Saclient::Cloud::Resource::ServerInstance;

use base qw(Saclient::Cloud::Resource::Resource);

## @class Saclient::Cloud::Resource::Server
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

## @var private Saclient::Cloud::Resource::ServerPlan $m_plan
# プラン
#
my $m_plan;

## @var private Saclient::Cloud::Resource::Iface[] $m_ifaces
# インタフェース
#
my $m_ifaces;

## @var private Saclient::Cloud::Resource::ServerInstance $m_instance
# インスタンス情報
#
my $m_instance;

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return "/server";
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return "Server";
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return "Servers";
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

## @method public Saclient::Cloud::Resource::Server create()
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

## @method public Saclient::Cloud::Resource::Server save()
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

## @method public Saclient::Cloud::Resource::Server reload()
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

## @method public Saclient::Cloud::Resource::Server boot()
# サーバを起動します。
#
sub boot {
	my $self = shift;
	{
		$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()) . "/power");
		return $self;
	}
}

## @method public Saclient::Cloud::Resource::Server shutdown()
# サーバをシャットダウンします。
#
sub shutdown {
	my $self = shift;
	{
		$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()) . "/power");
		return $self;
	}
}

## @method public Saclient::Cloud::Resource::Server stop()
# サーバを強制停止します。
#
sub stop {
	my $self = shift;
	{
		$self->{'_client'}->request("DELETE", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()) . "/power", {'Force' => 1});
		return $self;
	}
}

## @method public Saclient::Cloud::Resource::Server reboot()
# サーバを強制再起動します。
#
sub reboot {
	my $self = shift;
	{
		$self->{'_client'}->request("PUT", $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()) . "/reset");
		return $self;
	}
}

## @method public Saclient::Cloud::Resource::Server change_plan()
# サーバのプランを変更します。
#
sub change_plan {
	my $self = shift;
	my $planTo = shift;
	{
		my $path = $self->_api_path() . "/" . Saclient::Cloud::Util->url_encode($self->_id()) . "/to/plan/" . Saclient::Cloud::Util->url_encode($planTo->_id());
		my $result = $self->{'_client'}->request("PUT", $path);
		$self->api_deserialize($result->{$self->_root_key()});
		return $self;
	}
}

## @method public Saclient::Cloud::Resource::Disk[] find_disks()
# サーバに接続されているディスクのリストを取得します。
#
sub find_disks {
	my $self = shift;
	{
		my $model = Saclient::Cloud::Util->create_class_instance("saclient.cloud.model.Model_Disk", [$self->{'_client'}]);
		return $model->with_server_id($self->_id())->find();
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

my $n_plan = 0;

## @method private Saclient::Cloud::Resource::ServerPlan get_plan()
# (This method is generated in Translator_default#buildImpl)
#
sub get_plan {
	my $self = shift;
	{
		return $self->{'m_plan'};
	}
}

## @method public Saclient::Cloud::Resource::ServerPlan plan()
# プラン
#
sub plan {
	return $_[0]->get_plan();
}

my $n_ifaces = 0;

## @method private Saclient::Cloud::Resource::Iface[] get_ifaces()
# (This method is generated in Translator_default#buildImpl)
#
sub get_ifaces {
	my $self = shift;
	{
		return $self->{'m_ifaces'};
	}
}

## @method public Saclient::Cloud::Resource::Iface[] ifaces()
# インタフェース
#
sub ifaces {
	return $_[0]->get_ifaces();
}

my $n_instance = 0;

## @method private Saclient::Cloud::Resource::ServerInstance get_instance()
# (This method is generated in Translator_default#buildImpl)
#
sub get_instance {
	my $self = shift;
	{
		return $self->{'m_instance'};
	}
}

## @method public Saclient::Cloud::Resource::ServerInstance instance()
# インスタンス情報
#
sub instance {
	return $_[0]->get_instance();
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
		if ((ref($r) eq 'HASH' && exists $r->{"ServerPlan"})) {
			{
				$self->{'m_plan'} = !defined($r->{"ServerPlan"}) ? undef : new Saclient::Cloud::Resource::ServerPlan($self->{'_client'}, $r->{"ServerPlan"});
				$self->{'n_plan'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Interfaces"})) {
			{
				if (!defined($r->{"Interfaces"})) {
					{
						$self->{'m_ifaces'} = [];
					};
				}
				else {
					{
						$self->{'m_ifaces'} = [];
						foreach my $t (@{$r->{"Interfaces"}}) {
							{
								my $v = undef;
								$v = !defined($t) ? undef : new Saclient::Cloud::Resource::Iface($self->{'_client'}, $t);
								push(@{$self->{'m_ifaces'}}, $v);
							}
						};
					};
				};
				$self->{'n_ifaces'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"Instance"})) {
			{
				$self->{'m_instance'} = !defined($r->{"Instance"}) ? undef : new Saclient::Cloud::Resource::ServerInstance($self->{'_client'}, $r->{"Instance"});
				$self->{'n_instance'} = 0;
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
		if ($withClean || $self->{'n_plan'}) {
			{
				$ret->{"ServerPlan"} = $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id());
			};
		};
		if ($withClean || $self->{'n_ifaces'}) {
			{
				$ret->{"Interfaces"} = [];
				foreach my $r (@{$self->{'m_ifaces'}}) {
					{
						my $v = undef;
						$v = $withClean ? (!defined($r) ? undef : $r->api_serialize($withClean)) : (!defined($r) ? {'ID' => "0"} : $r->api_serialize_id());
						push(@{$ret->{"Interfaces"}}, $v);
					}
				};
			};
		};
		if ($withClean || $self->{'n_instance'}) {
			{
				$ret->{"Instance"} = $withClean ? (!defined($self->{'m_instance'}) ? undef : $self->{'m_instance'}->api_serialize($withClean)) : (!defined($self->{'m_instance'}) ? {'ID' => "0"} : $self->{'m_instance'}->api_serialize_id());
			};
		};
		return $ret;
	}
}

1;

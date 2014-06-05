#!/usr/bin/perl

package Saclient::Cloud::Resource::Icon;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

use base qw(Saclient::Cloud::Resource::Resource);

## @class Saclient::Cloud::Resource::Icon
#

my $m_id;

my $m_name;

my $m_url;

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return "/icon";
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return "Icon";
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return "Icons";
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

## @method public Saclient::Cloud::Resource::Icon create()
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

## @method public Saclient::Cloud::Resource::Icon save()
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

## @method public Saclient::Cloud::Resource::Icon reload()
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

sub name {
	return $_[0]->get_name();
}

my $n_url = 0;

## @method private string get_url()
# (This method is generated in Translator_default#buildImpl)
#
sub get_url {
	my $self = shift;
	{
		return $self->{'m_url'};
	}
}

sub url {
	return $_[0]->get_url();
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
		if ((ref($r) eq 'HASH' && exists $r->{"URL"})) {
			{
				$self->{'m_url'} = !defined($r->{"URL"}) ? undef : "" . $r->{"URL"};
				$self->{'n_url'} = 0;
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
		if ($withClean || $self->{'n_url'}) {
			{
				$ret->{"URL"} = $self->{'m_url'};
			};
		};
		return $ret;
	}
}

1;

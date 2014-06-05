#!/usr/bin/perl

package Saclient::Cloud::Resource::Iface;

use strict;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;

use base qw(Saclient::Cloud::Resource::Resource);

## @class Saclient::Cloud::Resource::Iface
#

my $m_id;

my $m_mac_address;

my $m_ip_address;

my $m_user_ip_address;

## @method private string _api_path()
# @private
#
sub _api_path {
	my $self = shift;
	{
		return "/interface";
	}
}

## @method private string _root_key()
# @private
#
sub _root_key {
	my $self = shift;
	{
		return "Interface";
	}
}

## @method private string _root_key_m()
# @private
#
sub _root_key_m {
	my $self = shift;
	{
		return "Interfaces";
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

## @method public Saclient::Cloud::Resource::Iface create()
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

## @method public Saclient::Cloud::Resource::Iface save()
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

## @method public Saclient::Cloud::Resource::Iface reload()
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

my $n_mac_address = 0;

## @method private string get_mac_address()
# (This method is generated in Translator_default#buildImpl)
#
sub get_mac_address {
	my $self = shift;
	{
		return $self->{'m_mac_address'};
	}
}

sub mac_address {
	return $_[0]->get_mac_address();
}

my $n_ip_address = 0;

## @method private string get_ip_address()
# (This method is generated in Translator_default#buildImpl)
#
sub get_ip_address {
	my $self = shift;
	{
		return $self->{'m_ip_address'};
	}
}

sub ip_address {
	return $_[0]->get_ip_address();
}

my $n_user_ip_address = 0;

## @method private string get_user_ip_address()
# (This method is generated in Translator_default#buildImpl)
#
sub get_user_ip_address {
	my $self = shift;
	{
		return $self->{'m_user_ip_address'};
	}
}

## @method private string set_user_ip_address()
# (This method is generated in Translator_default#buildImpl)
#
sub set_user_ip_address {
	my $self = shift;
	my $v = shift;
	{
		$self->{'m_user_ip_address'} = $v;
		$self->{'n_user_ip_address'} = 1;
		return $self->{'m_user_ip_address'};
	}
}

sub user_ip_address {
	if (1 < scalar(@_)) { $_[0]->set_user_ip_address($_[1]); return $_[0]; }
	return $_[0]->get_user_ip_address();
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
		if ((ref($r) eq 'HASH' && exists $r->{"MACAddress"})) {
			{
				$self->{'m_mac_address'} = !defined($r->{"MACAddress"}) ? undef : "" . $r->{"MACAddress"};
				$self->{'n_mac_address'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"IPAddress"})) {
			{
				$self->{'m_ip_address'} = !defined($r->{"IPAddress"}) ? undef : "" . $r->{"IPAddress"};
				$self->{'n_ip_address'} = 0;
			};
		}
		else {
			{
				$self->{'is_incomplete'} = 0;
			};
		};
		if ((ref($r) eq 'HASH' && exists $r->{"UserIPAddress"})) {
			{
				$self->{'m_user_ip_address'} = !defined($r->{"UserIPAddress"}) ? undef : "" . $r->{"UserIPAddress"};
				$self->{'n_user_ip_address'} = 0;
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
		if ($withClean || $self->{'n_mac_address'}) {
			{
				$ret->{"MACAddress"} = $self->{'m_mac_address'};
			};
		};
		if ($withClean || $self->{'n_ip_address'}) {
			{
				$ret->{"IPAddress"} = $self->{'m_ip_address'};
			};
		};
		if ($withClean || $self->{'n_user_ip_address'}) {
			{
				$ret->{"UserIPAddress"} = $self->{'m_user_ip_address'};
			};
		};
		return $ret;
	}
}

1;

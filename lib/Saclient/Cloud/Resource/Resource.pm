#!/usr/bin/perl

package Saclient::Cloud::Resource::Resource;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Util;


=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Resource

@ignore

=cut


my $_client;

sub get_client {
	my $self = shift;
	return $self->{'_client'};
}

sub client {
	return $_[0]->get_client();
}

my $_params;

sub set_param {
	my $self = shift;
	my $key = shift;
	my $value = shift;
	$self->{'_params'}->{$key} = $value;
}

sub _api_path {
	my $self = shift;
	return undef;
}

sub _root_key {
	my $self = shift;
	return undef;
}

sub _root_key_m {
	my $self = shift;
	return undef;
}

sub _id {
	my $self = shift;
	return undef;
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	$self->{'_client'} = $client;
	$self->{'_params'} = {};
	return $self;
}

my $is_new;

my $is_incomplete;

sub _on_before_save {
	my $self = shift;
	my $r = shift;
	{}
}

sub _on_after_api_deserialize {
	my $self = shift;
	my $r = shift;
	{}
}

sub _on_after_api_serialize {
	my $self = shift;
	my $r = shift;
	my $withClean = shift;
	{}
}

sub api_deserialize_impl {
	my $self = shift;
	my $r = shift;
	{}
}

sub api_deserialize {
	my $self = shift;
	my $r = shift;
	$self->api_deserialize_impl($r);
	$self->_on_after_api_deserialize($r);
}

sub api_serialize_impl {
	my $self = shift;
	my $withClean = shift || (0);
	return undef;
}

sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	my $ret = $self->api_serialize_impl($withClean);
	$self->_on_after_api_serialize($ret, $withClean);
	return $ret;
}

sub api_serialize_id {
	my $self = shift;
	my $id = $self->_id();
	if (!defined($id)) {
		return undef;
	}
	my $r = {};
	$r->{"ID"} = $id;
	return $r;
}

sub _save {
	my $self = shift;
	my $r = $self->api_serialize();
	my $params = $self->{'_params'};
	$self->{'_params'} = {};
	my $keys = [keys %{$params}];
	foreach my $k (@{$keys}) {
		my $v = $params->{$k};
		$r->{$k} = $v;
	}
	$self->_on_before_save($r);
	my $method = $self->{'is_new'} ? "POST" : "PUT";
	my $path = $self->_api_path();
	if (!$self->{'is_new'}) {
		$path .= "/" . Saclient::Cloud::Util::url_encode($self->_id());
	}
	my $q = {};
	$q->{$self->_root_key()} = $r;
	my $result = $self->{'_client'}->request($method, $path, $q);
	$self->api_deserialize($result->{$self->_root_key()});
	return $self;
}

=head2 destroy : void

このローカルオブジェクトのIDと対応するリソースの削除リクエストをAPIに送信します。

=cut
sub destroy {
	my $self = shift;
	if ($self->{'is_new'}) {
		return;
	}
	my $path = $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id());
	$self->{'_client'}->request("DELETE", $path);
}

sub _reload {
	my $self = shift;
	my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($self->_id()));
	$self->api_deserialize($result->{$self->_root_key()});
	return $self;
}

sub dump {
	my $self = shift;
	return $self->api_serialize(1);
}

1;

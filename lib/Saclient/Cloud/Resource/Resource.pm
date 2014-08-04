#!/usr/bin/perl

package Saclient::Cloud::Resource::Resource;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Util;
use Saclient::Cloud::Client;


=pod

=encoding utf8

=head1 Saclient::Cloud::Resource::Resource

@ignore

=cut


my $_client;

sub get_client {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_client'};
}

sub client {
	return $_[0]->get_client();
}

my $_params;

sub set_param {
	my $self = shift;
	my $_argnum = scalar @_;
	my $key = shift;
	my $value = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($key, "string");
	$self->{'_params'}->{$key} = $value;
}

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($client, "Saclient::Cloud::Client");
	$self->{'_client'} = $client;
	$self->{'_params'} = {};
	return $self;
}

my $is_new;

my $is_incomplete;

sub _on_before_save {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
}

sub _on_after_api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
}

sub _on_after_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $withClean = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($withClean, "bool");
}

sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
}

sub api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	$self->api_deserialize_impl($r);
	$self->_on_after_api_deserialize($r);
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saclient::Util::validate_type($withClean, "bool");
	return undef;
}

sub api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saclient::Util::validate_type($withClean, "bool");
	my $ret = $self->api_serialize_impl($withClean);
	$self->_on_after_api_serialize($ret, $withClean);
	return $ret;
}

sub api_serialize_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = $self->_id();
	if (!defined($id)) {
		return undef;
	}
	my $r = {};
	$r->{"ID"} = $id;
	return $r;
}

sub normalize_field_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saclient::Util::validate_arg_count($_argnum, 1);
	Saclient::Util::validate_type($name, "string");
	$name =~ s/([A-Z])/'_'.lc($1)/eg;
	return $name;
}

sub set_property {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	my $value = shift;
	Saclient::Util::validate_arg_count($_argnum, 2);
	Saclient::Util::validate_type($name, "string");
	$name = $self->normalize_field_name($name);
	$self->{"m_" . $name} = $value;
	$self->{"n_" . $name} = 1;
}

sub _save {
	my $self = shift;
	my $_argnum = scalar @_;
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
		$path .= "/" . Saclient::Util::url_encode($self->_id());
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
	my $_argnum = scalar @_;
	if ($self->{'is_new'}) {
		return;
	}
	my $path = $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id());
	$self->{'_client'}->request("DELETE", $path);
}

sub _reload {
	my $self = shift;
	my $_argnum = scalar @_;
	my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saclient::Util::url_encode($self->_id()));
	$self->api_deserialize($result->{$self->_root_key()});
	return $self;
}

=head2 exists : bool

このリソースが存在するかを調べます。

=cut
sub exists {
	my $self = shift;
	my $_argnum = scalar @_;
	my $params = {};
	Saclient::Util::set_by_path($params, "Filter.ID", [$self->_id()]);
	Saclient::Util::set_by_path($params, "Include", ["ID"]);
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	return $result->{"Count"} == 1;
}

sub dump {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->api_serialize(1);
}

1;

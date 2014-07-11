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
	return $self;
}

my $is_new;

my $is_incomplete;

sub api_deserialize {
	my $self = shift;
	my $r = shift;
	{}
}

sub api_serialize {
	my $self = shift;
	my $withClean = shift || (0);
	return undef;
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
	my $r = {};
	$r->{$self->_root_key()} = $self->api_serialize();
	my $method = $self->{'is_new'} ? "POST" : "PUT";
	my $path = $self->_api_path();
	if (!$self->{'is_new'}) {
		$path .= "/" . Saclient::Cloud::Util::url_encode($self->_id());
	}
	my $result = $self->{'_client'}->request($method, $path, $r);
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

#!/usr/bin/perl

package Saclient::Cloud::Model::Model;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Cloud::Client;
use Saclient::Cloud::Resource::Resource;


=pod

=encoding utf8

=head1 Saclient::Cloud::Model::Model

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

sub get_params {
	my $self = shift;
	return $self->{'_params'};
}

sub params {
	return $_[0]->get_params();
}

my $_total;

sub get_total {
	my $self = shift;
	return $self->{'_total'};
}

sub total {
	return $_[0]->get_total();
}

my $_count;

sub get_count {
	my $self = shift;
	return $self->{'_count'};
}

sub count {
	return $_[0]->get_count();
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

sub _class_name {
	my $self = shift;
	return undef;
}

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $client = shift;
	$self->{'_client'} = $client;
	$self->{'_params'} = {};
	$self->{'_total'} = undef;
	$self->{'_count'} = undef;
	return $self;
}

sub _offset {
	my $self = shift;
	my $offset = shift;
	$self->{'_params'}->{"Begin"} = $offset;
	return $self;
}

sub _limit {
	my $self = shift;
	my $count = shift;
	$self->{'_params'}->{"Count"} = $count;
	return $self;
}

sub _filter_by {
	my $self = shift;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	if (!(ref($self->{'_params'}) eq 'HASH' && exists $self->{'_params'}->{"Filter"})) {
		$self->{'_params'}->{"Filter"} = {};
	}
	my $filter = $self->{'_params'}->{"Filter"};
	if ($multiple) {
		if (!(ref($filter) eq 'HASH' && exists $filter->{$key})) {
			$filter->{$key} = [];
		}
		my $values = $filter->{$key};
		push(@{$values}, $value);
	}
	else {
		$filter->{$key} = $value;
	}
	return $self;
}

sub _reset {
	my $self = shift;
	$self->{'_params'} = {};
	$self->{'_total'} = 0;
	$self->{'_count'} = 0;
	return $self;
}

sub _create {
	my $self = shift;
	return Saclient::Cloud::Util::create_class_instance("saclient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, undef]);
}

sub _get_by_id {
	my $self = shift;
	my $id = shift;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saclient::Cloud::Util::url_encode($id), $params);
	$self->{'_total'} = 1;
	$self->{'_count'} = 1;
	my $record = $result->{$self->_root_key()};
	return Saclient::Cloud::Util::create_class_instance("saclient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $record]);
}

sub _find {
	my $self = shift;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	$self->{'_total'} = $result->{"Total"};
	$self->{'_count'} = $result->{"Count"};
	my $records = $result->{$self->_root_key_m()};
	my $data = [];
	foreach my $record (@{$records}) {
		my $i = Saclient::Cloud::Util::create_class_instance("saclient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $record]);
		push(@{$data}, $i);
	}
	return $data;
}

sub _find_one {
	my $self = shift;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	$self->{'_total'} = $result->{"Total"};
	$self->{'_count'} = $result->{"Count"};
	if ($self->{'_total'} == 0) {
		return undef;
	}
	my $records = $result->{$self->_root_key_m()};
	return Saclient::Cloud::Util::create_class_instance("saclient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $records->[0]]);
}

1;

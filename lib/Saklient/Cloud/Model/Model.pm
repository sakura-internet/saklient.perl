#!/usr/bin/perl

package Saklient::Cloud::Model::Model;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;


=pod

=encoding utf8

=head1 Saklient::Cloud::Model::Model

@ignore

=cut


my $_client;

sub get_client {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_client'};
}

sub client {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#client");
		throw $ex;
	}
	return $_[0]->get_client();
}

my $_params;

sub get_params {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_params'};
}

sub params {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#params");
		throw $ex;
	}
	return $_[0]->get_params();
}

my $_total;

sub get_total {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_total'};
}

sub total {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#total");
		throw $ex;
	}
	return $_[0]->get_total();
}

my $_count;

sub get_count {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_count'};
}

sub count {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Model::Model#count");
		throw $ex;
	}
	return $_[0]->get_count();
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

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_client'} = $client;
	$self->{'_params'} = {};
	$self->{'_total'} = undef;
	$self->{'_count'} = undef;
	return $self;
}

sub _offset {
	my $self = shift;
	my $_argnum = scalar @_;
	my $offset = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($offset, "int");
	$self->{'_params'}->{"Begin"} = $offset;
	return $self;
}

sub _limit {
	my $self = shift;
	my $_argnum = scalar @_;
	my $count = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($count, "int");
	$self->{'_params'}->{"Count"} = $count;
	return $self;
}

sub _sort {
	my $self = shift;
	my $_argnum = scalar @_;
	my $column = shift;
	my $reverse = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($column, "string");
	Saklient::Util::validate_type($reverse, "bool");
	if (!(ref($self->{'_params'}) eq 'HASH' && exists $self->{'_params'}->{"Sort"})) {
		$self->{'_params'}->{"Sort"} = [];
	}
	my $sort = $self->{'_params'}->{"Sort"};
	my $op = $reverse ? "-" : "";
	push(@{$sort}, $op . $column);
	return $self;
}

sub _filter_by {
	my $self = shift;
	my $_argnum = scalar @_;
	my $key = shift;
	my $value = shift;
	my $multiple = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($key, "string");
	Saklient::Util::validate_type($multiple, "bool");
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
	my $_argnum = scalar @_;
	$self->{'_params'} = {};
	$self->{'_total'} = 0;
	$self->{'_count'} = 0;
	return $self;
}

sub _create {
	my $self = shift;
	my $_argnum = scalar @_;
	return Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, undef]);
}

sub _get_by_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($id, "string");
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path() . "/" . Saklient::Util::url_encode($id), $params);
	$self->{'_total'} = 1;
	$self->{'_count'} = 1;
	return Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [
		$self->{'_client'},
		$result,
		1
	]);
}

sub _find {
	my $self = shift;
	my $_argnum = scalar @_;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	$self->{'_total'} = $result->{"Total"};
	$self->{'_count'} = $result->{"Count"};
	my $records = $result->{$self->_root_key_m()};
	my $data = [];
	foreach my $record (@{$records}) {
		my $i = Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $record]);
		push(@{$data}, $i);
	}
	return $data;
}

sub _find_one {
	my $self = shift;
	my $_argnum = scalar @_;
	my $params = $self->{'_params'};
	$self->_reset();
	my $result = $self->{'_client'}->request("GET", $self->_api_path(), $params);
	$self->{'_total'} = $result->{"Total"};
	$self->{'_count'} = $result->{"Count"};
	if ($self->{'_total'} == 0) {
		return undef;
	}
	my $records = $result->{$self->_root_key_m()};
	return Saklient::Util::create_class_instance("saklient.cloud.resource." . $self->_class_name(), [$self->{'_client'}, $records->[0]]);
}

sub _with_name_like {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	return $self->_filter_by("Name", $name);
}

sub _with_tag {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tag = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tag, "string");
	return $self->_filter_by("Tags.Name", $tag, 1);
}

sub _with_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $tags = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($tags, "ARRAY");
	return $self->_filter_by("Tags.Name", $tags, 1);
}

sub _sort_by_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reverse = shift || (0);
	Saklient::Util::validate_type($reverse, "bool");
	return $self->_sort("Name", $reverse);
}

1;

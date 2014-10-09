#!/usr/bin/perl

package Saklient::Cloud::Models::QueryParams;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;



#** @var public int Saklient::Cloud::Models::QueryParams::$begin 
# 
# @brief null
#*
my $begin;
sub begin {
	$_[0]->{"begin"} = $_[1] if scalar(@_);
		return $_[0]->{"begin"};
	}

#** @var public int Saklient::Cloud::Models::QueryParams::$count 
# 
# @brief null
#*
my $count;
sub count {
	$_[0]->{"count"} = $_[1] if scalar(@_);
		return $_[0]->{"count"};
	}

#** @var public any Saklient::Cloud::Models::QueryParams::$filter 
# 
# @brief null
#*
my $filter;
sub filter {
	$_[0]->{"filter"} = $_[1] if scalar(@_);
		return $_[0]->{"filter"};
	}

#** @var public string* Saklient::Cloud::Models::QueryParams::$sort 
# 
# @brief null
#*
my $sort;
sub sort {
	$_[0]->{"sort"} = $_[1] if scalar(@_);
		return $_[0]->{"sort"};
	}

#** @method public void new 
# 
# @brief null
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	$self->{'begin'} = 0;
	$self->{'count'} = 0;
	$self->{'filter'} = {};
	$self->{'sort'} = [];
	return $self;
}

#** @method public any build 
# 
# @brief null
#*
sub build {
	my $self = shift;
	my $_argnum = scalar @_;
	return {
		'From' => $self->{'begin'},
		'Count' => $self->{'count'},
		'Filter' => $self->{'filter'},
		'Sort' => $self->{'sort'}
	};
}

1;

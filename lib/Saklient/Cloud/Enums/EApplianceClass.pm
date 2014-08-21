#!/usr/bin/perl

package Saklient::Cloud::Enums::EApplianceClass;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

#** @class Saklient::Cloud::Enums::EApplianceClass
# 
# @brief アプライアンスのクラスを表す列挙子。
#*

our $_map = {
	"loadbalancer" => 10,
	"vpcrouter" => 20
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"loadbalancer"} = "loadbalancer";
	$self->{"vpcrouter"} = "vpcrouter";
	return $self;
};


#** public
# 
# @brief null
#*
sub loadbalancer { "loadbalancer"; }

#** public
# 
# @brief null
#*
sub vpcrouter { "vpcrouter"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EApplianceClass';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

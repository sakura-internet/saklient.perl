#!/usr/bin/perl

package Saklient::Cloud::Enums::EServerInstanceStatus;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

#** @class Saklient::Cloud::Enums::EServerInstanceStatus
# 
# @brief サーバの起動状態を表す列挙子。
#*

our $_map = {
	"down" => 0,
	"cleaning" => 5,
	"up" => 100
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"down"} = "down";
	$self->{"cleaning"} = "cleaning";
	$self->{"up"} = "up";
	return $self;
};


#** public
# 
# @brief null
#*
sub down { "down"; }

#** public
# 
# @brief null
#*
sub cleaning { "cleaning"; }

#** public
# 
# @brief null
#*
sub up { "up"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EServerInstanceStatus';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

#!/usr/bin/perl

package Saklient::Cloud::Enums::EAvailability;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

#** @class Saklient::Cloud::Enums::EAvailability
# 
# @brief リソースの有効性を表す列挙子。
#*

our $_map = {
	"selectable" => 69,
	"migrating" => 70,
	"precreate" => 71,
	"replicating" => 72,
	"transfering" => 73,
	"stopped" => 75,
	"failed" => 78,
	"charged" => 79,
	"uploading" => 80,
	"available" => 100
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"selectable"} = "selectable";
	$self->{"migrating"} = "migrating";
	$self->{"precreate"} = "precreate";
	$self->{"replicating"} = "replicating";
	$self->{"transfering"} = "transfering";
	$self->{"stopped"} = "stopped";
	$self->{"failed"} = "failed";
	$self->{"charged"} = "charged";
	$self->{"uploading"} = "uploading";
	$self->{"available"} = "available";
	return $self;
};


#** public
# 
# @brief null
#*
sub selectable { "selectable"; }

#** public
# 
# @brief null
#*
sub migrating { "migrating"; }

#** public
# 
# @brief null
#*
sub precreate { "precreate"; }

#** public
# 
# @brief null
#*
sub replicating { "replicating"; }

#** public
# 
# @brief null
#*
sub transfering { "transfering"; }

#** public
# 
# @brief null
#*
sub stopped { "stopped"; }

#** public
# 
# @brief null
#*
sub failed { "failed"; }

#** public
# 
# @brief null
#*
sub charged { "charged"; }

#** public
# 
# @brief null
#*
sub uploading { "uploading"; }

#** public
# 
# @brief null
#*
sub available { "available"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EAvailability';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

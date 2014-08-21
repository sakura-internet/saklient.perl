#!/usr/bin/perl

package Saklient::Cloud::Enums::EScriptClass;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;

#** @class Saklient::Cloud::Enums::EScriptClass
# 
# @brief スクリプトのクラスを表す列挙子。
#*

our $_map = {
	"shell" => 200,
	"ansible" => 300
};

sub new {
	my $self = bless {}, $_[0];
	$self->{"shell"} = "shell";
	$self->{"ansible"} = "ansible";
	return $self;
};


#** public
# 
# @brief null
#*
sub shell { "shell"; }

#** public
# 
# @brief null
#*
sub ansible { "ansible"; }

sub compare {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Enums::EScriptClass';
	my $l = defined($_[0]) ? $_map->{$_[0]} : undef;
	my $r = defined($_[1]) ? $_map->{$_[1]} : undef;
	return undef if !defined($l) || !defined($r);
	my $ret = $l - $r;
	return (0 < $ret) - ($ret < 0);
}

1;

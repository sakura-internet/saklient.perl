#!/usr/bin/perl

package Saklient::Cloud::Resources::LoadBalancer;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Errors::SaklientException;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resources::Appliance;

use base qw(Saklient::Cloud::Resources::Appliance);

#** @class Saklient::Cloud::Resources::LoadBalancer
# 
# @brief ロードバランサの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @method public void new ($client, $obj, $wrapped)
# 
# @ignore @param {Saklient::Cloud::Client} client
# @param bool $wrapped
#*
sub new {
	my $class = shift;
	my $self;
	my $_argnum = scalar @_;
	my $client = shift;
	my $obj = shift;
	my $wrapped = shift || (0);
	$self = $class->SUPER::new($client, $obj, $wrapped);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	return $self;
}

1;

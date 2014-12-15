#!/usr/bin/perl

package Saklient::Cloud::Facility;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Models::Model_Region;
use Saklient::Cloud::Client;


#** @class Saklient::Cloud::Facility
# 
# @brief 設備情報にアクセスするためのモデルを集めたクラス。
#*


#** @var private Saklient::Cloud::Models::Model_Region Saklient::Cloud::Facility::$_region 
# 
# @private
#*
my $_region;

#** @method private Saklient::Cloud::Models::Model_Region get_region 
# 
# @brief null
#*
sub get_region {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_region'};
}

#** @method public Saklient::Cloud::Models::Model_Region region ()
# 
# @brief リージョン情報。
#*
sub region {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Facility#region");
		throw $ex;
	}
	return $_[0]->get_region();
}

#** @method public void new ($client)
# 
# @ignore
# @param Client $client
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_region'} = new Saklient::Cloud::Models::Model_Region($client);
	return $self;
}

1;

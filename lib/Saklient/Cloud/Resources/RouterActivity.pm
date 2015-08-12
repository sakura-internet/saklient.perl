#!/usr/bin/perl

package Saklient::Cloud::Resources::RouterActivity;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Resources::Activity;
use Saklient::Cloud::Resources::RouterActivitySample;

use base qw(Saklient::Cloud::Resources::Activity);


#** @var private Saklient::Cloud::Resources::RouterActivitySample* Saklient::Cloud::Resources::RouterActivity::$_samples 
# 
# @private
#*
my $_samples;

#** @method private Saklient::Cloud::Resources::RouterActivitySample[] get_samples 
# 
# @brief null
#*
sub get_samples {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_samples'};
}

#** @method public Saklient::Cloud::Resources::RouterActivitySample[] samples ()
# 
# @brief サンプル列
#*
sub samples {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::RouterActivity#samples");
		throw $ex;
	}
	return $_[0]->get_samples();
}

#** @method private string _api_path_prefix 
# 
# @private
#*
sub _api_path_prefix {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/internet";
}

#** @method private void _add_sample ($atStr, $data)
# 
# @private@param {string} atStr
#*
sub _add_sample {
	my $self = shift;
	my $_argnum = scalar @_;
	my $atStr = shift;
	my $data = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($atStr, "string");
	push(@{$self->{'_samples'}}, new Saklient::Cloud::Resources::RouterActivitySample($atStr, $data));
}

#** @method public Saklient::Cloud::Resources::RouterActivity fetch ($startDate, $endDate)
# 
# @brief 現在の最新のアクティビティ情報を取得し、samplesに格納します。
#  
#  	 * @return this
# 
# @param NativeDate $startDate
# @param NativeDate $endDate
#*
sub fetch {
	my $self = shift;
	my $_argnum = scalar @_;
	my $startDate = shift || (undef);
	my $endDate = shift || (undef);
	Saklient::Util::validate_type($startDate, "DateTime");
	Saklient::Util::validate_type($endDate, "DateTime");
	$self->{'_samples'} = [];
	return $self->_fetch($startDate, $endDate);
}

1;

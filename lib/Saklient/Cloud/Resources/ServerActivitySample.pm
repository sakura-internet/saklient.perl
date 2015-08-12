#!/usr/bin/perl

package Saklient::Cloud::Resources::ServerActivitySample;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;



#** @var private NativeDate Saklient::Cloud::Resources::ServerActivitySample::$_at 
# 
# @private
#*
my $_at;

#** @method public NativeDate get_at 
# 
# @brief null
#*
sub get_at {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_at'};
}

#** @method public NativeDate at ()
# 
# @brief 記録日時
#*
sub at {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerActivitySample#at");
		throw $ex;
	}
	return $_[0]->get_at();
}

#** @var private bool Saklient::Cloud::Resources::ServerActivitySample::$_is_available 
# 
# @private
#*
my $_is_available;

#** @method public bool get_is_available 
# 
# @brief null
#*
sub get_is_available {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_is_available'};
}

#** @method public bool is_available ()
# 
# @brief 有効な値のとき真
#*
sub is_available {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerActivitySample#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

#** @var private double Saklient::Cloud::Resources::ServerActivitySample::$_cpu_time 
# 
# @private
#*
my $_cpu_time;

#** @method public double get_cpu_time 
# 
# @brief null
#*
sub get_cpu_time {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_cpu_time'};
}

#** @method public double cpu_time ()
# 
# @brief CPU時間
#*
sub cpu_time {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::ServerActivitySample#cpu_time");
		throw $ex;
	}
	return $_[0]->get_cpu_time();
}

#** @method public void new ($atStr, $data)
# 
# @brief null@param {string} atStr
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $atStr = shift;
	my $data = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($atStr, "string");
	$self->{'_at'} = Saklient::Util::str2date($atStr);
	$self->{'_is_available'} = 0;
	my $v = $data->{"CPU-TIME"};
	if (defined($v)) {
		$self->{'_is_available'} = 1;
		$self->{'_cpu_time'} = $v;
	}
	return $self;
}

1;

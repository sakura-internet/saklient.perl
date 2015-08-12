#!/usr/bin/perl

package Saklient::Cloud::Resources::DiskActivitySample;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;



#** @var private NativeDate Saklient::Cloud::Resources::DiskActivitySample::$_at 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::DiskActivitySample#at");
		throw $ex;
	}
	return $_[0]->get_at();
}

#** @var private bool Saklient::Cloud::Resources::DiskActivitySample::$_is_available 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::DiskActivitySample#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

#** @var private double Saklient::Cloud::Resources::DiskActivitySample::$_write 
# 
# @private
#*
my $_write;

#** @method public double get_write 
# 
# @brief null
#*
sub get_write {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_write'};
}

#** @method public double write ()
# 
# @brief ライト[BPS]
#*
sub write {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::DiskActivitySample#write");
		throw $ex;
	}
	return $_[0]->get_write();
}

#** @var private double Saklient::Cloud::Resources::DiskActivitySample::$_read 
# 
# @private
#*
my $_read;

#** @method public double get_read 
# 
# @brief null
#*
sub get_read {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_read'};
}

#** @method public double read ()
# 
# @brief リード[BPS]
#*
sub read {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::DiskActivitySample#read");
		throw $ex;
	}
	return $_[0]->get_read();
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
	$self->{'_is_available'} = 1;
	my $v = undef;
	$v = $data->{"Write"};
	if (!defined($v)) {
		$self->{'_is_available'} = 0;
	}
	else {
		$self->{'_write'} = $v;
	}
	$v = $data->{"Read"};
	if (!defined($v)) {
		$self->{'_is_available'} = 0;
	}
	else {
		$self->{'_read'} = $v;
	}
	return $self;
}

1;

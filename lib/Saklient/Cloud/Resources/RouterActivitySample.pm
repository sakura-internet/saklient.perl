#!/usr/bin/perl

package Saklient::Cloud::Resources::RouterActivitySample;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;



#** @var private NativeDate Saklient::Cloud::Resources::RouterActivitySample::$_at 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::RouterActivitySample#at");
		throw $ex;
	}
	return $_[0]->get_at();
}

#** @var private bool Saklient::Cloud::Resources::RouterActivitySample::$_is_available 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::RouterActivitySample#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

#** @var private double Saklient::Cloud::Resources::RouterActivitySample::$_outgoing 
# 
# @private
#*
my $_outgoing;

#** @method public double get_outgoing 
# 
# @brief null
#*
sub get_outgoing {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_outgoing'};
}

#** @method public double outgoing ()
# 
# @brief 送信[BPS]
#*
sub outgoing {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::RouterActivitySample#outgoing");
		throw $ex;
	}
	return $_[0]->get_outgoing();
}

#** @var private double Saklient::Cloud::Resources::RouterActivitySample::$_incoming 
# 
# @private
#*
my $_incoming;

#** @method public double get_incoming 
# 
# @brief null
#*
sub get_incoming {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_incoming'};
}

#** @method public double incoming ()
# 
# @brief 受信[BPS]
#*
sub incoming {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::RouterActivitySample#incoming");
		throw $ex;
	}
	return $_[0]->get_incoming();
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
	$v = $data->{"Out"};
	if (!defined($v)) {
		$self->{'_is_available'} = 0;
	}
	else {
		$self->{'_outgoing'} = $v;
	}
	$v = $data->{"In"};
	if (!defined($v)) {
		$self->{'_is_available'} = 0;
	}
	else {
		$self->{'_incoming'} = $v;
	}
	return $self;
}

1;

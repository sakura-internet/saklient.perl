#!/usr/bin/perl

package Saklient::Cloud::Resources::IfaceActivitySample;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;



#** @var private NativeDate Saklient::Cloud::Resources::IfaceActivitySample::$_at 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::IfaceActivitySample#at");
		throw $ex;
	}
	return $_[0]->get_at();
}

#** @var private bool Saklient::Cloud::Resources::IfaceActivitySample::$_is_available 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::IfaceActivitySample#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

#** @var private double Saklient::Cloud::Resources::IfaceActivitySample::$_send 
# 
# @private
#*
my $_send;

#** @method public double get_send 
# 
# @brief null
#*
sub get_send {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_send'};
}

#** @method public double send ()
# 
# @brief 送信[byte/sec]
#*
sub send {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::IfaceActivitySample#send");
		throw $ex;
	}
	return $_[0]->get_send();
}

#** @var private double Saklient::Cloud::Resources::IfaceActivitySample::$_receive 
# 
# @private
#*
my $_receive;

#** @method public double get_receive 
# 
# @brief null
#*
sub get_receive {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_receive'};
}

#** @method public double receive ()
# 
# @brief 受信[byte/sec]
#*
sub receive {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::IfaceActivitySample#receive");
		throw $ex;
	}
	return $_[0]->get_receive();
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
	$v = $data->{"Send"};
	if (!defined($v)) {
		$self->{'_is_available'} = 0;
	}
	else {
		$self->{'_send'} = $v;
	}
	$v = $data->{"Receive"};
	if (!defined($v)) {
		$self->{'_is_available'} = 0;
	}
	else {
		$self->{'_receive'} = $v;
	}
	return $self;
}

1;

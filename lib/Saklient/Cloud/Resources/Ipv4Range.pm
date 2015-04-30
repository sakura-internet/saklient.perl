#!/usr/bin/perl

package Saklient::Cloud::Resources::Ipv4Range;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;


#** @class Saklient::Cloud::Resources::Ipv4Range
# 
# @brief IPv4ネットワークのIPアドレス範囲。
#*


#** @var private string Saklient::Cloud::Resources::Ipv4Range::$_first 
# 
# @private
#*
my $_first;

#** @method public string get_first 
# 
# @brief null
#*
sub get_first {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_first'};
}

#** @method public string first ()
# 
# @brief 開始アドレス
#*
sub first {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Range#first");
		throw $ex;
	}
	return $_[0]->get_first();
}

#** @var private string Saklient::Cloud::Resources::Ipv4Range::$_last 
# 
# @private
#*
my $_last;

#** @method public string get_last 
# 
# @brief null
#*
sub get_last {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_last'};
}

#** @method public string last ()
# 
# @brief 終了アドレス
#*
sub last {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Range#last");
		throw $ex;
	}
	return $_[0]->get_last();
}

#** @var private string* Saklient::Cloud::Resources::Ipv4Range::$_as_array 
# 
# @private
#*
my $_as_array;

#** @method public string[] get_as_array 
# 
# @brief null
#*
sub get_as_array {
	my $self = shift;
	my $_argnum = scalar @_;
	my $ret = [];
	my $i = Saklient::Util::ip2long($self->{'_first'});
	my $i1 = Saklient::Util::ip2long($self->{'_last'});
	while ($i <= $i1) {
		push(@{$ret}, Saklient::Util::long2ip($i));
		$i++;
	}
	return $ret;
}

#** @method public string[] as_array ()
# 
# @brief この範囲に属するIPv4アドレスの一覧を取得します。
#*
sub as_array {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Ipv4Range#as_array");
		throw $ex;
	}
	return $_[0]->get_as_array();
}

#** @method public void new ($obj)
# 
# @ignore
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $obj = shift || (undef);
	if (!defined($obj)) {
		$obj = {};
	}
	my $first = Saklient::Util::get_by_path_any([$obj], ["Min", "min"]);
	$self->{'_first'} = undef;
	if (defined($first)) {
		$self->{'_first'} = $first;
	}
	if (defined($self->{'_first'}) && $self->{'_first'} eq "") {
		$self->{'_first'} = undef;
	}
	my $last = Saklient::Util::get_by_path_any([$obj], ["Max", "max"]);
	$self->{'_last'} = undef;
	if (defined($last)) {
		$self->{'_last'} = $last;
	}
	if (defined($self->{'_last'}) && $self->{'_last'} eq "") {
		$self->{'_last'} = undef;
	}
	return $self;
}

1;

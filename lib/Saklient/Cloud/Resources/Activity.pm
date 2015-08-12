#!/usr/bin/perl

package Saklient::Cloud::Resources::Activity;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;



#** @var private Saklient::Cloud::Client Saklient::Cloud::Resources::Activity::$_client 
# 
# @private
#*
my $_client;

#** @var private string Saklient::Cloud::Resources::Activity::$_source_id 
# 
# @private
#*
my $_source_id;

#** @method private string _api_path_prefix 
# 
# @private
#*
sub _api_path_prefix {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method private string _api_path_suffix 
# 
# @private
#*
sub _api_path_suffix {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/monitor";
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
}

#** @method public void new ($client)
# 
# @ignore @param {Saklient::Cloud::Client} client
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_client'} = $client;
	return $self;
}

#** @method public void set_source_id ($id)
# 
# @ignore @param {string} id
#*
sub set_source_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($id, "string");
	$self->{'_source_id'} = $id;
}

#** @method public Saklient::Cloud::Resources::Activity _fetch ($startDate, $endDate)
# 
# @brief 現在の最新のアクティビティ情報を取得し、samplesに格納します。
#  
#  	 * @return this
# 
# @private
# @param NativeDate $startDate
# @param NativeDate $endDate
#*
sub _fetch {
	my $self = shift;
	my $_argnum = scalar @_;
	my $startDate = shift || (undef);
	my $endDate = shift || (undef);
	Saklient::Util::validate_type($startDate, "DateTime");
	Saklient::Util::validate_type($endDate, "DateTime");
	my $query = {};
	if (defined($startDate)) {
		$query->{"Start"} = Saklient::Util::date2str($startDate);
	}
	if (defined($endDate)) {
		$query->{"End"} = Saklient::Util::date2str($endDate);
	}
	my $path = $self->_api_path_prefix() . "/" . Saklient::Util::url_encode($self->{'_source_id'}) . $self->_api_path_suffix();
	my $data = $self->{'_client'}->request("GET", $path);
	if (!defined($data)) {
		return undef;
	}
	$data = $data->{"Data"};
	if (!defined($data)) {
		return undef;
	}
	my $dates = [keys %{$data}];
	$dates = [sort @{$dates}];
	foreach my $date (@{$dates}) {
		$self->_add_sample($date, $data->{$date});
	}
	return $self;
}

1;

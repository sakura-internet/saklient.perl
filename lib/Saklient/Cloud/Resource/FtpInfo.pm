#!/usr/bin/perl

package Saklient::Cloud::Resource::FtpInfo;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;


#** @class Saklient::Cloud::Resource::FtpInfo
# 
# @brief FTPサーバのアカウント情報。
#*


#** @var private string Saklient::Cloud::Resource::FtpInfo::$_host_name 
# 
# @private
#*
my $_host_name;

#** @method public string get_host_name 
# 
# @brief null
#*
sub get_host_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_host_name'};
}

#** @method public string host_name ()
# 
# @brief ホスト名
#*
sub host_name {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::FtpInfo#host_name");
		throw $ex;
	}
	return $_[0]->get_host_name();
}

#** @var private string Saklient::Cloud::Resource::FtpInfo::$_user 
# 
# @private
#*
my $_user;

#** @method public string get_user 
# 
# @brief null
#*
sub get_user {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_user'};
}

#** @method public string user ()
# 
# @brief ユーザ名
#*
sub user {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::FtpInfo#user");
		throw $ex;
	}
	return $_[0]->get_user();
}

#** @var private string Saklient::Cloud::Resource::FtpInfo::$_password 
# 
# @private
#*
my $_password;

#** @method public string get_password 
# 
# @brief null
#*
sub get_password {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_password'};
}

#** @method public string password ()
# 
# @brief パスワード
#*
sub password {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::FtpInfo#password");
		throw $ex;
	}
	return $_[0]->get_password();
}

#** @method public void new ($obj)
# 
# @ignore
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $obj = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	$self->{'_host_name'} = $obj->{"HostName"};
	$self->{'_user'} = $obj->{"User"};
	$self->{'_password'} = $obj->{"Password"};
	return $self;
}

1;

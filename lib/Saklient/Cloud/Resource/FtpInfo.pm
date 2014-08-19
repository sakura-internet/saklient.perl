#!/usr/bin/perl

package Saklient::Cloud::Resource::FtpInfo;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;


=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::FtpInfo

FTPサーバのアカウント情報。

=cut


my $_host_name;

sub get_host_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_host_name'};
}

=head2 host_name

ホスト名

=cut
sub host_name {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::FtpInfo#host_name");
		throw $ex;
	}
	return $_[0]->get_host_name();
}

my $_user;

sub get_user {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_user'};
}

=head2 user

ユーザ名

=cut
sub user {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::FtpInfo#user");
		throw $ex;
	}
	return $_[0]->get_user();
}

my $_password;

sub get_password {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_password'};
}

=head2 password

パスワード

=cut
sub password {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::FtpInfo#password");
		throw $ex;
	}
	return $_[0]->get_password();
}

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

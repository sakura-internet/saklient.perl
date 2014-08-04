#!/usr/bin/perl

package Saclient::Errors::HttpException;

use strict;
use warnings;
use Error qw(:try);

use base qw(Error::Simple);
use overload ('""' => 'stringify');

=pod

=encoding utf8

=cut

sub new {
	my $class = shift;
	my $status = shift;
	my $code = shift || undef;
	my $message = shift || "";
	local $Error::Depth = $Error::Depth + 3;
	local $Error::Debug = 1;
	my $self = $class->SUPER::new($message);
	$self->{'status'} = $status;
	$self->{'code'} = $code;
	$self->{'message'} = $message;
	return $self;
}

sub status { $_[0]->{'status'}; }
sub code { $_[0]->{'code'}; }
sub message { $_[0]->{'message'}; }

1;

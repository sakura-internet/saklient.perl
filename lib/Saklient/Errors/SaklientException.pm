#!/usr/bin/perl

package Saklient::Errors::SaklientException;

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
	my $code = shift || undef;
	my $message = shift || "";
	local $Error::Depth = $Error::Depth + 2;
	local $Error::Debug = 1;
	my $self = $class->SUPER::new($message);
	$self->{'code'} = $code;
	$self->{'message'} = $message;
	return $self;
}

sub code { $_[0]->{'code'}; }
sub message { $_[0]->{'message'}; }

1;

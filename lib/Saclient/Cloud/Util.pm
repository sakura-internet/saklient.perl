#!/usr/bin/perl

package Saclient::Cloud::Util;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use URI::Escape;
use DateTime::Format::Strptime;


=pod

=encoding utf8

=cut

sub create_class_instance {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $classPath = shift;
	my $args = shift;
	my $ret = undef;
	$classPath =~ s/\./::/g;
	$classPath =~ s/(:|^)([a-z])/$1.uc($2)/eg;
	$ret = new $classPath(@$args);
	if (!defined($ret)) {
		throw Error::Simple("Could not create class instance of " . $classPath);
	}
	return $ret;
}

sub str2date {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $s = shift;
	if (!defined($s)) {
		return undef;
	}
	$s =~ s/([+-][0-9]{2}):([0-9]{2})$/$1$2/;
	return DateTime::Format::Strptime->new(pattern=>"%Y-%m-%dT%H:%M:%S%z")->parse_datetime($s);
}

sub date2str {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $d = shift;
	if (!defined($d)) {
		return undef;
	}
	my $s = $d->strftime("%Y-%m-%dT%H:%M:%S%z");
	$s =~ s/([+-][0-9]{2})([0-9]{2})$/$1:$2/;
	return $s;
}

sub url_encode {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $s = shift;
	return uri_escape($s);
}

sub cast_array {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $a = shift;
	my $clazz = shift;
	return $a;
}

1;

#!/usr/bin/perl

package Saclient::Util;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saclient::Errors::SaclientException;
use URI::Escape;
use DateTime::Format::Strptime;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(exists_path get_by_path set_by_path create_class_instance);


=pod

=encoding utf8

=cut

sub exists_path {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $obj = shift;
	my $path = shift;
	my $aPath = [split(quotemeta("."), $path)];
	foreach my $seg (@{$aPath}) {
		if (!defined($obj)) {
			return 0;
		}
		if (ref($obj) ne 'HASH') {
			return 0;
		}
		if ($seg eq "") {
			next;
		}
		if (!(ref($obj) eq 'HASH' && exists $obj->{$seg})) {
			return 0;
		}
		$obj = $obj->{$seg};
	}
	return 1;
}

sub get_by_path {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $obj = shift;
	my $path = shift;
	my $aPath = [split(quotemeta("."), $path)];
	foreach my $seg (@{$aPath}) {
		if (!defined($obj)) {
			return undef;
		}
		if (ref($obj) ne 'HASH') {
			return undef;
		}
		if ($seg eq "") {
			next;
		}
		if (!(ref($obj) eq 'HASH' && exists $obj->{$seg})) {
			return undef;
		}
		$obj = $obj->{$seg};
	}
	return $obj;
}

=head2 set_by_path($obj, string $path, $value) : void

@todo array support
@todo overwriting
@todo writing into children of non-object

=cut
sub set_by_path {
	shift if 3 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $obj = shift;
	my $path = shift;
	my $value = shift;
	my $aPath = [split(quotemeta("."), $path)];
	my $key = pop(@{$aPath});
	foreach my $seg (@{$aPath}) {
		if ($seg eq "") {
			next;
		}
		if (!(ref($obj) eq 'HASH' && exists $obj->{$seg})) {
			$obj->{$seg} = {};
		}
		$obj = $obj->{$seg};
	}
	$obj->{$key} = $value;
}

sub create_class_instance {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
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
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $s = shift;
	if (!defined($s)) {
		return undef;
	}
	$s =~ s/([+-][0-9]{2}):([0-9]{2})$/$1$2/;
	return DateTime::Format::Strptime->new(pattern=>"%Y-%m-%dT%H:%M:%S%z")->parse_datetime($s);
}

sub date2str {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $d = shift;
	if (!defined($d)) {
		return undef;
	}
	my $s = $d->strftime("%Y-%m-%dT%H:%M:%S%z");
	$s =~ s/([+-][0-9]{2})([0-9]{2})$/$1:$2/;
	return $s;
}

sub url_encode {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $s = shift;
	return uri_escape($s);
}

sub sleep {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $sec = shift;
	sleep($sec);
}

sub validate_arg_count {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $actual = shift;
	my $expected = shift;
	if ($actual < $expected) {
		my $ex = new Saclient::Errors::SaclientException('argument_count_mismatch', 'Argument count mismatch');
		throw $ex;
	}
}

sub validate_type {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Util';
	my $value = shift;
	my $typeName = shift;
	my $force = shift;
	my $isOk = 0;
	if (!$force) {
		return if $typeName eq 'any' || $typeName eq 'void' || !defined($value);
		if ($typeName eq 'int' || $typeName eq 'double' || $typeName eq 'bool' || $typeName eq 'string') {
			$isOk = !ref($value);
		}
		else {
			# ($typeName eq 'ARRAY' || $typeName eq 'HASH' || $typeName eq 'CODE' || $typeName eq 'REF' || $typeName eq 'GLOB' || $typeName eq 'SCALAR') ||...
			$isOk = ref($value) eq $typeName;
		}
	}
	unless ($isOk) {
		my $ex = new Saclient::Errors::SaclientException('argument_type_mismatch', 'Argument type mismatch (expected '.$typeName.')');
		throw $ex;
	}
}

1;

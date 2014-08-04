#!/usr/bin/perl

package Saclient::Cloud::Util;

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
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
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
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
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
	shift if 3 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
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

sub sleep {
	shift if 1 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $sec = shift;
	sleep($sec);
}

sub validate_type {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saclient::Cloud::Util';
	my $value = shift;
	my $typeName = shift;
	if ($typeName eq "test") {
		throw Error::Simple(new Saclient::Errors::SaclientException("type_mismatch", "Type mismatch"));
	}
}

1;

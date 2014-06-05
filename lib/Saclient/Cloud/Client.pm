#!/usr/bin/perl

package Saclient::Cloud::Client;

use strict;
use HTTP::Request;
use LWP::UserAgent;
use MIME::Base64;
use URI::Escape;
use JSON;
use Data::Dumper;

sub println {
	my $msg = shift;
	printf ::STDERR "%s\n", $msg;
}

my $config;

sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $token = shift;
	my $secret = shift;
	$self->{config} = {};
	$self->{config}->{apiRoot} = "https://secure.sakura.ad.jp/cloud/";
	$self->{config}->{apiRootSuffix} = undef;
	$self->setAccessKey($token, $secret);
	return $self;
}

sub cloneInstance {
	my $self = shift;
	my $c = saclient::cloud::Client->new($self->{config}->{token}, $self->{config}->{secret});
	$c->{config}->{apiRoot} = $self->{config}->{apiRoot};
	$c->{config}->{apiRootSuffix} = $self->{config}->{apiRootSuffix};
	return $c;
}

sub setApiRoot {
	my $self = shift;
	my $url = shift;
	$self->{config}->{apiRoot} = $url;
}

sub setApiRootSuffix {
	my $self = shift;
	my $suffix = shift;
	$self->{config}->{apiRootSuffix} = $suffix;
}

sub setAccessKey {
	my $self = shift;
	my $token = shift;
	my $secret = shift;
	$self->{config}->{token} = $token;
	$self->{config}->{secret} = $secret;
	$self->{config}->{authorization} = "Basic " . encode_base64($token.":".$secret);
}

sub request {
	my $self = shift;
	my $method = shift;
	my $path = shift;
	my $params = shift;
	$method = uc $method;
	$path =~ s|^/?|/|;
	my $json = defined($params) ? JSON->new->utf8(1)->encode($params) : undef;
	#print STDERR "// parameter: " . $json . "\n";
	if ($method eq "GET") {
		$path .= "?" . uri_escape($json) if defined $json;
		$json = undef;
	}
	unless ($path =~ /^http/) {
		my $urlRoot = $self->{config}->{apiRoot};
		if (defined $self->{config}->{apiRootSuffix}) {
			if ($self->{config}->{apiRootSuffix} =~ /is1[v-z]/) {
				$urlRoot =~ s|/cloud/$|/cloud-test/|;
			}
			$urlRoot .= $self->{config}->{apiRootSuffix};
			$urlRoot =~ s|/?$|/|;
		}
		$path = $urlRoot . 'api/cloud/1.1' . $path;
	}
	#print STDERR "// APIリクエスト中: ".$method." ".$path, "\n";
	
	my $request = HTTP::Request->new($method ne 'GET' ? 'POST' : 'GET', $path);
	$request->header('Content-Type' => 'application/x-www-form-urlencoded');
	$request->header('Authorization' => $self->{config}->{authorization});
	$request->header('User-Agent' => 'sacloud-client-perl');
	$request->header('X-Requested-With' => 'XMLHttpRequest');
	$request->header('X-Sakura-No-Authenticate-Header' => '1');
	$request->header('X-Sakura-HTTP-Method' => $method);
	$request->header('X-Sakura-Request-Format' => 'json');
	$request->header('X-Sakura-Response-Format' => 'json');
	$request->header('X-Sakura-Error-Level' => 'warning');
	$request->content($json);
	
	my $response = LWP::UserAgent->new->request($request);
	my $resh = {};
	foreach my $h ($response->headers->header_field_names) {
		$resh->{$h} = $response->headers->header($h);
		# if (preg_match('|^HTTP/[0-9\\.]+ +(.+)|', $h, $m)) {
		# 	$resh['Status'] = $m[1];
		# }
		# else {
		# 	$h = preg_split('/ *: */', $h, 2);
		# 	if (2 <= count($h)) $resh[$h[0]] = $h[1];
		# }
	}
	#print STDERR '// > '.$response->status_line, "\n";
	#print STDERR JSON->new->utf8(0)->encode($resh), "\n";
	
	if (!$response->is_success) {
		throw Error::Simple($response->status_line);
	}
	#print STDERR $response->content, "\n";
	my $ret = undef;
	if (defined($response->content)) {
		$ret = JSON->new->utf8(0)->decode($response->content);
#		print STDERR Dumper $ret;
	}
	#print STDERR "//  -> " . $response->status, "\n";
	return $ret; #Util.localizeKeys(ret);
}

1;

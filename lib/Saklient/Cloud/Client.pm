#!/usr/bin/perl

package Saklient::Cloud::Client;

use strict;
use HTTP::Request;
use LWP::UserAgent;
use MIME::Base64;
use URI::Escape;
use JSON;
use Data::Dumper;
#use Saklient::Errors::ExceptionFactory;
use Saklient::Errors::HttpException;

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
	$self->set_access_key($token, $secret);
	return $self;
}

sub clone_instance {
	my $self = shift;
	my $c = new Saklient::Cloud::Client($self->{config}->{token}, $self->{config}->{secret});
	$c->{config}->{apiRoot} = $self->{config}->{apiRoot};
	$c->{config}->{apiRootSuffix} = $self->{config}->{apiRootSuffix};
	return $c;
}

sub set_api_root {
	my $self = shift;
	my $url = shift;
	$self->{config}->{apiRoot} = $url;
}

sub set_api_root_suffix {
	my $self = shift;
	my $suffix = shift;
	$self->{config}->{apiRootSuffix} = $suffix;
}

sub set_access_key {
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
			$urlRoot .= $self->{config}->{apiRootSuffix};
			$urlRoot =~ s|/?$|/|;
		}
		$path = $urlRoot . 'api/cloud/1.1' . $path;
	}
	#print STDERR "// APIリクエスト中: ".$method." ".$path, "\n";
	
	my $request = new HTTP::Request($method ne 'GET' ? 'POST' : 'GET', $path);
	$request->header('Content-Type' => 'application/x-www-form-urlencoded');
	$request->header('Authorization' => $self->{config}->{authorization});
	$request->header('User-Agent' => 'saklient.perl ver-0.0.2.5 rev-a581b28f8ddd2cd75cb32f710d33d3d650bba044');
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
	
	my $ret = undef;
	if (defined($response->content)) {
		$ret = JSON->new->utf8(0)->decode($response->content);
#		print STDERR Dumper $ret;
	}
	
	if (!$response->is_success) {
		$response->status_line =~ /^([0-9]+)/;
		my $status = 0 + $1;
		#my $ex = Saklient::Errors::ExceptionFactory::create($status, $ret && $ret->{error_code}, $ret && $ret->{error_msg});
		my $ex = new Saklient::Errors::HttpException($status, $ret && $ret->{error_code}, $ret && $ret->{error_msg});
		throw $ex;
	}
	
	#print STDERR $response->content, "\n";
	#print STDERR "//  -> " . $response->status, "\n";
	return $ret; #Util.localizeKeys(ret);
}

1;

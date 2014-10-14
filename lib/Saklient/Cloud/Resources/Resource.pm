#!/usr/bin/perl

package Saklient::Cloud::Resources::Resource;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;
use Saklient::Errors::HttpException;



#** @var private Saklient::Cloud::Client Saklient::Cloud::Resources::Resource::$_client 
# 
# @private
#*
my $_client;

#** @method private Saklient::Cloud::Client get_client 
# 
# @brief null
#*
sub get_client {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_client'};
}

#** @method public Saklient::Cloud::Client client ()
# 
# @ignore
#*
sub client {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resources::Resource#client");
		throw $ex;
	}
	return $_[0]->get_client();
}

#** @var private any Saklient::Cloud::Resources::Resource::$_query 
# 
# @private
#*
my $_query;

#** @method public void set_param ($key, $value)
# 
# @ignore @param {string} key
#*
sub set_param {
	my $self = shift;
	my $_argnum = scalar @_;
	my $key = shift;
	my $value = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($key, "string");
	$self->{'_query'}->{$key} = $value;
}

#** @method private string _api_path 
# 
# @private
#*
sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method private string _root_key 
# 
# @private
#*
sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method private string _root_key_m 
# 
# @private
#*
sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method public string _class_name 
# 
# @private
#*
sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @method public string _id 
# 
# @private
#*
sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
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
	$self->{'_query'} = {};
	return $self;
}

#** @var private bool Saklient::Cloud::Resources::Resource::$is_new 
# 
# @ignore
#*
my $is_new;

#** @var private bool Saklient::Cloud::Resources::Resource::$is_incomplete 
# 
# @ignore
#*
my $is_incomplete;

#** @method private void _on_before_save ($query)
# 
# @private
#*
sub _on_before_save {
	my $self = shift;
	my $_argnum = scalar @_;
	my $query = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
}

#** @method private void _on_after_api_deserialize ($r, $root)
# 
# @private
#*
sub _on_after_api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $root = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
}

#** @method private void _on_before_api_serialize ($withClean)
# 
# @private@param {bool} withClean
#*
sub _on_before_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($withClean, "bool");
}

#** @method private void _on_after_api_serialize ($r, $withClean)
# 
# @private@param {bool} withClean
#*
sub _on_after_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($withClean, "bool");
}

#** @method private void api_deserialize_impl ($r)
# 
# @ignore
#*
sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
}

#** @method public void api_deserialize ($obj, $wrapped)
# 
# @ignore @param {bool} wrapped
#*
sub api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $obj = shift;
	my $wrapped = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($wrapped, "bool");
	my $root = undef;
	my $record = undef;
	my $rkey = $self->_root_key();
	if (defined($obj)) {
		if (!$wrapped) {
			if (defined($rkey)) {
				$root = {};
				$root->{$rkey} = $obj;
			}
			$record = $obj;
		}
		else {
			$root = $obj;
			$record = $obj->{$rkey};
		}
	}
	$self->api_deserialize_impl($record);
	$self->_on_after_api_deserialize($record, $root);
}

#** @method private any api_serialize_impl ($withClean)
# 
# @ignore @param {bool} withClean
#*
sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	return undef;
}

#** @method public any api_serialize ($withClean)
# 
# @ignore @param {bool} withClean
#*
sub api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	$self->_on_before_api_serialize($withClean);
	my $ret = $self->api_serialize_impl($withClean);
	$self->_on_after_api_serialize($ret, $withClean);
	return $ret;
}

#** @method private any api_serialize_id 
# 
# @ignore
#*
sub api_serialize_id {
	my $self = shift;
	my $_argnum = scalar @_;
	my $id = $self->_id();
	if (!defined($id)) {
		return undef;
	}
	my $r = {};
	$r->{"ID"} = $id;
	return $r;
}

#** @method private string normalize_field_name ($name)
# 
# @ignore @param {string} name
#*
sub normalize_field_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	$name =~ s/([A-Z])/'_'.lc($1)/eg;
	return $name;
}

#** @method private Saklient::Cloud::Resources::Resource _save 
# 
# @brief このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新規作成または上書き保存します。
# 
# @private
# @retval this
#*
sub _save {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = $self->api_serialize();
	my $query = $self->{'_query'};
	$self->{'_query'} = {};
	my $keys = [keys %{$query}];
	foreach my $k (@{$keys}) {
		my $v = $query->{$k};
		$r->{$k} = $v;
	}
	my $method = $self->{'is_new'} ? "POST" : "PUT";
	my $path = $self->_api_path();
	if (!$self->{'is_new'}) {
		$path .= "/" . Saklient::Util::url_encode($self->_id());
	}
	my $q = {};
	$q->{$self->_root_key()} = $r;
	$self->_on_before_save($q);
	my $result = $self->{'_client'}->request($method, $path, $q);
	$self->api_deserialize($result, 1);
	return $self;
}

#** @method public void destroy 
# 
# @brief このローカルオブジェクトのIDと一致するリソースの削除リクエストをAPIに送信します。
#*
sub destroy {
	my $self = shift;
	my $_argnum = scalar @_;
	if ($self->{'is_new'}) {
		return;
	}
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id());
	$self->request_retry("DELETE", $path);
}

#** @method private Saklient::Cloud::Resources::Resource _reload 
# 
# @brief 最新のリソース情報を再取得します。
# 
# @private
# @retval this
#*
sub _reload {
	my $self = shift;
	my $_argnum = scalar @_;
	my $result = $self->request_retry("GET", $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()));
	$self->api_deserialize($result, 1);
	return $self;
}

#** @method public bool exists 
# 
# @brief このリソースが存在するかを調べます。
#*
sub exists {
	my $self = shift;
	my $_argnum = scalar @_;
	my $query = {};
	Saklient::Util::set_by_path($query, "Filter.ID", [$self->_id()]);
	Saklient::Util::set_by_path($query, "Include", ["ID"]);
	my $result = $self->request_retry("GET", $self->_api_path(), $query);
	my $cnt = $result->{"Count"};
	return Saklient::Util::num_eq($cnt, 1);
}

#** @method public any dump 
# 
# @ignore
#*
sub dump {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->api_serialize(1);
}

#** @method public string true_class_name 
# 
# @ignore
#*
sub true_class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return undef;
}

#** @cmethod public Saklient::Cloud::Resources::Resource create_with ($className, $client, $obj, $wrapped)
# 
# @ignore @param {string} className
# @param Saklient::Cloud::Client $client
# @param bool $wrapped
#*
sub create_with {
	shift if 3 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::Resources::Resource';
	my $_argnum = scalar @_;
	my $className = shift;
	my $client = shift;
	my $obj = shift;
	my $wrapped = shift || (0);
	Saklient::Util::validate_arg_count($_argnum, 3);
	Saklient::Util::validate_type($className, "string");
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	my $a = [
		$client,
		$obj,
		$wrapped
	];
	my $ret = Saklient::Util::create_class_instance("saklient.cloud.resources." . $className, $a);
	my $trueClassName = $ret->true_class_name();
	if (defined($trueClassName)) {
		$ret = Saklient::Util::create_class_instance("saklient.cloud.resources." . $trueClassName, $a);
	}
	return $ret;
}

#** @method public any request_retry ($method, $path, $query, $retryCount, $retrySleep)
# 
# @brief null@param {string} method
# 
# @param string $path
# @param int $retryCount
# @param int $retrySleep
#*
sub request_retry {
	my $self = shift;
	my $_argnum = scalar @_;
	my $method = shift;
	my $path = shift;
	my $query = shift || (undef);
	my $retryCount = shift || (5);
	my $retrySleep = shift || (5);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($method, "string");
	Saklient::Util::validate_type($path, "string");
	Saklient::Util::validate_type($retryCount, "int");
	Saklient::Util::validate_type($retrySleep, "int");
	my $ret = undef;
	while (1 < $retryCount) {
		my $isOk = 0;
		try {
			$ret = $self->{'_client'}->request($method, $path, $query);
			$isOk = 1;
		}
		catch Saklient::Errors::HttpException with {
			my $ex = shift;
			$isOk = 0;
		};
		if ($isOk) {
			$retryCount = -1;
		}
		else {
			$retryCount -= 1;
			sleep $retrySleep;
		}
	}
	if (Saklient::Util::num_eq($retryCount, 0)) {
		$ret = $self->{'_client'}->request($method, $path, $query);
	}
	return $ret;
}

1;

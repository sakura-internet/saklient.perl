#!/usr/bin/perl

package Saklient::Cloud::API;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;
use Saklient::Cloud::Product;
use Saklient::Cloud::Models::Model_Icon;
use Saklient::Cloud::Models::Model_Server;
use Saklient::Cloud::Models::Model_Disk;
use Saklient::Cloud::Models::Model_Appliance;
use Saklient::Cloud::Models::Model_Archive;
use Saklient::Cloud::Models::Model_IsoImage;
use Saklient::Cloud::Models::Model_Iface;
use Saklient::Cloud::Models::Model_Swytch;
use Saklient::Cloud::Models::Model_Router;
use Saklient::Cloud::Models::Model_Ipv6Net;
use Saklient::Cloud::Models::Model_Script;


#** @class Saklient::Cloud::API
# 
# @brief さくらのクラウドAPIクライアントを利用する際、最初にアクセスすべきルートとなるクラス。
# 
# @see API.authorize
#*


#** @var private Client Saklient::Cloud::API::$_client 
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
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#client");
		throw $ex;
	}
	return $_[0]->get_client();
}

#** @var private Product Saklient::Cloud::API::$_product 
# 
# @private
#*
my $_product;

#** @method private Saklient::Cloud::Product get_product 
# 
# @brief null
#*
sub get_product {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_product'};
}

#** @method public Saklient::Cloud::Product product ()
# 
# @brief 商品情報にアクセスするためのモデルを集めたオブジェクト。
#*
sub product {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#product");
		throw $ex;
	}
	return $_[0]->get_product();
}

#** @var private Saklient::Cloud::Models::Model_Icon Saklient::Cloud::API::$_icon 
# 
# @private
#*
my $_icon;

#** @method private Saklient::Cloud::Models::Model_Icon get_icon 
# 
# @brief null
#*
sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_icon'};
}

#** @method public Saklient::Cloud::Models::Model_Icon icon ()
# 
# @brief アイコンにアクセスするためのモデル。
#*
sub icon {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#icon");
		throw $ex;
	}
	return $_[0]->get_icon();
}

#** @var private Saklient::Cloud::Models::Model_Server Saklient::Cloud::API::$_server 
# 
# @private
#*
my $_server;

#** @method private Saklient::Cloud::Models::Model_Server get_server 
# 
# @brief null
#*
sub get_server {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_server'};
}

#** @method public Saklient::Cloud::Models::Model_Server server ()
# 
# @brief サーバにアクセスするためのモデル。
#*
sub server {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#server");
		throw $ex;
	}
	return $_[0]->get_server();
}

#** @var private Saklient::Cloud::Models::Model_Disk Saklient::Cloud::API::$_disk 
# 
# @private
#*
my $_disk;

#** @method private Saklient::Cloud::Models::Model_Disk get_disk 
# 
# @brief null
#*
sub get_disk {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_disk'};
}

#** @method public Saklient::Cloud::Models::Model_Disk disk ()
# 
# @brief ディスクにアクセスするためのモデル。
#*
sub disk {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#disk");
		throw $ex;
	}
	return $_[0]->get_disk();
}

#** @var private Saklient::Cloud::Models::Model_Appliance Saklient::Cloud::API::$_appliance 
# 
# @private
#*
my $_appliance;

#** @method private Saklient::Cloud::Models::Model_Appliance get_appliance 
# 
# @brief null
#*
sub get_appliance {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_appliance'};
}

#** @method public Saklient::Cloud::Models::Model_Appliance appliance ()
# 
# @brief アプライアンスにアクセスするためのモデル。
#*
sub appliance {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#appliance");
		throw $ex;
	}
	return $_[0]->get_appliance();
}

#** @var private Saklient::Cloud::Models::Model_Archive Saklient::Cloud::API::$_archive 
# 
# @private
#*
my $_archive;

#** @method private Saklient::Cloud::Models::Model_Archive get_archive 
# 
# @brief null
#*
sub get_archive {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_archive'};
}

#** @method public Saklient::Cloud::Models::Model_Archive archive ()
# 
# @brief アーカイブにアクセスするためのモデル。
#*
sub archive {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#archive");
		throw $ex;
	}
	return $_[0]->get_archive();
}

#** @var private Saklient::Cloud::Models::Model_IsoImage Saklient::Cloud::API::$_iso_image 
# 
# @private
#*
my $_iso_image;

#** @method private Saklient::Cloud::Models::Model_IsoImage get_iso_image 
# 
# @brief null
#*
sub get_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_iso_image'};
}

#** @method public Saklient::Cloud::Models::Model_IsoImage iso_image ()
# 
# @brief ISOイメージにアクセスするためのモデル。
#*
sub iso_image {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#iso_image");
		throw $ex;
	}
	return $_[0]->get_iso_image();
}

#** @var private Saklient::Cloud::Models::Model_Iface Saklient::Cloud::API::$_iface 
# 
# @private
#*
my $_iface;

#** @method private Saklient::Cloud::Models::Model_Iface get_iface 
# 
# @brief null
#*
sub get_iface {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_iface'};
}

#** @method public Saklient::Cloud::Models::Model_Iface iface ()
# 
# @brief インタフェースにアクセスするためのモデル。
#*
sub iface {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#iface");
		throw $ex;
	}
	return $_[0]->get_iface();
}

#** @var private Saklient::Cloud::Models::Model_Swytch Saklient::Cloud::API::$_swytch 
# 
# @private
#*
my $_swytch;

#** @method private Saklient::Cloud::Models::Model_Swytch get_swytch 
# 
# @brief null
#*
sub get_swytch {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_swytch'};
}

#** @method public Saklient::Cloud::Models::Model_Swytch swytch ()
# 
# @brief スイッチにアクセスするためのモデル。
#*
sub swytch {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#swytch");
		throw $ex;
	}
	return $_[0]->get_swytch();
}

#** @var private Saklient::Cloud::Models::Model_Router Saklient::Cloud::API::$_router 
# 
# @private
#*
my $_router;

#** @method private Saklient::Cloud::Models::Model_Router get_router 
# 
# @brief null
#*
sub get_router {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_router'};
}

#** @method public Saklient::Cloud::Models::Model_Router router ()
# 
# @brief ルータにアクセスするためのモデル。
#*
sub router {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#router");
		throw $ex;
	}
	return $_[0]->get_router();
}

#** @var private Saklient::Cloud::Models::Model_Ipv6Net Saklient::Cloud::API::$_ipv6_net 
# 
# @private
#*
my $_ipv6_net;

#** @method private Saklient::Cloud::Models::Model_Ipv6Net get_ipv6_net 
# 
# @brief null
#*
sub get_ipv6_net {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ipv6_net'};
}

#** @method public Saklient::Cloud::Models::Model_Ipv6Net ipv6_net ()
# 
# @brief IPv6ネットワークにアクセスするためのモデル。
#*
sub ipv6_net {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#ipv6_net");
		throw $ex;
	}
	return $_[0]->get_ipv6_net();
}

#** @var private Saklient::Cloud::Models::Model_Script Saklient::Cloud::API::$_script 
# 
# @private
#*
my $_script;

#** @method private Saklient::Cloud::Models::Model_Script get_script 
# 
# @brief null
#*
sub get_script {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_script'};
}

#** @method public Saklient::Cloud::Models::Model_Script script ()
# 
# @brief スクリプトにアクセスするためのモデル。
#*
sub script {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::API#script");
		throw $ex;
	}
	return $_[0]->get_script();
}

#** @method private void new ($client)
# 
# @ignore
# @param Client $client
#*
sub new {
	my $class = shift;
	my $self = bless {}, $class;
	my $_argnum = scalar @_;
	my $client = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	$self->{'_client'} = $client;
	$self->{'_product'} = new Saklient::Cloud::Product($client);
	$self->{'_icon'} = new Saklient::Cloud::Models::Model_Icon($client);
	$self->{'_server'} = new Saklient::Cloud::Models::Model_Server($client);
	$self->{'_disk'} = new Saklient::Cloud::Models::Model_Disk($client);
	$self->{'_appliance'} = new Saklient::Cloud::Models::Model_Appliance($client);
	$self->{'_archive'} = new Saklient::Cloud::Models::Model_Archive($client);
	$self->{'_iso_image'} = new Saklient::Cloud::Models::Model_IsoImage($client);
	$self->{'_iface'} = new Saklient::Cloud::Models::Model_Iface($client);
	$self->{'_swytch'} = new Saklient::Cloud::Models::Model_Swytch($client);
	$self->{'_router'} = new Saklient::Cloud::Models::Model_Router($client);
	$self->{'_ipv6_net'} = new Saklient::Cloud::Models::Model_Ipv6Net($client);
	$self->{'_script'} = new Saklient::Cloud::Models::Model_Script($client);
	return $self;
}

#** @cmethod public Saklient::Cloud::API authorize ($token, $secret, $zone)
# 
# @brief 指定した認証情報を用いてアクセスを行うAPIクライアントを作成します。
# 
# 必要な認証情報は、コントロールパネル右上にあるアカウントのプルダウンから
# 「設定」を選択し、「APIキー」のページにて作成できます。
# 
# @param string $token ACCESS TOKEN
# @param string $secret ACCESS TOKEN SECRET
# @param string $zone
# @retval APIクライアント
#*
sub authorize {
	shift if 2 < scalar(@_) && defined($_[0]) && $_[0] eq 'Saklient::Cloud::API';
	my $_argnum = scalar @_;
	my $token = shift;
	my $secret = shift;
	my $zone = shift || (undef);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($token, "string");
	Saklient::Util::validate_type($secret, "string");
	Saklient::Util::validate_type($zone, "string");
	my $c = new Saklient::Cloud::Client($token, $secret);
	my $ret = new Saklient::Cloud::API($c);
	return defined($zone) ? $ret->in_zone($zone) : $ret;
}

#** @method public Saklient::Cloud::API in_zone ($name)
# 
# @brief 認証情報を引き継ぎ、指定したゾーンへのアクセスを行うAPIクライアントを作成します。
# 
# @param string $name ゾーン名
# @retval APIクライアント
#*
sub in_zone {
	my $self = shift;
	my $_argnum = scalar @_;
	my $name = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($name, "string");
	my $ret = new Saklient::Cloud::API($self->{'_client'}->clone_instance());
	my $suffix = "";
	if ($name eq "is1x" || $name eq "is1y") {
		$suffix = "-test";
	}
	$ret->{'_client'}->set_api_root("https://secure.sakura.ad.jp/cloud" . $suffix . "/");
	$ret->{'_client'}->set_api_root_suffix("zone/" . $name);
	return $ret;
}

1;

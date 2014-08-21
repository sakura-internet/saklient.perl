#!/usr/bin/perl

package Saklient::Cloud::Resource::ServerInstance;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Util;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::IsoImage;
use Saklient::Cloud::Enums::EServerInstanceStatus;

use base qw(Saklient::Cloud::Resource::Resource);

#** @class Saklient::Cloud::Resource::ServerInstance
# 
# @brief サーバインスタンスの実体1つに対応し、属性の取得や操作を行うためのクラス。
#*


#** @var private string Saklient::Cloud::Resource::ServerInstance::$m_status 
# 
# @brief 起動状態 {@link EServerInstanceStatus}
#*
my $m_status;

#** @var private string Saklient::Cloud::Resource::ServerInstance::$m_before_status 
# 
# @brief 前回の起動状態 {@link EServerInstanceStatus}
#*
my $m_before_status;

#** @var private NativeDate Saklient::Cloud::Resource::ServerInstance::$m_status_changed_at 
# 
# @brief 現在の起動状態に変化した日時
#*
my $m_status_changed_at;

#** @var private IsoImage Saklient::Cloud::Resource::ServerInstance::$m_iso_image 
# 
# @brief 挿入されているISOイメージ
#*
my $m_iso_image;

#** @method public void new ($client, $obj, $wrapped)
# 
# @ignore @param {Saklient::Cloud::Client} client
# @param bool $wrapped
#*
sub new {
	my $class = shift;
	my $self;
	my $_argnum = scalar @_;
	my $client = shift;
	my $obj = shift;
	my $wrapped = shift || (0);
	$self = $class->SUPER::new($client);
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($client, "Saklient::Cloud::Client");
	Saklient::Util::validate_type($wrapped, "bool");
	$self->api_deserialize($obj, $wrapped);
	return $self;
}

#** @method public bool is_up 
# 
# @brief サーバが起動しているときtrueを返します。
#*
sub is_up {
	my $self = shift;
	my $_argnum = scalar @_;
	return defined($self->get_status()) && Saklient::Cloud::Enums::EServerInstanceStatus::compare($self->get_status(), Saklient::Cloud::Enums::EServerInstanceStatus::up) == 0;
}

#** @method public bool is_down 
# 
# @brief サーバが停止しているときtrueを返します。
#*
sub is_down {
	my $self = shift;
	my $_argnum = scalar @_;
	return !defined($self->get_status()) || Saklient::Cloud::Enums::EServerInstanceStatus::compare($self->get_status(), Saklient::Cloud::Enums::EServerInstanceStatus::down) == 0;
}

#** @var private bool Saklient::Cloud::Resource::ServerInstance::$n_status 
# 
# @brief null
#*
my $n_status = 0;

#** @method private string get_status 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_status'};
}

#** @method public string status ()
# 
# @brief 起動状態 {@link EServerInstanceStatus}
#*
sub status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#status");
		throw $ex;
	}
	return $_[0]->get_status();
}

#** @var private bool Saklient::Cloud::Resource::ServerInstance::$n_before_status 
# 
# @brief null
#*
my $n_before_status = 0;

#** @method private string get_before_status 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_before_status {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_before_status'};
}

#** @method public string before_status ()
# 
# @brief 前回の起動状態 {@link EServerInstanceStatus}
#*
sub before_status {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#before_status");
		throw $ex;
	}
	return $_[0]->get_before_status();
}

#** @var private bool Saklient::Cloud::Resource::ServerInstance::$n_status_changed_at 
# 
# @brief null
#*
my $n_status_changed_at = 0;

#** @method private NativeDate get_status_changed_at 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_status_changed_at {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_status_changed_at'};
}

#** @method public NativeDate status_changed_at ()
# 
# @brief 現在の起動状態に変化した日時
#*
sub status_changed_at {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#status_changed_at");
		throw $ex;
	}
	return $_[0]->get_status_changed_at();
}

#** @var private bool Saklient::Cloud::Resource::ServerInstance::$n_iso_image 
# 
# @brief null
#*
my $n_iso_image = 0;

#** @method private Saklient::Cloud::Resource::IsoImage get_iso_image 
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub get_iso_image {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_iso_image'};
}

#** @method public Saklient::Cloud::Resource::IsoImage iso_image ()
# 
# @brief 挿入されているISOイメージ
#*
sub iso_image {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::ServerInstance#iso_image");
		throw $ex;
	}
	return $_[0]->get_iso_image();
}

#** @method private void api_deserialize_impl ($r)
# 
# @brief (This method is generated in Translator_default#buildImpl)
#*
sub api_deserialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	$self->{'is_new'} = !defined($r);
	if ($self->{'is_new'}) {
		$r = {};
	}
	$self->{'is_incomplete'} = 0;
	if (Saklient::Util::exists_path($r, "Status")) {
		$self->{'m_status'} = !defined(Saklient::Util::get_by_path($r, "Status")) ? undef : "" . Saklient::Util::get_by_path($r, "Status");
	}
	else {
		$self->{'m_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status'} = 0;
	if (Saklient::Util::exists_path($r, "BeforeStatus")) {
		$self->{'m_before_status'} = !defined(Saklient::Util::get_by_path($r, "BeforeStatus")) ? undef : "" . Saklient::Util::get_by_path($r, "BeforeStatus");
	}
	else {
		$self->{'m_before_status'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_before_status'} = 0;
	if (Saklient::Util::exists_path($r, "StatusChangedAt")) {
		$self->{'m_status_changed_at'} = !defined(Saklient::Util::get_by_path($r, "StatusChangedAt")) ? undef : Saklient::Util::str2date("" . Saklient::Util::get_by_path($r, "StatusChangedAt"));
	}
	else {
		$self->{'m_status_changed_at'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_status_changed_at'} = 0;
	if (Saklient::Util::exists_path($r, "CDROM")) {
		$self->{'m_iso_image'} = !defined(Saklient::Util::get_by_path($r, "CDROM")) ? undef : new Saklient::Cloud::Resource::IsoImage($self->{'_client'}, Saklient::Util::get_by_path($r, "CDROM"));
	}
	else {
		$self->{'m_iso_image'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_iso_image'} = 0;
}

#** @method private any api_serialize_impl ($withClean)
# 
# @ignore@param {bool} withClean
#*
sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	my $ret = {};
	if ($withClean || $self->{'n_status'}) {
		Saklient::Util::set_by_path($ret, "Status", $self->{'m_status'});
	}
	if ($withClean || $self->{'n_before_status'}) {
		Saklient::Util::set_by_path($ret, "BeforeStatus", $self->{'m_before_status'});
	}
	if ($withClean || $self->{'n_status_changed_at'}) {
		Saklient::Util::set_by_path($ret, "StatusChangedAt", !defined($self->{'m_status_changed_at'}) ? undef : Saklient::Util::date2str($self->{'m_status_changed_at'}));
	}
	if ($withClean || $self->{'n_iso_image'}) {
		Saklient::Util::set_by_path($ret, "CDROM", $withClean ? (!defined($self->{'m_iso_image'}) ? undef : $self->{'m_iso_image'}->api_serialize($withClean)) : (!defined($self->{'m_iso_image'}) ? {'ID' => "0"} : $self->{'m_iso_image'}->api_serialize_id()));
	}
	return $ret;
}

1;

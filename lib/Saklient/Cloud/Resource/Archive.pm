#!/usr/bin/perl

package Saklient::Cloud::Resource::Archive;

use strict;
use warnings;
use Carp;
use Error qw(:try);
use Data::Dumper;
use Saklient::Cloud::Client;
use Saklient::Cloud::Resource::Resource;
use Saklient::Cloud::Resource::Icon;
use Saklient::Cloud::Resource::FtpInfo;
use Saklient::Cloud::Resource::DiskPlan;
use Saklient::Cloud::Resource::Server;
use Saklient::Cloud::Enums::EScope;
use Saklient::Cloud::Enums::EAvailability;
use Saklient::Errors::SaklientException;

use base qw(Saklient::Cloud::Resource::Resource);

=pod

=encoding utf8

=head1 Saklient::Cloud::Resource::Archive

アーカイブの実体1つに対応し、属性の取得や操作を行うためのクラス。

=cut


my $m_id;

my $m_scope;

my $m_name;

my $m_description;

my $m_tags;

my $m_icon;

my $m_size_mib;

my $m_service_class;

my $m_plan;

my $m_availability;

sub _api_path {
	my $self = shift;
	my $_argnum = scalar @_;
	return "/archive";
}

sub _root_key {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archive";
}

sub _root_key_m {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archives";
}

sub _class_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return "Archive";
}

sub _id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_id();
}

=head2 save : Saklient::Cloud::Resource::Archive

このローカルオブジェクトに現在設定されているリソース情報をAPIに送信し、新規作成または上書き保存します。

@return this

=cut
sub save {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_save();
}

=head2 reload : Saklient::Cloud::Resource::Archive

最新のリソース情報を再取得します。

@return this

=cut
sub reload {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->_reload();
}

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

sub get_is_available {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_availability() eq Saklient::Cloud::Enums::EAvailability::available;
}

=head2 is_available

ディスクが利用可能なときtrueを返します。

=cut
sub is_available {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#is_available");
		throw $ex;
	}
	return $_[0]->get_is_available();
}

sub get_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->get_size_mib() >> 10;
}

sub set_size_gib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $sizeGib = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($sizeGib, "int");
	$self->set_size_mib($sizeGib * 1024);
	return $sizeGib;
}

=head2 size_gib

サイズ[GiB]

=cut
sub size_gib {
	if (1 < scalar(@_)) {
		$_[0]->set_size_gib($_[1]);
		return $_[0];
	}
	return $_[0]->get_size_gib();
}

my $_source;

sub get_source {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_source'};
}

sub set_source {
	my $self = shift;
	my $_argnum = scalar @_;
	my $source = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($source, "Saklient::Cloud::Resource::Resource");
	$self->{'_source'} = $source;
	return $source;
}

=head2 source

アーカイブのコピー元

=cut
sub source {
	if (1 < scalar(@_)) {
		$_[0]->set_source($_[1]);
		return $_[0];
	}
	return $_[0]->get_source();
}

my $_ftp_info;

sub get_ftp_info {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'_ftp_info'};
}

=head2 ftp_info

FTP情報

=cut
sub ftp_info {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#ftp_info");
		throw $ex;
	}
	return $_[0]->get_ftp_info();
}

sub _on_after_api_deserialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $root = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	if (defined($root)) {
		if ((ref($root) eq 'HASH' && exists $root->{"FTPServer"})) {
			my $ftp = $root->{"FTPServer"};
			if (defined($ftp)) {
				$self->{'_ftp_info'} = new Saklient::Cloud::Resource::FtpInfo($ftp);
			}
		}
	}
	if (defined($r)) {
		if ((ref($r) eq 'HASH' && exists $r->{"SourceArchive"})) {
			my $s = $r->{"SourceArchive"};
			if (defined($s)) {
				my $id = $s->{"ID"};
				if (defined($id)) {
					$self->{'_source'} = new Saklient::Cloud::Resource::Archive($self->{'_client'}, $s);
				}
			}
		}
		if ((ref($r) eq 'HASH' && exists $r->{"SourceDisk"})) {
			my $s = $r->{"SourceDisk"};
			if (defined($s)) {
				my $id = $s->{"ID"};
				if (defined($id)) {
					my $obj = Saklient::Util::create_class_instance("saklient.cloud.resource.Disk", [$self->{'_client'}, $s]);
					$self->{'_source'} = $obj;
				}
			}
		}
	}
}

sub _on_after_api_serialize {
	my $self = shift;
	my $_argnum = scalar @_;
	my $r = shift;
	my $withClean = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($withClean, "bool");
	if (!defined($r)) {
		return;
	}
	if (defined($self->{'_source'})) {
		if ($self->{'_source'}->_class_name() eq "Archive") {
			my $s = $withClean ? $self->{'_source'}->api_serialize(1) : {'ID' => $self->{'_source'}->_id()};
			$r->{"SourceArchive"} = $s;
		}
		else {
			if ($self->{'_source'}->_class_name() eq "Disk") {
				my $s = $withClean ? $self->{'_source'}->api_serialize(1) : {'ID' => $self->{'_source'}->_id()};
				$r->{"SourceDisk"} = $s;
			}
			else {
				$self->{'_source'} = undef;
				Saklient::Util::validate_type($self->{'_source'}, "Disk or Archive", 1);
			}
		}
	}
}

=head2 open_ftp(bool $reset=0) : Saklient::Cloud::Resource::Archive

FTPSを開始し、イメージファイルをアップロード・ダウンロードできる状態にします。

アカウント情報は、ftpInfo プロパティから取得することができます。

@param reset 既にFTPSが開始されているとき、trueを指定してこのメソッドを呼ぶことでパスワードを再設定します。
@return this

=cut
sub open_ftp {
	my $self = shift;
	my $_argnum = scalar @_;
	my $reset = shift || (0);
	Saklient::Util::validate_type($reset, "bool");
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/ftp";
	my $q = {};
	Saklient::Util::set_by_path($q, "ChangePassword", $reset);
	my $result = $self->{'_client'}->request("PUT", $path, $q);
	$self->_on_after_api_deserialize(undef, $result);
	return $self;
}

=head2 close_ftp : Saklient::Cloud::Resource::Archive

FTPSを終了し、アーカイブを利用可能な状態にします。

@return this

=cut
sub close_ftp {
	my $self = shift;
	my $_argnum = scalar @_;
	my $path = $self->_api_path() . "/" . Saklient::Util::url_encode($self->_id()) . "/ftp";
	my $result = $self->{'_client'}->request("DELETE", $path);
	$self->{'_ftp_info'} = undef;
	return $self;
}

=head2 after_copy(int $timeoutSec, (Saklient::Cloud::Resource::Archive, bool) => void $callback) : void

コピー中のアーカイブが利用可能になるまで待機します。

@ignore

=cut
sub after_copy {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift;
	my $callback = shift;
	Saklient::Util::validate_arg_count($_argnum, 2);
	Saklient::Util::validate_type($timeoutSec, "int");
	Saklient::Util::validate_type($callback, "CODE");
	my $ret = $self->sleep_while_copying($timeoutSec);
	$callback->($self, $ret);
}

=head2 sleep_while_copying(int $timeoutSec=3600) : bool

コピー中のアーカイブが利用可能になるまで待機します。

@return 成功時はtrue、タイムアウトやエラーによる失敗時はfalseを返します。

=cut
sub sleep_while_copying {
	my $self = shift;
	my $_argnum = scalar @_;
	my $timeoutSec = shift || (3600);
	Saklient::Util::validate_type($timeoutSec, "int");
	my $step = 3;
	while (0 < $timeoutSec) {
		$self->reload();
		my $a = $self->get_availability();
		if ($a eq Saklient::Cloud::Enums::EAvailability::available) {
			return 1;
		}
		if ($a ne Saklient::Cloud::Enums::EAvailability::migrating) {
			$timeoutSec = 0;
		}
		$timeoutSec -= $step;
		if (0 < $timeoutSec) {
			sleep $step;
		}
	}
	return 0;
}

my $n_id = 0;

sub get_id {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_id'};
}

=head2 id

ID

=cut
sub id {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#id");
		throw $ex;
	}
	return $_[0]->get_id();
}

my $n_scope = 0;

sub get_scope {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_scope'};
}

=head2 scope

スコープ {@link EScope}

=cut
sub scope {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#scope");
		throw $ex;
	}
	return $_[0]->get_scope();
}

my $n_name = 0;

sub get_name {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_name'};
}

sub set_name {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_name'} = $v;
	$self->{'n_name'} = 1;
	return $self->{'m_name'};
}

=head2 name

名前

=cut
sub name {
	if (1 < scalar(@_)) {
		$_[0]->set_name($_[1]);
		return $_[0];
	}
	return $_[0]->get_name();
}

my $n_description = 0;

sub get_description {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_description'};
}

sub set_description {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "string");
	$self->{'m_description'} = $v;
	$self->{'n_description'} = 1;
	return $self->{'m_description'};
}

=head2 description

説明

=cut
sub description {
	if (1 < scalar(@_)) {
		$_[0]->set_description($_[1]);
		return $_[0];
	}
	return $_[0]->get_description();
}

my $n_tags = 0;

sub get_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_tags'};
}

sub set_tags {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "ARRAY");
	$self->{'m_tags'} = $v;
	$self->{'n_tags'} = 1;
	return $self->{'m_tags'};
}

=head2 tags

タグ

=cut
sub tags {
	if (1 < scalar(@_)) {
		$_[0]->set_tags($_[1]);
		return $_[0];
	}
	return $_[0]->get_tags();
}

my $n_icon = 0;

sub get_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_icon'};
}

sub set_icon {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "Saklient::Cloud::Resource::Icon");
	$self->{'m_icon'} = $v;
	$self->{'n_icon'} = 1;
	return $self->{'m_icon'};
}

=head2 icon

アイコン

=cut
sub icon {
	if (1 < scalar(@_)) {
		$_[0]->set_icon($_[1]);
		return $_[0];
	}
	return $_[0]->get_icon();
}

my $n_size_mib = 0;

sub get_size_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_size_mib'};
}

sub set_size_mib {
	my $self = shift;
	my $_argnum = scalar @_;
	my $v = shift;
	Saklient::Util::validate_arg_count($_argnum, 1);
	Saklient::Util::validate_type($v, "int");
	if (!$self->{'is_new'}) {
		{ my $ex = new Saklient::Errors::SaklientException("immutable_field", "Immutable fields cannot be modified after the resource creation: " . "Saklient::Cloud::Resource::Archive#size_mib"); throw $ex; };
	}
	$self->{'m_size_mib'} = $v;
	$self->{'n_size_mib'} = 1;
	return $self->{'m_size_mib'};
}

=head2 size_mib

サイズ[MiB]

=cut
sub size_mib {
	if (1 < scalar(@_)) {
		$_[0]->set_size_mib($_[1]);
		return $_[0];
	}
	return $_[0]->get_size_mib();
}

my $n_service_class = 0;

sub get_service_class {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_service_class'};
}

=head2 service_class

サービスクラス

=cut
sub service_class {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#service_class");
		throw $ex;
	}
	return $_[0]->get_service_class();
}

my $n_plan = 0;

sub get_plan {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_plan'};
}

=head2 plan

プラン

=cut
sub plan {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#plan");
		throw $ex;
	}
	return $_[0]->get_plan();
}

my $n_availability = 0;

sub get_availability {
	my $self = shift;
	my $_argnum = scalar @_;
	return $self->{'m_availability'};
}

=head2 availability

有効状態 {@link EAvailability}

=cut
sub availability {
	if (1 < scalar(@_)) {
		my $ex = new Saklient::Errors::SaklientException('non_writable_field', "Non-writable field: Saklient::Cloud::Resource::Archive#availability");
		throw $ex;
	}
	return $_[0]->get_availability();
}

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
	if (Saklient::Util::exists_path($r, "ID")) {
		$self->{'m_id'} = !defined(Saklient::Util::get_by_path($r, "ID")) ? undef : "" . Saklient::Util::get_by_path($r, "ID");
	}
	else {
		$self->{'m_id'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_id'} = 0;
	if (Saklient::Util::exists_path($r, "Scope")) {
		$self->{'m_scope'} = !defined(Saklient::Util::get_by_path($r, "Scope")) ? undef : "" . Saklient::Util::get_by_path($r, "Scope");
	}
	else {
		$self->{'m_scope'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_scope'} = 0;
	if (Saklient::Util::exists_path($r, "Name")) {
		$self->{'m_name'} = !defined(Saklient::Util::get_by_path($r, "Name")) ? undef : "" . Saklient::Util::get_by_path($r, "Name");
	}
	else {
		$self->{'m_name'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_name'} = 0;
	if (Saklient::Util::exists_path($r, "Description")) {
		$self->{'m_description'} = !defined(Saklient::Util::get_by_path($r, "Description")) ? undef : "" . Saklient::Util::get_by_path($r, "Description");
	}
	else {
		$self->{'m_description'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_description'} = 0;
	if (Saklient::Util::exists_path($r, "Tags")) {
		if (!defined(Saklient::Util::get_by_path($r, "Tags"))) {
			$self->{'m_tags'} = [];
		}
		else {
			$self->{'m_tags'} = [];
			foreach my $t (@{Saklient::Util::get_by_path($r, "Tags")}) {
				my $v1 = undef;
				$v1 = !defined($t) ? undef : "" . $t;
				push(@{$self->{'m_tags'}}, $v1);
			}
		}
	}
	else {
		$self->{'m_tags'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_tags'} = 0;
	if (Saklient::Util::exists_path($r, "Icon")) {
		$self->{'m_icon'} = !defined(Saklient::Util::get_by_path($r, "Icon")) ? undef : new Saklient::Cloud::Resource::Icon($self->{'_client'}, Saklient::Util::get_by_path($r, "Icon"));
	}
	else {
		$self->{'m_icon'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_icon'} = 0;
	if (Saklient::Util::exists_path($r, "SizeMB")) {
		$self->{'m_size_mib'} = !defined(Saklient::Util::get_by_path($r, "SizeMB")) ? undef : (0+("" . Saklient::Util::get_by_path($r, "SizeMB")));
	}
	else {
		$self->{'m_size_mib'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_size_mib'} = 0;
	if (Saklient::Util::exists_path($r, "ServiceClass")) {
		$self->{'m_service_class'} = !defined(Saklient::Util::get_by_path($r, "ServiceClass")) ? undef : "" . Saklient::Util::get_by_path($r, "ServiceClass");
	}
	else {
		$self->{'m_service_class'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_service_class'} = 0;
	if (Saklient::Util::exists_path($r, "Plan")) {
		$self->{'m_plan'} = !defined(Saklient::Util::get_by_path($r, "Plan")) ? undef : new Saklient::Cloud::Resource::DiskPlan($self->{'_client'}, Saklient::Util::get_by_path($r, "Plan"));
	}
	else {
		$self->{'m_plan'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_plan'} = 0;
	if (Saklient::Util::exists_path($r, "Availability")) {
		$self->{'m_availability'} = !defined(Saklient::Util::get_by_path($r, "Availability")) ? undef : "" . Saklient::Util::get_by_path($r, "Availability");
	}
	else {
		$self->{'m_availability'} = undef;
		$self->{'is_incomplete'} = 1;
	}
	$self->{'n_availability'} = 0;
}

sub api_serialize_impl {
	my $self = shift;
	my $_argnum = scalar @_;
	my $withClean = shift || (0);
	Saklient::Util::validate_type($withClean, "bool");
	my $missing = [];
	my $ret = {};
	if ($withClean || $self->{'n_id'}) {
		Saklient::Util::set_by_path($ret, "ID", $self->{'m_id'});
	}
	if ($withClean || $self->{'n_scope'}) {
		Saklient::Util::set_by_path($ret, "Scope", $self->{'m_scope'});
	}
	if ($withClean || $self->{'n_name'}) {
		Saklient::Util::set_by_path($ret, "Name", $self->{'m_name'});
	}
	else {
		if ($self->{'is_new'}) {
			push(@{$missing}, "name");
		}
	}
	if ($withClean || $self->{'n_description'}) {
		Saklient::Util::set_by_path($ret, "Description", $self->{'m_description'});
	}
	if ($withClean || $self->{'n_tags'}) {
		Saklient::Util::set_by_path($ret, "Tags", []);
		foreach my $r1 (@{$self->{'m_tags'}}) {
			my $v = undef;
			$v = $r1;
			push(@{$ret->{"Tags"}}, $v);
		}
	}
	if ($withClean || $self->{'n_icon'}) {
		Saklient::Util::set_by_path($ret, "Icon", $withClean ? (!defined($self->{'m_icon'}) ? undef : $self->{'m_icon'}->api_serialize($withClean)) : (!defined($self->{'m_icon'}) ? {'ID' => "0"} : $self->{'m_icon'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_size_mib'}) {
		Saklient::Util::set_by_path($ret, "SizeMB", $self->{'m_size_mib'});
	}
	if ($withClean || $self->{'n_service_class'}) {
		Saklient::Util::set_by_path($ret, "ServiceClass", $self->{'m_service_class'});
	}
	if ($withClean || $self->{'n_plan'}) {
		Saklient::Util::set_by_path($ret, "Plan", $withClean ? (!defined($self->{'m_plan'}) ? undef : $self->{'m_plan'}->api_serialize($withClean)) : (!defined($self->{'m_plan'}) ? {'ID' => "0"} : $self->{'m_plan'}->api_serialize_id()));
	}
	if ($withClean || $self->{'n_availability'}) {
		Saklient::Util::set_by_path($ret, "Availability", $self->{'m_availability'});
	}
	if (scalar(@{$missing}) > 0) {
		{ my $ex = new Saklient::Errors::SaklientException("required_field", "Required fields must be set before the Archive creation: " . join(", ", @{$missing})); throw $ex; };
	}
	return $ret;
}

1;

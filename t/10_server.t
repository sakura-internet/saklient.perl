#!perl

use strict;
use warnings;
use errors;
use Test::More;
use FindBin;
use File::Basename qw(basename dirname);
BEGIN { unshift(@INC, dirname($FindBin::RealBin) . "/lib") }
use Saclient::Cloud::API;
use Saclient::Cloud::Enums::EServerInstanceStatus;
use Saclient::Errors::HttpException;
use JSON;
use Data::Dumper;
use POSIX 'strftime';
use String::Random;
binmode STDOUT, ":utf8";

my $tests = 33;



# load config file
my $root = dirname $FindBin::RealBin;
my $test_ok_file = $root . '/testok';
unless (-f $test_ok_file) {
	diag "詳細テストを行うには $test_ok_file をtouchしてください。";
	ok 1;
	plan tests => 1;
	done_testing;
	exit 0;
}
my $config_file = $root . '/config.sh';
ok -f $config_file, "$config_file を作成してください。";
my %config = ();
my $fh;
open $fh, '<', $config_file;
while (my $line = readline $fh) {
	next unless $line =~ /^\s*export\s+(\w+)\s*=\s*(.+?)\s*$/;
	my $key = $1;
	my $value = $2;
	$value =~ s/'([^']*)'|"([^"]*)"|\\(.)|(.)/$1||$2||$3||$4/ge;
	$config{$key} = $value;
}
close $fh;
ok $config{'SACLOUD_TOKEN'}, 'SACLOUD_TOKEN must be defined in config.sh';
ok $config{'SACLOUD_SECRET'}, 'SACLOUD_SECRET must be defined in config.sh';
#ok $config{'SACLOUD_ZONE'}, 'SACLOUD_ZONE must be defined in config.sh';



# authorize
my $api = Saclient::Cloud::API::authorize($config{'SACLOUD_TOKEN'}, $config{'SACLOUD_SECRET'});
$api = $api->in_zone($config{'SACLOUD_ZONE'}) if $config{'SACLOUD_ZONE'};
isa_ok $api, 'Saclient::Cloud::API';



# should be found
my $servers = $api->server->sort_by_memory->find;
isa_ok $servers, 'ARRAY';
cmp_ok scalar(@$servers), '>', 0;

my $mem = 0;
foreach my $server (@$servers) {
	$tests += 8;
	isa_ok $server, 'Saclient::Cloud::Resource::Server';
	isa_ok $server->plan(), 'Saclient::Cloud::Resource::ServerPlan';
	cmp_ok $server->plan()->cpu(), '>', 0;
	cmp_ok $server->plan()->memory_mib(), '>', 0;
	cmp_ok $server->plan()->memory_gib(), '>', 0;
	is($server->plan()->memory_mib() / $server->plan()->memory_gib(), 1024);
	isa_ok $server->tags(), 'ARRAY';
	foreach my $tag (@{$server->tags()}) {
		$tests += 2;
		ok !ref($tag);
		like($tag, qr/./);
	}
	cmp_ok $server->plan->memory_gib(), '>=', $mem;
	$mem = $server->plan->memory_gib();
}

# should be limited
$servers = $api->server->limit(1)->find;
is scalar(@$servers), 1;



# should be CRUDed
my $name = '!perl_test-' . strftime('%Y%m%d_%H%M%S', localtime) . '-' . String::Random->new->randregex('\\w{8}');
my $description = 'This instance was created by saclient.perl test';
my $tag = 'saclient-test';
my $cpu = 1;
$mem = 2;
my $host_name = 'saclient-test';
my $ssh_public_key = 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3sSg8Vfxrs3eFTx3G//wMRlgqmFGxh5Ia8DZSSf2YrkZGqKbL1t2AsiUtIMwxGiEVVBc0K89lORzra7qoHQj5v5Xlcdqodgcs9nwuSeS38XWO6tXNF4a8LvKnfGS55+uzmBmVUwAztr3TIJR5TTWxZXpcxSsSEHx7nIcr31zcvosjgdxqvSokAsIgJyPQyxCxsPK8SFIsUV+aATqBCWNyp+R1jECPkd74ipEBoccnA0pYZnRhIsKNWR9phBRXIVd5jx/gK5jHqouhFWvCucUs0gwilEGwpng3b/YxrinNskpfOpMhOD9zjNU58OCoMS8MA17yqoZv59l3u16CrnrD saclient-test@local';
my $ssh_private_key_file = dirname($FindBin::RealBin) . '/test-sshkey.txt';

# search archives
diag 'searching archives...';
my $archives = $api->archive
	->with_name_like('CentOS 6.5 64bit')
	->with_size_gib(20)
	->with_shared_scope
	->limit(1)
	->find;
cmp_ok scalar(@$archives), '>', 0;
my $archive = $archives->[0];

# search scripts
diag 'searching scripts...';
my $scripts = $api->script
	->with_name_like('WordPress')
	->with_shared_scope
	->limit(1)
	->find;
cmp_ok scalar(@$scripts), '>', 0;
my $script = $scripts->[0];

# create a disk
diag 'creating a disk...';
my $disk = $api->disk->create;
my $ok = 0;
try {
	$disk->save;
}
catch Saclient::Errors::SaclientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'required_field';
	$ok = 1;
};
ok $ok, 'Requiredフィールドが未set時は SaclientException がスローされなければなりません';
$disk
	->name($name)
	->description($description)
	->tags([$tag])
	->source($archive)
	->save;
is $disk->size_gib, 20;

# check an immutable field
diag 'updating the disk...';
$ok = 0;
try {
	$disk->size_mib(20480)->save;
}
catch Saclient::Errors::SaclientException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'immutable_field';
	$ok = 1;
};
#
ok $ok, 'Immutableフィールドの再set時は SaclientException がスローされなければなりません';

# create a server
diag 'creating a server...';
my $server = $api->server->create;
isa_ok $server, 'Saclient::Cloud::Resource::Server';
$server->name($name)
	->description($description)
	->tags([$tag])
	->plan($api->product->server->get_by_spec($cpu, $mem))
	->save;

# check the server properties
cmp_ok $server->id, '>', 0;
is $server->name, $name;
is $server->description, $description;
isa_ok $server->tags, 'ARRAY';
is scalar(@{$server->tags}), 1;
is $server->tags->[0], $tag;
is $server->plan->cpu, $cpu;
is $server->plan->memory_gib, $mem;

# connect to shared segment
diag 'connecting the server to shared segment...';
my $iface = $server->add_iface;
isa_ok $iface, 'Saclient::Cloud::Resource::Iface';
cmp_ok $iface->id, '>', 0;
$iface->connect_to_shared_segment;

# wait disk copy
diag 'waiting disk copy...';
fail 'アーカイブからディスクへのコピーがタイムアウトしました' unless $disk->sleep_while_copying;
$disk->source(undef);
$disk->reload;
isa_ok $disk->source, 'Saclient::Cloud::Resource::Archive';
is $disk->source->id, $archive->id;
is $disk->size_gib, $archive->size_gib;

# connect the disk to the server
diag 'connecting the disk to the server...';
$disk->connect_to($server);

# config the disk
diag 'writing configuration to the disk...';
$disk->create_config
	->host_name($host_name)
	->password(String::Random->new->randregex('\\w{8}'))
	->ssh_key($ssh_public_key)
	->add_script($script)
	->write;

# boot
diag 'booting the server...';
$server->boot;
sleep 1;
$server->reload;
is $server->instance->status, Saclient::Cloud::Enums::EServerInstanceStatus::up, 'サーバが起動しません';

# boot conflict
diag 'checking the server power conflicts...';
$ok = 0;
try {
	$server->boot;
}
catch Saclient::Errors::HttpException with {
	my $ex = shift;
	throw $ex if $ex->code ne 'conflict';
	$ok = 1;
};
#
ok $ok, 'サーバ起動中の起動試行時は HttpConflictException がスローされなければなりません';

# ssh
my $ip_address = $server->ifaces->[0]->ip_address;
ok $ip_address;
my $cmd = "ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null -i$ssh_private_key_file root\@$ip_address hostname 2>/dev/null";
my $ssh_success = 0;
diag 'trying to SSH to the server...';
for (my $i=0; $i<10; $i++) {
	sleep 5;
	my $host_name_got = `$cmd`;
	chomp $host_name_got;
	next unless $host_name eq $host_name_got;
	$ssh_success = 1;
	last;
}
ok $ssh_success, '作成したサーバへ正常にSSHできません';

# stop
sleep 3;
diag 'stopping the server...';
$server->stop;
fail 'サーバが正常に停止しません' unless $server->sleep_until_down;

# disconnect the disk from the server
diag 'disconnecting the disk from the server...';
$disk->disconnect;

# delete the server
diag 'deleting the server...';
$server->destroy;

# duplicate the disk
diag 'duplicating the disk (expanding to 40GiB)...';
my $disk2 = $api->disk->create;
$disk2->name($name . "-copy");
$disk2->description($description);
$disk2->tags([$tag]);
$disk2->source($disk);
$disk2->size_gib(40);
$disk2->save;

# wait disk duplication
diag 'waiting disk duplication...';
fail 'ディスクの複製がタイムアウトしました' unless $disk2->sleep_while_copying;
$disk2->source(undef);
$disk2->reload;
isa_ok $disk2->source, 'Saclient::Cloud::Resource::Disk';
is $disk2->source->id, $disk->id;
is $disk2->size_gib, 40;

# delete the disks
diag 'deleting the disks...';
$disk2->destroy;
$disk->destroy;

#
plan tests => $tests;
done_testing;


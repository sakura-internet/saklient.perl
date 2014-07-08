#!/usr/bin/perl

use strict;
use warnings;
use Saclient::Cloud::API;
use Saclient::Cloud::Enums::EServerInstanceStatus;
use JSON;
use Data::Dumper;
use POSIX 'strftime';
binmode STDOUT, ":utf8";

my $api = Saclient::Cloud::API::authorize($ARGV[0], $ARGV[1]);#->in_zone("is1b");

if (1) {
	my $server = $api->server->create;
	$server->name('saclient.pl');
	$server->description('This instance was created by saclient.pl example');
	$server->tags(['saclient-test']);
	$server->plan($api->product->server->get_by_spec(1, 1));
	$server->save;
	my $servers = $api->server->with_name_like('saclient.pl')->find;
	printf "%s\n", $servers->[0]->name;
	printf "%s\n", $servers->[0]->description;
	printf "%s\n", join(', ', @{$servers->[0]->tags});
	$server->destroy;
}

if (0) {
	
	my $plan_from = $api->product->server->get_by_spec(2, 4);
	printf "plan from: [%s] %dcore %dGB\n", $plan_from->id, $plan_from->cpu, $plan_from->memory_gib;
	my $plan_to   = $api->product->server->get_by_spec(4, 8);
	printf "plan to:   [%s] %dcore %dGB\n", $plan_to->id, $plan_to->cpu, $plan_to->memory_gib;
	printf "\n";
	
	my $servers = $api->server->with_plan($plan_from)->find();
	foreach my $server (@$servers) {
		printf "server [%s] %dcore %dGB '%s'\n", $server->id, $server->plan->cpu, $server->plan->memory_gib, $server->name;
		$server->change_plan($plan_to);
		printf "    -> [%s] %dcore %dGB\n\n", $server->id, $server->plan->cpu, $server->plan->memory_gib;
	}

}

if (0) {
	
	printf "%s\n", Saclient::Cloud::Enums::EServerInstanceStatus::down();
	printf "%s\n", Saclient::Cloud::Enums::EServerInstanceStatus->down();
	printf "%s\n", Saclient::Cloud::Enums::EServerInstanceStatus::compare("up", "down");
	printf "%s\n", Saclient::Cloud::Enums::EServerInstanceStatus->compare("up", "down");
	
}

if (0) {

	my $icons = $api->icon->with_name_like("cent")->limit(1)->find();
	die "icon not found" unless $icons && @$icons;
	my $icon = $icons->[0];
	printf "icon [%s] %s\n\n", $icon->id, $icon->name;
	
	my $servers = $api->server->with_name_like("cent")->find();
	foreach my $server (@$servers) {
		printf "server [%s] %s\n", $server->id, $server->name;
		$server->icon(undef);
		$server->save();
		printf "  changed icon to nothing: %s\n", $server->icon ? "NG" : "OK";
		$server->icon($icon);
		$server->save();
		printf "  changed icon to: [%s] %s\n\n", $server->icon->id, $server->icon->name;
	}

}

if (0) {
	my $now = strftime "%Y/%m/%d %H:%M:%S", localtime;
	my $servers = $api->server->with_tag("abc")->find();
	foreach my $server (@$servers) {
		printf "server [%s] %s\n", $server->id, $server->name;
		$server
			->description($server->description . "\n" . $now)
			->save;
		printf "%s\n\n", $server->description;
	}
	
}

if (0) {

	# Lists all disks connected to stopped servers
	my $servers = $api->server->with_instance_status("down")->find();
	foreach my $server (@$servers) {
		#next if $server->instance->status ne "down";
		next unless scalar @{$server->tags};
		printf "\n";
		printf "server [%s] %s%s at %s\n", $server->id, $server->is_up?"+":"-", $server->instance->status, $server->instance->status_changed_at;
		printf "    tags: %s\n", join ', ', @{$server->tags};
		#print JSON->new->utf8(0)->pretty(1)->encode($server->dump());
		#
		if ($server->ifaces) {
			foreach my $iface (@{$server->ifaces}) {
				printf "    iface [%s] %s %s\n", $iface->id, $iface->mac_address, $iface->ip_address || $iface->user_ip_address;
				#print Dumper $iface;
			}
		}
		#
		my $disks = $server->find_disks(); # same as: $api->disk->with_server_id($server->{id})->find();
		foreach my $disk (@$disks) {
			printf "    disk [%s] %s\n", $disk->id, $disk->name;
			#print JSON->new->utf8(0)->pretty(1)->encode($disk->dump());
		}
	}
	
}


#my $server = $api->server->with_instance_status("down")->find()->[0];
#print Dumper $server->tags;




#my $disks = $api->disk->find();
#foreach my $disk (@$disks) {
#	next if $disk->server;
#	print JSON->new->utf8(0)->pretty(1)->encode($disk->dump());
#	#print Dumper $disk;
#}

#my $diskplans = $api->product->disk->find();
#foreach my $diskplan (@$diskplans) {
#	print Dumper $diskplan->dump();
#}

#my $ipv6nets = $api->ipv6net->find();
#foreach my $ipv6net (@$ipv6nets) {
#	print JSON->new->utf8(0)->pretty(1)->encode($ipv6net->dump());
#}



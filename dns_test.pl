#!/usr/bin/env perl

use strict;
use warnings;
use Net::DNS;

my $url = "http://news.yahoo.co.jp/topics";
my ($proto, $host, $port, $path) = $url =~ m/^(.+?):\/\/(.+?):?(\d+)?(\/.*)?$/;

print "proto	= ", $host, "\n";
print "host	= ", $proto, "\n";
print "port	= ", $port ? $port : "80", "\n";
print "path	= ", $path, "\n";

my $res = Net::DNS::Resolver->new;
my $reply = $res->search($host);

if ($reply) {
	foreach my $rr ($reply->answer) {
		next unless ($rr->type eq "A");
		print "IP Address : ", $rr->address, "\n";
	}
} else {
	warn "query failed:", $res->errorstring, "\n";
}

exit 0;


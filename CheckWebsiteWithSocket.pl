#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use CGI qw( :standard);
use IO::Socket::INET;

my $query = CGI->new;

my $host = $query->param('hostname');
my $port = $query->param('port');
my $timeout = $query->param('timeout');

print "Content-Type: text/html \n\n";

my $socket = IO::Socket::INET->new(PeerAddr => $host,
    PeerPort => $port,
    Proto    => 'tcp',
    Timeout  => $timeout);

if (defined $socket) {
    print "Connection established for: $host:$port";
} else {
    print "Connection failed for: $host:$port";
}
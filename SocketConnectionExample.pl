#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

my $host = 'daluga.com';
my $port = 80;
my $timeout = 10; # in seconds

# -------------------------------------------------------------------------------------------
# Looks to be the more modern way to check a socket connection.
# -------------------------------------------------------------------------------------------
use IO::Socket::INET;

my $socket = IO::Socket::INET->new(PeerAddr => $host,
                                   PeerPort => $port,
                                   Proto    => 'tcp',
                                   Timeout  => $timeout)
    or print "Connection failed for: $host:$port";
    #or print "Connection failed for: $host:$port : $@";

if (defined $socket) {
    print "Connection established for: $host:$port" ;
    $socket->close();
}

# -------------------------------------------------------------------------------------------
# This block works but I am not sure how to set the timeout value for the connection.
# -------------------------------------------------------------------------------------------
#use Socket;
#
#my $iaddr = inet_aton($host) || die "No host: $host";
#my $protocol = getprotobyname("tcp");
#
#socket(SOCK, PF_INET, SOCK_STREAM, $protocol) || die "socket: $!";
#
#my $paddr = sockaddr_in($port, $iaddr);
#
#if (connect(SOCK, $paddr)) {
#    print "$host: $port is open"
#} elsif (!connect(SOCK, $paddr)) {
#    print "$host: $port is closed"
#} else {
#    print "Error";
#}

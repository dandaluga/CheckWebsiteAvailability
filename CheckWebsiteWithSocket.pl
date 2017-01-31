#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
#use IO::Socket::INET;
use Socket;

my $host = 'daluga.com';
my $port = 80;

# -------------------------------------------------------
#my $socket = IO::Socket::INET->new(PeerAddr => $host,
#                                   PeerPort => $port,
#                                   Proto    => 'tcp',
#                                   Timeout  => '10')
#    or die "Couldn't connect to $host:$port : $@\n";

#my $line;
#$socket->recv($line, '10000');
#print "received response: $line\n";

#$socket->close();

# -------------------------------------------------------
#print $socket "GET / HTTP/1.1\r\n\r\n";
#open (OUT, ">out.txt");
#while (<$socket>) {
#    print OUT;
#}
#close (OUT);
#close $socket;

my $iaddr = inet_aton($host) || die "No host: $host";
my $protocol = getprotobyname("tcp");

socket(SOCK, PF_INET, SOCK_STREAM, $protocol) || die "socket: $!";

my $paddr = sockaddr_in($port, $iaddr);

if (connect(SOCK, $paddr)) {
    print "$host: $port is open"
} elsif (!connect(SOCK, $paddr)) {
    print "$host: $port is closed"
} else {
    print "Error";
}

#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';

use CGI qw( :standard);

my $query = CGI->new;

require LWP::UserAgent;

my $host = $query->param('hostname');
#my $port = $query->param('port');
my $timeout = $query->param('timeout');

my $ua = LWP::UserAgent->new;

$ua->timeout($timeout);

my $response = $ua->get($host);

print "Content-Type: text/html \n\n";

if ($response->is_success) {
    #print $response->content;
    print "Connection established for: $host";
    print "<br/>";
    print "Connection status is: " . $response->status_line;
} else {
    print "Connection failed for: $host";
    print "<br/>";
    print "Connection failed for the following reason: " . $response->status_line;
    #print $response->status_line;
}
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
    print "<br/>";
    #print "HTTP content is " . $response->decoded_content;
    if ($response->previous) {
        print "<br/>";
        print "Redirect Summary: ";
        print "<br/>";
        #print "Host " . $host . " redirected to " . $response->request->uri;
        #print "Host " . $host . " redirected to ";
        my $found_an_https_redirect = 0;
        foreach my $url ($response->redirects) {
            print "<br/>" ;
            #print "Redirect -> " . $url->base;
            print "Redirect -> " . $url->request->uri;
            #print "Redirect -> " . $url->request->uri . " the HTTP status is " . $url->code;
            if (index($url->request->uri, "https://") != -1) {
                $found_an_https_redirect = 1;
            }
        };
        print "<br/>";
        print "<br/>";
        print "Final Destination -> " . $response->request->uri . "the HTTP statis is " . $response->code;
        print "<br/>";
        print "<br/>";
        if ($found_an_https_redirect) {
            print "Found an https redirect!";
        } else {
            print "Did NOT find an https redirect!";
        }
    }
} else {
    print "Connection failed for: $host";
    print "<br/>";
    print "Connection failed for the following reason: " . $response->status_line;
    #print $response->status_line;
}
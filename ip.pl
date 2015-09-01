#!/usr/bin/env perl

use strict;
# use Modern::Perl;

my $pageToGrab = "http://www.ipchicken.com/";
my $command = "curl $pageToGrab";
my $data = `$command`;

if ($data =~ /size="5" color="#0000FF"><b>\n.*?(\d+\.\d+\.\d+\.\d+)/gm) {
    print $1;
} else {
    print "No IP found."
} #end if
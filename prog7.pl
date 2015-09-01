#!/usr/bin/env perl

use Modern::Perl;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author: David Quiring
# Created: Thursday 02/19/15 12:57:50
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.

# Program to add up user time on loki.

# check input peramiters
my $user;
if ($#ARGV == 0 ) {
    $user = substr ($ARGV[0], 0,8);
} else {
    print "Usage $0 login\n";
    exit();
} #end if

my @last = `last`;

# keep track of the number of logins
# keep track of the amount of time loged in

print "Here is a listing of the logins for $user:\n";

my $uHrs = 0;
my $uMin = 0;
my $uLogins = 0;

foreach my $login (@last) {
    chomp $login;
    my @data = split(/ {1,}/, $login);
    if ($login eq '') {
        next;
    } #end if

    if ($data[0] eq $user) {
        $uLogins ++;
        printf ("%3d. ", $uLogins);
        print $login . "\n";
        #print $data[9] . "\n";

        if ( $login =~ /\((\d)?\+?(\d\d):(\d\d)\)/ ) {
            #print $1 . ' | ' . $2 . ' | ' . $3 . "\n"; 

            if (!$1) {
                $uHrs += $2;
                $uMin += $3;
            } else {
                $uHrs += ($1 * 24);
                $uHrs += $2;
                $uMin += $3;
            } #end if
        }#end if
    } #end if
} #end foreach

#fix the number of mins if > 60
if ($uMin > 60) {
    my $exHr = int($uMin/60);
    $uHrs += $exHr;
    $uMin -= (60 * $exHr);
} #end if


printf ("\n%s loged in %d times and loged %02d:%02d (HH:MM)\n", $user, $uLogins, $uHrs, $uMin);

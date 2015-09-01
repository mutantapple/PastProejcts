#!/usr/bin/perl

use Modern::Perl;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author: David Quiring
# Created: Saturday 01/31/15 15:23:53
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.


print "Plese enter a 9 character string: ";
my $st = <>;

chomp $st;

my $v1 = chop ($st);
my $v2 = chop ($st);
my $v3 = chop ($st);
my $v4 = chop ($st);
my $v5 = chop ($st);
my $v6 = chop ($st);
my $v7 = chop ($st);
my $v8 = chop ($st);
my $v9 = chop ($st);

my $pal = "PALINDROME";

#check to the values

if ($v1 ne $v9) {
    $pal = 'NOT';
}

if ($v2 ne $v8) {
    $pal = 'NOT';
}

if ($v3 ne $v7) {
    $pal = "NOT";
}

if ($v4 ne $v6) {
    $pal = "NOT";
}


print $pal;
print "\n";

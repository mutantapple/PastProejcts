#!/usr/bin/perl

use Modern::Perl;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.
# David Quiring

# Author: David Quiring
# Created: Thursday 01/22/15 14:18:24
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.

# simple program to split up a 5 digit number

# Ask the user for the number
print "Enter a five-digit number: ";
my $num = <>;
chomp $num;

    if ($num ~~ [10000..99999]) {

my $np5 = chop $num;
my $np4 = chop $num;
my $np3 = chop $num;
my $np2 = chop $num;
my $np1 = chop $num;

print "$np1   $np2   $np3   $np4   $np5\n\n";
} else {
    print "ERROR: Your number must be five digits in length.\n\n";
}

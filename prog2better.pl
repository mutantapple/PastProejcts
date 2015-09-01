#!/usr/bin/perl

use strict;
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

# This program is going to find out some information about 3 numbers
# that the user enters.

# Get the numbers.
print "Enter the first number:  ";
my $numb1 = <>;
chomp $numb1;
print "Enter the second number: ";
my $numb2 = <>;
chomp $numb2;
print "Enter the thrid number:  ";
my $numb3 = <>;
chomp $numb3;

# Do the math
my $min;
my $max;
my $avg;
my $sum;
my $prd;

$sum = $numb1 + $numb2 + $numb3;
$avg = $sum / 3;
$prd = $numb1 * $numb2 * $numb3;

# find min and max

# find max
#if ($numb1 > $numb2 && $numb1 > $numb3) {
#    $max = $numb1;
#} elsif ($numb2 > $numb1 && $numb2 > $numb3) {
#    $max = $numb2;
#} else {
#    $max = $numb3;
#}

$max = $numb1;
if ($max < $numb2) {
    $max = $numb2;
}
if ($max < $numb3) {
    $max = $numb3;
}

# find min
#if ($numb1 < $numb2 && $numb1 < $numb3) {
#    $min = $numb1;
#} elsif ($numb2 < $numb1 && $numb2 < $numb3) {
#    $min = $numb2;
#} else {
#    $min = $numb3;
#}

$min = $numb1;
if ($min > $numb2) {
    $min = $numb2;
}
if ($min > $numb3) {
    $min = $numb3;
}



#print out the data
print "ADD: $sum\n";
printf ("AVG: %.3f\n", $avg);
print "PRD: $prd\n";
print "LRG: $max\n";
print "SML: $min\n";
print "\n";

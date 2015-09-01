#!/usr/bin/perl

#use Modern::Perl;
use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author: David Quiring
# Created: Tuesday 02/03/15 13:36:26
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.

print "Please enter a binary number up to 30 digits: ";
my $bn = <>;
chomp $bn;

my $flipedBN = '';
my $length = 0;

# make a copy of the origal number to be choped up.
my $bnc = $bn;

# flip the binary number so that we do some math.
while ($bnc ne '') {
    $flipedBN .= (chop $bnc);
    $length ++;
}

my $decimal;
my $exp = $length;

#decrement the exp counter becuse it's obo
$exp --;

#convert the "binary number to decimal"
while ($flipedBN ne '') {
    my $numb;
    my $product;
    $numb = (chop $flipedBN);

    $product = ($numb *= 2 ** $exp);
    $exp --;
    $decimal += $product;
}

#print the data
print $bn . " is " . $decimal . " in decimal.\n\n"
#printf ("%s is %d in decimal. \n\n", $bn, $decimal);

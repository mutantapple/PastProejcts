#!/usr/bin/env perl

use Modern::Perl;
use Data::Dumper;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author: David Quiring
# Created: Tuesday 03/10/15 12:46:35
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.

# usage statment
if ($#ARGV != 0) {
    print "\t Usage: $0 takes the user that you want to do a finger look up on.\n\n";
    exit;
} #end if

my $userName = shift;

#convert the username to a soundex
my $userSDX = &soundex ($userName);

print "The name you were looking for, $userName, converted to $userSDX\n\n";

# # the key-value pairs are the name and the correct Soundex code
# my %sndx = ( "Euler" => "E4600" , "Gauss" => "G2000" ,
#             "Hilbert" => "H4163" , "Knuth" => "K5300",
#             "Lloyd" => "L3000" , "Lukasieicz" => "L2220", );
# print "Processing known names:\n\n";
# my @names = sort {$a cmp $b} keys %sndx;
# for my $nm (@names) {
#     my $findSdx = &soundex($nm); # calls function w/param of $nm
#     print "The soundex for $nm should be $sndx{$nm} and is $findSdx\n";

#     if ( $findSdx ne $sndx{$nm} ) {
#     print "\tHowever, that is incorrect!\n\n";
#     } #end if
# } #end for

# read in /etc/passwd
open (IN,"/etc/passwd");
my @wholeFile = <IN>; 
close IN;

my %userID;
my %lName;
my %fName;

my $numbOfMatches = 0;

foreach my $line (@wholeFile) {
    my ($userid, $firstname, $lastname);

    #get the user data
    ($userid, $firstname, $lastname) = &getNames($line);
    my @args;

    # check to seee if we have a userid match
    if ($userSDX eq &soundex($userid)) {
        @args = ("finger", $userid);
        system (@args);
        $numbOfMatches ++;
    } #end if

    # check to see if we have a first name match
    if ($userSDX eq &soundex($firstname)) {
        @args = ("finger", $firstname);
        system (@args);
        $numbOfMatches ++;
    } #end if

    #check to seee if we have a last name match
    if ($userSDX eq &soundex($lastname)) {
        @args = ("finger", $lastname);
        system (@args);
        $numbOfMatches ++;
    } #end if

} #end foreach

if ($numbOfMatches == 0) {
    print "finger: $userName: no such user\n"
} #end if

### getNames will return the userid, first name , and last name
### of the line past to it from the /etc/passwd file.
sub getNames {
    my $param = shift; #get the argument
    my $userName = '';
    my $fName = '';
    my $lName = '';

    # get the user name
    my @data = split (/:/, $param);

    $userName = $data[0];

    # Get the First and Last name of the user
    if ($data[4]) {
        @data = split (/,/, $data[4]);
        if ($data[0]) {
            @data = split (/ /, $data[0]);
            $fName = $data[0];
            $lName = $data[$#data];
        } #end if
    } #end if 

    return $userName, $fName, $lName;

} #end getNames

### The goal of the soundex subroutine below is to take in a string
### which will be a last name and process it via Soundex magic,
### resulting in $sdxValue at the very end containing the Soundex
### code for the input. So, if "Euler" (no quotes) gets passed in
### to $temp, $sdxValue should contain "E4600" when all work is done.

### basically return the soundex of the vaule pased to it.
sub soundex {
    my $temp = shift;

    # make sure that we have a srint to process
    if (!$temp) {
        return '';
    } #end if

    #convert everything to upercase so we can do a simpler conversion
    $temp = uc $temp; 
    my $sdxValue = '';    

    $sdxValue = substr($temp, 0, 1);

    # do the main conversion
    for (my $i = 1; $i < length($temp); $i++) {
        my $char = substr($temp, $i, 1);
        my $lchar = substr($temp, $i - 1, 1);

        #s/[DT]+/3/g <--- well that would remove the magority of this code.

        # compare the current char to the prevous one.
        # if the it is the same skip it,
        # if it's not save it.
        if ($char =~ /[BFPV]/) {
            if ($lchar =~ /[BFPV]/) {
                next;
            } #end if
            $sdxValue .= '1';
        } #end if

        #see above
        if ($char =~ /[CGJKQSXZ]/) {
            if ($lchar =~ /[CGJKQSXZ]/) {
                next;
            } #end if
            $sdxValue .= '2';
        } #end if 

        #see above
        if ($char =~ /[DT]/) {
            if ($lchar =~ /[DT]/) {
                next;
            } #end if
            $sdxValue .= '3';
        } #end if 

        #see above
        if ($char =~ /[L]/) {
            if ($lchar =~ /[L]/) {
                next;
            } #end if
            $sdxValue .= '4';
        } #end if 

        #see above
        if ($char =~ /[MN]/) {
            if ($lchar =~ /[MN]/) {
                next;
            } #end if
            $sdxValue .= '5';
        } #end if 

        #see above
        if ($char =~ /[R]/) {
            if ($lchar =~ /[R]/) {
                next;
            } #end if
            $sdxValue .= '6';
        } #end if 
    } #end for

    # check to make sure that we have 5 chars
    if (length($sdxValue) < 5) {
        #if it's not long enough add extra zeros
        my $dif = 5 - length($sdxValue);
        $sdxValue .= '0' x $dif; 
    } #end if

    $sdxValue = substr($sdxValue, 0, 5);

    return $sdxValue;
} #end soundex

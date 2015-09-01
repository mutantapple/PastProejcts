#!/usr/bin/env perl

use Modern::Perl;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author: David Quiring
# Created: Tuesday 02/10/15 12:07:42
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.


# Program to gather the votes for the Acadamy Awards
# Set up the arrays for the list of awards
my @selections;
my @bestPicture = (
    'American Sniper',
    'Birdman or (The Unexpected Virtue of Ignorance)',
    'Boyhood',
    'The Grand Budapest Hotel',
    'The Imitation Game',
    'Selma',
    'The Theory of Everything',
    'Whiplash',
    'Write In', );
my @actor = (
    'Steve Carell, "Foxcatcher"',
    'Bradley Cooper, "American Sniper"',
    'Benedict Cumberbatch, "The Imitation Game"',
    'Michael Keaton, "Birdman"',
    'Eddie Redmayne, "The Theory of Everything"',
    'Write In', );
my @actress = (
    'Marion Cotillard, "Two Days, One Night"',
    'Felicity Jones, "The Theory of Everything"',
    'Julianne Moore, "Still Alice"',
    'Rosamund Pike, "Gone Girl"',
    'Reese Witherspoon, "Wild"',
    'Write In',    );
my @animatedFeature = (
    'Big Hero 6',
    'The Boxtrolls',
    'How to Train Your Dragon 2',
    'Song of the Sea',
    'The Tale of Princess Kaguya',
    'Write In', );
my @makeupAndHairstyling = (
    'Foxcatcher',
    'The Grand Budapest Hotel',
    'Guardians of the Galaxy',
    'Write In',    );
my @originalSong = (
    '"Everything is Awesome" from "The Lego Movie"',
    '"Glory" from "Selma"',
    '"Grateful" from "Beyond the Lights"',
    '"I\'m Not Gonna Miss You" from "Glen Campbell . I\'ll Be Me"',
    '"Lost Stars" from "Begin Again"',
    'Write In',);
my @adaptedScreenplay = (
    'American Sniper',
    'The Imitation Game',
    'Inherent Vice',
    'The Theory of Everything',
    'Whiplash',
    'Write In',    );
my @originalScreenplay = (
    'Birdman or (The Unexpected Virtue of Ignorance)',
    'Boyhood',
    'Foxcatcher',
    'The Grand Budapest Hotel',
    'Nightcrawler',
    'Write In',    );

print "Welcome to the 87th Academy Awards! \n";
print "=" x60 . "\n";

# bestPicture
print "The nominees for Best Picture are: \n\n";
my $num = 1;
foreach my $moive (@bestPicture) {
    print "\t [$num] $moive \n";
    $num ++;
} # end foreach

my $pick = -1;

while ($pick != 0...$#bestPicture) {
    print "Please enter your choice for Best Picture now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#bestPicture) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[0] = $candidate;
        last;

    } elsif ($pick == 0..$#bestPicture) {
        $selections[0] = $bestPicture[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[0] . " as Best Picture.\n";
print "=" x60 . "\n\n";

# Actor in a Leading Role
print "The nominees for Actor in a Leading Role are: \n\n";
$num = 1;
foreach my $actor (@actor) {
    print "\t [$num] $actor \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#actor) {
    print "Please enter your choice for Actor now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#actor) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[1] = $candidate;
        last;

    } elsif ($pick == 0..$#actor) {
        $selections[1] = $actor[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[1] . " as Actor in a Leading Role.\n";
print "=" x60 . "\n\n";

# Actress in a Leading Role
print "The nominees for Actress in a Leading Role are: \n\n";
$num = 1;
foreach my $actress (@actress) {
    print "\t [$num] $actress \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#actress) {
    print "Please enter your choice for Actress now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#actress) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[2] = $candidate;
        last;

    } elsif ($pick == 0..$#actress) {
        $selections[2] = $actress[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[2] . " as Actress in a Leading Role.\n";
print "=" x60 . "\n\n";


# Animated Feature Film
print "The nominees for Animated Feature Film are: \n\n";
$num = 1;
foreach my $fiml (@animatedFeature) {
    print "\t [$num] $fiml \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#animatedFeature) {
    print "Please enter your choice for Animated Feature Film now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#animatedFeature) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[3] = $candidate;
        last;

    } elsif ($pick == 0..$#animatedFeature) {
        $selections[3] = $animatedFeature[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[3] . " as Animated Feature Film.\n";
print "=" x60 . "\n\n";


# Animated Feature Film
print "The nominees for Makeup and Hairstyling are: \n\n";
$num = 1;
foreach my $makeup (@makeupAndHairstyling) {
    print "\t [$num] $makeup \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#makeupAndHairstyling) {
    print "Please enter your choice for Makeup and Hairstyling now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#makeupAndHairstyling) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[4] = $candidate;
        last;

    } elsif ($pick == 0..$#makeupAndHairstyling) {
        $selections[4] = $makeupAndHairstyling[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[4] . " as Makeup and Hairstyling.\n";
print "=" x60 . "\n\n";


# Original Song
print "The nominees for Original Song are: \n\n";
$num = 1;
foreach my $song (@originalSong) {
    print "\t [$num] $song \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#originalSong) {
    print "Please enter your choice for Makeup and Hairstyling now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#originalSong) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[5] = $candidate;
        last;

    } elsif ($pick == 0..$#originalSong) {
        $selections[5] = $originalSong[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[5] . " as Original Song.\n";
print "=" x60 . "\n\n";


# Adapted Screenplay
print "The nominees for Adapted Screenplay are: \n\n";
$num = 1;
foreach my $screenplay (@adaptedScreenplay) {
    print "\t [$num] $screenplay \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#adaptedScreenplay) {
    print "Please enter your choice for Makeup and Hairstyling now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#adaptedScreenplay) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[6] = $candidate;
        last;

    } elsif ($pick == 0..$#adaptedScreenplay) {
        $selections[6] = $adaptedScreenplay[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[6] . " as Adapted Screenplay.\n";
print "=" x60 . "\n\n";

# Original Screenplay
print "The nominees for Original Screenplay are: \n\n";
$num = 1;
foreach my $screenplay (@originalScreenplay) {
    print "\t [$num] $screenplay \n";
    $num ++;
} # end foreach

$pick = -1;
while ($pick != 0...$#originalScreenplay) {
    print "Please enter your choice for Makeup and Hairstyling now: ";
    $pick = <>;
    chomp $pick;

    # off set selection to correct obo
    $pick -- ;

    # process the data
    if ($pick == $#originalScreenplay) {
        print "Please enter your write-in candidate: ";
        my $candidate = <>;
        chomp $candidate;

        $selections[6] = $candidate;
        last;

    } elsif ($pick == 0..$#originalScreenplay) {
        $selections[6] = $originalScreenplay[$pick];
        last;

    } else {
        printf ("I'm sorry, but %d is not a valid option.\n",$pick);
    } #end else if
} #end while

print "Thank you for selecting " . $selections[6] . " as Original Screenplay.\n";
print "=" x60 . "\n\n";



#print the results
foreach my $results (@selections) {
    print $results. "\n";
} #end foreach




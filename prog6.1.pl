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
my %selections;
my %data = (
    'Best Picture' => [
        'American Sniper',
        'Birdman or (The Unexpected Virtue of Ignorance)',
        'Boyhood',
        'The Grand Budapest Hotel',
        'The Imitation Game',
        'Selma',
        'The Theory of Everything',
        'Whiplash',
        'Write In', ],
    'Actor in a Leading Role' => [
        'Steve Carell, "Foxcatcher"',
        'Bradley Cooper, "American Sniper"',
        'Benedict Cumberbatch, "The Imitation Game"',
        'Michael Keaton, "Birdman"',
        'Eddie Redmayne, "The Theory of Everything"',
        'Write In', ],
    'Actress in a Leading Role' => [
        'Marion Cotillard, "Two Days, One Night"',
        'Felicity Jones, "The Theory of Everything"',
        'Julianne Moore, "Still Alice"',
        'Rosamund Pike, "Gone Girl"',
        'Reese Witherspoon, "Wild"',
        'Write In',    ],
    'Animated Feature Film' => [
        'Big Hero 6',
        'The Boxtrolls',
        'How to Train Your Dragon 2',
        'Song of the Sea',
        'The Tale of Princess Kaguya',
        'Write In', ],
    'Makeup and Hairstyling' => [
        'Foxcatcher',
        'The Grand Budapest Hotel',
        'Guardians of the Galaxy',
        'Write In',    ],
    'Original Song' => [
        '"Everything is Awesome" from "The Lego Movie"',
        '"Glory" from "Selma"',
        '"Grateful" from "Beyond the Lights"',
        '"I\'m Not Gonna Miss You" from "Glen Campbell . I\'ll Be Me"',
        '"Lost Stars" from "Begin Again"',
        'Write In', ], 
    'Writing Adapted Screenplay' => [
        'American Sniper',
        'The Imitation Game',
        'Inherent Vice',
        'The Theory of Everything',
        'Whiplash',
        'Write In',    ],
    'Writing Original Screenplay' => [
        'Birdman or (The Unexpected Virtue of Ignorance)',
        'Boyhood',
        'Foxcatcher',
        'The Grand Budapest Hotel',
        'Nightcrawler',
        'Write In',    ],);

my @catagories = (
    'Best Picture',
    'Actor in a Leading Role',
    'Actress in a Leading Role',
    'Animated Feature Film',
    'Makeup and Hairstyling',
    'Original Song',
    'Writing Adapted Screenplay',
    'Writing Original Screenplay',
);


print "Welcome to the 87th Academy Awards! \n";
print "=" x60 . "\n";

foreach my $catagory (@catagories) {
    print "The nominees for " . $catagory . " are: \n\n";

    my $num = 1;

    foreach my $movie (@{$data{$catagory}}) {
        print "\t [$num] $movie\n";
        $num ++;
    } #end foreach
    my @aCatagory = @{$data{$catagory}};

    #get the users pic
    my $pick = -1;

    while (!(0 <= $pick && $pick <= $#aCatagory)) {
        print "Please enter your choice for $catagory now: ";
        $pick = <>;
        chomp $pick;
        $pick --; #to correct for obo

        if ($pick == $#aCatagory) {
            print "Please enter your write-in candidate: ";
            my $candidate = <>;
            chomp $candidate;
            $selections{$catagory} = $candidate;
        } elsif (0 <= $pick && $pick <= $#aCatagory) {
            $selections{$catagory} = $aCatagory[$pick];
        } else {
            printf ("I'm sorry, but %d is not a valid option.\n",$pick + 1);
        } #end elseif
    } #end while

    print "Thank you for selecting $selections{$catagory} as $catagory.\n";
    print "=" x60 . "\n\n";
} #end foreach


#print the results
print "Thank you for voting. Here is a summary of your votes: \n\n";
foreach my $catagory (@catagories) {
    print "For $catagory you voted for: \n";
    print "\t $selections{$catagory}\n\n";

} #end foreach



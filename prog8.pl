#!/usr/bin/env perl

use Modern::Perl;
use Mail::Sendmail;
use Data::Dumper;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author: David Quiring
# Created: Tuesday 02/24/15 13:21:44
# Email: dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.

my $pageToGrab = "http://boxofficemojo.com/weekend/chart/";
my $command = "lynx -dump -width=205 $pageToGrab";
my $allData = `$command`;

my $mailTo;

if ($#ARGV == 0 ) {
    $mailTo = shift;
} else {
    print "Usage $0 email address\n";
    exit();
} #end if

# Data that we are interested in
# Position this week.
# Position Last week
# Title
# Weekend
# Cumalative

my @movies;
while ($allData =~ /(\d+|N|-).*?(\d+|N|-).*?\[\d+\](.*)\[.*?(\$\S+).*?\$\W?.*?(\$\S+)+.*\n/g) {

    push @movies, [$1, $2, substr ($3, 0,30), $4, $5];
} #end while

#print Dumper @movies;

#print "Data scraped from http://boxofficemojo.com/weekend/chart/\n";
#print "### ### Movie Title \tWeekend\t Cume\n";

# Now that we have that taken care of now we have to process the data.
# Biggest Debut: The Equalizer (1)
# Weakest Debut: Lilting (97)
# Biggest Gain: Hector And The Search For Happiness (24 places)
# Biggest Loss: Iceman (2014) (25 places)
my $biggestDebut;
my $bdPos;
my $weakestDebut;
my $wdPos;
my $biggestGain;
my $bgPlaces = 0;
my $biggestLoss;
my $blPlaces = 0;

my $formatedData = sprintf "Data scraped from http://boxofficemojo.com/weekend/chart/\n";
$formatedData .= sprintf "###\t###\tMovie Title\t\t\tWeekend\t\tCume\n";

foreach my $movie (@movies) {
    #print Dumper $movie;
    #print @$movie[0] . "\n";

    # Set the Biggest Debut
    if (!$biggestDebut) { 
        if (@$movie[1] eq 'N'){
            $biggestDebut = @$movie[2];
            $bdPos = @$movie[0];
        } #end if
    } #end if

    # set the Weakest Debut
    if (@$movie[1] eq 'N'){
        $weakestDebut = @$movie[2];
        $wdPos = @$movie[0];
    } #end if

    # find the biggest gain
    # pre - cur
    if (@$movie[0] =~ /\d+/ && @$movie[1] =~ /\d+/) {
        my $tmp = @$movie[1] - @$movie[0];
        if ($bgPlaces < $tmp) {
            $bgPlaces = $tmp;
            $biggestGain = @$movie[2];
        } #end if
    } #end if

    #find the biggest loss
    if (@$movie[0] =~ /\d+/ && @$movie[1] =~ /\d+/) {
        my $tmp = @$movie[0] - @$movie[1];
        if ($blPlaces < $tmp) {
            $blPlaces = $tmp;
            $biggestLoss = @$movie[2];
        } #end if
    } #end if
    #printf("%3s\t%3s\t%s\n",@$movie[0], @$movie[1], @$movie[2]);
    $formatedData .= sprintf("%3s\t%3s\t%s\t%-12s\t%s\n",
        @$movie[0], @$movie[1], @$movie[2], @$movie[3], @$movie[4]);

} #end while

$formatedData .= sprintf "\n";
$formatedData .= sprintf ("Biggest Debut:\t %s [%03d]\n", $biggestDebut, $bdPos);
$formatedData .= sprintf ("Weakest Debut:\t %s [%03d]\n", $weakestDebut, $wdPos);
$formatedData .= sprintf ("Biggest Gain:\t %s [%03d places]\n", $biggestGain, $bgPlaces);
$formatedData .= sprintf ("Biggest Loss:\t %s [%03d places]\n", $biggestLoss, $blPlaces);

my $mailFrom = 'dquiring@unomaha.edu';
my $subjectLine = "Weekend Box Office Report";
my $message = "<pre>$formatedData</pre>";
my %mail = ( To => $mailTo,
    From => $mailFrom,
    Subject => $subjectLine,
    Message => $message, # must be a string, not an array
    'Content-Type' => 'text/html; charset="utf-8"'
);
if (sendmail %mail) {
    print "Successfully sent mail to $mailTo. Check your box!\n";
}
else {
    print "Error sending mail: $Mail::Sendmail::error \n";
}

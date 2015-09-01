#!/usr/bin/env perl

use Modern::Perl;
use Net::hostent;
#use diagnostics;

# Honor Pledge: On my honor as a student of the University
# of Nebraska at Omaha, I have neither given nor received
# unauthorized help on this homework assignment.

# Author:  David Quiring
# Created: Thursday 03/19/15 13:29:28
# Email:   dquiring@greenaliensw.com
# Copyright(c) 2015 Green Alien Software LLC. All Rights Reserved.

# usage statment
if (!@ARGV) {
    print "\t Usage: $0 takes a list of apache acces log files and creates a summary.\n\n";
    exit;
} #end if

my $totalNumberOfBites = 0;
my $numberOfFiles = 0;
my $numberOfEntries = 0;
my %hostNames;
my %domains;
my %dates;
my %hours;
my %statusCodes;
my %urls;
my %fileTypes;
my %userAgents;
my %browserFamilies;
my %referrers;
my %referrersDomains;
my %operatingSystems;

my $output = '';

# process each suplied file.
foreach my $file (@ARGV) {
    open (IN,"$file");
    my @wholeFile = <IN>; 
    close IN;

    # incomnet the number of files. <--- yes i'm doing this with a counter becuse I can.
    $numberOfFiles++;

    # process each line in the log file.
    foreach my $line (@wholeFile) {
        if ($line =~ /(\d+\.\d+\.\d+\.\d+).*\[(\d+\/\w+\/\d+):(\d+):.+?"(\w+) (\/?.*\/?) (.*?)" (\d+) (\d+) "(.*?)"\s"(.*)"/) {
            #incoment the number of entries
            $numberOfEntries++;

            my $ip = $1;
            my $date = $2;
            my $hr = $3;
            my $request = $4;
            my $resource = $5;
            my $requestType = $6;
            my $statusCode = $7;
            my $numberOfBites = $8;
            my $referrer = $9;
            my $userAgent = $10;

            $totalNumberOfBites += $numberOfBites;

            my $hostName = &ipLookUp ($ip);

            # store the date for the host names.
            if ($hostNames{$hostName}) {
                $hostNames{$hostName} ++;
            } else {
                $hostNames{$hostName} = 1;
            } #end else;

            my $domain = &getDomain ($hostName);

            # store the data for the domains
            if ($hostName =~ /(\d+\.\d+\.\d+\.\d+)/) {
                if ($domains{"DOTTED QUAD OR OTHER"}) {
                    $domains{"DOTTED QUAD OR OTHER"} ++;
                } else {
                    $domains{"DOTTED QUAD OR OTHER"} = 1;
                } #end if
            } elsif ($domains{$domain}) {
                $domains{$domain} ++;
            } else {
                $domains{$domain} = 1;
            } #end if

            # store the data for the dates
            if ($dates{$date}) {
                $dates{$date} ++;
            } else {
                $dates{$date} = 1;
            } #end if

            # store the data for the hours
            if ($hours{$hr}) {
                $hours{$hr} ++;
            } else {
                $hours{$hr} = 1;
            } #end if

            # store the data for the status codes
            if ($statusCodes{$statusCode}) {
                $statusCodes{$statusCode} ++;
            } else {
                $statusCodes{$statusCode} = 1;
            } #end if

            # store the data for urls
            if ($urls{$resource}) {
                $urls{$resource} ++;
            } else {
                $urls{$resource} = 1;
            } #end if

            # store the data for File Types
            my $fileType = &getFileType($resource);

            if ($fileTypes{$fileType}) {
                $fileTypes{$fileType} ++;
            } else {
                $fileTypes{$fileType} = 1;
            } #end if

            # Idealy we would track two different types browser data
            # The browser and then the version for each
            # This data could be displayed in two differnt ways.
            # combined and separate.
            # I would do it in a combined method.
            # It would look something like this.
            # Hits  %-age   Resource                                                    
            # ----  -----   --------
            #   50   4.50   Chrome
            #    1   0.40   39.0.2171

            # Sore the data for the user agents
            # subsitute "-" for NO BROWSER ID
            if ($userAgent eq "-") {
                $userAgent = "NO BROWSER ID";
            } # end if

            if ($userAgents{$userAgent}) {
                $userAgents{$userAgent} ++;
            } else {
                $userAgents{$userAgent} = 1;
            } #end if

            # Store the data for the browser family
            my $browserFamilie = &getBrowserFamilie($userAgent);
            if ($browserFamilies{$browserFamilie}) {
                $browserFamilies{$browserFamilie} ++;
            } else {
                $browserFamilies{$browserFamilie} = 1;
            } #end if

            # sore the referrers
            # check for reffere
            if ($referrer eq '-') {
                $referrer = 'NO REFERER';
            } #end if

            if ($referrers{$referrer}) {
                $referrers{$referrer} ++;
            } else {
                $referrers{$referrer} = 1;
            } #end if

            # get the REFERRERS' DOMAINS
            # check for no referrer
            if ($referrer eq 'NO REFERER') {
                if ($referrersDomains{"NONE"}) {
                    $referrersDomains{"NONE"} ++;
                } else {
                    $referrersDomains{"NONE"} = 1;
                } # end if
            } else {
                my $reDomain = &getRefDomain ($referrer);
                if ($referrersDomains{$reDomain}) {
                    $referrersDomains{$reDomain} ++;
                } else {
                    $referrersDomains{$reDomain} = 1;
                } #end if
            } #end if

            # get the Operating Systems
            my $os = &getOS ($userAgent);
            if ($operatingSystems{$os}) {
                $operatingSystems{$os} ++;
            } else {
                $operatingSystems{$os} = 1;
            } #end if


        }#end if
    } #end foreach
} #end foreach

# $output .=  out the data
$output .=  "Web Server Log Analyzer v0.0.1\n\n";

$output .=  "Processed $numberOfEntries entries from $numberOfFiles log files.\n";
$output .=  "Processed the following logfiles:\n";
foreach my $logFile (@ARGV) {
    $output .=  "$logFile ";
} #end foreach

$output .=  "\n\n";

# start with hostNames
$output .=  '='x79 . "\n";
$output .=  "HOSTNAMES\n";
$output .=  '='x79 . "\n"; 

$output .=  "  Hits %-age  Host Name\n";
$output .=  "  ---- -----  ---------\n";
$output .=  "\n";

foreach my $key (sort keys %hostNames) {
    my $percentage = ($hostNames{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $hostNames{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# now do the domain names

$output .=  '='x79 . "\n";
$output .=  "DOMAINS\n";
$output .=  '='x79 . "\n"; 

$output .=  "  Hits %-age  Domains\n";
$output .=  "  ---- -----  -------\n";
$output .=  "\n";

foreach my $key (sort keys %domains) {
    my $percentage = ($domains{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $domains{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# now do the dates

$output .=  '='x79 . "\n";
$output .=  "DATES\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  Dates\n";
$output .=  "  ---- -----  -----\n";
$output .=  "\n";

foreach my $key (sort keys %dates) {
    my $percentage = ($dates{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $dates{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

#now do the Hours

$output .=  '='x79 . "\n";
$output .=  "HOURS\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  Hours\n";
$output .=  "  ---- -----  -----\n";
$output .=  "\n";

foreach my $key (sort keys %hours) {
    my $percentage = ($hours{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $hours{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the Status Codes

$output .=  '='x79 . "\n";
$output .=  "Status Codes\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  Status Codes\n";
$output .=  "  ---- -----  ------------\n";
$output .=  "\n";

foreach my $key (sort keys %statusCodes) {
    my $percentage = ($statusCodes{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $statusCodes{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the URLS

$output .=  '='x79 . "\n";
$output .=  "URLS\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  URLS\n";
$output .=  "  ---- -----  ----\n";
$output .=  "\n";

foreach my $key (sort keys %urls) {
    my $percentage = ($urls{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $urls{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the File Types

$output .=  '='x79 . "\n";
$output .=  "FILE TYPES\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  FILE TYPES\n";
$output .=  "  ---- -----  ----------\n";
$output .=  "\n";

foreach my $key (sort keys %fileTypes) {
    my $percentage = ($fileTypes{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $fileTypes{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the browsers

$output .=  '='x79 . "\n";
$output .=  "BROWSERS\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  BROWSERS\n";
$output .=  "  ---- -----  --------\n";
$output .=  "\n";

foreach my $key (sort keys %userAgents) {
    my $percentage = ($userAgents{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $userAgents{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the BROWSER FAMILIES

$output .=  '='x79 . "\n";
$output .=  "BROWSER FAMILIES\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  BROWSER FAMILIES\n";
$output .=  "  ---- -----  ----------------\n";
$output .=  "\n";

foreach my $key (sort keys %browserFamilies) {
    my $percentage = ($browserFamilies{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $browserFamilies{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the BROWSER FAMILIES

$output .=  '='x79 . "\n";
$output .=  "BROWSER REFERRERS\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  REFERRERS\n";
$output .=  "  ---- -----  ---------\n";
$output .=  "\n";

foreach my $key (sort keys %referrers) {
    my $percentage = ($referrers{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $referrers{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the BROWSER FAMILIES

$output .=  '='x79 . "\n";
$output .=  "REFERRERS' DOMAINS\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  REFERRERS' DOMAINS\n";
$output .=  "  ---- -----  ------------------\n";
$output .=  "\n";

foreach my $key (sort keys %referrersDomains) {
    my $percentage = ($referrersDomains{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $referrersDomains{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

# do the OSs

$output .=  '='x79 . "\n";
$output .=  "OPERATING SYSTEMS\n";
$output .=  '='x79 . "\n";

$output .=  "  Hits %-age  OPERATING SYSTEMS\n";
$output .=  "  ---- -----  ------------------\n";
$output .=  "\n";

foreach my $key (sort keys %operatingSystems) {
    my $percentage = ($operatingSystems{$key}/$numberOfEntries) * 100;
    $output .= sprintf ("%6d %5.2f  %-s\n", $operatingSystems{$key}, $percentage, $key);
} #end foreach
$output .=  " -----\n";
$output .= sprintf ("%6d entries displayed\n", $numberOfEntries);
$output .=  "\n\n\n";

$output .=  "Total bytes served: $totalNumberOfBites \n\n";

# print $output;

# write the data out to file dquiring.summary

my $filename = 'dquiring.summary';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "$output";
close $fh;
print "The log procesing has complated. The results can be found in dquiring.summary\n";

# end "main"


# Do the host look up for the preceing url
sub getDomain {
    my $hostName = shift;
    my $domain;

    if ($hostName =~ /.*\.(\S+\.\S+)/) {
        $domain = $1;
    } else {
        $domain = $hostName;
    } # end if

    return $domain;
} #end getDomain

# Do the host look up for the IP
sub ipLookUp {
    ### Now we set $name to the hostname if the lookup (gethost) succeeds
    my $IP = shift;
    my $name;
    if ( my $h = gethost($IP) ) {
        $name = $h->name();
        return $name;
    } else {
        return $IP;
    } #end if.
} #end ipLookUp

# Get the file type
sub getFileType {
    ### get the file type
    my $resource = shift;
    my $fileType = 'Other';

    if ($resource =~ /\.cgi/) { #is the file cgi
        $fileType = "CGI Program (cgi)";
    } elsif ($resource =~ /\.jpg|\.jpeg|\.gif|\.ico|\.png/) { #is the file jpg,jpeg,gif,ico,png
        $fileType = "Image (jpg,jpeg,gif,ico,png)";
    } elsif ($resource =~ /\.css/) { # is the file css
        $fileType = "Style Sheet (CSS)";
    } elsif ($resource =~ /\.html|\.htm/) {#is the fiel htm,html
        $fileType = "Web Pages (htm,html)";
    } #end if

    return $fileType;
} # end getFileTypes

# return what browser the user is using
sub getBrowserFamilie {
    my $browserFamilie = 'Unknown';
    my $browserString = shift;

    if($browserString =~ /Chrome/) {
        $browserFamilie = "Chrome";
    } elsif ($browserString =~ /Safari/) {
        $browserFamilie = "Safari";
    } elsif ($browserString =~ /Firefox/) {
        $browserFamilie = "Firefox";
    } elsif ($browserString =~ /Opera/) {
        $browserFamilie = "Opera";
    } elsif ($browserString =~ /MSIE/) {
        $browserFamilie = "MSIE";
    } #end if

    return $browserFamilie;

} # end getBrowserFamilie

# return the os of the requester
sub getOS {
    my $os = 'Other';
    my $string = shift;

    if ($string =~ /nux/) {
        $os = 'Linux';
    } elsif ($string =~ /Mac/) {
        $os = 'Macintosh';
    } elsif ($string =~ /Windows/) {
        $os = 'Windows';
    } #end if

    return $os;
} #end getOS

# returns the domain from a url.
sub getRefDomain {
    my $domain = '';
    my $urlSrtring = shift;

    if ($urlSrtring =~ /.*\.(\S+?\.\S+?)\//) {
        $domain = $1;
    } else {
        $domain = 'NONE';
    }#end if

} #end getRefDomain
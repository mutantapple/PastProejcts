#!/usr/bin/env perl

use Modern::Perl;
use Data::Dump qw(dump);
use DateTime;

#this will back up the minecraft servers.
#keep 7 days worth of zip backups just incase something goes wrong.
#I will move these backups over to an external volume either in an ftp or locally.
#useing rsync -varmz

#----Run Dayly----

#1. make a dir for each server
#2. rsync the files over (olny changes)
#3. zip the files and name the zip the the name of the machine and the date
#4. check for and remove old backup zips

# server name, ip and file path.

# my @serverList = ( 
# 		  {
# 		   name => 'MC1',
# 		   ip => '192.168.2.151',
# 		   path => '~/McMyAdmin/Minecraft'
# 		  },
# 		  {
# 		   name => 'MC2',
# 		   ip => '192.168.2.152',
# 		   path => '~/mc'
# 		  }
# 	   );

my @serverList = ( 
          {
           name => 'MC1',
           ip => '192.168.2.151',
           path => '~/McMyAdmin/Minecraft'
          },
       );
#dump($serverList);

#copy over earch server's data files
foreach $server (@serverList) {
	$rpath = $server->{ip} . ':' . $server->{path} . '/';
	$lpath = "~/mcserverbackup/" . $server->{name};
	
	system("rsync -armz --delete $rpath $lpath");
}


#zip management

my $dt = DateTime->now;
my $date  = $dt->ymd;
$dt->subtract( days => 7 );
my $wdate = $dt->ymd; #-7 days

foreach my $server (@serverList) {
        my $path = $server->{name};
        my $zip = $server->{name}. '_' . $date . '.zip';

        #make the zip file

        system("cd  ~/mcserverbackup && zip -urq $zip $path");

        #delete old backups after 1 week.

        system("rm ~/mcserverbackup/$server->{name}_$wdate.zip");
}
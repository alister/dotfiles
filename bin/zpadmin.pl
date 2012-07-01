#!/usr/bin/perl -w
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
# Author : Paul.Errington@northtyneside.gov.uk
# Date : 10 Sept 2007
# Description : manage your zpools!
#
#  # ZPOOL MONITOR ->
#  0,30 * * * * /pathtobin/zpadmin.pl
#
#  # ZPOOL WEEKLY SCRUB ->
#  0 5 * * 0 /pathtobin/zpadmin.pl -scrub
#
#=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

use strict;
use Time::localtime;
use Getopt::Long;
use Net::SMTP;
use Sys::Hostname;

my $log_path="/home/alister/zpool_adm.log";
my $hostname = hostname;

sub log_event {
      my $event = shift;
      my @abbr = qw( Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec );

      open(EVENT_ZLOG, ">> $log_path") or die "can't open $log_path: $!";
      flock(EVENT_ZLOG, 2) or die "can't flock $log_path: $!";

      printf EVENT_ZLOG "%s %d %02d:%02d:%02d %s: %s\n", @abbr[localtime->mon()],
                              localtime->mday(),
                              localtime->hour(),
                              localtime->min(),
                              localtime->sec(),
                              $hostname,
                              $event;

      close(EVENT_ZLOG) or die "can't close $log_path: $!";
}

sub get_zp_list {
# zpool list -H -o name
      my $pool_names = `zpool list -H -o name`;
      if ($pool_names eq "no pools available\n") {
            return $pool_names;
      }
      my @pool_names = split("\n",$pool_names);
      return @pool_names;
}

sub get_zp_health {
# zpool list -H -o health $pool_name
      my $pool_name = shift;
      my $result = `zpool list -H -o health $pool_name`;
      chomp $result;
      return $result;
}

sub get_zp_scrub {
}

sub get_zp_errors {
}

sub scrub_pool {
# zpool scrub $pool_name
      my $pool_name = shift;
      system("zpool scrub $pool_name") == 0 or
            die "zpool scrub $pool_name failed: $?";
      my $result = $? >> 8;

      if ($? == -1) {
            print "failed to execute: $!\n";
            log_event("[ERROR] scrub_pool: failed to execute: $!");
            return $result;
        } elsif ($? & 127) {
            printf "child died with signal %d, %s coredump\n",
                  ($? & 127),  ($? & 128) ? 'with' : 'without';
            log_event("[ERROR] scrub_pool: child died and coredumped");
            return $result;
        } else {
            #printf "child exited with value %d\n", $? >> 8;
            return $result;
        }
}

sub mailme {
      my ($message) = @_;
      my $mydomain = $hostname;
      my $mailfrom = "admin\@$hostname";
      my $mailto = "sysadmin\@wherewelive.com";
      my $mailhost = "mailhost"; # switch to ip or real mail host

      my $smtp = Net::SMTP->new($mailhost,
                  Hello => $mydomain,
                  Timeout => 30,
                  Debug   => 0 );
      $smtp->mail($mailfrom);
      $smtp->recipient($mailto);
      $smtp->data();
      $smtp->datasend("To: $mailto\n");
      $smtp->datasend("Subject: Zpool on $hostname requires sysadmin attention\n");
      $smtp->datasend("\n");
      $smtp->datasend("$message");
      $smtp->dataend();
      $smtp->quit;
}

#START PROCESS>>>
if ( ! -f "/sbin/zpool") {
      print "zpools not supported in this sun release.\n";
      exit 1;
}

zpcheck();

sub zpcheck {
      my ($scrub, $check, $verbose);
      GetOptions("scrub" => \$scrub, "check" => \$check, "verbose" => \$verbose);
      my @zpools = get_zp_list();

      if ($zpools[0] eq "no pools available\n") {
            print "no pools defined!\n" if(defined($verbose));
            return 0;
      }

      foreach my $pool (@zpools) {
            my $health = get_zp_health($pool);
            if ( $health eq "ONLINE" ) {
                  print "zpool $pool status is $health, ok.\n" if(defined ($verbose));
                  #log_event("[STATUS] zpool $pool status is $health, ok.");
		 		if(defined($scrub)) {
                        print "Starting scrub of pool $pool..." if(defined ($verbose));
                        if (scrub_pool($pool)) {
                              print "error initiating scrub.\n" if(defined ($verbose));
                              log_event("[ERROR] Could not start scrub on zpool $pool.");
                        } else {
                              log_event("[VERIFY] Scrub started on zpool $pool.");
                              print "running.\n" if(defined($verbose));
                        }
                  }
            } else {
                  $health = "unknown" if (!$health);
                  print "Problem with zpool $pool detected, status is $health\n" if(defined($verbose));
                  log_event("[ERROR] Problem with zpool $pool detected, status is $health.");
                  mailme("zpool $pool on host $hostname is status $health.  \n");
            }
      }
}


##############################################################################
### This script is submitted to BigAdmin by a user of the BigAdmin community.
### Sun Microsystems, Inc. is not responsible for the
### contents or the code enclosed. 
###
###
###  Copyright Sun Microsystems, Inc. ALL RIGHTS RESERVED
### Use of this software is authorized pursuant to the
### terms of the license found at
### http://www.sun.com/bigadmin/common/berkeley_license.jsp
##############################################################################

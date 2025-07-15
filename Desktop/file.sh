#!/bin/bash

sec2date()
{
     perl -e 'use POSIX qw(strftime);
              $mt = strftime "%c", localtime($ARGV[0]);
              print $mt,"\n";' "$1"

}
# start here
# assumes you want to run right now, then every 8 hours
#  %c is the current default locale's version for date

/usr/bin/date +%c > ~/datefile
# this is the number of seconds between runs 3600 sec = 1 hour
export lapse=$(( 4 * 1 ))

# loop forever
while :
do
  testdate=$(cat datefile)                            # read date time from file
  when=$(/usr/bin/date --date="$testdate" +%s)  # turn date into seconds
  now=$(/usr/bin/date +%s)                      # right now in seconds
  
  if [[ $now -ge $when ]] ; then
     echo "running my job here"   # change this to run a job
     /usr/bin/date +%c > ~/datefile && cat ~/datefile
     when=$(( $when + $lapse ))
     sec2date $when > ~/datefile
  fi
  
  sleep 1      
done

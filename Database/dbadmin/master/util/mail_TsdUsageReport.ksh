#!/bin/ksh

. /etc/profile

mailinglist="mkahn@fast-track.com lshields@fast-track.com nparmelee@fast-track.com"
sender="dmishra@fast-track.com"
cclist="dmishra@fast-track.com kkingdon@fast-track.com"

sed "s/$/`echo \\\r`/" /export/home/reports/reports/tsd/TsdBetaUsage.pdf | \
uuencode TsdBetaUsage.pdf | \
mailx -r $sender -s "TSD Beta Usage Report" -c $cclist $mailinglist

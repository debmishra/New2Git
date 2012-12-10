#!/bin/ksh

. /etc/profile

pagerlist="4156862541@vtext.com dmishra@mdsol.com"
mailinglist="dmishra@mdsol.com"

export ORACLE_SID=prod
export ORACLE_HOME=/u01/app/oracle/product/10.2.0

day_of_week=`date +%u`
logfile=/export/home/oracle/log/rman_hot_bkup.txt.$(date +%m%d_%H%m)

if [ $day_of_week -eq 1 ]
then
   cmdfile=/export/home/oracle/util/hot_db_bkup_lvl0.rcv
else
   cmdfile=/export/home/oracle/util/hot_db_bkup_lvl1.rcv
fi

echo $day_of_week "====" > $logfile
echo $cmdfile "===="     > $logfile

$ORACLE_HOME/bin/rman CMDFILE "$cmdfile" LOG "$logfile"

egrep "ORA-|RMAN-" $logfile
if [ $? -eq 0 ] ; then
  echo "RMAN backup failure" | mailx -s  "FAILED -- $ORACLE_SID rman backup $cmdfile " $pagerlist
else
  echo "Successful" | mailx -s  "SUCCESS -- $ORACLE_SID rman backup $cmdfile ..." $mailinglist
fi

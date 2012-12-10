#!/bin/ksh
# Script Definition
# The script runs in the BR database site and checks the Primary if both
# the log history is in sync.
# Usage stby_sync_status.ksh <local> <remote> <threshhold_number>
# example stby_sync_status.ksh prod prod 4
#
#############################################################################

. /etc/profile
cd ~oracle
. ./.profile

export LOCAL=$1;
export REMOTE=$2;
export THRESHOLD=$3;
export ORACLE_SID=$LOCAL;
export ALERT_DBA="dmishra@mdsol.com 4156862541@vtext.com"
export MAIL_DBA="dmishra@mdsol.com"
ORACLE_USER=system
ORACLE_PWD=`get_pwd $ORACLE_USER`
echo $ORACLE_SID

#sqlplus /nolog << EOF
#connect / as sysdba
sqlplus -s "/ as sysdba"  << EOF
set heading off;
set echo off;
spool /tmp/stdby_\$LOCAL.lst;
select max(sequence#) from v\$log_history;
exit;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD@prod_primary << EOF
set heading off;
set echo off;
spool /tmp/prim_\$REMOTE.lst;
select max(sequence#) from v\$archived_log;
exit;
EOF

primary_seq_cnt=`cat /tmp/prim_$REMOTE.lst|grep -v SQL | grep " "|tr -s " "`
stbdy_seq_cnt=`cat /tmp/stdby_$LOCAL.lst|grep -v SQL | grep " "|tr -s " "`

#echo $primary_seq_cnt
#echo $stbdy_seq_cnt

DIFFER=`expr $primary_seq_cnt-$stbdy_seq_cnt`

if [[ $DIFFER -gt $THRESHOLD ]] 
then
echo "Behind $DIFFER logs in $LOCAL `date`">> $MSG1
echo "Log archive is $DIFFER behind in standby`date`" | mailx -s "STANDBY STATUS: $LOCAL Lagging" $ALERT_DBA
exit
fi
echo "STANDBY sync status -- $DIFFER logs differ" | mailx -s "STANDBY STATUS: $DIFFER difference" $ALERT_DBA

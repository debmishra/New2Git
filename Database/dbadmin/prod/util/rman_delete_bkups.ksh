#!/bin/ksh
### RMAN delete obsolete bkups ###

. /etc/profile

export ORACLE_SID=demo
export ORACLE_HOME=/u01/app/oracle/product/10.2.0

day_of_week=`date +%u`

$ORACLE_HOME/bin/rman CMDFILE "/home/oracle/util/rman_delete_bkup.rcv" LOG "/home/oracle/log/rman_delete_bkup..txt.$(date +%m%d_%H%m)"

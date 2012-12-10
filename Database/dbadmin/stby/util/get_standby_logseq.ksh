#!/bin/ksh
# Get sequence number of last archival file applied to standby
# This is executed by a job from the primary database server.
#
export ORACLE_SID=prod
export ORACLE_HOME=/u01/app/oracle/product/10.2.0
export PATH=$PATH:$ORACLE_HOME/bin
sqlplus -s "/ as sysdba"  << EOF
set heading off;
set echo off;
select max(sequence#) from v\$log_history;
exit;
EOF

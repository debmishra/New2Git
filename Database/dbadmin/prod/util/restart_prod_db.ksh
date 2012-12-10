#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\restart_prod_db.ksh$ 
#
#
# Description:  Monthly job to restart the production database
#
#############################################################
 
. /etc/profile

ORACLE_SID=prod;export ORACLE_SID
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

email="dmishra@mdsol.com"
pager="4156862541@vtext.com"

#########################
###Only run script on 1st
###Saturday of each month.
#########################

if [[ `date +%u` -ne 6 ]]
then
   exit 1
fi

if [[ `date +%d` -gt 7 ]]
then
  exit 1
fi

########################
###Shutdown the database
########################

sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

sleep 10

#######################
###Startup the database
#######################

sqlplus /nolog << EOF
connect / as sysdba
startup 
exit

EOF

if [[ `ps -ef | grep ora_pmon_prod| grep -v grep | wc -l` -ne 1 ]]
 then
   echo "Production database is down" | mailx -s "Unable to start Prod DB" "dmishra@mdsol.com"
   echo "Production database is down" | mailx -s "Unable to start Prod DB" "4156862541@vtext.com"
fi


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         6/7/2011 10:10:10 PM Debashish Mishra 
# $
# 
#############################################################

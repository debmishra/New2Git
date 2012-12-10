#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: export_test.ksh$ 
#
# $Revision: 7$        $Date: 2/27/2008 3:23:09 PM$
#
#
# Description:  Exports the fasttrack schema of test database
#
#############################################################
 
. /etc/profile
cd $oracle
. ./.profile


#mv /work/orabackup/test/dump/*test.dmp*.Z /dumpstore1/testdump/
#mv /work/orabackup/test/dump/*prev.dmp*.Z /dumpstore2/prevdump/


export ORACLE_SID=test

ORACLE_USER=admin
ORACLE_PWD=`get_pwd $ORACLE_USER`

tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 100
select ','||lower(username) from dba_users where username like 'TSM10%' or username like 'FT15%';
EOF`

tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

/u01/app/oracle/product/9.2.0/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=ftcommon,tsmclient0$tsmclient_list \
FILE=/work/orabackup/test/dump/tsm10_test.dmp \
LOG=/u01/app/oracle/log/tsm10_test.dmp.log

echo
echo
echo "List of users exported:" >> /u01/app/oracle/log/tsm10_test.dmp.log
echo ftcommon,tsmclient0$tsmclient_list >> /u01/app/oracle/log/tsm10_test.dmp.log


mv /work/orabackup/test/dump/tsm10_test.dmp /work/orabackup/test/dump/tsm10_test.dmp.$(date +%m%d)
mv /u01/app/oracle/log/tsm10_test.dmp.log /u01/app/oracle/log/tsm10_test.dmp.log.$(date +%m%d)

compress /work/orabackup/test/dump/tsm10_test.dmp.$(date +%m%d)

export ORACLE_SID=prev

ORACLE_USER=admin
ORACLE_PWD=`get_pwd $ORACLE_USER`

tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 100
select ','||lower(username) from dba_users where username like 'TSM10%' or username like 'FT15%';
EOF`

tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

/u01/app/oracle/product/9.2.0/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=ftcommon,tsmclient0$tsmclient_list \
FILE=/work/orabackup/test/dump/tsm10_prev.dmp \
LOG=/u01/app/oracle/log/tsm10_prev.dmp.log

echo
echo
echo "List of users exported:" >> /u01/app/oracle/log/tsm10_prev.dmp.log
echo ftcommon,tsmclient0$tsmclient_list >> /u01/app/oracle/log/tsm10_prev.dmp.log

mv /work/orabackup/test/dump/tsm10_prev.dmp /work/orabackup/test/dump/tsm10_prev.dmp.$(date +%m%d)
mv /u01/app/oracle/log/tsm10_prev.dmp.log /u01/app/oracle/log/tsm10_prev.dmp.log.$(date +%m%d)

compress /work/orabackup/test/dump/tsm10_prev.dmp.$(date +%m%d)

export ORACLE_SID=



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         2/27/2008 3:23:09 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:45:52 AM  Debashish Mishra  
#  5    DevTSM    1.4         5/7/2004 5:28:07 PM  Debashish Mishra  
#  4    DevTSM    1.3         2/20/2004 4:55:02 PM Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:24:24 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:06 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:45 AM Debashish Mishra 
# $
# 
#############################################################

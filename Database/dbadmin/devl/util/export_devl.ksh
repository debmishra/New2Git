#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: export_devl.ksh$ 
#
# $Revision: 8$        $Date: 2/27/2008 3:22:33 PM$
#
#
# Description:  Exports the fasttrack schema of devl database
#
#############################################################
 
. /etc/profile

export ORACLE_SID=devl

ORACLE_USER=admin
ORACLE_PWD=`get_pwd $ORACLE_USER`

tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 100
select ','||lower(username) from dba_users where username like 'TSM10%' and username <> 'TSM10' ;
EOF`

tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

/u01/app/oracle/product/9.0.1/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=ftdc,emul,ft15t,ft15e,ft15,tsm10$tsmclient_list \
FILE=/work/orabackup/devl/dump/tsm10_devl.dmp \
LOG=/export/home/oracle/log/tsm10_devl.dmp.log

echo
echo
echo "List of users exported:" >> /export/home/oracle/log/tsm10_devl.dmp.log
echo ftdc,emul,ft15t,ft15e,ft15,tsm10$tsmclient_list >> /export/home/oracle/log/tsm10_devl.dmp.log

# /u01/app/oracle/product/9.0.1/bin/exp USERID=fasttrack14a/welcome@devl OWNER=fasttrack14a \
# FILE=/work/orabackup/devl/dump/fasttrack14a_devl.dmp \
# LOG=/export/home/oracle/log/fasttrack14a_devl.dmp.log

# mv /work/orabackup/devl/dump/fasttrack14a_devl.dmp /work/orabackup/devl/dump/fasttrack14a_devl.dmp.$(date +%m%d)
# mv /export/home/oracle/log/fasttrack14a_devl.dmp.log /export/home/oracle/log/fasttrack14a_devl.dmp.log.$(date +%m%d)
mv /work/orabackup/devl/dump/tsm10_devl.dmp /work/orabackup/devl/dump/tsm10_devl.dmp.$(date +%m%d)
mv /export/home/oracle/log/tsm10_devl.dmp.log /export/home/oracle/log/tsm10_devl.dmp.log.$(date +%m%d)

compress /work/orabackup/devl/dump/tsm10_devl.dmp.$(date +%m%d)

# export ORACLE_SID=utest

# ORACLE_USER=admin
# ORACLE_PWD=`get_pwd $ORACLE_USER`

# tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
# set hea off
# set feedback off
# set pages 100
# select ','||lower(username) from dba_users where username like 'TSM10%' and username <> 'TSM10' ;
# EOF`

# tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

# /u01/app/oracle/product/9.0.1/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
# OWNER=ft15,tsm10$tsmclient_list \
# FILE=/work/orabackup/devl/dump/tsm10_utest.dmp \
# LOG=/export/home/oracle/log/tsm10_utest.dmp.log

# echo
# echo
# echo "List of users exported:" >> /export/home/oracle/log/tsm10_utest.dmp.log
# echo ft15,tsm10$tsmclient_list >> /export/home/oracle/log/tsm10_utest.dmp.log


# mv /work/orabackup/devl/dump/tsm10_utest.dmp /work/orabackup/devl/dump/tsm10_utest.dmp.$(date +%m%d)
# mv /export/home/oracle/log/tsm10_utest.dmp.log /export/home/oracle/log/tsm10_utest.dmp.log.$(date +%m%d)


export ORACLE_SID=



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         2/27/2008 3:22:33 PM Debashish Mishra  
#  7    DevTSM    1.6         3/3/2005 6:42:49 AM  Debashish Mishra  
#  6    DevTSM    1.5         2/20/2004 4:55:14 PM Debashish Mishra  
#  5    DevTSM    1.4         12/26/2003 4:23:31 PMDebashish Mishra  
#  4    DevTSM    1.3         5/16/2003 1:11:28 PM Debashish Mishra added ft15e to
#       it
#  3    DevTSM    1.2         2/25/2003 12:33:10 PMDebashish Mishra  
#  2    DevTSM    1.1         1/21/2003 1:21:11 PM Debashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:09 AM Debashish Mishra 
# $
# 
#############################################################

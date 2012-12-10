#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: export_demo.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:22:55 PM$
#
#
# Description:  Exports the fasttrack schema of test database
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

export ORACLE_SID=test1

ORACLE_USER=admin
ORACLE_PWD=`get_pwd $ORACLE_USER`

tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 100
select ','||lower(username) from dba_users where username like 'TSMCLIENT%';
EOF`

tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

/oracle/product/9.0.1/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=ft15t,tsm10t,ft15,tsm10$tsmclient_list \
FILE=/u02/app/oracle/dump/test1/tsm10_test1.dmp \
LOG=/export/home/oracle/log/tsm10_test1.dmp.log

echo
echo
echo "List of users exported:" >> /export/home/oracle/log/tsm10_test1.dmp.log
echo ft15t,tsm10t,ft15,tsm10$tsmclient_list >> /export/home/oracle/log/tsm10_test1.dmp.log


mv /u02/app/oracle/dump/test1/tsm10_test1.dmp /u02/app/oracle/dump/test1/tsm10_test1.dmp.$(date +%m%d)
mv /export/home/oracle/log/tsm10_test1.dmp.log /export/home/oracle/log/tsm10_test1.dmp.log.$(date +%m%d)

export ORACLE_SID=demo

ORACLE_USER=admin
ORACLE_PWD=`get_pwd $ORACLE_USER`

tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 100
select ','||lower(username) from dba_users where username like 'TSMCLIENT%';
EOF`

tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

/oracle/product/9.0.1/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=ft15,tsm10$tsmclient_list \
FILE=/u02/app/oracle/dump/demo/tsm10_demo.dmp \
LOG=/export/home/oracle/log/tsm10_demo.dmp.log

echo
echo
echo "List of users exported:" >> /export/home/oracle/log/tsm10_demo.dmp.log
echo ft15,tsm10$tsmclient_list >> /export/home/oracle/log/tsm10_demo.dmp.log

mv /u02/app/oracle/dump/demo/tsm10_demo.dmp /u02/app/oracle/dump/demo/tsm10_demo.dmp.$(date +%m%d)
mv /export/home/oracle/log/tsm10_demo.dmp.log /export/home/oracle/log/tsm10_demo.dmp.log.$(date +%m%d)

export ORACLE_SID=



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:22:55 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:44:23 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/6/2002 1:35:25 PM  Debashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:20 AM Debashish Mishra 
# $
# 
#############################################################

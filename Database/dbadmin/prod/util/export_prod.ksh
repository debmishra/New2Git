#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: export_prod.ksh$ 
#
# $Revision: 15$        $Date: 6/7/2011 10:05:15 PM$
#
#
# Description:  Export the fasttrack schema of production database
#
#############################################################
 
. /etc/profile

find /s03/oracle/disk_bkup/dump/ -type f -mtime +7 -print -exec rm -f {} \;
mv /orabackup/prod/dump/* /s03/oracle/disk_bkup/dump/

export ORACLE_SID=prod
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

tsmclient_list1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF 
set hea off
set feedback off
set pages 100
select ','||lower(username) from dba_users where username like 'TSM%' and username not like 'TSM10E%';
EOF`

tsmclient_list=`echo $tsmclient_list1 | tr -d " "`

/u01/app/oracle/product/10.2.0/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=dmishra,ftcommon$tsmclient_list \
FILE=/orabackup/prod/dump/tsm_prod.dmp \
LOG=/export/home/oracle/log/tsm_prod.dmp.log

echo
echo
echo "List of users exported:" >> /export/home/oracle/log/tsm_prod.dmp.log
echo dmishra,ftcommon$tsmclient_list >> /export/home/oracle/log/tsm_prod.dmp.log

mv /orabackup/prod/dump/tsm_prod.dmp /orabackup/prod/dump/tsm_prod.dmp.$(date +%m%d)
mv /export/home/oracle/log/tsm_prod.dmp.log /export/home/oracle/log/tsm_prod.dmp.log.$(date +%m%d)

#compress /orabackup/prod/dump/tsm_prod.dmp.$(date +%m%d)

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  15   DevTSM    1.14        6/7/2011 10:05:15 PM Debashish Mishra  
#  14   DevTSM    1.13        8/11/2009 12:03:27 AMDebashish Mishra  
#  13   DevTSM    1.12        2/27/2008 3:21:50 PM Debashish Mishra  
#  12   DevTSM    1.11        3/15/2005 7:16:37 PM Debashish Mishra  
#  11   DevTSM    1.10        3/3/2005 6:44:53 AM  Debashish Mishra  
#  10   DevTSM    1.9         10/13/2004 8:01:22 AMDebashish Mishra  
#  9    DevTSM    1.8         12/26/2003 4:21:35 PMDebashish Mishra  
#  8    DevTSM    1.7         10/13/2003 9:53:34 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  7    DevTSM    1.6         7/14/2003 5:10:37 PM Debashish Mishra  
#  6    DevTSM    1.5         7/2/2003 5:43:39 PM  Debashish Mishra  
#  5    DevTSM    1.4         2/25/2003 12:40:54 PMDebashish Mishra  
#  4    DevTSM    1.3         9/16/2002 3:47:16 PM Debashish Mishra  
#  3    DevTSM    1.2         9/6/2002 4:44:58 PM  Debashish Mishra Modified after
#       new schemas
#  2    DevTSM    1.1         8/5/2002 1:54:53 PM  Debashish Mishra Modified for
#       implementation of audit_trail
#  1    DevTSM    1.0         8/1/2002 11:41:34 AM Debashish Mishra 
# $
# 
#############################################################

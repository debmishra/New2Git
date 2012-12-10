#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: mail_errors.ksh$ 
#
# $Revision: 9$        $Date: 6/7/2011 10:05:16 PM$
#
#
# Description:  <ADD>
#
#############################################################
. /etc/profile
cd ~oracle
. ./.profile

echo ""					>  /export/home/oracle/mail_errors.log
echo "Disk Space Position" 		>>  /export/home/oracle/mail_errors.log
echo "===================" 		>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log

df -k 					>> /export/home/oracle/mail_errors.log

echo "" 				>> /export/home/oracle/mail_errors.log
echo "Free space in tablespaces"	>> /export/home/oracle/mail_errors.log
echo "========================="	>> /export/home/oracle/mail_errors.log
echo""					>> /export/home/oracle/mail_errors.log

sqlplus -s /nolog << EOF   		>> /export/home/oracle/mail_errors.log
connect / as sysdba
set pages 200
select a.tablespace_name, a.max_size, a.allocated_size, b.total_free, b.max_free from
(select tablespace_name,sum(bytes)/(1024*1024) allocated_size,
sum(maxbytes)/(1024*1024) max_size from dba_data_files
group by tablespace_name) a,(
select tablespace_name,sum(bytes)/(1024*1024) total_free, 
max(bytes)/(1024*1024) max_free from dba_free_space
group by tablespace_name) b where
a.tablespace_name=b.tablespace_name(+);
exit;
EOF


echo ""					>> /export/home/oracle/mail_errors.log
echo "Oracle processs" 			>>  /export/home/oracle/mail_errors.log
echo "===============" 			>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log

ps -ef | grep oracle | grep -v grep 	>> /export/home/oracle/mail_errors.log

echo ""					>> /export/home/oracle/mail_errors.log
echo "Oracle Listener" 			>>  /export/home/oracle/mail_errors.log
echo "===============" 			>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log

lsnrctl status 				>> /export/home/oracle/mail_errors.log

echo ""					>> /export/home/oracle/mail_errors.log
echo "Hot Backup Logs" 			>>  /export/home/oracle/mail_errors.log
echo "===============" 			>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log

grep ORA- /orabackup/prod/hot/hot_backup_prod.log >> /export/home/oracle/mail_errors.log


echo ""					>> /export/home/oracle/mail_errors.log
echo "Other Logs" 			>>  /export/home/oracle/mail_errors.log
echo "==========" 			>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log
echo "Plz. review following log files. If there are no files, then ignore this section" >> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log

find /export/home/oracle/log -type f -mtime -1 | grep -il ORA- >> /export/home/oracle/mail_errors.log

echo ""					>> /export/home/oracle/mail_errors.log
echo "Alert Logs" 			>>  /export/home/oracle/mail_errors.log
echo "==========" 			>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log


grep ORA- /u01/app/oracle/admin/prod/bdump/alert_prod.log >> /export/home/oracle/mail_errors.log
cat /u01/app/oracle/admin/prod/bdump/alert_prod.log >> /u01/app/oracle/admin/prod/bdump/alert_prod_save.log
rm /u01/app/oracle/admin/prod/bdump/alert_prod.log

if [[ $(date +%d) = 01 ]]
  then 
   if [[ $(date +%m) = 01 || $(date +%m) = 04 || $(date +%m) = 07 || $(date +%m) = 10 ]]
     then
       mv /u01/app/oracle/admin/prod/bdump/alert_prod_save.log /u01/app/oracle/admin/prod/bdump/alert_prod_backup.log
   fi
fi

echo ""					>> /export/home/oracle/mail_errors.log
echo "Trace Files" 			>>  /export/home/oracle/mail_errors.log
echo "==========" 			>> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log
echo "Here is the list of Trace files generated in last 24 hrs. Look for only *.trc files" >> /export/home/oracle/mail_errors.log
echo ""					>> /export/home/oracle/mail_errors.log

find /u01/app/oracle/admin/prod/bdump -type f -mtime -1 >> /export/home/oracle/mail_errors.log


cat /export/home/oracle/mail_errors.log | mailx -s ErrorLogs -r dmishra@mdsol.com "dmishra@mdsol.com"

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  9    DevTSM    1.8         6/7/2011 10:05:16 PM Debashish Mishra  
#  8    DevTSM    1.7         8/11/2009 12:03:27 AMDebashish Mishra  
#  7    DevTSM    1.6         2/27/2008 3:21:51 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:44:57 AM  Debashish Mishra  
#  5    DevTSM    1.4         10/13/2004 8:01:25 AMDebashish Mishra  
#  4    DevTSM    1.3         10/13/2003 9:53:37 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  3    DevTSM    1.2         9/9/2003 8:25:16 AM  Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:55 PMDebashish Mishra  
#  1    DevTSM    1.0         9/16/2002 11:27:56 AMDebashish Mishra 
# $
# 
#############################################################

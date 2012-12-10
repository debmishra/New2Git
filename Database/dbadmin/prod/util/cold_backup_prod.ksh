#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cold_backup_prod.ksh$ 
#
# $Revision: 12$        $Date: 6/7/2011 10:05:14 PM$
#
#
# Description:  cold backup of the production database
#
#############################################################
 
. /etc/profile

ORACLE_SID=prod;export ORACLE_SID
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

dest_dir=/orabackup/prod/tts

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$datafile;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >>/export/home/oracle/util/cb_datafile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/data' from v\$tempfile;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_controlfile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||name||' $dest_dir/control' from v\$controlfile;
EOF

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF  >/export/home/oracle/util/cb_logfile
set hea off
set feedback off
set pages 0
set lin 200
select 'cp '||member||' $dest_dir/redolog' from v\$logfile;
EOF

chmod 755 /export/home/oracle/util/cb_datafile
chmod 755 /export/home/oracle/util/cb_controlfile
chmod 755 /export/home/oracle/util/cb_logfile

#Shutdown the database

sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

#copy the database files


/export/home/oracle/util/cb_datafile
/export/home/oracle/util/cb_controlfile
/export/home/oracle/util/cb_logfile
cp /u01/app/oracle/product/10.2.0/dbs/initprod.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/dbs/spfileprod.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/tnsnames.ora $dest_dir/config
cp /u01/app/oracle/product/10.2.0/network/admin/listener.ora $dest_dir/config
mv /export/home/oracle/util/cb_datafile $dest_dir/config
mv /export/home/oracle/util/cb_controlfile $dest_dir/config
mv /export/home/oracle/util/cb_logfile $dest_dir/config

#Startup the database

sqlplus /nolog << EOF
connect / as sysdba
startup 
exit

EOF

#Verify the cold backup

. /etc/profile
cd ~oracle
. ./.profile

dest_dir=/orabackup/prod/tts/data
log_dir=/export/home/oracle/log

email="dmishra@mdsol.com 4156862541@vtext.com"
nopage="dmishra@mdsol.com"
pager="4156862541@vtext.com"

rm -rf $log_dir/verify_cold_backup.log

cd $dest_dir
for filename in `ls *.dbf`
do
$ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_cold_backup.log 2>&1
done

if [[ `grep DBV- $log_dir/verify_cold_backup.log | wc -l` -ne 0 ]]
 then
   grep DBV- $log_dir/verify_cold_backup.log | mailx -s "Prod DBV Errors Cold backup" $nopage
   echo 'DBV errors in prod cold backup' | mailx -s "Prod DBV Errors" $pager
fi

errcnt=0

for num1 in `grep 'Total Pages Failing' $log_dir/verify_cold_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num1`
done

for num2 in `grep 'Total Pages Marked Corrupt' $log_dir/verify_cold_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num2`
done

if [[ $errcnt -ne 0 ]] 
 then
   echo 'Block corruption in Prod coldbackup'| mailx -s Block_corruption $email
fi



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  12   DevTSM    1.11        6/7/2011 10:05:14 PM Debashish Mishra  
#  11   DevTSM    1.10        8/11/2009 12:03:26 AMDebashish Mishra  
#  10   DevTSM    1.9         2/27/2008 3:21:49 PM Debashish Mishra  
#  9    DevTSM    1.8         3/3/2005 6:44:49 AM  Debashish Mishra  
#  8    DevTSM    1.7         10/13/2004 8:01:20 AMDebashish Mishra  
#  7    DevTSM    1.6         9/12/2004 3:19:44 AM Debashish Mishra  
#  6    DevTSM    1.5         1/7/2004 2:13:07 PM  Debashish Mishra Modified for
#       dbv & tsm10t
#  5    DevTSM    1.4         10/13/2003 9:53:32 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  4    DevTSM    1.3         6/30/2003 8:58:32 AM Debashish Mishra Modified after
#       space problems in production server
#  3    DevTSM    1.2         2/25/2003 12:40:52 PMDebashish Mishra  
#  2    DevTSM    1.1         8/5/2002 1:54:52 PM  Debashish Mishra Modified for
#       implementation of audit_trail
#  1    DevTSM    1.0         8/1/2002 11:41:34 AM Debashish Mishra 
# $
# 
#############################################################

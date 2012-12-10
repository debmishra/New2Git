#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cold_backup_devl.ksh$ 
#
# $Revision: 6$        $Date: 2/27/2008 3:22:33 PM$
#
#
# Description: This Script backsup the DEVL database everynight after shutting it down 
#
#############################################################

. /etc/profile

ORACLE_SID=devl;export ORACLE_SID
ORACLE_USER=dmishra
ORACLE_PWD=`get_pwd $ORACLE_USER`

#Check for the day to decide the destination directory for the backup

 if [[ $(date +%a) = Mon || $(date +%a) = Wed || $(date +%a) = Fri ]]
   then
     dest_dir=/work/orabackup/devl/mwf
 else
     dest_dir=/work/orabackup/devl/tts
 fi

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

/u01/app/oracle/product/9.2.0/bin/sqlplus /nolog << EOF
connect $ORACLE_USER/$ORACLE_PWD as sysdba
shutdown immediate
exit

EOF

#copy the database files


/export/home/oracle/util/cb_datafile
/export/home/oracle/util/cb_controlfile
/export/home/oracle/util/cb_logfile
cp /u01/app/oracle/admin/devl/pfile/initdevl.ora $dest_dir/config
cp /u01/app/oracle/product/9.2.0/network/admin/tnsnames.ora $dest_dir/config
cp /u01/app/oracle/product/9.2.0/network/admin/listener.ora $dest_dir/config
mv /export/home/oracle/util/cb_datafile $dest_dir/config
mv /export/home/oracle/util/cb_controlfile $dest_dir/config
mv /export/home/oracle/util/cb_logfile $dest_dir/config


#Startup the database

/u01/app/oracle/product/9.2.0/bin/sqlplus /nolog << EOF
connect $ORACLE_USER/$ORACLE_PWD as sysdba
startup pfile=/u01/app/oracle/admin/devl/pfile/initdevl.ora
exit

EOF

#Verify the files that has been backed up

. /etc/profile
cd ~oracle
. ./.profile

dest_dir=/work/orabackup/devl/tts/data
log_dir=/export/home/oracle/log
email=dmishra@fast-track.com

rm -rf $log_dir/verify_cold_backup.log
cd $dest_dir


for filename in `ls *.dbf`
do
$ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_cold_backup.log 2>&1
done

if [[ `grep DBV- $log_dir/verify_cold_backup.log | wc -l` -ne 0 ]]
 then
   grep DBV- $log_dir/verify_cold_backup.log | mailx -s "DBV Errors from rossvr5" $email
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
   echo 'Block corruption in rossvr5 coldbackup'| mailx -s Block_corruption $email
fi



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/27/2008 3:22:33 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:42:47 AM  Debashish Mishra  
#  4    DevTSM    1.3         1/7/2004 2:12:23 PM  Debashish Mishra Modified for
#       dbv
#  3    DevTSM    1.2         12/26/2003 4:23:31 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:33:10 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:08 AM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cold_backup_test.ksh$ 
#
# $Revision: 7$        $Date: 2/27/2008 3:23:09 PM$
#
#
# Description:  This Script backsup the TEST database everynight after shutting it down
#
#############################################################
 
. /etc/profile

ORACLE_SID=test;export ORACLE_SID

#Check for the day to decide the destination directory for the backup

 if [[ $(date +%a) = Mon || $(date +%a) = Wed || $(date +%a) = Fri ]]
   then
     dest_dir=/work/orabackup/test/mwf
 else
     dest_dir=/work/orabackup/test/tts
 fi

#Shutdown the database

/u01/app/oracle/product/9.0.1/bin/sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

#copy the database files

rm -rf $dest_dir/data/*

cp /u02/oracle/database/test/*.dbf $dest_dir/data
compress $dest_dir/data/*.dbf
cp /u03/oracle/database/test/*.dbf $dest_dir/data
compress $dest_dir/data/*.dbf
cp /u02/oracle/database/test/*.ctl $dest_dir/control
cp /u02/oracle/database/test/*.log $dest_dir/redolog
cp /u03/oracle/database/test/*.ctl $dest_dir/control
cp /u03/oracle/database/test/*.log $dest_dir/redolog
cp /u01/app/oracle/admin/test/oradata/*.log $dest_dir/redolog
cp /u01/app/oracle/admin/test/oradata/*.ctl $dest_dir/control
cp /u01/app/oracle/admin/test/pfile/inittest.ora $dest_dir/config
cp /oracle/app/oracle/product/9.0.1/network/admin/tnsnames.ora $dest_dir/config
cp /oracle/app/oracle/product/9.0.1/network/admin/listener.ora $dest_dir/config


#Startup the database

/u01/app/oracle/product/9.0.1/bin/sqlplus /nolog << EOF
connect / as sysdba
startup pfile=/u01/app/oracle/admin/test/pfile/inittest.ora
exit

EOF

ORACLE_SID=prev;export ORACLE_SID

dest_dir=/work/orabackup/prev/tts


#Shutdown the database

/u01/app/oracle/product/9.0.1/bin/sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

#copy the database files

cp /u02/oracle/database/prev/*.dbf $dest_dir/data
cp /u03/oracle/database/prev/*.dbf $dest_dir/data
cp /u02/oracle/database/prev/*.ctl $dest_dir/control
cp /u02/oracle/database/prev/*.log $dest_dir/redolog
cp /u03/oracle/database/prev/*.ctl $dest_dir/control
cp /u03/oracle/database/prev/*.log $dest_dir/redolog
cp /u01/app/oracle/admin/prev/oradata/*.log $dest_dir/redolog
cp /u01/app/oracle/admin/prev/oradata/*.ctl $dest_dir/control
cp /u01/app/oracle/admin/prev/pfile/initprev.ora $dest_dir/config

#Startup the database

/u01/app/oracle/product/9.0.1/bin/sqlplus /nolog << EOF
connect / as sysdba
startup pfile=/u01/app/oracle/admin/prev/pfile/initprev.ora
exit

EOF

ORACLE_SID= ;export ORACLE_SID

# Verify the Preview cold backup

 
. /etc/profile
cd ~oracle
. ./.profile

dest_dir=/work/orabackup/prev/tts/data
log_dir=/u01/app/oracle/log
email=dmishra@fast-track.com

rm -rf $log_dir/verify_prev_cold_backup.log
cd $dest_dir


for filename in `ls *.dbf`
do
$ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_prev_cold_backup.log 2>&1
done

if [[ `grep DBV- $log_dir/verify_prev_cold_backup.log | wc -l` -ne 0 ]]
 then
   grep DBV- $log_dir/verify_prev_cold_backup.log | mailx -s "Prev DBV Errors" $email
fi

errcnt=0

for num1 in `grep 'Total Pages Failing' $log_dir/verify_prev_cold_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num1`
done

for num2 in `grep 'Total Pages Marked Corrupt' $log_dir/verify_prev_cold_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num2`
done

if [[ $errcnt -ne 0 ]] 
 then
   echo 'Block corruption in Prev database coldbackup'| mailx -s Block_corruption $email
fi

# Verify the test cold backup

 
. /etc/profile
cd ~oracle
. ./.profile

dest_dir=/work/orabackup/test/tts/data
log_dir=/u01/app/oracle/log
email=dmishra@fast-track.com

rm -rf $log_dir/verify_test_cold_backup.log
cd $dest_dir


for filename in `ls *.dbf.Z`
do
uncompress $filename
filename2=`echo $filename|cut -f1-2 -d.` 
$ORACLE_HOME/bin/dbv file=$filename2 blocksize=8192 >> $log_dir/verify_test_cold_backup.log 2>&1
compress $filename2
done

if [[ `grep DBV- $log_dir/verify_test_cold_backup.log | wc -l` -ne 0 ]]
 then
   grep DBV- $log_dir/verify_test_cold_backup.log | mailx -s "Test DBV Errors" $email
fi

errcnt=0

for num1 in `grep 'Total Pages Failing' $log_dir/verify_test_cold_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num1`
done

for num2 in `grep 'Total Pages Marked Corrupt' $log_dir/verify_test_cold_backup.log | cut -f2 -d: | cut -c2`
do
errcnt=`expr $errcnt + $num2`
done

if [[ $errcnt -ne 0 ]] 
 then
   echo 'Block corruption in test database coldbackup'| mailx -s Block_corruption $email
fi


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         2/27/2008 3:23:09 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:45:51 AM  Debashish Mishra  
#  5    DevTSM    1.4         2/12/2004 10:41:19 AMDebashish Mishra  
#  4    DevTSM    1.3         1/7/2004 2:13:26 PM  Debashish Mishra dbv
#       implemented for preview
#  3    DevTSM    1.2         7/16/2003 4:49:10 PM Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:05 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:45 AM Debashish Mishra 
# $
# 
#############################################################

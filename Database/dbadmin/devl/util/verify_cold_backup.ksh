#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: verify_cold_backup.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:22:34 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
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
#  3    DevTSM    1.2         2/27/2008 3:22:34 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:42:54 AM  Debashish Mishra  
#  1    DevTSM    1.0         2/20/2004 4:55:19 PM Debashish Mishra 
# $
# 
#############################################################

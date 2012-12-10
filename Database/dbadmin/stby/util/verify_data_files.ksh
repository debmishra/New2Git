#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: verify_data_files.ksh$ 
#
# $Revision: 3$        $Date: 4/18/2011 8:06:35 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
#Verify the cold backup

. /etc/profile
cd ~oracle
. ./.profile


ORACLE_SID=prod;export ORACLE_SID

#Shutdown the database

/u01/app/oracle/product/10.2.0/bin/sqlplus /nolog << EOF
connect / as sysdba
shutdown immediate
exit

EOF

# verify the database files in place

dest_dir=/r02/oracle/oradata/prod
dest_dir2=/r03/oracle/oradata/prod
dest_dir3=/r04/oracle/oradata/prod
dest_dir4=/r05/oracle/oradata/prod
log_dir=/export/home/oracle/log

email="dmishra@mdsol.com 4156862541@vtext.com mpasupuleti@mdsol.com 5105011758@tmomail.net"
nopage=dmishra@mdsol.com
pager="4156862541@vtext.com 5105011758@tmomail.net"

rm -rf $log_dir/verify_cold_backup.log

cd $dest_dir
for filename in `ls *.dbf`
do
 if [[ `echo $filename | grep "@" | wc -l` -eq 0 ]]
   then
     $ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_cold_backup.log 2>&1
 fi
done

cd $dest_dir2
for filename in `ls *.dbf`
do
 if [[ `echo $filename | grep "@" | wc -l` -eq 0 ]]
   then
     $ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_cold_backup.log 2>&1
 fi
done

cd $dest_dir3
for filename in `ls *.dbf`
do
 if [[ `echo $filename | grep "@" | wc -l` -eq 0 ]]
   then
     $ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_cold_backup.log 2>&1
 fi
done

cd $dest_dir4
for filename in `ls *.dbf`
do
 if [[ `echo $filename | grep "@" | wc -l` -eq 0 ]]
   then
     $ORACLE_HOME/bin/dbv file=$filename blocksize=8192 >> $log_dir/verify_cold_backup.log 2>&1
 fi
done

if [[ `grep DBV- $log_dir/verify_cold_backup.log | wc -l` -ne 0 ]]
 then
   grep DBV- $log_dir/verify_cold_backup.log | mailx -s "Stby DBV Errors Cold backup" $nopage
   echo 'DBV errors in stby cold backup' | mailx -s "Stby DBV Errors" $pager
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
   echo 'Block corruption in Stby files'| mailx -s Block_corruption $email
fi


#Start the database

/u01/app/oracle/product/10.2.0/bin/sqlplus /nolog << EOF
connect / as sysdba
startup nomount;
Alter database mount standby database;
exit

EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         4/18/2011 8:06:35 AM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:46:23 AM  Debashish Mishra  
#  1    DevTSM    1.0         1/7/2004 2:13:38 PM  Debashish Mishra 
# $
# 
#############################################################

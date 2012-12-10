#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: compare_ear_stat.ksh$ 
#
# $Revision: 5$        $Date: 4/18/2011 8:06:35 AM$
#
#
# Description:  <ADD>
#
#############################################################

mailinglist="dmishra@mdsol.com"
home_dir=/export/home/oracle/log
 
rcp smssvr2:$home_dir/smssvr1_ear_stat $home_dir/smssvr1_ear_stat

if [[ -f $home_dir/compare_ear_stat.out ]]
 then
  rm -rf $home_dir/compare_ear_stat.out
fi

cat $home_dir/smssvr1_ear_stat | while read value1 size1 file1
  do
    num1=`grep $file1 $home_dir/rossvr3_ear_stat | wc -l`
     if [[ $num1 -eq 0 ]]
       then
         echo "$file1 not found in standby apps server"  >> $home_dir/compare_ear_stat.out    
     elif [[ $num1 -gt 2 ]]
       then
         echo "multiple entries found for $file1. Stat file corrupted" >> $home_dir/compare_ear_stat.out
     else
        grep $file1 $home_dir/rossvr3_ear_stat | read value2 size2 file2
        if [[ $value1 = $value2 && $size1 = $size2 ]] 
         then
          echo  "Both checksum and size match for $file1"
        else
          echo "either checksum or size doesn't match for $file1" >> $home_dir/compare_ear_stat.out
        fi
     fi
  done

if [[ -f $home_dir/compare_ear_stat.out ]]
 then
  cat $home_dir/compare_ear_stat.out | mailx -s "ear comparison failed" $mailinglist
fi






#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         4/18/2011 8:06:35 AM Debashish Mishra  
#  4    DevTSM    1.3         3/3/2005 6:46:21 AM  Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:24:48 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:32 PMDebashish Mishra  
#  1    DevTSM    1.0         2/11/2003 6:47:31 PM Debashish Mishra 
# $
# 
#############################################################


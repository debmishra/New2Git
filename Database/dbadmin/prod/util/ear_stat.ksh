#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: ear_stat.ksh$ 
#
# $Revision: 6$        $Date: 2/27/2008 3:21:50 PM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ -f /export/home/oracle/smssvr1_ear_stat ]]
 then
    rm -rf /export/home/oracle/smssvr1_ear_stat
fi

cd /products/fasttrack/
 
for dir1 in `ls` 
do 
  if [[ -d $dir1/tsm/fasttrack  ]] 
    then 
       /bin/cksum $dir1/tsm/fasttrack/FTtsm.ear >> /export/home/oracle/smssvr1_ear_stat 
  fi 
  if [[ -d $dir1/common/fasttrack  ]] 
    then 
       /bin/cksum $dir1/common/fasttrack/FTrdbmsrealm.jar >> /export/home/oracle/smssvr1_ear_stat 
  fi 
done

for filename in `ls TSDBETA/*.ear`
do
 /bin/cksum $filename >> /export/home/oracle/smssvr1_ear_stat
done

rcp /export/home/oracle/smssvr1_ear_stat smssvr2:/export/home/oracle/log/smssvr1_ear_stat

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/27/2008 3:21:50 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:44:53 AM  Debashish Mishra  
#  4    DevTSM    1.3         1/12/2004 2:10:17 PM Debashish Mishra  
#  3    DevTSM    1.2         9/9/2003 8:25:13 AM  Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:53 PMDebashish Mishra  
#  1    DevTSM    1.0         2/11/2003 6:47:57 PM Debashish Mishra 
# $
# 
#############################################################

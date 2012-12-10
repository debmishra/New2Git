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
# $Revision: 3$        $Date: 3/3/2005 6:46:21 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ -f /export/home/oracle/rossvr3_ear_stat ]]
 then
    rm -rf /export/home/oracle/rossvr3_ear_stat
fi

cd /products/fasttrack/
 
for dir1 in `ls` 
do 
  if [[ -d $dir1/tsm/fasttrack  ]] 
    then 
       /bin/cksum $dir1/tsm/fasttrack/FTtsm.ear >> /export/home/oracle/rossvr3_ear_stat 
  fi 
done

rcp /export/home/oracle/rossvr3_ear_stat rossvr4:/export/home/oracle/log/rossvr3_ear_stat

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         3/3/2005 6:46:21 AM  Debashish Mishra  
#  2    DevTSM    1.1         12/26/2003 4:24:49 PMDebashish Mishra  
#  1    DevTSM    1.0         2/11/2003 6:47:32 PM Debashish Mishra 
# $
# 
#############################################################

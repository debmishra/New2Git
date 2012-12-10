#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: check_diskspace.ksh$ 
#
# $Revision: 5$        $Date: 4/18/2011 8:06:34 AM$
#
#
# Description:  <ADD>
#
#############################################################
. /etc/profile

email="dmishra@mdsol.com mpasupuleti@mdsol.com"
pager="4156862541@vtext.com 5105011758@tmomail.net"

for num in `df -k | grep -v capacity |awk '{print $5}' | awk -F% '{print $1}'`
do
  if [[ $num -gt 92 ]]
  then
    if [[ -f /mailsent ]]
    then
      exit 0
    else

     echo "Warning: check disk space in stby Database servers" | mailx -s DiskSpace $email
     echo "Warning: check disk space in stby Database servers" | mailx -s DiskSpace $pager
     touch /mailsent
     exit 0
    fi
  fi
done

if [[ -f /mailsent ]]
then
 rm /mailsent
fi

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         4/18/2011 8:06:34 AM Debashish Mishra  
#  4    DevTSM    1.3         3/3/2005 6:46:20 AM  Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:24:47 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:31 PMDebashish Mishra  
#  1    DevTSM    1.0         1/23/2003 9:44:18 AM Debashish Mishra 
# $
# 
#############################################################

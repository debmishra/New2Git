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
# $Revision: 9$        $Date: 6/7/2011 10:05:13 PM$
#
#
# Description:  <ADD>
#
#############################################################
. /etc/profile
 
for num in `df -k | grep -v capacity | awk '{print $5}' | awk -F% '{print $1}'`
do
  if [[ $num -gt 92 ]]
  then
    if [[ -f /mailsent ]]
    then
      exit 0
    else

     df -k | mailx -s DiskSpace_df_k dmishra@mdsol.com 
     echo "Warning: check disk space in production database server" | mailx -s DiskSpace dmishra@mdsol.com
     echo "Warning: check disk space in production database server" | mailx -s DiskSpace -r dmishra@mdsol.com 4156862541@vtext.com
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
#  9    DevTSM    1.8         6/7/2011 10:05:13 PM Debashish Mishra  
#  8    DevTSM    1.7         8/11/2009 12:03:26 AMDebashish Mishra  
#  7    DevTSM    1.6         2/27/2008 3:21:49 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:44:47 AM  Debashish Mishra  
#  5    DevTSM    1.4         10/13/2004 8:01:18 AMDebashish Mishra  
#  4    DevTSM    1.3         10/13/2003 9:53:31 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  3    DevTSM    1.2         9/9/2003 8:25:11 AM  Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:51 PMDebashish Mishra  
#  1    DevTSM    1.0         8/14/2002 1:35:02 PM Debashish Mishra 
# $
# 
#############################################################

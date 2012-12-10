#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: delete_archive_log.ksh$ 
#
# $Revision: 10$        $Date: 6/7/2011 10:05:14 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile

email="dmishra@mdsol.com"
pager="4156862541@vtext.com"

num=`df -k | grep -v capacity | grep "c1t5d1s0" | awk '{print $5}' | awk -F% '{print $1}'`

if [[ $num -gt 75 ]]
 then
  msg="Warning: Space problem in /arch/oracle/prod. Moved all archived logs to /archive/oracle/prod. Copy these archivelogs manually from this location to standby database server(/arch/oracle/prod) ASAP"
  echo $msg |  mailx -s ArchiveLogs $email
echo "Warning: Archive log space problem. Moving to different location" | mailx -s ArchiveLogs $pager
  mv /arch/oracle/prod/*.log /archive/oracle/prod/
  num2=`df -k | grep -v capacity | grep "c1t5d1s0" | awk '{print $5}' | awk -F% '{print $1}'`
  if [[ $num2 -gt 99 ]]
   then
    rm /arch/prod/oracle/*
    echo "Alert: Archive log force delete. Recreate standby database" | mailx -s ArchiveLogs $email
    echo "Alert: Archive log force delete. Recreate standby database" | mailx -s ArchiveLogs $pager
  fi
fi


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  10   DevTSM    1.9         6/7/2011 10:05:14 PM Debashish Mishra  
#  9    DevTSM    1.8         8/11/2009 12:03:26 AMDebashish Mishra  
#  8    DevTSM    1.7         2/27/2008 3:21:50 PM Debashish Mishra  
#  7    DevTSM    1.6         3/3/2005 6:44:53 AM  Debashish Mishra  
#  6    DevTSM    1.5         10/13/2004 8:01:22 AMDebashish Mishra  
#  5    DevTSM    1.4         10/13/2003 9:53:34 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  4    DevTSM    1.3         9/9/2003 8:25:13 AM  Debashish Mishra  
#  3    DevTSM    1.2         2/25/2003 12:40:53 PMDebashish Mishra  
#  2    DevTSM    1.1         10/31/2002 5:04:26 PMDebashish Mishra  
#  1    DevTSM    1.0         10/28/2002 10:58:55 AMDebashish Mishra 
# $
# 
#############################################################

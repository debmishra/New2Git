#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile$ 
#
# $Revision$        $Date$
#
#
# Description:  <ADD>
#
#############################################################
. /etc/profile
 
mailinglist="5105011758@txt.att.net mpasupuleti@mdsol.com dmishra@mdsol.com"
pagerlist="5105011758@txt.att.net 4156862541@vtext.com"
for num in `df -k | grep -v capacity | awk '{print $5}' | awk -F% '{print $1}'`
do
  if [[ $num -gt 92 ]]
  then
    if [[ -f /mailsent ]]
    then
      exit 0
    else

     df -k | mailx -s DiskSpace_df_k $mailinglist
     echo "Warning: check disk space in production database server" | mailx -s DiskSpace $mailinglist
     echo "Warning: check disk space in production database server" | mailx -s DiskSpace -r $pagerlist
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
# $Log$
# 
#############################################################

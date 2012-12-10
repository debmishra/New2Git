#!/bin/ksh
#
#
# This program is the confidential and proprietary product of
# Fast Track Systems, Inc.  Any unauthorized use, reproduction,
# or transfer of this program is strictly prohibited.
# Copyright (C) 2000 by Fast Track Systems, Inc.
# All rights reserved.
#
# $Workfile: c:\tsm\Database\dbadmin\prod\util\ck_arch_disk_space.ksh$
#
# $Revision: 1$        $Date: 6/7/2011 10:12:14 PM$
#
#
# Description:  Check disk space for PROD archival logs directory
#
#############################################################

pagerlist="4156862541@vtext.com dmishra@mdsol.com"
mailinglist="dmishra@mdsol.com"

used_perc_orig=`df -h /arch/oracle/prod | awk '{print $5}' | grep -v capacity | cut -f 1 -d %`
used_perc_dest=`df -h /s04/oracle/arch_bkup_prod | awk '{print $5}' | grep -v capacity | cut -f 1 -d %`


if [ $used_perc_orig -gt 80 ]
then
   echo "$used_perc_orig% is used in /arch/oracle/prod " | mailx -s "Arch Disk Space Alert in 13.21" $pagerlist
fi

if [ $used_perc_orig -gt 70 ]
then
   echo "$used_perc_orig % used in /arch/oracle/prod" | mailx -s "Arch Disk Space Alert in 13.21" $mailinglist 
   find /arch/oracle/prod -type f -mtime +1 -exec mv {} /s04/oracle/arch_bkup_prod/ \;
else
   find /arch/oracle/prod -type f -mtime +3 -exec mv {} /s04/oracle/arch_bkup_prod/ \;
fi

if [ $used_perc_dest -gt 85 ]
then
  echo "$used_perc_dest % used in arch_bkup_prod" | mailx -s "Disk Space Alert arch_bkup_prod in 13.21" $mailinglist
  find /s04/oracle/arch_bkup_prod -type f -mtime +7 -exec rm -f {} \;
else
  find /s04/oracle/arch_bkup_prod -type f -mtime +15 -exec rm -f {} \;
fi

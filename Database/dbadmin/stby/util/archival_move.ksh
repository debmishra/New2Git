#!/bin/ksh
#
#
# This program is the confidential and proprietary product of
# Fast Track Systems, Inc.  Any unauthorized use, reproduction,
# or transfer of this program is strictly prohibited.
# Copyright (C) 2000 by Fast Track Systems, Inc.
# All rights reserved.
#
# $Workfile: c:\tsm\Database\dbadmin\stby\util\archival_move.ksh$
#
# $Revision: 1$        $Date: 4/18/2011 8:06:46 AM$
#
#
# Description:  Move archival files and remove after 3 days
#
#############################################################

used_perc_orig=`df -h /arch/oracle/ltst | awk '{print $5}' | grep -v capacity | cut -f 1 -d %`
used_perc_dest=`df -h /r06/oracle/arch_bkup | awk '{print $5}' | grep -v capacity | cut -f 1 -d %`

if [ $used_perc_orig -gt 80 ]
then
   find /arch/oracle/ltst -type f -mtime +1 -exec mv {} /r06/oracle/arch_bkup/ \;
else
   find /arch/oracle/ltst -type f -mtime +4 -exec mv {} /r06/oracle/arch_bkup/ \;
fi

if [ used_perc_dest -gt 90 ]
then
  find /r06/oracle/arch_bkup -type f -mtime +4 -exec rm -f {} \;
else
  find /r06/oracle/arch_bkup -type f -mtime +10 -exec rm -f {} \;
fi

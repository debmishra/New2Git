#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: sar_monitor.ksh$ 
#
# $Revision: 4$        $Date: 4/18/2011 8:06:35 AM$
#
#
# Description:  Create the sar files for root cron
#
#############################################################
 

### Move files older than 1 days to /r06/oracle/sar_output
### Delete files older than 7days in /r06/oracle/sar_output
###find /var/adm/sa/sa* -mtime +1 -exec mv {} /r06/oracle/sar_output/ \;
###find /r06/oracle/sar_output/sa* -mtime +7 -exec rm -f {} \;

#/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 300 288 
### 1 minute data
/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 60 1440

### 5 seconds data
##/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 5 17279

### 2 seconds data
##/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 2 43199

# /usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 1 10800

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         4/18/2011 8:06:35 AM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:46:23 AM  Debashish Mishra  
#  2    DevTSM    1.1         12/26/2003 4:24:50 PMDebashish Mishra  
#  1    DevTSM    1.0         2/25/2003 12:41:22 PMDebashish Mishra 
# $
# 
#############################################################

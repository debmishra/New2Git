#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\mv_sar_files.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:47 AM$
#
#
# Description:  Move the sar files and delete after 7days
#
#############################################################
 

### Move files older than 1 days to /r06/oracle/sar_output
### Delete files older than 7days in /r06/oracle/sar_output
find /var/adm/sa/sa* -mtime +0 -exec mv {} /r06/oracle/sar_output/ \;
find /r06/oracle/sar_output/sa* -mtime +7 -exec rm -f {} \;

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         4/18/2011 8:06:47 AM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cleanup_prod.ksh$ 
#
# $Revision: 7$        $Date: 4/18/2011 8:06:34 AM$
#
#
# Description:  Cleanup export dumps and other logs on prod database
#
#############################################################
 
. /etc/profile

find /arch/oracle/prod -type f -mtime +2 -print -exec rm -f {} \;

#find /u01/app/oracle/admin/prod/udump -type f -mtime +7 -print -exec rm -f {} \;
#find /u01/app/oracle/admin/prod/bdump -type f -mtime +15 -print -exec rm -f {} \;
#find /u01/app/oracle/admin/prod/cdump -type f -mtime +15 -print -exec rm -f {} \;


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         4/18/2011 8:06:34 AM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:46:21 AM  Debashish Mishra  
#  5    DevTSM    1.4         12/26/2003 4:24:48 PMDebashish Mishra  
#  4    DevTSM    1.3         2/25/2003 12:41:31 PMDebashish Mishra  
#  3    DevTSM    1.2         1/13/2003 11:24:10 AMDebashish Mishra  
#  2    DevTSM    1.1         10/24/2002 3:39:55 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:57 AM Debashish Mishra 
# $
# 
#############################################################

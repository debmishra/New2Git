#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cleanup_test.ksh$ 
#
# $Revision: 7$        $Date: 2/27/2008 3:23:09 PM$
#
#
# Description:  Cleanup export dumps and other logs on test database
#
#############################################################
. /etc/profile

find /u01/app/oracle/admin/test/arch -type f -mtime +4 -print -exec rm -f {} \;

find /u01/app/oracle/log -type f -mtime +5 -print -exec rm -f {} \;
find /work/orabackup/test/dump -type f -mtime +1 -print -exec rm -f {} \;
#find /dumpstore1/testdump -type f -mtime +1 -print -exec rm -f {} \;
#find /dumpstore2/prevdump -type f -mtime +1 -print -exec rm -f {} \;

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         2/27/2008 3:23:09 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:45:51 AM  Debashish Mishra  
#  5    DevTSM    1.4         5/7/2004 5:28:07 PM  Debashish Mishra  
#  4    DevTSM    1.3         2/20/2004 4:55:01 PM Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:24:23 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:05 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:44 AM Debashish Mishra 
# $
# 
#############################################################

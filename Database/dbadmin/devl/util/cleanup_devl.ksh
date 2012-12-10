#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: cleanup_devl.ksh$ 
#
# $Revision: 8$        $Date: 2/27/2008 3:22:33 PM$
#
#
# Description:  Cleanup export dumps and other logs on devlopment database
#
#############################################################
. /etc/profile

find /export/home/oracle/log -type f -mtime +5 -print -exec rm -f {} \;
find /work/orabackup/devl/dump -type f -mtime +1 -print -exec rm -f {} \;
find /u03/oracle/archive -type f -mtime +1 -print -exec rm -f {} \;


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         2/27/2008 3:22:33 PM Debashish Mishra  
#  7    DevTSM    1.6         3/3/2005 6:42:47 AM  Debashish Mishra  
#  6    DevTSM    1.5         3/19/2004 6:17:39 PM Debashish Mishra  
#  5    DevTSM    1.4         2/20/2004 4:55:13 PM Debashish Mishra  
#  4    DevTSM    1.3         12/26/2003 4:23:30 PMDebashish Mishra  
#  3    DevTSM    1.2         2/25/2003 12:33:10 PMDebashish Mishra  
#  2    DevTSM    1.1         1/21/2003 1:21:11 PM Debashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:08 AM Debashish Mishra 
# $
# 
#############################################################

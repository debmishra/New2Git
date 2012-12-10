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
# $Revision: 11$        $Date: 6/7/2011 10:05:14 PM$
#
#
# Description:  Cleanup export dumps and other logs on prod database
#
#############################################################
 
. /etc/profile

find /orabackup/prod/audit_dump -type f -mtime +90 -print -exec rm -f {} \;
find /orabackup/prod/hot/archive -type f -mtime +3 -print -exec rm -f {} \;
find /arch/oracle/prod -type f -mtime +3 -print -exec rm -f {} \;
find /export/home/oracle/log -type f -mtime +7 -print -exec rm -f {} \;
find /orabackup/prod/dump -type f -mtime +2 -print -exec rm -f {} \;

###Commented on 05/28/09 since database moved to another server.
###find /orabackup/demo/expdmp -type f -mtime +2 -print -exec rm -f {} \;

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  11   DevTSM    1.10        6/7/2011 10:05:14 PM Debashish Mishra  
#  10   DevTSM    1.9         8/11/2009 12:03:26 AMDebashish Mishra  
#  9    DevTSM    1.8         2/27/2008 3:21:49 PM Debashish Mishra  
#  8    DevTSM    1.7         3/3/2005 6:44:48 AM  Debashish Mishra  
#  7    DevTSM    1.6         10/13/2004 8:01:19 AMDebashish Mishra  
#  6    DevTSM    1.5         8/4/2004 2:39:18 PM  Debashish Mishra  
#  5    DevTSM    1.4         12/26/2003 4:21:34 PMDebashish Mishra  
#  4    DevTSM    1.3         10/13/2003 9:53:32 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  3    DevTSM    1.2         8/15/2003 2:03:09 PM Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:52 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:34 AM Debashish Mishra 
# $
# 
#############################################################

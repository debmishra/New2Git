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
# $Revision: 9$        $Date: 6/7/2011 10:05:21 PM$
#
#
# Description:  Create the sar files for root cron
#
#############################################################
 
/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 300 288

#/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 60 1440 

# /usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 1 7200

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  9    DevTSM    1.8         6/7/2011 10:05:21 PM Debashish Mishra  
#  8    DevTSM    1.7         8/11/2009 12:03:32 AMDebashish Mishra  
#  7    DevTSM    1.6         2/27/2008 3:21:53 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:45:00 AM  Debashish Mishra  
#  5    DevTSM    1.4         10/13/2004 8:01:28 AMDebashish Mishra  
#  4    DevTSM    1.3         10/13/2003 9:53:38 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  3    DevTSM    1.2         9/9/2003 8:25:17 AM  Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:56 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:35 AM Debashish Mishra 
# $
# 
#############################################################

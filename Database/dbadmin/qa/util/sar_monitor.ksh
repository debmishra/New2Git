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
# $Revision: 5$        $Date: 2/27/2008 3:23:10 PM$
#
#
# Description:  Create the sar files for root cron
#
#############################################################
 
/usr/sbin/sar -o /var/adm/sa/sa$(date +%d) 300 288 

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         2/27/2008 3:23:10 PM Debashish Mishra  
#  4    DevTSM    1.3         3/3/2005 6:45:53 AM  Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:24:25 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:07 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:46 AM Debashish Mishra 
# $
# 
#############################################################

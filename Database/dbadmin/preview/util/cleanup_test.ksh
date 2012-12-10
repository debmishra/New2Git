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
# $Revision: 4$        $Date: 2/27/2008 3:22:55 PM$
#
#
# Description:  Cleanup export dumps and other logs on test database
#
#############################################################
. /etc/profile


find /export/home/oracle/log -type f -mtime +5 -print -exec rm -f {} \;
find /u02/app/oracle/dump -type f -mtime +3 -print -exec rm -f {} \;

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:22:55 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:44:22 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/6/2002 1:35:25 PM  Debashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:20 AM Debashish Mishra 
# $
# 
#############################################################

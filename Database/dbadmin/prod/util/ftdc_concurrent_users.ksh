#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: ftdc_concurrent_users.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:15 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

ftdc_dir=/export/home/oracle/ftdc


date_time=`date '+%m/%d/%y/%H:%M:%S'`
conc_users=`rsh smssvr1 netstat -n |awk '{print $1}'| grep 443 | wc -l`
echo $date_time $conc_users >> $ftdc_dir/ftdc_concurrent_users 


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         6/7/2011 10:05:15 PM Debashish Mishra  
#  7    DevTSM    1.6         8/11/2009 12:03:27 AMDebashish Mishra  
#  6    DevTSM    1.5         2/27/2008 3:21:50 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:44:54 AM  Debashish Mishra  
#  4    DevTSM    1.3         10/13/2004 8:01:23 AMDebashish Mishra  
#  3    DevTSM    1.2         10/13/2003 9:53:35 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  2    DevTSM    1.1         9/9/2003 8:25:14 AM  Debashish Mishra  
#  1    DevTSM    1.0         5/21/2003 3:15:28 PM Debashish Mishra 
# $
# 
#############################################################


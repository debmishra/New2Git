#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: ftdc_concurrent_users_data.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:21:50 PM$
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
#  4    DevTSM    1.3         2/27/2008 3:21:50 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:44:54 AM  Debashish Mishra  
#  2    DevTSM    1.1         9/9/2003 8:25:14 AM  Debashish Mishra  
#  1    DevTSM    1.0         5/21/2003 3:15:28 PM Debashish Mishra 
# $
# 
#############################################################

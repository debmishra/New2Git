#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\raid_info.ksh$ 
#
# $Revision: 1$        $Date: 6/7/2011 10:12:14 PM$
#
#
# Description:  <ADD>
#
#############################################################
. /etc/profile

echo "metadb output:" > /tmp/raid_info.log
metadb >> /tmp/raid_info.log 
echo " " >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo "metastat output:" >> /tmp/raid_info.log
metastat >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo "df -h output:" >> /tmp/raid_info.log
df -h >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo "Root cronjobs:" >> /tmp/raid_info.log
cat /var/spool/cron/crontabs/root >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo " " >> /tmp/raid_info.log
echo "Oracle cronjobs:" >> /tmp/raid_info.log
cat /var/spool/cron/crontabs/oracle >> /tmp/raid_info.log

cat /tmp/raid_info.log | mailx -s "XOSSVR2 - 13.21 - Server Info" dmishra@mdsol.com 

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         6/7/2011 10:12:14 PM Debashish Mishra 
# $
# 
#############################################################

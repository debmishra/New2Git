
#! /bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\raidutil_healthck.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:48 AM$
#
#
# Description:  Cleanup export dumps and other logs on prod database
#
#############################################################
 
/usr/lib/osa/bin/healthck -a >> /export/home/oracle/log/raidutil_healthck.log
echo "\n\n" >> /export/home/oracle/log/raidutil_healthck.log
/usr/lib/osa/bin/raidutil -c c1t5d0 -B >> /export/home/oracle/log/raidutil_healthck.log
cat /export/home/oracle/log/raidutil_healthck.log | mailx -s "raidutil healthck for rossvr4" dmishra@fast-track.com 
cat /export/home/oracle/log/raidutil_healthck.log >> /export/home/oracle/log/raidutil_healthck.log.old
rm /export/home/oracle/log/raidutil_healthck.log

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         4/18/2011 8:06:48 AM Debashish Mishra 
# $
# 
#############################################################

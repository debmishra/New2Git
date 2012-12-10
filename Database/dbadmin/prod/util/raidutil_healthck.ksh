#!/bin/ksh
#
#
# This program is the confidential and proprietary product of
# Fast Track Systems, Inc.  Any unauthorized use, reproduction,
# or transfer of this program is strictly prohibited.
# Copyright (C) 2000 by Fast Track Systems, Inc.
# All rights reserved.
#
# $Workfile: raidutil_healthck.ksh$
#
# $Revision: 2$        $Date: 6/7/2011 10:04:11 PM$
#
#
# Description:  Cleanup export dumps and other logs on prod database
#
#############################################################

/usr/lib/osa/bin/healthck -a > /export/home/oracle/log/raidutil_healthck.log
echo "\n" >> /export/home/oracle/log/raidutil_healthck.log
/usr/lib/osa/bin/raidutil -c c2t5d0 -B >> /export/home/oracle/log/raidutil_healthck.log
cat /export/home/oracle/log/raidutil_healthck.log | mailx -r dmishra@mdsol.com -s "raidutil healthck for smssvr2" dmishra@mdsol.com
cat /export/home/oracle/log/raidutil_healthck.log >> /export/home/oracle/log/raidutil_healthck.log.old
rm /export/home/oracle/log/raidutil_healthck.log

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         6/7/2011 10:04:11 PM Debashish Mishra  
#  1    DevTSM    1.0         8/11/2009 12:03:53 AMDebashish Mishra 
# $
#
#############################################################

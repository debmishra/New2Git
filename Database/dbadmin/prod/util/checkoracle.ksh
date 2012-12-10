#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: checkoracle.ksh$ 
#
# $Revision: 9$        $Date: 6/7/2011 10:05:14 PM$
#
#
# Description:  This file verifies whether oracle is up and running before starting weblogic
#
#############################################################

. /etc/profile
. /export/home/oracle/.profile

if [ `uname -n` = rossvr6 ]
then

        while [`rsh rossvr5 ps -ef|grep ora_pmon_|grep -v grep|wc -l` -ne 1 ]
        do
                echo "Oracle is still down"
                sleep 15
        done

        if [`rsh rossvr5 ps -ef|grep ora_pmon_|grep -v grep|wc -l`  -eq 1 ]
        then 
        echo "oracle is up now"
        fi 
fi

if [ `uname -n` = rossvr1 ]
then

        while [`rsh rossvr8 ps -ef|grep ora_pmon_|grep -v grep|wc -l` -ne 1 ]
        do
                echo "Oracle is still down"
                sleep 15
        done

        if [`rsh rossvr8 ps -ef|grep ora_pmon_|grep -v grep|wc -l`  -eq 1 ]
        then
        echo "oracle is up now"
        fi 
fi

if [ `uname -n` = rossvr3 ]
then

        while [`rsh rossvr4 ps -ef|grep ora_pmon_|grep -v grep|wc -l` -ne 1 ]
        do
                echo "Oracle is still down"
                sleep 15
        done

        if [`rsh rossvr4 ps -ef|grep ora_pmon_|grep -v grep|wc -l`  -eq 1 ]
        then
        echo "oracle is up now"
        fi 

	if [$1 = dosleep ]
	then
	sleep 120
	fi
fi



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  9    DevTSM    1.8         6/7/2011 10:05:14 PM Debashish Mishra  
#  8    DevTSM    1.7         8/11/2009 12:03:26 AMDebashish Mishra  
#  7    DevTSM    1.6         2/27/2008 3:21:49 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:44:48 AM  Debashish Mishra  
#  5    DevTSM    1.4         10/13/2004 8:01:19 AMDebashish Mishra  
#  4    DevTSM    1.3         10/13/2003 9:53:32 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  3    DevTSM    1.2         9/9/2003 8:25:11 AM  Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:52 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:33 AM Debashish Mishra 
# $
# 
#############################################################

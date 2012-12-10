#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: backup_tape_cold.ksh$ 
#
# $Revision: 9$        $Date: 6/7/2011 10:05:13 PM$
#
#
# Description:   Tar the cold backup to the tape
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

date
echo "start copying  /work/orabackup/prod/tts directory... "
tar cvf /dev/rmt/0 /work/orabackup/prod/tts
echo "start copying  /work/orabackup/prod/dump directory... "
tar rvf /dev/rmt/0 /work/orabackup/prod/dump
date

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  9    DevTSM    1.8         6/7/2011 10:05:13 PM Debashish Mishra  
#  8    DevTSM    1.7         8/11/2009 12:03:26 AMDebashish Mishra  
#  7    DevTSM    1.6         2/27/2008 3:21:49 PM Debashish Mishra  
#  6    DevTSM    1.5         3/3/2005 6:44:47 AM  Debashish Mishra  
#  5    DevTSM    1.4         10/13/2004 8:01:18 AMDebashish Mishra  
#  4    DevTSM    1.3         10/13/2003 9:53:31 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  3    DevTSM    1.2         9/9/2003 8:25:10 AM  Debashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:40:51 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:33 AM Debashish Mishra 
# $
# 
#############################################################

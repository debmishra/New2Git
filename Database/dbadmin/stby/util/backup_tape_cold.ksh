#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\backup_tape_cold.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:46 AM$
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
#  1    DevTSM    1.0         4/18/2011 8:06:46 AM Debashish Mishra 
# $
# 
#############################################################

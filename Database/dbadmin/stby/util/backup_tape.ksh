#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\stby\util\backup_tape.ksh$ 
#
# $Revision: 1$        $Date: 4/18/2011 8:06:46 AM$
#
#
# Description:  Tar the filesystem and backups to the tape
#
#############################################################
. /etc/profile
cd ~oracle
. ./.profile

echo "start copying  /export/home file system... "
date 
tar cvf /dev/rmt/0 /export/home
echo "start copying /u01 files system... "
tar rvf /dev/rmt/0 /u01
echo "Start copying the hotbackups... "
tar rvf /dev/rmt/0 /work/orabackup/prod/hot
echo "end of tar... "
date

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         4/18/2011 8:06:46 AM Debashish Mishra 
# $
# 
#############################################################

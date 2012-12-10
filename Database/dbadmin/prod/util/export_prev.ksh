#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: export_prev.ksh$ 
#
# $Revision: 2$        $Date: 6/7/2011 10:04:11 PM$
#
#
# Description:  Export the fasttrack schema of production database
#
#############################################################
 
. /etc/profile


export ORACLE_SID=prev
ORACLE_USER=backup_user
ORACLE_PWD=`get_pwd $ORACLE_USER`

/u01/app/oracle/product/10.2.0/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
full=y \
FILE=/orabackup/prev/dump/prev.dmp \
LOG=/export/home/oracle/log/prev.dmp.log

mv /orabackup/prev/dump/prev.dmp /orabackup/prev/dump/prev.dmp.$(date +%m%d)
mv /export/home/oracle/log/prev.dmp.log /export/home/oracle/log/prev.dmp.log.$(date +%m%d)

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         6/7/2011 10:04:11 PM Debashish Mishra  
#  1    DevTSM    1.0         8/11/2009 12:04:16 AMDebashish Mishra 
# $
# 
#############################################################

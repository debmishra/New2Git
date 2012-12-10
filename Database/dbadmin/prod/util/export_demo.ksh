#!/bin/ksh
#
#
# This program is the confidential and proprietary demouct of 
# Fast Track Systems, Inc.  Any unauthorized use, redemouction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: export_demo.ksh$ 
#
# Description: Full database export of demo database
#
#####################################################
 
. /etc/profile


#rm -f /orabackup/demo/expdmp/*

export ORACLE_SID=demo

/u01/app/oracle/product/10.2.0/bin/expdp 'userid="/ as sysdba"' \
full=y \
dumpfile=expdp_demo.dmp \
logfile=expdp_demo.log

mv /orabackup/demo/expdmp/expdp_demo.dmp /orabackup/demo/expdmp/expdp_demo.dmp.$(date +%m%d)

echo `date` >> /orabackup/demo/expdmp/expdp_demo.log
gzip /orabackup/demo/expdmp/expdp_demo.dmp.$(date +%m%d)
echo `date` >> /orabackup/demo/expdmp/expdp_demo.log

mv /orabackup/demo/expdmp/expdp_demo.log /orabackup/demo/expdmp/expdp_demo.log.$(date +%m%d)

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         6/7/2011 10:04:11 PM Debashish Mishra  
#  1    DevTSM    1.0         8/11/2009 12:04:10 AMDebashish Mishra 
# $
# 
#############################################################

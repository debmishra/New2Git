#!/bin/ksh
#
#
# This program is the confidential and proprietary demouct of
# Fast Track Systems, Inc.  Any unauthorized use, redemouction,
# or transfer of this program is strictly prohibited.
# Copyright (C) 2000 by Fast Track Systems, Inc.
# All rights reserved.
#
# $Workfile: c:\tsm\Database\dbadmin\stby\util\export_ltst.ksh$
#
# Description: Full database export of performance database "ltst"
#
#####################################################

. /etc/profile


rm -f /u03/oracle/exp_backup/ltst/*

export ORACLE_SID=ltst

/u01/app/oracle/product/10.2.0/bin/expdp 'userid="/ as sysdba"' \
full=y \
dumpfile=expdp_ltst.dmp \
logfile=expdp_ltst.log

#echo `date` >> /u03/oracle/exp_backup/ltst/expdp_ltst.log
#gzip /u03/oracle/exp_backup/ltst/expdp_ltst.dmp
#echo `date` >> /u03/oracle/exp_backup/ltst/expdp_ltst.log

#############################################################
# MODIFICATION HISTORY:
#
# $Log:
#  1    DevSource 1.0         09/09/2008 1:20:00 PM Mahesh Pasupuleti
# $
#
#############################################################

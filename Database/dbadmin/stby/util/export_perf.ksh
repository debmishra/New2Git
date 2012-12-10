#!/bin/ksh
#
#
# This program is the confidential and proprietary demouct of
# Fast Track Systems, Inc.  Any unauthorized use, redemouction,
# or transfer of this program is strictly prohibited.
# Copyright (C) 2000 by Fast Track Systems, Inc.
# All rights reserved.
#
# $Workfile: c:\tsm\Database\dbadmin\stby\util\export_perf.ksh$
#
# Description: Full database export of performance database "perf"
#
#####################################################

. /etc/profile
export ORACLE_SID=perf

find /orabackup/disk_bkup/dump/ -type f -mtime +2 -print -exec rm -f {} \;
find /export/home/oracle/log/exp_perf.log.* -type f +7  -print -exec rm -f {} \;

mv /orabackup/perf/expbkup/* /orabackup/disk_bkup/dump/

/u01/app/oracle/product/10.2.0/bin/exp 'userid="/ as sysdba"' \
owner=tsm10,ftcommon,tsm10_32,tsm10_31 \
file=/orabackup/perf/expbkup/exp_perf.dmp \
log=/export/home/oracle/log/exp_perf.log

mv /orabackup/perf/expbkup/exp_perf.dmp /orabackup/perf/expbkup/exp_perf.dmp.$(date +%m%d)
mv /export/home/oracle/log/exp_perf.log /export/home/oracle/log/exp_perf.log.$(date +%m%d)

#############################################################
# MODIFICATION HISTORY:
#
# $Log:
#  1    DevSource 1.0         11/09/2010  Mahesh Pasupuleti
# $
#
#############################################################

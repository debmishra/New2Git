#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: backup_emlt.ksh$ 
#
# $Revision: 3$        $Date: 3/3/2005 6:46:20 AM$
#
#
# Description:  Exports the fasttrack schema of devl database
#
#############################################################
 
. /etc/profile

mv /export/home/oracle/emlt_exp_modified.dmp /export/home/oracle/emlt_exp_modified.dmp.save
compress /export/home/oracle/emlt_exp_modified.dmp.save

export ORACLE_SID=emlt

ORACLE_USER=dmishra
ORACLE_PWD=emlt

/u01/app/oracle/product/9.2.0/bin/exp USERID=$ORACLE_USER/$ORACLE_PWD \
OWNER=ft15e,tsm10e,tsm10e_bgn_2,tsm10e_cvt_2,tsm10e_bay_2,tsm10e_eva_2,tsm10e_fts_2,tsm10e_ft1_2,tsm10e_ft2_2,\
tsm10e_ft3_2,tsm10e_ft4_2,tsm10e_ft5_2,tsm10e_client0,ftcommon \
FILE=/export/home/oracle/emlt_exp_modified.dmp \
LOG=/export/home/oracle/backup_emlt.ksh.log

export ORACLE_SID=



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         3/3/2005 6:46:20 AM  Debashish Mishra  
#  2    DevTSM    1.1         12/26/2003 4:24:46 PMDebashish Mishra  
#  1    DevTSM    1.0         3/28/2003 4:07:26 PM Debashish Mishra 
# $
# 
#############################################################

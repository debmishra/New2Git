#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: failover_ph2.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:13 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
#phase2 starts here

#*******************
#Disable the cronjob
#*******************

/export/home/oracle/recover_stbydb.ksh

mv /arch/oracle/prod/* /arch/oracle/prod_bkp/

sqlplus /nolog  << EOF
connect / as sysdba
ALTER DATABASE ACTIVATE STANDBY DATABASE;
shutdown immediate 
startup
ALTER TABLESPACE temp ADD
TEMPFILE '/r02/oracle/oradata/prod/temp01.dbf' SIZE 40M AUTOEXTEND ON;
EOF

# After this login to smssvr1 and issue the command "pkill java"
# and login to rossvr3 and issue the command init -6


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:18:13 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:35:43 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:19:40 PM Debashish Mishra  
#  1    DevTSM    1.0         6/4/2002 10:05:18 AM Debashish Mishra 
# $
# 
#############################################################

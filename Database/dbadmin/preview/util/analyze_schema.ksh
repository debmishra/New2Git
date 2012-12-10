#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: analyze_schema.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:22:55 PM$
#
#
# Description:  Analyze schema structures
#
#############################################################

. /etc/profile
cd ~oracle
. ./.profile

ORACLE_USER=dmishra 
ORACLE_PWD=test1

export ORACLE_SID=test1

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
execute dbms_stats.gather_schema_stats('ft15');
execute dbms_stats.gather_schema_stats('tsm10');
execute dbms_stats.gather_schema_stats('tsmclient0');
EOF

ORACLE_USER=dmishra
ORACLE_PWD=demo

export ORACLE_SID=demo

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
execute dbms_stats.gather_schema_stats('ft15');
execute dbms_stats.gather_schema_stats('tsm10');
execute dbms_stats.gather_schema_stats('tsmclient0');
EOF

export ORACLE_SID=
#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:22:55 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:44:21 AM  Debashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:20 AM Debashish Mishra 
# $
# 
#############################################################

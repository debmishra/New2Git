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
# $Revision: 5$        $Date: 2/27/2008 3:23:09 PM$
#
#
# Description:  Analyze schema structures
#
#############################################################

. /etc/profile
cd ~oracle
. ./.profile

ORACLE_USER=dmishra 
ORACLE_PWD=`get_pwd $ORACLE_USER`

export ORACLE_SID=test

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
execute dbms_stats.gather_schema_stats('ft15');
execute dbms_stats.gather_schema_stats('tsm10');
execute dbms_stats.gather_schema_stats('tsmclient0');
EOF

export ORACLE_SID=prev

sqlplus -s $ORACLE_USER/prev << EOF
execute dbms_stats.gather_schema_stats('ft15e');
execute dbms_stats.gather_schema_stats('tsm10e');
execute dbms_stats.gather_schema_stats('tsm10p');
execute dbms_stats.gather_schema_stats('ft15p');
EOF




#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         2/27/2008 3:23:09 PM Debashish Mishra  
#  4    DevTSM    1.3         3/3/2005 6:45:50 AM  Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:24:23 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:41:05 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:44 AM Debashish Mishra 
# $
# 
#############################################################

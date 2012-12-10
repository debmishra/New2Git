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
# $Revision: 6$        $Date: 6/7/2011 10:05:13 PM$
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

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
execute dbms_stats.gather_schema_stats('fasttrack');
execute dbms_stats.gather_schema_stats('fasttrack13');
EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         6/7/2011 10:05:13 PM Debashish Mishra  
#  5    DevTSM    1.4         8/11/2009 12:03:24 AMDebashish Mishra  
#  4    DevTSM    1.3         2/27/2008 3:21:49 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:44:45 AM  Debashish Mishra  
#  2    DevTSM    1.1         10/13/2004 8:01:16 AMDebashish Mishra  
#  1    DevTSM    1.0         2/12/2004 10:40:49 AMDebashish Mishra 
# $
# 
#############################################################

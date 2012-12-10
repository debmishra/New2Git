#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: analyze_schema_prod.ksh$ 
#
# $Revision: 12$        $Date: 6/7/2011 10:05:13 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

ORACLE_USER=backup_user 
ORACLE_PWD=`get_pwd $ORACLE_USER`

export ORACLE_SID=prod

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
execute dbms_stats.gather_schema_stats('tsm10');
execute dbms_stats.gather_schema_stats('ft15');
EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  12   DevTSM    1.11        6/7/2011 10:05:13 PM Debashish Mishra  
#  11   DevTSM    1.10        8/11/2009 12:03:24 AMDebashish Mishra  
#  10   DevTSM    1.9         2/27/2008 3:21:49 PM Debashish Mishra  
#  9    DevTSM    1.8         3/3/2005 6:44:46 AM  Debashish Mishra  
#  8    DevTSM    1.7         10/13/2004 8:01:17 AMDebashish Mishra  
#  7    DevTSM    1.6         1/7/2004 2:13:06 PM  Debashish Mishra Modified for
#       dbv & tsm10t
#  6    DevTSM    1.5         10/13/2003 9:53:29 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  5    DevTSM    1.4         9/9/2003 8:25:09 AM  Debashish Mishra  
#  4    DevTSM    1.3         2/25/2003 12:40:49 PMDebashish Mishra  
#  3    DevTSM    1.2         9/6/2002 4:44:58 PM  Debashish Mishra Modified after
#       new schemas
#  2    DevTSM    1.1         8/5/2002 1:54:51 PM  Debashish Mishra Modified for
#       implementation of audit_trail
#  1    DevTSM    1.0         8/1/2002 11:41:33 AM Debashish Mishra 
# $
# 04/22/2009 -- Dropped schemas tsm10t,ft15t,tsm10d,ft15d
#               tsm10g,ft15g,tsm10e,ft15e 
#############################################################

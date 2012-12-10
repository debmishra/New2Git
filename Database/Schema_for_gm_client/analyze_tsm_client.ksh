#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: analyze_tsm_client.ksh$ 
#
# $Revision: 8$        $Date: 2/27/2008 3:17:43 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $3 = '' ]] then

    echo
    echo "Usage :  analyze_tsm_client.ksh <client_schema> <oracle_admin_user> <oracle_admin_passwd> <database connect string>"
    echo
    echo This script requires at least three arguments. 
    echo client schema name to be analyzed  
    echo oracle admin user name and password
    echo 
    exit 2
fi

if [[ $4 = '' ]] then
adminconnect=$2/$3
else 
adminconnect=$2/$3@$4
fi

sqlplus -s $adminconnect  << EOF

execute dbms_stats.gather_schema_stats('$1');

EOF

exit 0



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         2/27/2008 3:17:43 PM Debashish Mishra  
#  7    DevTSM    1.6         11/28/2006 12:45:22 PMDebashish Mishra  
#  6    DevTSM    1.5         9/19/2006 12:07:59 AMDebashish Mishra  removed
#       references to obsolete tables
#  5    DevTSM    1.4         4/20/2006 12:40:03 PMDebashish Mishra Medicare
#       changes
#  4    DevTSM    1.3         3/3/2005 6:33:25 AM  Debashish Mishra   
#  3    DevTSM    1.2         3/3/2005 6:32:15 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:19:12 PM Debashish Mishra  
#  1    DevTSM    1.0         6/20/2003 11:14:12 AMDebashish Mishra 
# $
# 
#############################################################

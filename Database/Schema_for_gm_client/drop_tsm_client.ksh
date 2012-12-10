#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: drop_tsm_client.ksh$ 
#
# $Revision: 5$        $Date: 2/27/2008 3:17:43 PM$
#
#
# Description:  <ADD>
#
#############################################################

typeset -u CLIENTUSER 

if [[ $3 = '' ]] 
  then

    echo
    echo "Usage :  drop_tsm_client.ksh <admin_userid> <admin_password> <client_userid> <database connect string>"
    echo
    echo This script requires at least three arguments. 
    echo admin userid and password  
    echo client schema name to be dropped
    echo optional database connect string
    echo 
    exit 2
  fi

admin_user=$1
admin_pwd=$2
clientuser=$3
CLIENTUSER=$3
dbname=$4
tabname='v$session'

if [[ $dbname = '' ]] 
  then
     admin_connect=$admin_user/$admin_pwd
else 
  admin_connect=$admin_user/$admin_pwd@$dbname
fi

clientloggedin=`sqlplus -s $admin_connect << EOF
set heading off
set feedback off
select count(*) from $tabname where username='$CLIENTUSER';
EOF`


if [[ $clientloggedin -gt 0 ]] 
	then

	echo
	echo This client has currently logged into database and can not be recreated
	echo exiting ...
	echo
	exit 2
fi

sqlplus -s $admin_connect  << EOF >>clientschema.out 2>&1
 drop user $clientuser cascade;			
 exit;
EOF

exit 0


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         2/27/2008 3:17:43 PM Debashish Mishra  
#  4    DevTSM    1.3         9/19/2006 12:08:01 AMDebashish Mishra  removed
#       references to obsolete tables
#  3    DevTSM    1.2         3/3/2005 6:33:26 AM  Debashish Mishra   
#  2    DevTSM    1.1         3/3/2005 6:32:16 AM  Debashish Mishra  
#  1    DevTSM    1.0         6/24/2003 10:42:41 AMDebashish Mishra 
# $
# 
#############################################################

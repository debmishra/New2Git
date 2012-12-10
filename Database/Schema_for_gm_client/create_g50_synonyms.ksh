#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: create_g50_synonyms.ksh$ 
#
# $Revision: 6$        $Date: 2/27/2008 3:17:43 PM$
#
#
# Description:  <ADD>
#
#############################################################
 

if [[ $3 = '' ]] 
  then

    echo
    echo "Usage :  create_g50_synonyms.ksh <pri_client_username> <pri_client_password> <sec_client_username> <database connect string>"
    echo
    echo This script requires at least three arguments. 
    echo primary client schema name and password  
    echo secondary client schema name 
    echo optional database connect string
    echo 
    exit 2
  fi

pri_user=$1
pri_pwd=$2
sec_user=$3
dbname=$4

if [[ $dbname = '' ]] 
  then
     pri_connect=$pri_user/$pri_pwd
else 
  pri_connect=$pri_user/$pri_pwd@$dbname
fi

sqlplus -s $pri_connect  << EOF >>g50synonyms.out 2>&1
 drop synonym g50_pap_clinical_proc_cost;
 drop synonym g50_pap_overhead;
 drop synonym g50_ip_study_price;
 drop synonym g50_mapper;
 create synonym g50_pap_clinical_proc_cost for $sec_user.pap_clinical_proc_cost;	
 create synonym g50_pap_overhead for $sec_user.pap_overhead;				
 create synonym g50_ip_study_price for $sec_user.ip_study_price;
 create synonym g50_mapper for $sec_user.mapper;				
 exit;
EOF

exit 0


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/27/2008 3:17:43 PM Debashish Mishra  
#  5    DevTSM    1.4         9/19/2006 12:08:00 AMDebashish Mishra  removed
#       references to obsolete tables
#  4    DevTSM    1.3         3/3/2005 6:33:25 AM  Debashish Mishra   
#  3    DevTSM    1.2         3/3/2005 6:32:15 AM  Debashish Mishra  
#  2    DevTSM    1.1         7/2/2003 5:43:07 PM  Debashish Mishra  
#  1    DevTSM    1.0         6/24/2003 10:42:40 AMDebashish Mishra 
# $
# 
#############################################################

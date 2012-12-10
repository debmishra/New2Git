#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: insert_g50_client_data.ksh$ 
#
# $Revision: 7$        $Date: 2/27/2008 3:17:43 PM$
#
#
# Description:  <ADD>
#
#############################################################
 

if [[ $4 = '' ]] 
  then

    echo
    echo "Usage :  create_g50_client_data.ksh <master_user> <master_paswd> <pri_client_username> <sec_client_username> <database connect string>"
    echo
    echo This script requires at least four arguments. 
    echo master schema name and password  
    echo primary and secondary client schema name 
    echo optional database connect string
    echo 
    exit 2
  fi

master_user=$1
master_pwd=$2
pri_user=$3
sec_user=$4
dbname=$5

if [[ $dbname = '' ]] 
  then
     master_connect=$master_user/$master_pwd
else 
  master_connect=$master_user/$master_pwd@$dbname
fi

sqlplus -s $master_connect  << EOF >>g50data.out 2>&1

Insert into $pri_user.g50_pap_clinical_proc_cost 
select * from $sec_user.pap_clinical_proc_cost
where company_pct50 is not null;
commit;
Insert into $pri_user.g50_ip_study_price 
select * from $sec_user.ip_study_price;
commit;
Insert into $pri_user.g50_pap_overhead
select * from $sec_user.pap_overhead;
commit;
Insert into $pri_user.G50_COMPANY_PAP_ODC_COST
select * from $sec_user.COMPANY_PAP_ODC_COST;
commit;
exit;
EOF

exit 0


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         2/27/2008 3:17:43 PM Debashish Mishra  
#  6    DevTSM    1.5         9/19/2006 12:08:01 AMDebashish Mishra  removed
#       references to obsolete tables
#  5    DevTSM    1.4         3/3/2005 6:33:26 AM  Debashish Mishra   
#  4    DevTSM    1.3         3/3/2005 6:32:16 AM  Debashish Mishra  
#  3    DevTSM    1.2         7/14/2004 4:13:23 PM Kelly Kingdon   bug fix 49Q. 
#       we should not copy rows over to g50 table if company_pct50 is null, we
#       only use this data for the company values.  Saves data and fixes problem
#       where deprice rows were being found by g50 code that was not happy with
#       specifity not set.
#  2    DevTSM    1.1         7/2/2003 5:43:07 PM  Debashish Mishra  
#  1    DevTSM    1.0         6/24/2003 10:34:49 AMDebashish Mishra 
# $
# 
#############################################################

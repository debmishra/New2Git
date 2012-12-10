#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsm10_client_derived_prices.ksh$ 
#
# $Revision: 6$        $Date: 2/27/2008 3:17:44 PM$
#
#
# Description:  <ADD>
#
#############################################################
 


if  test  $# != 3
 then
    echo 'Usage :  tsm10_client_derived_prices.ksh <master_client_schema_name>  <master_client_password> <database_connect string>'
    echo 
    echo This script requires three arguments. 
    echo master client schema name 
    echo master client password 
    echo and database connect string
    echo 
    exit 2
 fi

Sqlplus –s   $1/$2@$3    << EOF 

insert into pap_clinical_proc_cost(ID,COUNTRY_ID,INDMAP_ID,PHASE_ID,MAPPER_ID, 
PCT25,PCT50,PCT75,DE_PRICE,SPECIFICITY,LEVEL2_SKIP_FLG) 
select increment_sequence('pap_clinical_proc_cost_seq'),a.country_id, 0,0,b.id, 
a.LOW_PRICE,a.MED_PRICE,a.HIGH_PRICE,1,10,0 from derived_prices a,mapper b 
where a.procedure_def_id=b.procedure_def_id and not exists ( 
select 1 from pap_clinical_proc_cost c where c.country_id=a.country_id and 
c.mapper_id=b.id and c.indmap_id=0 and c.phase_id=0 );
commit;
exit  

EOF
exit 0

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/27/2008 3:17:44 PM Debashish Mishra  
#  5    DevTSM    1.4         10/22/2006 8:43:31 PMDebashish Mishra replaced the
#       sequence with the function
#  4    DevTSM    1.3         10/8/2006 12:56:13 AMDebashish Mishra  
#  3    DevTSM    1.2         9/21/2006 11:53:27 AMDebashish Mishra fixed bugs
#  2    DevTSM    1.1         9/21/2006 10:00:59 AMDebashish Mishra updated for
#       same schema
#  1    DevTSM    1.0         9/20/2006 11:03:17 PMDebashish Mishra 
# $
# 
#############################################################
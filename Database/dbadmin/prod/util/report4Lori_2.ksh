#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_2.ksh$ 
#
# $Revision: 11$        $Date: 6/7/2011 10:05:19 PM$
#
#
# Description:  <ADD>
#
#############################################################

cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com"
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"
 
export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000

spool /export/home/oracle/log/UnlistedProcs.csv

set heading off
/*
select '"'||'Report run date: '||'","'||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT'||'"' from dual;
Select '"Summary Report of Number of site budgets in each client division"' from dual;

select '"client_division","Site Budgets"' from dual;

select '"'||client_division||'","'||budgets||'"' from(
select c.name||'('||c.client_div_identifier||')' Client_Division,
count(*) budgets
from trial_budget a, trial b, client_div c
where a.trial_id=b.id 
and b.client_div_id =c.id
and a.institution_id is not null
group by c.name||'('||c.client_div_identifier||')');
*/
Select '"Detail Report of unlisted procedures for each Client"' from dual;

select '"client","type","Unlisted Procedure","Description","Low","Medium","High"' from dual;

select '"'||b.name||'('||b.client_identifier||')'||'","'||
decode(a.type,'CLIN','PROC',a.type)||'","'|| a.name||'","'||
trim(a.long_desc)||'","'||a.low||'","'||a.mid||'","'||a.high||'"'
from unlisted_procedure a,client b
where a.client_id=b.id
and upper(b.client_identifier) <> 'DUMMY'
order by b.name||'('||b.client_identifier||')',
decode(a.type,'CLIN','PROC',a.type);

spool off
exit;
EOF

mv /export/home/oracle/log/UnlistedProcs.csv /export/home/oracle/log/UnlistedProcs_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/UnlistedProcs_$(date +%m%d%y).csv | \
uuencode UnlistedProcs_$(date +%m%d%y).csv | \
mailx -r $sender -s "Unlisted Procedures in production" -c $cclist $mailinglist

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  11   DevTSM    1.10        6/7/2011 10:05:19 PM Debashish Mishra  
#  10   DevTSM    1.9         8/11/2009 12:03:30 AMDebashish Mishra  
#  9    DevTSM    1.8         9/3/2008 11:58:50 AM Debashish Mishra  
#  8    DevTSM    1.7         2/27/2008 3:21:52 PM Debashish Mishra  
#  7    DevTSM    1.6         9/6/2006 9:49:59 PM  Debashish Mishra  
#  6    DevTSM    1.5         9/12/2005 12:42:02 PMDebashish Mishra  
#  5    DevTSM    1.4         9/12/2005 11:25:27 AMDebashish Mishra  
#  4    DevTSM    1.3         3/15/2005 7:16:39 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:44:58 AM  Debashish Mishra  
#  2    DevTSM    1.1         10/13/2004 8:01:26 AMDebashish Mishra  
#  1    DevTSM    1.0         12/26/2003 4:22:13 PMDebashish Mishra 
# $
# 
#############################################################

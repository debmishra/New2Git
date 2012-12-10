#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Ed_1.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:16 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

###mailinglist="eseguine@mdsol.com lshields@mdsol.com spepe@mdsol.com mdanishefsky@mdsol.com"
mailinglist="trialplanning@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Ed/NumberOfUsersAndLastWeekTrialsSummary.csv


select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Summary Report of Total Users and Trials created last week"' from dual;

Select '"NAME","ID","#users","LastWeekTrials",' from dual;
select '"'||x.name||'","'||x.id||'","'||x.num_users||'","'||to_number(nvl(y.num_trial_last_week,0))||'",' from
(select b.name, b.client_div_identifier id, count(*) num_users from
ftuser a, client_div b  where a.client_div_id = b.id and
a.id in (select ftuser_id from ftuser_to_client_group) and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
b.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
GROUP BY b.name, b.client_div_identifier ) x ,
(select f.client_div_identifier id, count(*) num_trial_last_week
from picase_trial d,trial e,client_div f where
d.trial_id=e.id and e.client_div_id = f.id and
d.create_date between sysdate-7 and sysdate and 
f.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
group by f.client_div_identifier) y
where x.id = y.id(+)
order by x.id;


spool off
exit;
EOF

mv /export/home/oracle/log/Ed/NumberOfUsersAndLastWeekTrialsSummary.csv /export/home/oracle/log/Ed/NumberOfUsersAndLastWeekTrialsSummary_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Ed/NumberOfUsersAndLastWeekTrialsSummary_$(date +%m%d%y).csv | \
uuencode NumberOfUsersAndLastWeekTrialsSummary_$(date +%m%d%y).csv | \
mailx -r $sender -s "Usage report - NumberOfUsersAndLastWeekTrialsSummary" -c $cclist $mailinglist

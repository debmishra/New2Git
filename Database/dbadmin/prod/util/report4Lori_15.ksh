#!/bin/ksh

cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="TrialPlanningSupport@mdsol.com,spepe@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF

set heading off
set feedback off
set lin 300
set pages 3000

delete from active_user_report where report_date < sysdate-365;
delete from active_user_report where report_date > sysdate-5;

Insert into active_user_report
SELECT 'PICASE',trunc(sysdate), b.id,a.id
FROM ftuser a,client_div b
WHERE a.client_div_id = b.id and
a.id in (select ftuser_id from ftuser_to_client_group) and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
b.id in (select client_div_id from client_div_to_lic_app 
         where app_name in ('GM30','PICASE') and LICENSE_EXP_DATE > sysdate)
ORDER BY 2,3;


Insert into active_user_report
SELECT 'CROCAS',trunc(sysdate), b.id,a.id
FROM ftuser a,client_div b
WHERE a.client_div_id = b.id and
a.active_crocas_user = 1 and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
b.id in (select client_div_id from client_div_to_lic_app 
	 where app_name='CROCAS' and LICENSE_EXP_DATE > sysdate)
ORDER BY 2,3;


Insert into active_user_report
SELECT 'GMOWN',trunc(sysdate), b.id,a.id
FROM ftuser a,client_div b
WHERE a.client_div_id = b.id and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id=34) and
b.id in (select client_div_id from client_div_to_lic_app 
	 where app_name='GMOWN' and LICENSE_EXP_DATE > sysdate)
ORDER BY 2,3;

Insert into active_user_report
SELECT 'PBTOWN',trunc(sysdate), b.id,a.id
FROM ftuser a,client_div b
WHERE a.client_div_id = b.id and
a.active_crocas_user = 1 and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id=33) and
b.id in (select client_div_id from client_div_to_lic_app 
	 where app_name='CROCAS' and LICENSE_EXP_DATE > sysdate)
ORDER BY 2,3;

Insert into active_user_report
SELECT 'TSN',trunc(sysdate), b.id,a.id
FROM ftuser a,client_div b
WHERE a.client_div_id = b.id and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 30 and 32) and
b.id in (select client_div_id from client_div_to_lic_app 
	 where app_name='TSN' and LICENSE_EXP_DATE > sysdate)
ORDER BY 2,3;

commit;


spool /export/home/oracle/log/GM_users.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"Users activated in TGM last month"' from dual;

select '"Client Div","User Name","Login ID","Email"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"' 
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='PICASE' and 
report_date between sysdate-1 and sysdate
minus
select ftuser_id from active_user_report where app_name='PICASE' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7) 
order by 1;

Select '"Users Inactivated in TGM last month"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"'  
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='PICASE' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7
minus
select ftuser_id from active_user_report where app_name='PICASE' and 
report_date between sysdate-1 and sysdate)
order by 1;

spool off

spool /export/home/oracle/log/CROCAS_users.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"Users activated in CROCAS last month"' from dual;

select '"Client Div","User Name","Login ID","Email"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"'  
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='CROCAS' and 
report_date between sysdate-1 and sysdate
minus
select ftuser_id from active_user_report where app_name='CROCAS' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7)
order by 1;

Select '"Users Inactivated in CROCAS last month"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"'  
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='CROCAS' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7
minus
select ftuser_id from active_user_report where app_name='CROCAS' and 
report_date between sysdate-1 and sysdate)
order by 1;

spool off


spool /export/home/oracle/log/GM_Analysis_users.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"Users activated in GM-Analysis last month"' from dual;

select '"Client Div","User Name","Login ID","Email"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"' 
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='GMOWN' and 
report_date between sysdate-1 and sysdate
minus
select ftuser_id from active_user_report where app_name='GMOWN' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7) 
order by 1;

Select '"Users Inactivated in GM-Analysis last month"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"'  
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='GMOWN' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7
minus
select ftuser_id from active_user_report where app_name='GMOWN' and 
report_date between sysdate-1 and sysdate)
order by 1;

spool off


spool /export/home/oracle/log/CRO_Contractor_Analysis_users.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"Users activated in CRO Contractor-Analysis last month"' from dual;

select '"Client Div","User Name","Login ID","Email"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"' 
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='PBTOWN' and 
report_date between sysdate-1 and sysdate
minus
select ftuser_id from active_user_report where app_name='PBTOWN' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7) 
order by 1;

Select '"Users Inactivated in CRO Contractor-Analysis last month"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'","'||a.email||'"'  
from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='PBTOWN' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7
minus
select ftuser_id from active_user_report where app_name='PBTOWN' and 
report_date between sysdate-1 and sysdate)
order by 1;

spool off
/*
spool /export/home/oracle/log/GM_Contracting_users.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"Users activated in GM Contracting last month"' from dual;

select '"Client Div","User Name","Login ID"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'"' from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='TSN' and 
report_date between sysdate-1 and sysdate
minus
select ftuser_id from active_user_report where app_name='TSN' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7) 
order by 1;

Select '"Users Inactivated in GM Contracting last month"' from dual;

select '"'||b.client_div_identifier||'","'||a.first_name||' '||a.last_name||'","'||a.name||'"'  from ftuser a , client_div b
where a.client_div_id=b.id and a.id in (
select ftuser_id from active_user_report where app_name='TSN' and 
report_date between add_months(sysdate,-1)-7 and add_months(sysdate,-1)+7
minus
select ftuser_id from active_user_report where app_name='TSN' and 
report_date between sysdate-1 and sysdate)
order by 1;

spool off
*/
exit;
EOF

mv /export/home/oracle/log/GM_users.csv /export/home/oracle/log/GM_users_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_users_$(date +%m%d%y).csv | \
uuencode GM_users_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM users - Activated and Inactivated last month" -c $cclist $mailinglist


mv /export/home/oracle/log/CROCAS_users.csv /export/home/oracle/log/CROCAS_users_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/CROCAS_users_$(date +%m%d%y).csv | \
uuencode CROCAS_users_$(date +%m%d%y).csv | \
mailx -r $sender -s "CROCAS_users - Activated and Inactivated last month" -c $cclist $mailinglist


mv /export/home/oracle/log/GM_Analysis_users.csv /export/home/oracle/log/GM_Analysis_users_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_Analysis_users_$(date +%m%d%y).csv | \
uuencode GM_Analysis_users_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM-Analysis users - Activated and Inactivated last month" -c $cclist $mailinglist


mv /export/home/oracle/log/CRO_Contractor_Analysis_users.csv /export/home/oracle/log/CRO_Contractor_Analysis_users_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/CRO_Contractor_Analysis_users_$(date +%m%d%y).csv | \
uuencode CRO_Contractor_Analysis_users_$(date +%m%d%y).csv | \
mailx -r $sender -s "CRO Contractor-Analysis users - Activated and Inactivated last month" -c $cclist $mailinglist

#mv /export/home/oracle/log/GM_Contracting_users.csv /export/home/oracle/log/GM_Contracting_users_$(date +%m%d%y).csv

#sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_Contracting_users_$(date +%m%d%y).csv | \
#uuencode GM_Contracting_users_$(date +%m%d%y).csv | \
#mailx -r $sender -s "GM Contracting users - Activated and Inactivated last month" -c $cclist $mailinglist

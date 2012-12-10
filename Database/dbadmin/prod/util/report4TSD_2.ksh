#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4TSD_2.ksh$ 
#
# $Revision: 4$        $Date: 6/7/2011 10:05:21 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="designerservices@mdsol.com"
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
spool /export/home/oracle/log/Designer_NumberOfUsersAndLastWeekTrialsSummary.csv


select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Summary Report of Total Users and Trials created last week"' from dual;

Select '"NAME","ID","#users","LastWeekTrials",' from dual;
select '"'||x.name||'","'||x.id||'","'||x.num_users||'","'||to_number(nvl(y.num_trial_last_week,0))||'",' from
(select b.name, b.client_div_identifier id, count(*) num_users from
ftuser a, client_div b  where a.client_div_id = b.id and
a.active_tspd_user=1 and
b.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD')
GROUP BY b.name, b.client_div_identifier ) x ,
(select f.client_div_identifier id, count(*) num_trial_last_week
from tspd_trial d,trial e,client_div f where
d.trial_id=e.id and e.client_div_id = f.id and
d.create_date between sysdate-7 and sysdate and 
f.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD')
group by f.client_div_identifier) y
where x.id = y.id(+)
order by x.id;


spool off


set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Designer_UserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Detail Report of Users in each Client Division"' from dual;

select '"ID","User Name","#LOGIN","LAST LOGIN DATE",' from dual;
SELECT '"'||b.client_div_identifier||'","'||a.First_name||' '||a.Last_name||'","'||c.num_login||'","'||
to_char(a.last_login_date,'mm/dd/yy hh24:mi')||'",' 
FROM ftuser a,client_div b, 
(select ftuser_id, count(*) num_login from ftuser_login_history group by ftuser_id) c
WHERE a.client_div_id = b.id and a.id=c.ftuser_id(+) and
a.active_tspd_user=1 and
b.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD')
ORDER BY b.client_div_identifier;

spool off

set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id

spool /export/home/oracle/log/Designer_TrialPerUser.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Detail Report of # of Trials created by users in each Client Division"' from dual;

select '"ID","USER NAME","#TRIAL",' from dual;

select '"'||ID||'","'||USER_NAME||'","'||NUM_TRIAL||'",' from(
select c.client_div_identifier ID,b.first_name||' '||b.last_name USER_NAME,count(*) NUM_TRIAL
from tspd_trial a, ftuser b, client_div c where
b.active_tspd_user=1 and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD')
group by c.client_div_identifier, b.first_name||' '||b.last_name);


spool off

set hea off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Designer_UserAndTrialIn4wksAnd12months.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Summary Report of #distinct userlogin & #trials in last 4 weeks and 12 months"' from dual;
select '"ID","# of users logged in during last 4 weeks","# of users logged in during last 12 months","Total # of Trials in last 4 weeks","Total # of Trials in last 12 months",' from dual;

SELECT '"'||y.id||'","'||nvl(x.distinct_user,0)||'","'||y.distinct_user||'","'||nvl(x.total_trial,0)||'","'||nvl(y.total_trial,0)||'",' 
from
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.active_tspd_user=1 and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD') and
a.ftuser_id = b.id and b.client_div_id=c.id 
and a.last_login_change_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from tspd_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id 
AND b.active_tspd_user=1 and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD')
and a.create_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q WHERE p.id=q.id(+)) x,
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.active_tspd_user=1 and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD') and
a.ftuser_id = b.id and b.client_div_id=c.id
and a.last_login_change_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from tspd_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.active_tspd_user=1 and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD')
and a.create_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q
WHERE p.id=q.id(+)) y WHERE x.id(+)=y.id ORDER BY y.id;


spool off

set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Designer_DetailUserAndTrialIn4wks.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Detail Report of #Login & #Trial in last 4 weeks"' from dual; 
select '"ID","USER NAME","#login","#trial"' from dual;


SELECT '"'||x.id||'","'||x.user_name||'","'||x.login_cnt||'","'||decode(y.trial_cnt,NULL,0,y.trial_cnt)||'"' 
from
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) login_cnt
from ftuser_login_history a, ftuser b, client_div c where
b.active_tspd_user=1 and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD') and
a.ftuser_id = b.id and b.client_div_id=c.id  
and a.last_login_change_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) x,
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) trial_cnt
from tspd_trial a, ftuser b, client_div c where
b.active_tspd_user=1 and
c.id in (select client_div_id from client_div_to_lic_app where app_name='TSPD') and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  AND
a.create_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) y
WHERE x.id=y.id(+) AND x.user_name=y.user_name(+)
ORDER BY x.id,x.user_name;

spool off

exit;
EOF

mv /export/home/oracle/log/Designer_NumberOfUsersAndLastWeekTrialsSummary.csv /export/home/oracle/log/Designer_NumberOfUsersAndLastWeekTrialsSummary_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Designer_NumberOfUsersAndLastWeekTrialsSummary_$(date +%m%d%y).csv | \
uuencode Designer_NumberOfUsersAndLastWeekTrialsSummary_$(date +%m%d%y).csv | \
mailx -r $sender -s "Designer Usage report - NumberOfUsersAndLastWeekTrialsSummary" -c $cclist $mailinglist

mv /export/home/oracle/log/Designer_UserDetails.csv /export/home/oracle/log/Designer_UserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Designer_UserDetails_$(date +%m%d%y).csv | \
uuencode Designer_UserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "Designer Usage report - UserDetails" -c $cclist $mailinglist

mv /export/home/oracle/log/Designer_TrialPerUser.csv /export/home/oracle/log/Designer_TrialPerUser_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Designer_TrialPerUser_$(date +%m%d%y).csv | \
uuencode Designer_TrialPerUser_$(date +%m%d%y).csv | \
mailx -r $sender -s "Designer Usage report - TrialPerUser" -c $cclist $mailinglist

mv /export/home/oracle/log/Designer_UserAndTrialIn4wksAnd12months.csv /export/home/oracle/log/Designer_UserAndTrialIn4wksAnd12months_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Designer_UserAndTrialIn4wksAnd12months_$(date +%m%d%y).csv | \
uuencode Designer_UserAndTrialIn4wksAnd12months_$(date +%m%d%y).csv | \
mailx -r $sender -s "Designer Usage report - UserAndTrialIn4wksAnd12months" -c $cclist $mailinglist

mv /export/home/oracle/log/Designer_DetailUserAndTrialIn4wks.csv /export/home/oracle/log/Designer_DetailUserAndTrialIn4wks_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Designer_DetailUserAndTrialIn4wks_$(date +%m%d%y).csv | \
uuencode Designer_DetailUserAndTrialIn4wks_$(date +%m%d%y).csv | \
mailx -r $sender -s "Designer Usage report - DetailUserAndTrialIn4wks" -c $cclist $mailinglist
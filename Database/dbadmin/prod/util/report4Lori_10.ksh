#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_10.ksh$ 
#
# $Revision: 6$        $Date: 6/7/2011 10:05:18 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

###mailinglist="lshields@mdsol.com mdanishefsky@mdsol.com spepe@mdsol.com jdolfi@mdsol.com"
mailinglist="trialplanning@mdsol.com,spepe@mdsol.com"
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column name format a35
column id format a8
column user_name format a32
column last_login_date format a25
break on id
spool /export/home/oracle/log/Report4Lori10.txt



set heading off
select 'Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT' from dual;
select '==========================================================' from dual;
Select 'Summary Report of Total Users and Trials created last week' from dual;
select '==========================================================' from dual;
set heading on

select x.name,x.id,x.num_users "#users",nvl(y.num_trial_last_week,0) "LastWeekTrials" from
(select b.name, b.client_div_identifier id, count(*) num_users from
ftuser a, client_div b  where a.client_div_id = b.id and
a.active_crocas_user = 1 and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
b.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS')
GROUP BY b.name, b.client_div_identifier ) x ,
(select f.client_div_identifier id, count(*) num_trial_last_week
from cro_trial d,trial e,client_div f where
d.trial_id=e.id and e.client_div_id = f.id and
d.create_date between sysdate-7 and sysdate and 
f.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS')
group by f.client_div_identifier) y
where x.id = y.id(+)
order by x.id;

column user_name format a30
column last_login_date format a25
break on id

set heading off
select '===============================================' from dual;
Select 'Detail Report of Users in each Client Division' from dual;
select '===============================================' from dual;
set heading on

SELECT b.client_div_identifier id,a.First_name||' '||a.Last_name user_name,c.num_login "#LOGIN",
to_char(c.last_login_date,'mm/dd/yy hh24:mi') last_login_date 
FROM ftuser a,client_div b,
(select ftuser_id, count(*) num_login, max(modify_date) last_login_date from audit_hist
 WHERE action='auditAction.login_succeeded' AND app_type='CROCAS' group by ftuser_id) c
WHERE a.client_div_id = b.id and a.id=c.ftuser_id(+) and
a.active_crocas_user = 1 and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
b.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS')
ORDER BY b.client_div_identifier;

set heading off
select '=====================================================================' from dual;
Select 'Detail Report of # of Trials created by users in each Client Division' from dual;
select '=====================================================================' from dual;
set heading on

select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) "#trial" 
from cro_trial a, ftuser b, client_div c where
b.active_crocas_user = 1 and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS')
group by c.client_div_identifier, b.first_name||' '||b.last_name
order by 1,2;


set heading off
select '===================================================================================' from dual;
Select 'Summary Report of #distinct userlogin & #total trials in last 4 weeks and 12 months' from dual;
select '===================================================================================' from dual;
select '       # of Distinct user login     Total # of Trials' from dual;
set heading on

SELECT y.id,nvl(x.distinct_user,0) "4weeks",y.distinct_user "12months",
nvl(x.total_trial,0) "4weeks",nvl(y.total_trial,0) "12months" from
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from audit_hist a, ftuser b, client_div c where
a.app_type = 'CROCAS' and a.action = 'auditAction.login_succeeded' and
b.active_crocas_user = 1 and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS')  and
a.ftuser_id = b.id and b.client_div_id=c.id 
and a.modify_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from cro_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id 
AND b.active_crocas_user = 1 and 
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS') 
and a.create_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q WHERE p.id=q.id(+)) x,
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from audit_hist a, ftuser b, client_div c where
a.app_type = 'CROCAS' and a.action = 'auditAction.login_succeeded' and
b.active_crocas_user = 1 and 
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS') and
a.ftuser_id = b.id and b.client_div_id=c.id
and a.modify_date> sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from cro_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.active_crocas_user = 1 and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS')
and a.create_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q
WHERE p.id=q.id(+)) y WHERE x.id(+)=y.id ORDER BY y.id;

set heading off
select '================================================' from dual;
Select 'Detail Report of #Login & #Trial in last 4 weeks' from dual; 
select '================================================' from dual;
set heading on


SELECT x.id,x.user_name,x.login_cnt "#login",decode(y.trial_cnt,NULL,0,y.trial_cnt) "#trial" from
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) login_cnt
from audit_hist a, ftuser b, client_div c where
a.app_type = 'CROCAS' and a.action = 'auditAction.login_succeeded' and
b.active_crocas_user = 1 and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS') and
a.ftuser_id = b.id and b.client_div_id=c.id  
and a.modify_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) x,
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) trial_cnt
from cro_trial a, ftuser b, client_div c where
b.active_crocas_user = 1 and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 25 and 28) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='CROCAS') and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  AND
a.create_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) y
WHERE x.id=y.id(+) AND x.user_name=y.user_name(+)
ORDER BY id,user_name;

spool off
exit;
EOF


cat /export/home/oracle/log/Report4Lori10.txt | mailx -s "CROCAS Production usage report" -r $sender -c $cclist $mailinglist

#cat /export/home/oracle/log/Report4Lori10.txt | mailx -s CROCAS_Production_usage_report dmishra@fast-track.com



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         6/7/2011 10:05:18 PM Debashish Mishra  
#  5    DevTSM    1.4         8/11/2009 12:03:29 AMDebashish Mishra  
#  4    DevTSM    1.3         9/3/2008 11:58:49 AM Debashish Mishra  
#  3    DevTSM    1.2         2/27/2008 3:21:51 PM Debashish Mishra  
#  2    DevTSM    1.1         9/15/2006 12:02:06 PMDebashish Mishra  
#  1    DevTSM    1.0         9/6/2006 9:50:18 PM  Debashish Mishra 
# $
# 
#############################################################

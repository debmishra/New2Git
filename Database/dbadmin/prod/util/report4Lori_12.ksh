#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_12.ksh$ 
#
# $Revision: 3$        $Date: 6/7/2011 10:05:18 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="fnaids@shire.com rdillon@shire.com"
#mailinglist="dmishra@fast-track.com"
cclist="lshields@mdsol.com dmishra@mdsol.com"
#cclist="dmishra@mdsol.com"
sender="TrialPlanningSupport@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Report4Lori_12.txt



set heading off
select 'Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT' from dual;
select ' ' from dual;
Select 'Users and Trials created last month:' from dual;
set heading on

select x.name,x.id,x.num_users "#users",nvl(y.num_trial_last_week,0) "LastMonthTrials" from
(select b.name, b.client_div_identifier id, count(*) num_users from
ftuser a, client_div b  where a.client_div_id = b.id and b.client_div_identifier='SHR' and
a.id in (select ftuser_id from ftuser_to_client_group) and a.name <> 'fasttrack@SHR'
GROUP BY b.name, b.client_div_identifier ) x ,
(select f.client_div_identifier id, count(*) num_trial_last_week
from picase_trial d,trial e,client_div f where
d.trial_id=e.id and e.client_div_id = f.id and f.client_div_identifier='SHR' and
d.create_date between trunc(add_months(sysdate, -1),'MONTH') and trunc(sysdate,'MONTH')
group by f.client_div_identifier) y
where x.id = y.id(+)
order by x.name;

column user_name format a30
column last_login_date format a25
break on id

set heading off
select '============' from dual;
Select 'User details:' from dual;
select '============' from dual;
set heading on

SELECT a.First_name||' '||a.Last_name user_name,c.num_login "#LOGIN",
to_char(a.last_login_date,'mm/dd/yy hh24:mi') last_login_date 
FROM ftuser a,client_div b, 
(select ftuser_id, count(*) num_login from ftuser_login_history group by ftuser_id) c
WHERE a.client_div_id = b.id and a.id=c.ftuser_id(+) and b.client_div_identifier='SHR' and
a.id in (select ftuser_id from ftuser_to_client_group)
ORDER BY 1;

set heading off
select '=============================================' from dual;
Select 'Detail Report of # of Trials created by users' from dual;
select '=============================================' from dual;
set heading on

select  
b.first_name||' '||b.last_name user_name, 
count(*) "#trial" 
from picase_trial a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  and c.client_div_identifier='SHR'
group by  b.first_name||' '||b.last_name order by 1;

set heading off
select '====================================================' from dual;
Select 'Detail Report of # of IPT created and saved by users' from dual;
select '====================================================' from dual;
set heading on

select b.first_name||' '||b.last_name user_name,
count(*) "#IPT" from ip_session a, ftuser b, client_div c where
a.client_div_id = c.id and a.creator_ftuser_id=b.id and c.client_div_identifier='SHR'
group by b.first_name||' '||b.last_name order by 1;

set heading off
select '======================================================================================' from dual;
Select 'Summary Report of #distinct userlogin & #total trials in last month and last 12 months' from dual;
select '======================================================================================' from dual;
select '#DistinctUserLogin       Total # of Trials' from dual;
set heading on

SELECT nvl(x.distinct_user,0) "last_month",y.distinct_user "12months",
nvl(x.total_trial,0) "last_month",nvl(y.total_trial,0) "12months" from
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.ftuser_id = b.id and b.client_div_id=c.id and c.client_div_identifier='SHR'
and a.last_login_change_date between trunc(add_months(sysdate, -1),'MONTH') and trunc(sysdate,'MONTH') AND
b.name NOT LIKE 'fasttrack@%'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from picase_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id and c.client_div_identifier='SHR'
AND b.id in (select ftuser_id from ftuser_to_client_group)
and a.create_date between trunc(add_months(sysdate, -1),'MONTH') and trunc(sysdate,'MONTH') AND
b.name NOT LIKE 'fasttrack@%' 
group by c.client_div_identifier) q WHERE p.id=q.id(+)) x,
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.ftuser_id = b.id and b.client_div_id=c.id and c.client_div_identifier='SHR'
and a.last_login_change_date between trunc(add_months(sysdate, -12),'MONTH') and trunc(sysdate,'MONTH') AND
b.name NOT LIKE 'fasttrack@%' 
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from picase_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id and c.client_div_identifier='SHR'
AND b.id in (select ftuser_id from ftuser_to_client_group)
and a.create_date between trunc(add_months(sysdate, -12),'MONTH') and trunc(sysdate,'MONTH') AND
b.name NOT LIKE 'fasttrack@%' 
group by c.client_div_identifier) q
WHERE p.id=q.id(+)) y WHERE x.id(+)=y.id ORDER BY 1;

set heading off
select '==============================================' from dual;
Select 'Detail Report of #Login & #Trial in last month' from dual; 
select '==============================================' from dual;
set heading on


SELECT x.user_name,x.login_cnt "#login",decode(y.trial_cnt,NULL,0,y.trial_cnt) "#trial" from
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) login_cnt
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.ftuser_id = b.id and b.client_div_id=c.id and c.client_div_identifier='SHR' and
b.name <> 'fasttrack@SHR' 
and a.last_login_change_date between trunc(add_months(sysdate, -1),'MONTH') and trunc(sysdate,'MONTH')
group by c.client_div_identifier, b.first_name||' '||b.last_name) x,
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) trial_cnt
from picase_trial a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.creator_ftuser_id = b.id and b.client_div_id=c.id and c.client_div_identifier='SHR' 
and b.name <> 'fasttrack@SHR'
AND a.create_date  between trunc(add_months(sysdate, -1),'MONTH') and trunc(sysdate,'MONTH')
group by c.client_div_identifier, b.first_name||' '||b.last_name) y
WHERE x.id=y.id(+) AND x.user_name=y.user_name(+)
ORDER BY 1;

spool off
exit;
EOF



cat /export/home/oracle/log/Report4Lori_12.txt | mailx -s "Grants Manager(SHR) usage report" -r $sender -c $cclist $mailinglist

#cat /export/home/oracle/log/Report4Lori_12.txt | mailx -s "Grants Manager(SHR) usage report" dmishra@fast-track.com



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         6/7/2011 10:05:18 PM Debashish Mishra  
#  2    DevTSM    1.1         8/11/2009 12:03:30 AMDebashish Mishra  
#  1    DevTSM    1.0         9/3/2008 12:02:08 PM Debashish Mishra 
# $
# 
#############################################################
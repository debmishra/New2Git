#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori.ksh$ 
#
# $Revision: 18$        $Date: 6/7/2011 10:05:17 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com,spepe@mdsol.com"
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

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
spool /export/home/oracle/log/Report4Lori.txt



set heading off
select 'Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT' from dual;
select '==========================================================' from dual;
Select 'Summary Report of Total Users and Trials created last week' from dual;
select '==========================================================' from dual;
set heading on

select x.name,x.id,x.num_users "#users",nvl(y.num_trial_last_week,0) "LastWeekTrials" from
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

column user_name format a30
column last_login_date format a25
break on id

set heading off
select '===============================================' from dual;
Select 'Detail Report of Users in each Client Division' from dual;
select '===============================================' from dual;
set heading on

SELECT b.client_div_identifier id,a.First_name||' '||a.Last_name user_name,c.num_login "#LOGIN",
to_char(a.last_login_date,'mm/dd/yy hh24:mi') last_login_date 
FROM ftuser a,client_div b, 
(select ftuser_id, count(*) num_login from ftuser_login_history group by ftuser_id) c
WHERE a.client_div_id = b.id and a.id=c.ftuser_id(+) and
a.id in (select ftuser_id from ftuser_to_client_group) and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
b.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
ORDER BY b.client_div_identifier;

set heading off
select '=====================================================================' from dual;
Select 'Detail Report of # of Trials created by users in each Client Division' from dual;
select '=====================================================================' from dual;
set heading on

select c.client_div_identifier id,
b.first_name||' '||b.last_name user_name, decode(a.gm_version,null,'<=2.x',3,'>=3.x') GM_VERSION ,
count(*) "#trial"
from picase_trial a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name IN ('PICASE','GM30'))
group by c.client_div_identifier, b.first_name||' '||b.last_name,decode(a.gm_version,null,'<=2.x',3,'>=3.x')
ORDER BY 1,2,3;

set heading off
select '============================================================================' from dual;
Select 'Detail Report of # of IPT created and saved by users in each Client Division' from dual;
select '============================================================================' from dual;
set heading on

select c.client_div_identifier id,b.first_name||' '||b.last_name user_name,
count(*) "#IPT" from ip_session a, ftuser b, client_div c where
a.client_div_id = c.id and a.creator_ftuser_id=b.id and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
group by c.client_div_identifier, b.first_name||' '||b.last_name;

set heading off
select '===================================================================================' from dual;
Select 'Summary Report of #distinct userlogin & #total trials in last 4 weeks and 12 months' from dual;
select '===================================================================================' from dual;
select '       # of Distinct user login     Total # of Trials<=2.0     Total # of Trials>=3.0' from dual;
set heading on
SELECT y.id,nvl(x.distinct_user,0) "4weeks",y.distinct_user "12months",
nvl(x.total_trial,0) "4weeks<=GM2.0",nvl(y.total_trial,0) "12months<=GM2.0",
nvl(x.total_3_trial,0) "4weeks>=GM3.0",nvl(y.total_3_trial,0) "12months>=GM3.0" from
(SELECT p.id,p.distinct_user,q.total_trial,r.total_3_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')  and
a.ftuser_id = b.id and b.client_div_id=c.id
and a.last_login_change_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from picase_trial a, ftuser b, client_div c where a.gm_version is null and
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
and a.create_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q, 
(select c.client_div_identifier id, count(*) total_3_trial
from picase_trial a, ftuser b, client_div c where a.gm_version=3 and
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='GM30')
and a.create_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) r
WHERE p.id=q.id(+) and p.id=r.id(+)) x,
(SELECT p.id,p.distinct_user,q.total_trial, r.total_3_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE') and
a.ftuser_id = b.id and b.client_div_id=c.id
and a.last_login_change_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from picase_trial a, ftuser b, client_div c where a.gm_version is null and
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
and a.create_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q,
(select c.client_div_identifier id, count(*) total_3_trial
from picase_trial a, ftuser b, client_div c where a.gm_version=3 and
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='GM30')
and a.create_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) r
WHERE p.id=q.id(+) and p.id=r.id(+)) y 
WHERE x.id(+)=y.id ORDER BY y.id;

set heading off
select '================================================' from dual;
Select 'Detail Report of #Login & #Trial in last 4 weeks' from dual; 
select '================================================' from dual;
set heading on


SELECT x.id,x.user_name,x.login_cnt "#login",decode(y.trial_cnt,NULL,0,y.trial_cnt) "#trial<=2.0",
decode(z.gm3_trial_cnt,NULL,0,z.gm3_trial_cnt) "#trial>=3.0"
from
(select c.client_div_identifier id,
b.first_name||' '||b.last_name user_name,
count(*) login_cnt
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE') and
a.ftuser_id = b.id and b.client_div_id=c.id
and a.last_login_change_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) x,
(select c.client_div_identifier id,
b.first_name||' '||b.last_name user_name,
count(*) trial_cnt
from picase_trial a, ftuser b, client_div c where a.gm_version=null and
b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE') and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  AND
a.create_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) y,
(select c.client_div_identifier id,
b.first_name||' '||b.last_name user_name,
count(*) gm3_trial_cnt
from picase_trial a, ftuser b, client_div c where a.gm_version=3 and
b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='GM30') and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  AND
a.create_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) z
WHERE x.id=y.id(+) AND x.user_name=y.user_name(+) and x.id=z.id(+) AND x.user_name=z.user_name(+)
ORDER BY id,user_name;
spool off
exit;
EOF

cat /export/home/oracle/log/Report4Lori.txt | mailx -s "Production usage report" -r $sender -c $cclist $mailinglist




#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  18   DevTSM    1.17        6/7/2011 10:05:17 PM Debashish Mishra  
#  17   DevTSM    1.16        8/11/2009 12:03:29 AMDebashish Mishra  
#  16   DevTSM    1.15        9/3/2008 11:58:49 AM Debashish Mishra  
#  15   DevTSM    1.14        2/27/2008 3:21:51 PM Debashish Mishra  
#  14   DevTSM    1.13        12/13/2007 11:48:51 AMDebashish Mishra  
#  13   DevTSM    1.12        9/15/2006 12:02:05 PMDebashish Mishra  
#  12   DevTSM    1.11        9/6/2006 9:49:58 PM  Debashish Mishra  
#  11   DevTSM    1.10        3/15/2005 7:16:38 PM Debashish Mishra  
#  10   DevTSM    1.9         3/3/2005 6:44:58 AM  Debashish Mishra  
#  9    DevTSM    1.8         2/28/2005 9:54:25 AM Debashish Mishra  
#  8    DevTSM    1.7         10/13/2004 8:01:26 AMDebashish Mishra  
#  7    DevTSM    1.6         8/4/2004 2:39:20 PM  Debashish Mishra  
#  6    DevTSM    1.5         12/18/2003 6:18:40 PMDebashish Mishra  
#  5    DevTSM    1.4         10/13/2003 9:53:37 AMDebashish Mishra Modified after
#       replacing hard disk in production database server
#  4    DevTSM    1.3         8/29/2003 5:09:12 PM Debashish Mishra Added counts
#       for IPT
#  3    DevTSM    1.2         8/27/2003 7:49:03 PM Debashish Mishra added number
#       of trials created last week
#  2    DevTSM    1.1         8/26/2003 4:40:06 PM Debashish Mishra  
#  1    DevTSM    1.0         8/15/2003 2:03:22 PM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Ed_5.ksh$ 
#
# $Revision: 8$        $Date: 6/7/2011 10:05:17 PM$
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
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set hea off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Ed/UserAndTrialIn4wksAnd12months.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Summary Report of #distinct userlogin & #trials in last 4 weeks and 12 months"' from dual;
select '"ID","# of users logged in during last 4 weeks","# of users logged in during last 12 months","Total # of Trials in last 4 weeks","Total # of Trials in last 12 months",' from dual;

SELECT '"'||y.id||'","'||nvl(x.distinct_user,0)||'","'||y.distinct_user||'","'||nvl(x.total_trial,0)||'","'||nvl(y.total_trial,0)||'",' 
from
(SELECT p.id,p.distinct_user,q.total_trial from
(select c.client_div_identifier id,count(distinct a.ftuser_id) distinct_user
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE') and
a.ftuser_id = b.id and b.client_div_id=c.id 
and a.last_login_change_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) p,
(select c.client_div_identifier id, count(*) total_trial
from picase_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id 
AND b.id in (select ftuser_id from ftuser_to_client_group) and 
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
and a.create_date > sysdate-28 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q WHERE p.id=q.id(+)) x,
(SELECT p.id,p.distinct_user,q.total_trial from
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
from picase_trial a, ftuser b, client_div c where
a.creator_ftuser_id = b.id and b.client_div_id=c.id
AND b.id in (select ftuser_id from ftuser_to_client_group) and 
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE')
and a.create_date > sysdate-365 AND
b.name NOT LIKE 'fasttrack@%' AND c.client_div_identifier <> 'FTS'
group by c.client_div_identifier) q
WHERE p.id=q.id(+)) y WHERE x.id(+)=y.id ORDER BY y.id;


spool off
exit;
EOF



mv /export/home/oracle/log/Ed/UserAndTrialIn4wksAnd12months.csv /export/home/oracle/log/Ed/UserAndTrialIn4wksAnd12months_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Ed/UserAndTrialIn4wksAnd12months_$(date +%m%d%y).csv | \
uuencode UserAndTrialIn4wksAnd12months_$(date +%m%d%y).csv | \
mailx -r $sender -s "Usage report - UserAndTrialIn4wksAnd12months" -c $cclist $mailinglist



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  8    DevTSM    1.7         6/7/2011 10:05:17 PM Debashish Mishra  
#  7    DevTSM    1.6         8/11/2009 12:03:29 AMDebashish Mishra  
#  6    DevTSM    1.5         9/3/2008 11:58:49 AM Debashish Mishra  
#  5    DevTSM    1.4         2/27/2008 3:21:51 PM Debashish Mishra  
#  4    DevTSM    1.3         2/15/2007 4:48:08 PM Debashish Mishra  
#  3    DevTSM    1.2         9/6/2006 9:49:57 PM  Debashish Mishra  
#  2    DevTSM    1.1         4/17/2005 9:35:04 AM Debashish Mishra  
#  1    DevTSM    1.0         3/15/2005 7:17:01 PM Debashish Mishra 
# $
# 
#############################################################


#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Ed_6.ksh$ 
#
# $Revision: 7$        $Date: 6/7/2011 10:05:17 PM$
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

set heading off
set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Ed/DetailUserAndTrialIn4wks.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Detail Report of #Login & #Trial in last 4 weeks"' from dual; 
select '"ID","USER NAME","#login","#trial"' from dual;


SELECT '"'||x.id||'","'||x.user_name||'","'||x.login_cnt||'","'||decode(y.trial_cnt,NULL,0,y.trial_cnt)||'"' 
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
from picase_trial a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and 
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id in (9,10)) and
c.id in (select client_div_id from client_div_to_lic_app where app_name='PICASE') and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  AND
a.create_date > sysdate-28
group by c.client_div_identifier, b.first_name||' '||b.last_name) y
WHERE x.id=y.id(+) AND x.user_name=y.user_name(+)
ORDER BY x.id,x.user_name;

spool off
exit;
EOF



mv /export/home/oracle/log/Ed/DetailUserAndTrialIn4wks.csv /export/home/oracle/log/Ed/DetailUserAndTrialIn4wks_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Ed/DetailUserAndTrialIn4wks_$(date +%m%d%y).csv | \
uuencode DetailUserAndTrialIn4wks_$(date +%m%d%y).csv | \
mailx -r $sender -s "Usage report - DetailUserAndTrialIn4wks" -c $cclist $mailinglist



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  7    DevTSM    1.6         6/7/2011 10:05:17 PM Debashish Mishra  
#  6    DevTSM    1.5         8/11/2009 12:03:29 AMDebashish Mishra  
#  5    DevTSM    1.4         9/3/2008 11:58:49 AM Debashish Mishra  
#  4    DevTSM    1.3         2/27/2008 3:21:51 PM Debashish Mishra  
#  3    DevTSM    1.2         2/15/2007 4:48:09 PM Debashish Mishra  
#  2    DevTSM    1.1         9/6/2006 9:49:58 PM  Debashish Mishra  
#  1    DevTSM    1.0         5/9/2005 1:03:49 AM  Debashish Mishra 
# $
# 
#############################################################


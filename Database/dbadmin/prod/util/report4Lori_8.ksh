#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_8.ksh$ 
#
# $Revision: 6$        $Date: 6/7/2011 10:05:20 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="lshields@mdsol.com fcattie@mdsol.com"
#mailinglist="dmishra@fast-track.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10e/`get_pwd tsm10e` <<EOF 

set feedback off
set lin 300
set pages 1000
column name format a33
column id format a8
column user_name format a30
column last_login_date format a25
break on id
spool /export/home/oracle/log/Report4frx_training.txt



set heading off
select '===================================' from dual;
Select 'FRX Training Logins for '||to_char(sysdate,'MM/DD/YYYY') from dual; 
select '===================================' from dual;
set heading on


SELECT x.user_name,x.login_cnt "#login",decode(y.trial_cnt,NULL,0,y.trial_cnt) "#trial" from
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) login_cnt
from ftuser_login_history a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.ftuser_id = b.id and b.client_div_id=c.id  
and a.last_login_change_date > trunc(sysdate)
and c.client_div_identifier='FRX'
group by c.client_div_identifier, b.first_name||' '||b.last_name) x,
(select c.client_div_identifier id, 
b.first_name||' '||b.last_name user_name, 
count(*) trial_cnt
from picase_trial a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_client_group) and
a.creator_ftuser_id = b.id and b.client_div_id=c.id  AND
a.create_date > trunc(sysdate)
and c.client_div_identifier='FRX'
group by c.client_div_identifier, b.first_name||' '||b.last_name) y
WHERE x.id=y.id(+) AND x.user_name=y.user_name(+)
ORDER BY user_name;

spool off
exit;
EOF

cat /export/home/oracle/log/Report4frx_training.txt | mailx -s "FRX Training report for `date +%m/%d/%y`" -r $sender -c $cclist $mailinglist

#cat /export/home/oracle/log/Report4frx_training.txt | mailx -s "FRX Training report for `date +%m/%d/%y`" dmishra@fast-track.com



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         6/7/2011 10:05:20 PM Debashish Mishra  
#  5    DevTSM    1.4         8/11/2009 12:03:31 AMDebashish Mishra  
#  4    DevTSM    1.3         9/3/2008 11:58:50 AM Debashish Mishra  
#  3    DevTSM    1.2         2/27/2008 3:21:52 PM Debashish Mishra  
#  2    DevTSM    1.1         9/6/2006 9:50:01 PM  Debashish Mishra  
#  1    DevTSM    1.0         11/16/2005 2:05:52 PMDebashish Mishra 
# $
# 
#############################################################

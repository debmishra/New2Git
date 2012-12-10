#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\report4TSD_3.ksh$ 
#
# $Revision: 1$        $Date: 6/7/2011 10:09:30 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="designerservices@mdsol.com mcherry@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set heading off
set feedback off
set lin 100
set pages 1000
spool /export/home/oracle/log/quarterly_login.csv


select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT"' from dual;
Select '"Quarterly distinct user login report"' from dual;


select '"Client","Identifier","Q'||to_char(add_months(trunc(sysdate,'Q'), -12),'Q-YYYY')||'",'||'"Q'||to_char(add_months(trunc(sysdate,'Q'), -9),'Q-YYYY')||'",'||
       '"Q'||to_char(add_months(trunc(sysdate,'Q'), -6),'Q-YYYY')||'",'||'"Q'||to_char(add_months(trunc(sysdate,'Q'), -3),'Q-YYYY')||'"'
from dual;

select '"'||u.name||'",'||u.client_div_identifier||','||nvl(y.qtr,0)||','||nvl(x.qtr,0)||','||nvl(w.qtr,0)||','||nvl(v.qtr,0) from
(select a.client_div_id, b.client_div_identifier,b.name from client_div_to_lic_app a, client_div b where 
 a.client_div_id=b.id and a.app_name='TSPD' and a.license_exp_date > sysdate) U,
(select b.client_div_id,count(distinct a.ftuser_id) qtr 
from audit_hist a, ftuser b, client_div c
where a.ftuser_id=b.id and b.client_div_id=c.id and 
a.action='auditAction.login_succeeded' and 
b.name not like 'fasttrack@% ' and
a.app_type='TSPD' and
a.modify_date between add_months(trunc(sysdate,'Q'), -3) and
trunc(sysdate,'Q') 
group by b.client_div_id) v,
(select b.client_div_id,count(distinct a.ftuser_id) qtr
from audit_hist a, ftuser b, client_div c
where a.ftuser_id=b.id and b.client_div_id=c.id and 
a.action='auditAction.login_succeeded' and 
b.name not like 'fasttrack@% ' and
a.app_type='TSPD' and
a.modify_date between add_months(trunc(sysdate,'Q'), -6) and
add_months(trunc(sysdate,'Q'), -3)
group by b.client_div_id) w, 
(select b.client_div_id,count(distinct a.ftuser_id) qtr
from audit_hist a, ftuser b, client_div c
where a.ftuser_id=b.id and b.client_div_id=c.id and 
a.action='auditAction.login_succeeded' and 
b.name not like 'fasttrack@% ' and
a.app_type='TSPD' and
a.modify_date between add_months(trunc(sysdate,'Q'), -9) and
add_months(trunc(sysdate,'Q'), -6)
group by b.client_div_id) x,
(select b.client_div_id,count(distinct a.ftuser_id) qtr
from audit_hist a, ftuser b, client_div c
where a.ftuser_id=b.id and b.client_div_id=c.id and 
a.action='auditAction.login_succeeded' and 
b.name not like 'fasttrack@% ' and
a.app_type='TSPD' and
a.modify_date between add_months(trunc(sysdate,'Q'), -12) and
add_months(trunc(sysdate,'Q'), -9)
group by b.client_div_id) y
where u.client_div_id=v.client_div_id (+) and
u.client_div_id=w.client_div_id (+) and
u.client_div_id=x.client_div_id (+) and
u.client_div_id=y.client_div_id (+);

spool off

exit;
EOF

mv /export/home/oracle/log/quarterly_login.csv /export/home/oracle/log/quarterly_login_$(date +%m%d%y).csv
sed "s/$/`echo \\\r`/" /export/home/oracle/log/quarterly_login_$(date +%m%d%y).csv | \
uuencode quarterly_login_$(date +%m%d%y).csv | \
mailx -r $sender -s "quarterly distinct user login report for Designer" -c $cclist $mailinglist


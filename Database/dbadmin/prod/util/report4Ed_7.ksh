#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Ed_7.ksh$ 
#
# $Revision: 3$        $Date: 6/7/2011 10:05:17 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com,spepe@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set heading off
set feedback off
set lin 300
set pages 1000
spool /export/home/oracle/log/TPS_login_trial_count.csv


select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific"' from dual;
Select '"TPS -- Total User logins and Trials created"' from dual;
select '"Product","Month-Year","#of users logged in","Total# of logins","Number of Client divisions","Number of Trials created",' from dual;

SELECT  '"'||decode(x.app_type,'CROCAS','CRO Contractor','GMOWN','GM Analysis','PBTOWN','CRO Contractor Analysis',
'PICASE','Grants Manager 2.0','GM30','Grants Manager 3.0','TSN','GM Contracting',x.app_type)||'","'||To_Char(x.monyr,'Mon-YYYY')||'","'||x.num_usr||'","'||x.tot_login||'","'||x.tot_clients||'","'||y.num_trial||'"' 
from
(SELECT app_type, Trunc(modify_date,'MM') monyr,Count(DISTINCT ftuser_id) num_usr, Count(*) tot_login, Count(DISTINCT b.client_div_id) tot_clients
FROM audit_hist a, ftuser b, client_div c
WHERE a.ftuser_id=b.id AND b.client_div_id=c.id AND   a.action ='auditAction.login_succeeded' AND a.modify_date >= Trunc(SYSDATE-365,'YYYY')
   AND c.client_div_identifier NOT LIKE 'FT%'   AND c.client_div_identifier <> 'MDT' AND b.NAME NOT LIKE 'fasttrack%'  AND a.app_type <>'TSPD' and a.app_type <> 'DGW'
GROUP BY app_type, Trunc(modify_date,'MM')
ORDER BY 1,2) X,
(SELECT app_type, Trunc(modify_date,'MM') monyr , Count(*) num_trial
FROM audit_hist a, ftuser b, client_div c
WHERE a.ftuser_id=b.id AND b.client_div_id=c.id AND   a.action ='auditAction.trialNewlyCreated' AND a.modify_date >= Trunc(SYSDATE-365,'YYYY')
   AND c.client_div_identifier NOT LIKE 'FT%'   AND c.client_div_identifier <> 'MDT' AND b.NAME NOT LIKE 'fasttrack%'  AND a.app_type <>'TSPD' and a.app_type <> 'DGW'
GROUP BY app_type, Trunc(modify_date,'MM')
ORDER BY 1,2) Y
WHERE x.app_type=y.app_type(+) AND x.monyr=y.monyr(+);


spool off
exit;
EOF

mv /export/home/oracle/log/TPS_login_trial_count.csv /export/home/oracle/log/TPS_login_trial_count_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/TPS_login_trial_count_$(date +%m%d%y).csv | \
uuencode TPS_login_trial_count_$(date +%m%d%y).csv | \
mailx -r $sender -s "TPS - Login and Trial count" -c $cclist $mailinglist

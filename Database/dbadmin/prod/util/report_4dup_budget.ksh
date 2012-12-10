#!/bin/ksh
### Used for one time report generation only and not to be scheduled.
### Created on 04/13/09

cd /export/home/oracle
. /etc/profile
. ./.profile
mailinglist="mdanishefsky@mdsol.com,lshields@mdsol.com"
cclist="dmishra@mdsol.com"

sender="noreply@mdsol.com"

export ORACLE_SID=prod
export current_date=`date`
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column name format a33
column protocol_identifier format a60
alter session set nls_date_format='DD-MON-YYYY HH24:MI';
set markup html on 
spool /export/home/oracle/log/report_dup_budget.html

SELECT y.client_div_identifier "Client Divisions",x.protocol_identifier  
FROM trial x, client_div y
WHERE x.client_div_id=y.id 
AND x.id IN (
select a.trial_id
from trial_budget a, trial b, picase_trial c 
WHERE a.delete_flg=0    AND a.trial_id=b.id AND b.trial_status <> 'DELETED'
AND c.gm_version is null AND c.trial_id=b.id
group by a.country_id,a.trial_id, a.region_id, a.institution_id
having count(*)>1 );

spool off
set markup html off;
exit;
EOF

if [ `ls -ltr /export/home/oracle/log/report_dup_budget.html | awk '{print $5}'` -gt 0 ]
then
 cat /export/home/oracle/log/report_dup_budget.html | \
 uuencode duplicate_budget.html | mailx -s "Duplicate budgets list" -r $sender -c $cclist $mailinglist
else
 echo "No duplicate budgets found." | mailx -s "No duplicate budgets." -r $sender -c $cclist $mailinglist
fi


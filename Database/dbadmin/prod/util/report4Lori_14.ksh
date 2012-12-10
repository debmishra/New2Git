#!/bin/ksh

cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="TrialPlanningSupport@mdsol.com,spepe@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF

set heading off
set feedback off
set lin 300
set pages 3000
spool /export/home/oracle/log/GM_CompleteUserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"GM Report for complete user details"' from dual;
select '"Client Div","User Name","Creation Date","Last Login Date","#GM login","#last month login","#last month trial","#last 3months login","#last 3months trial","#last 6months login","#last 6months trial","#last 12months login","#last 12months trial","#IPT"' from dual;


select '"'||p.client_div_identifier||'","'||p.name||'","'||p.creation_date||'","'||vv.last_login_date||'","'||q.total_login||'","'||
 r.Last_month_login||'","'||v.last_month_trial||'","'||s.Last_3months_login||'","'||w.last_3months_trial||'","'||
t.Last_6months_login||'","'||x.last_6months_trial||'","'||u.Last_12months_login||'","'||y.last_12months_trial||'","'||z.total_ipt||'"' 
from
(SELECT distinct c.id, d.client_div_identifier,c.first_name||' '||c.last_name NAME,c.creation_date,
 c.last_login_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id  
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name in ('PICASE','GM30')
 AND EXISTS 
 (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) p,
(SELECT ftuser_id,count(*) total_login FROM audit_hist 
WHERE action='auditAction.login_succeeded' AND app_type in ('PICASE','GM30') GROUP BY ftuser_id) q,
(SELECT ftuser_id,Count(*) Last_month_login FROM audit_hist WHERE modify_date > add_months(sysdate,-1) AND
action='auditAction.login_succeeded' AND app_type in ('PICASE','GM30') GROUP BY ftuser_id) r,
(SELECT ftuser_id,Count(*) Last_3months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-3) AND
action='auditAction.login_succeeded' AND app_type in ('PICASE','GM30') GROUP BY ftuser_id) s,
(SELECT ftuser_id,Count(*) Last_6months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-6) AND
action='auditAction.login_succeeded' AND app_type in ('PICASE','GM30') GROUP BY ftuser_id) t,
(SELECT ftuser_id,Count(*) Last_12months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-12) AND
action='auditAction.login_succeeded' AND app_type in ('PICASE','GM30') GROUP BY ftuser_id) u, 
(select creator_ftuser_id ftuser_id, count(*) last_month_trial from picase_trial 
where create_date> add_months(sysdate,-1) group by creator_ftuser_id) v,
(select creator_ftuser_id ftuser_id, count(*) last_3months_trial from picase_trial 
where create_date> add_months(sysdate,-3) group by creator_ftuser_id) w,
(select creator_ftuser_id ftuser_id, count(*) last_6months_trial from picase_trial 
where create_date> add_months(sysdate,-6) group by creator_ftuser_id) x,
(select creator_ftuser_id ftuser_id, count(*) last_12months_trial from picase_trial 
where create_date> add_months(sysdate,-12) group by creator_ftuser_id) y,
(select creator_ftuser_id ftuser_id, count(*) total_ipt from ip_session group by creator_ftuser_id) z,
(SELECT ftuser_id,max(modify_date) last_login_date FROM audit_hist WHERE
action='auditAction.login_succeeded' AND app_type='PICASE' GROUP BY ftuser_id) vv
where p.id=q.ftuser_id(+) and p.id=r.ftuser_id(+) and p.id=s.ftuser_id(+) and p.id=t.ftuser_id(+) and p.id=u.ftuser_id(+) and
p.id=v.ftuser_id(+) and p.id=w.ftuser_id(+) and p.id=x.ftuser_id(+) and p.id=y.ftuser_id(+) and p.id=z.ftuser_id(+) 
and p.id=vv.ftuser_id(+)
ORDER BY 1;

spool off


spool /export/home/oracle/log/CROCAS_CompleteUserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"CROCAS Report for complete user details"' from dual;
select '"Client Div","User Name","Creation Date","Last Login Date","Total login","#last month login","#last month budgets","#last 3months login","#last 3months budgets","#last 6months login","#last 6months budgets","#last 12months login","#last 12months budgets"' from dual;


select '"'||p.client_div_identifier||'","'||p.name||'","'||p.creation_date||'","'||vv.last_login_date||'","'||q.total_login||'","'||r.last_month_login||'","'||
v.last_month_budgets||'","'||s.last_3months_login||'","'||w.last_3months_budgets||'","'||t.last_6months_login||'","'||
x.last_6months_budgets||'","'||u.last_12months_login||'","'||y.last_12months_budgets||'"' 
from
(SELECT c.id, d.client_div_identifier,c.first_name||' '||c.last_name NAME,c.CREATION_DATE,
 c.last_login_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE c.client_div_id=d.id AND  
 d.id=e.client_div_id and e.app_name='CROCAS' and e.license_exp_date > sysdate and c.active_crocas_user=1) p,
(SELECT ftuser_id,count(*) total_login FROM audit_hist 
WHERE action='auditAction.login_succeeded' AND app_type='CROCAS' GROUP BY ftuser_id) q,
(SELECT ftuser_id,Count(*) Last_month_login FROM audit_hist WHERE modify_date > add_months(sysdate,-1) AND
action='auditAction.login_succeeded' AND app_type='CROCAS' GROUP BY ftuser_id) r,
(SELECT ftuser_id,Count(*) Last_3months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-3) AND
action='auditAction.login_succeeded' AND app_type='CROCAS' GROUP BY ftuser_id) s,
(SELECT ftuser_id,Count(*) Last_6months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-6) AND
action='auditAction.login_succeeded' AND app_type='CROCAS' GROUP BY ftuser_id) t,
(SELECT ftuser_id,Count(*) Last_12months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-12) AND
action='auditAction.login_succeeded' AND app_type='CROCAS' GROUP BY ftuser_id) u,
(select creator_ftuser_id ftuser_id, count(*) last_month_budgets from CRO_BUDGET 
where create_date> add_months(sysdate,-1) group by creator_ftuser_id) v,
(select creator_ftuser_id ftuser_id, count(*) last_3months_budgets from CRO_BUDGET 
where create_date> add_months(sysdate,-3) group by creator_ftuser_id) w,
(select creator_ftuser_id ftuser_id, count(*) last_6months_budgets from CRO_BUDGET 
where create_date> add_months(sysdate,-6) group by creator_ftuser_id) x,
(select creator_ftuser_id ftuser_id, count(*) last_12months_budgets from CRO_BUDGET 
where create_date> add_months(sysdate,-12) group by creator_ftuser_id) y,
(SELECT ftuser_id,max(modify_date) last_login_date FROM audit_hist WHERE
action='auditAction.login_succeeded' AND app_type='CROCAS' GROUP BY ftuser_id) vv
where 
p.id=q.ftuser_id(+) and p.id=r.ftuser_id(+) and p.id=s.ftuser_id(+) and p.id=t.ftuser_id(+) and
p.id=u.ftuser_id(+) and p.id=v.ftuser_id(+) and p.id=w.ftuser_id(+) and p.id=x.ftuser_id(+) and 
p.id=y.ftuser_id(+) and p.id=vv.ftuser_id(+)
ORDER BY 1;

spool off


spool /export/home/oracle/log/GM-A_CompleteUserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"GM-Analysis Report for complete user details"' from dual;
select '"Client Div","User Name","Creation Date","Last Login Date","#GM-A login","#last month login","#last 3months login","#last 6months login","#last 12months login"' from dual;


select '"'||p.client_div_identifier||'","'||p.name||'","'||p.creation_date||'","'||v.last_login_date||'","'||q.total_login||'","'||
 r.Last_month_login||'","'||s.Last_3months_login||'","'||
t.Last_6months_login||'","'||u.Last_12months_login||'"' 
from
(SELECT c.id, d.client_div_identifier,c.first_name||' '||c.last_name NAME,c.creation_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id  
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='GMOWN'
 AND EXISTS 
 (SELECT 1 from ftuser_to_ftgroup g WHERE g.ftuser_id=c.id and g.ftgroup_id=34)
 AND EXISTS 
 (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) p,
(SELECT ftuser_id,count(*) total_login FROM audit_hist 
WHERE action='auditAction.login_succeeded' AND app_type='GMOWN' GROUP BY ftuser_id) q,
(SELECT ftuser_id,Count(*) Last_month_login FROM audit_hist WHERE modify_date > add_months(sysdate,-1) AND
action='auditAction.login_succeeded' AND app_type='GMOWN' GROUP BY ftuser_id) r,
(SELECT ftuser_id,Count(*) Last_3months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-3) AND
action='auditAction.login_succeeded' AND app_type='GMOWN' GROUP BY ftuser_id) s,
(SELECT ftuser_id,Count(*) Last_6months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-6) AND
action='auditAction.login_succeeded' AND app_type='GMOWN' GROUP BY ftuser_id) t,
(SELECT ftuser_id,Count(*) Last_12months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-12) AND
action='auditAction.login_succeeded' AND app_type='GMOWN' GROUP BY ftuser_id) u,
(SELECT ftuser_id,max(modify_date) last_login_date FROM audit_hist WHERE
action='auditAction.login_succeeded' AND app_type='GMOWN' GROUP BY ftuser_id) v
where p.id=q.ftuser_id(+) and p.id=r.ftuser_id(+) and p.id=s.ftuser_id(+) and p.id=t.ftuser_id(+) 
and p.id=u.ftuser_id(+) and p.id=v.ftuser_id(+) 
ORDER BY 1;

spool off

spool /export/home/oracle/log/CRO-A_CompleteUserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"CRO Contractor - Analysis Report for complete user details"' from dual;
select '"Client Div","User Name","Creation Date","Last Login Date","Total login","#last month login","#last 3months login","#last 6months login","#last 12months login"' from dual;

select '"'||p.client_div_identifier||'","'||p.name||'","'||p.creation_date||'","'||v.last_login_date||'","'||q.total_login||'","'||r.last_month_login||'","'||
s.last_3months_login||'","'||t.last_6months_login||'","'||u.last_12months_login||'"' 
from
(SELECT c.id, d.client_div_identifier,c.first_name||' '||c.last_name NAME,c.CREATION_DATE
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE c.client_div_id=d.id AND  
 d.id=e.client_div_id and e.app_name='CROCAS' and e.license_exp_date > sysdate and c.active_crocas_user=1
 AND EXISTS 
 (SELECT 1 from ftuser_to_ftgroup g WHERE g.ftuser_id=c.id and g.ftgroup_id=33)) p,
(SELECT ftuser_id,count(*) total_login FROM audit_hist 
WHERE action='auditAction.login_succeeded' AND app_type='PBTOWN' GROUP BY ftuser_id) q,
(SELECT ftuser_id,Count(*) Last_month_login FROM audit_hist WHERE modify_date > add_months(sysdate,-1) AND
action='auditAction.login_succeeded' AND app_type='PBTOWN' GROUP BY ftuser_id) r,
(SELECT ftuser_id,Count(*) Last_3months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-3) AND
action='auditAction.login_succeeded' AND app_type='PBTOWN' GROUP BY ftuser_id) s,
(SELECT ftuser_id,Count(*) Last_6months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-6) AND
action='auditAction.login_succeeded' AND app_type='PBTOWN' GROUP BY ftuser_id) t,
(SELECT ftuser_id,Count(*) Last_12months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-12) AND
action='auditAction.login_succeeded' AND app_type='PBTOWN' GROUP BY ftuser_id) u,
(SELECT ftuser_id,max(modify_date) last_login_date FROM audit_hist WHERE
action='auditAction.login_succeeded' AND app_type='PBTOWN' GROUP BY ftuser_id) v
where 
p.id=q.ftuser_id(+) and p.id=r.ftuser_id(+) and p.id=s.ftuser_id(+) and p.id=t.ftuser_id(+) and
p.id=u.ftuser_id(+) and p.id=v.ftuser_id(+)  
ORDER BY 1;

spool off

spool /export/home/oracle/log/GM-C_CompleteUserDetails.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"GM-Contracting Report for complete user details"' from dual;
select '"Client Div","User Name","Creation Date","Last Login Date","#GM-C login","#last month login","#last month trial","#last 3months login","#last 3months trial","#last 6months login","#last 6months trial","#last 12months login","#last 12months trial"' from dual;

select '"'||p.client_div_identifier||'","'||p.name||'","'||p.creation_date||'","'||v.last_login_date||'","'||q.total_login||'","'||
 r.Last_month_login||'","'||w.last_month_trial||'","'||s.Last_3months_login||'","'||x.last_3months_trial||'","'||
t.Last_6months_login||'","'||y.last_6months_trial||'","'||u.Last_12months_login||'","'||z.last_12months_trial||'"' 
from
(SELECT c.id, d.client_div_identifier,c.first_name||' '||c.last_name NAME,c.creation_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id  
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='TSN'
 AND EXISTS 
 (SELECT 1 from ftuser_to_ftgroup g WHERE g.ftuser_id=c.id and g.ftgroup_id in (30,31,32))
 AND EXISTS 
 (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) p,
(SELECT ftuser_id,count(*) total_login FROM audit_hist 
WHERE action='auditAction.login_succeeded' AND app_type='TSN' GROUP BY ftuser_id) q,
(SELECT ftuser_id,Count(*) Last_month_login FROM audit_hist WHERE modify_date > add_months(sysdate,-1) AND
action='auditAction.login_succeeded' AND app_type='TSN' GROUP BY ftuser_id) r,
(SELECT ftuser_id,Count(*) Last_3months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-3) AND
action='auditAction.login_succeeded' AND app_type='TSN' GROUP BY ftuser_id) s,
(SELECT ftuser_id,Count(*) Last_6months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-6) AND
action='auditAction.login_succeeded' AND app_type='TSN' GROUP BY ftuser_id) t,
(SELECT ftuser_id,Count(*) Last_12months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-12) AND
action='auditAction.login_succeeded' AND app_type='TSN' GROUP BY ftuser_id) u,
(SELECT ftuser_id,max(modify_date) last_login_date FROM audit_hist WHERE
action='auditAction.login_succeeded' AND app_type='TSN' GROUP BY ftuser_id) v,
(select creator_ftuser_id ftuser_id, count(*) last_month_trial from tsn_trial 
where create_date> add_months(sysdate,-1) group by creator_ftuser_id) w,
(select creator_ftuser_id ftuser_id, count(*) last_3months_trial from tsn_trial 
where create_date> add_months(sysdate,-3) group by creator_ftuser_id) x,
(select creator_ftuser_id ftuser_id, count(*) last_6months_trial from tsn_trial 
where create_date> add_months(sysdate,-6) group by creator_ftuser_id) y,
(select creator_ftuser_id ftuser_id, count(*) last_12months_trial from tsn_trial 
where create_date> add_months(sysdate,-12) group by creator_ftuser_id) z
where p.id=q.ftuser_id(+) and p.id=r.ftuser_id(+) and p.id=s.ftuser_id(+) and p.id=t.ftuser_id(+) 
and p.id=u.ftuser_id(+) and p.id=v.ftuser_id(+) and p.id=w.ftuser_id(+) and p.id=x.ftuser_id(+) 
and p.id=y.ftuser_id(+) and p.id=z.ftuser_id(+) 
ORDER BY 1;

spool off


exit;
EOF

mv /export/home/oracle/log/GM_CompleteUserDetails.csv /export/home/oracle/log/GM_CompleteUserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_CompleteUserDetails_$(date +%m%d%y).csv | \
uuencode GM_CompleteUserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM CompleteUserDetails" -c $cclist $mailinglist


mv /export/home/oracle/log/CROCAS_CompleteUserDetails.csv /export/home/oracle/log/CROCAS_CompleteUserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/CROCAS_CompleteUserDetails_$(date +%m%d%y).csv | \
uuencode CROCAS_CompleteUserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "CROCAS CompleteUserDetails" -c $cclist $mailinglist

mv /export/home/oracle/log/GM-A_CompleteUserDetails.csv /export/home/oracle/log/GM-A_CompleteUserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM-A_CompleteUserDetails_$(date +%m%d%y).csv | \
uuencode GM-A_CompleteUserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM-Analysis CompleteUserDetails" -c $cclist $mailinglist


mv /export/home/oracle/log/CRO-A_CompleteUserDetails.csv /export/home/oracle/log/CRO-A_CompleteUserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/CRO-A_CompleteUserDetails_$(date +%m%d%y).csv | \
uuencode CRO-A_CompleteUserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "CRO Contractor - Analysis CompleteUserDetails" -c $cclist $mailinglist

mv /export/home/oracle/log/GM-C_CompleteUserDetails.csv /export/home/oracle/log/GM-C_CompleteUserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM-C_CompleteUserDetails_$(date +%m%d%y).csv | \
uuencode GM-C_CompleteUserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM Contracting CompleteUserDetails" -c $cclist $mailinglist



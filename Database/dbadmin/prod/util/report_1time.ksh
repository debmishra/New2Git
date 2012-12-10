#!/bin/ksh

cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="dmishra@fast-track.com"
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
Select '"TGM Report for complete user details"' from dual;
select '"Client Div","User Name","Creation Date","Last Login Date","#GM login","#last month login","#last month trial","#last 3months login","#last 3months trial","#last 6months login","#last 6months trial","#last 12months login","#last 12months trial","#IPT"' from dual;


select '"'||p.client_div_identifier||'","'||p.name||'","'||p.creation_date||'","'||p.last_login_date||'","'||q.total_login||'","'||
 r.Last_month_login||'","'||v.last_month_trial||'","'||s.Last_3months_login||'","'||w.last_3months_trial||'","'||
t.Last_6months_login||'","'||x.last_6months_trial||'","'||u.Last_12months_login||'","'||y.last_12months_trial||'","'||z.total_ipt||'"' 
from
(SELECT c.id, d.client_div_identifier,c.first_name||' '||c.last_name NAME,c.creation_date,
 c.last_login_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id  
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='PICASE'
 AND d.client_div_identifier like 'TAK%'
 AND EXISTS 
 (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) p,
(SELECT ftuser_id,count(*) total_login FROM audit_hist 
WHERE action='auditAction.login_succeeded' AND app_type='PICASE' GROUP BY ftuser_id) q,
(SELECT ftuser_id,Count(*) Last_month_login FROM audit_hist WHERE modify_date > add_months(sysdate,-1) AND
action='auditAction.login_succeeded' AND app_type='PICASE' GROUP BY ftuser_id) r,
(SELECT ftuser_id,Count(*) Last_3months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-3) AND
action='auditAction.login_succeeded' AND app_type='PICASE' GROUP BY ftuser_id) s,
(SELECT ftuser_id,Count(*) Last_6months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-6) AND
action='auditAction.login_succeeded' AND app_type='PICASE' GROUP BY ftuser_id) t,
(SELECT ftuser_id,Count(*) Last_12months_login FROM audit_hist WHERE modify_date > add_months(sysdate,-12) AND
action='auditAction.login_succeeded' AND app_type='PICASE' GROUP BY ftuser_id) u, 
(select creator_ftuser_id ftuser_id, count(*) last_month_trial from picase_trial 
where create_date> add_months(sysdate,-1) group by creator_ftuser_id) v,
(select creator_ftuser_id ftuser_id, count(*) last_3months_trial from picase_trial 
where create_date> add_months(sysdate,-3) group by creator_ftuser_id) w,
(select creator_ftuser_id ftuser_id, count(*) last_6months_trial from picase_trial 
where create_date> add_months(sysdate,-6) group by creator_ftuser_id) x,
(select creator_ftuser_id ftuser_id, count(*) last_12months_trial from picase_trial 
where create_date> add_months(sysdate,-12) group by creator_ftuser_id) y,
(select creator_ftuser_id ftuser_id, count(*) total_ipt from ip_session group by creator_ftuser_id) z
where p.id=q.ftuser_id(+) and p.id=r.ftuser_id(+) and p.id=s.ftuser_id(+) and p.id=t.ftuser_id(+) and p.id=u.ftuser_id(+) and
p.id=v.ftuser_id(+) and p.id=w.ftuser_id(+) and p.id=x.ftuser_id(+) and p.id=y.ftuser_id(+) and p.id=z.ftuser_id(+) 
ORDER BY 1;

spool off

exit;
EOF

mv /export/home/oracle/log/GM_CompleteUserDetails.csv /export/home/oracle/log/GM_CompleteUserDetails_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_CompleteUserDetails_$(date +%m%d%y).csv | \
uuencode GM_CompleteUserDetails_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM CompleteUserDetails" -c $cclist $mailinglist


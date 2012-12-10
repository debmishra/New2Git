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
set lin 350
set pages 3000
spool /export/home/oracle/log/GM_Company_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"GM report for company usage"' from dual;
select '"Client Div","Name","Total GM20 Users","GM20 Expiration","Total GM30 Users","GM30 Expiration","#last month distinct user login","#last month trial","#last 3months distinct user login","#last 3months trial","#last 6months distinct user login","#last 6months trial","#last 12months distinct user login","#last 12months trial"' from dual;

select '"'||p.client_div_identifier||'","'||p.name||'","'||p.tot_gm20_users||'","'||p.gm20_license_exp_date||'","'||
p.tot_gm30_users||'","'||p.gm30_license_exp_date||'","'||
q.Last_month_login||'","'||u.last_month_trial||'","'||r.Last_3months_login||'","'||v.last_3months_trial||'","'||
s.Last_6months_login||'","'||w.last_6months_trial||'","'||t.Last_12months_login||'","'||x.last_12months_trial||'"'
from
(SELECT k.id, k.client_div_identifier,k.NAME, l.tot_gm20_users,l.gm20_license_exp_date,l.tot_gm30_users, l.gm30_license_exp_date FROM
(SELECT d.id, d.client_div_identifier,d.NAME FROM client_div d 
WHERE EXISTS (SELECT 1 FROM client_div_to_lic_app e
where d.id=e.client_div_id AND e.app_name IN ('PICASE','GM30') AND e.license_exp_date > SYSDATE)) k,
(SELECT Decode(m.id,NULL,n.id,m.id) id, m.tot_gm20_users, m. gm20_license_exp_date, n.tot_gm30_users, n.gm30_license_exp_date from
(SELECT d.id, count(*) tot_gm20_users, e.license_exp_date gm20_license_exp_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE
 c.client_div_id=d.id and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='PICASE'
 AND EXISTS
 (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)
 GROUP BY d.id, d.client_div_identifier,d.name,e.license_exp_date ) m 
 full outer join 
 (SELECT d.id, count(*) tot_gm30_users, e.license_exp_date gm30_license_exp_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE
 c.client_div_id=d.id and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='GM30'
 AND c.active_tsm_user = 1 AND c.imed_name IS NOT NULL AND c.imed_key IS NOT NULL 
 AND EXISTS
 (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)
 GROUP BY d.id, d.client_div_identifier,d.name,e.license_exp_date) n
 ON m.id=n.id) l
 WHERE k.id=l.id(+)) p,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_month_login FROM audit_hist a, ftuser b
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-1) AND
 a.action='auditAction.login_succeeded' AND a.app_type in ('PICASE','GM30') GROUP BY b.client_div_id) q,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_3months_login FROM audit_hist a, ftuser b
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-3) AND
 a.action='auditAction.login_succeeded' AND a.app_type in ('PICASE','GM30') GROUP BY b.client_div_id) r,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_6months_login FROM audit_hist a, ftuser b
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-6) AND
 a.action='auditAction.login_succeeded' AND a.app_type in ('PICASE','GM30') GROUP BY b.client_div_id) s,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_12months_login FROM audit_hist a, ftuser b
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-12) AND
 a.action='auditAction.login_succeeded' AND a.app_type in ('PICASE','GM30') GROUP BY b.client_div_id) t,
(select b.client_div_id id, count(*) last_month_trial from picase_trial a, ftuser b
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-1) group by b.client_div_id) u,
(select b.client_div_id id, count(*) last_3months_trial from picase_trial a, ftuser b
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-3) group by b.client_div_id) v,
(select b.client_div_id id, count(*) last_6months_trial from picase_trial a, ftuser b
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-6) group by b.client_div_id) w,
(select b.client_div_id id, count(*) last_12months_trial from picase_trial a, ftuser b
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-12) group by b.client_div_id) x
where p.id=q.id(+) and p.id=r.id(+) and p.id=s.id(+) and p.id=t.id(+) and p.id=u.id(+) and
p.id=v.id(+) and p.id=w.id(+) and p.id=x.id(+)
ORDER BY 1;

spool off

spool /export/home/oracle/log/CROCAS_Company_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"CROCAS report for company usage"' from dual;
select '"Client Div","Name","Total Users","Expiration","#last month distinct user login","#last month trial","#last 3months distinct user login","#last 3months trial","#last 6months distinct user login","#last 6months trial","#last 12months distinct user login","#last 12months trial"' from dual;


select '"'||p.client_div_identifier||'","'||p.name||'","'||p.tot_users||'","'||p.license_exp_date||'","'||q.last_month_login||'","'||
u.last_month_budgets||'","'||r.last_3months_login||'","'||v.last_3months_budgets||'","'||s.last_6months_login||'","'||
w.last_6months_budgets||'","'||t.last_12months_login||'","'||x.last_12months_budgets||'"' 
from
(SELECT d.id, d.client_div_identifier,d.name, count(*) tot_users, e.license_exp_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE  
 c.client_div_id=d.id and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='CROCAS'
 and c.active_crocas_user=1
 GROUP BY d.id, d.client_div_identifier,d.name,e.license_exp_date) p,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_month_login FROM audit_hist a, ftuser b  
 WHERE a.ftuser_id=b.id and a.modify_date > add_months(sysdate,-1) AND
 a.action='auditAction.login_succeeded' AND a.app_type='CROCAS' GROUP BY b.client_div_id) q,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_3months_login FROM audit_hist a, ftuser b  
 WHERE a.ftuser_id=b.id and a.modify_date > add_months(sysdate,-3) AND
 a.action='auditAction.login_succeeded' AND a.app_type='CROCAS' GROUP BY b.client_div_id) r,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_6months_login FROM audit_hist a, ftuser b  
 WHERE a.ftuser_id=b.id and a.modify_date > add_months(sysdate,-6) AND
 a.action='auditAction.login_succeeded' AND a.app_type='CROCAS' GROUP BY b.client_div_id) s,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_12months_login FROM audit_hist a, ftuser b  
 WHERE a.ftuser_id=b.id and a.modify_date > add_months(sysdate,-12) AND
 a.action='auditAction.login_succeeded' AND a.app_type='CROCAS' GROUP BY b.client_div_id) t,
(select b.client_div_id id, count(*) last_month_budgets from CRO_BUDGET a, ftuser b 
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-1) group by b.client_div_id) u,
(select b.client_div_id id, count(*) last_3months_budgets from CRO_BUDGET a, ftuser b 
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-3) group by b.client_div_id) v,
(select b.client_div_id id, count(*) last_6months_budgets from CRO_BUDGET a, ftuser b 
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-6) group by b.client_div_id) w,
(select b.client_div_id id, count(*) last_12months_budgets from CRO_BUDGET a, ftuser b 
where a.creator_ftuser_id=b.id and a.create_date> add_months(sysdate,-12) group by b.client_div_id) x
where 
p.id=q.id(+) and p.id=r.id(+) and p.id=s.id(+) and p.id=t.id(+) and
p.id=u.id(+) and p.id=v.id(+) and p.id=w.id(+) and p.id=x.id(+) 
ORDER BY 1;


spool off

spool /export/home/oracle/log/GM_Analysis_Company_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"GM-Analysis report for company usage"' from dual;
select '"Client Div","Name","Total Users","Expiration","#last month distinct user login","#last 3months distinct user login","#last 6months distinct user login","#last 12months distinct user login"' from dual;

select '"'||p.client_div_identifier||'","'||p.name||'","'||p.tot_users||'","'||p.license_exp_date||'","'||
 q.Last_month_login||'","'||r.Last_3months_login||'","'||
s.Last_6months_login||'","'||t.Last_12months_login||'"' 
from
(SELECT d.id, d.client_div_identifier,d.name, count(*) tot_users, e.license_exp_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE  
 c.client_div_id=d.id and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='GMOWN'
 AND EXISTS 
 (SELECT 1 from ftuser_to_ftgroup f WHERE f.ftuser_id=c.id AND f.ftgroup_id=34 AND c.name NOT LIKE 'fasttrack%')
 GROUP BY d.id, d.client_div_identifier,d.name,e.license_exp_date) p,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_month_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-1) AND
 a.action='auditAction.login_succeeded' AND a.app_type='GMOWN' GROUP BY b.client_div_id) q,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_3months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-3) AND
 a.action='auditAction.login_succeeded' AND a.app_type='GMOWN' GROUP BY b.client_div_id) r,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_6months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-6) AND
 a.action='auditAction.login_succeeded' AND a.app_type='GMOWN' GROUP BY b.client_div_id) s,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_12months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-12) AND
 a.action='auditAction.login_succeeded' AND a.app_type='GMOWN' GROUP BY b.client_div_id) t 
where p.id=q.id(+) and p.id=r.id(+) and p.id=s.id(+) and p.id=t.id(+)  
ORDER BY 1;

spool off

spool /export/home/oracle/log/CRO_Contractor_Analysis_Company_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"CRO Contractor - Analysis report for company usage"' from dual;
select '"Client Div","Name","Total Users","Expiration","#last month distinct user login","#last 3months distinct user login","#last 6months distinct user login","#last 12months distinct user login"' from dual;

select '"'||p.client_div_identifier||'","'||p.name||'","'||p.tot_users||'","'||p.license_exp_date||'","'||
 q.Last_month_login||'","'||r.Last_3months_login||'","'||
s.Last_6months_login||'","'||t.Last_12months_login||'"' 
from
(SELECT d.id, d.client_div_identifier,d.name, count(*) tot_users, e.license_exp_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE  
 c.client_div_id=d.id and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='CROCAS'
 and c.active_crocas_user=1
 AND EXISTS 
 (SELECT 1 from ftuser_to_ftgroup f WHERE f.ftuser_id=c.id AND f.ftgroup_id=33 AND c.name NOT LIKE 'fasttrack%')
 GROUP BY d.id, d.client_div_identifier,d.name,e.license_exp_date) p,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_month_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-1) AND
 a.action='auditAction.login_succeeded' AND a.app_type='PBTOWN' GROUP BY b.client_div_id) q,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_3months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-3) AND
 a.action='auditAction.login_succeeded' AND a.app_type='PBTOWN' GROUP BY b.client_div_id) r,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_6months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-6) AND
 a.action='auditAction.login_succeeded' AND a.app_type='PBTOWN' GROUP BY b.client_div_id) s,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_12months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-12) AND
 a.action='auditAction.login_succeeded' AND a.app_type='PBTOWN' GROUP BY b.client_div_id) t 
where p.id=q.id(+) and p.id=r.id(+) and p.id=s.id(+) and p.id=t.id(+)  
ORDER BY 1;


spool off
/*
spool /export/home/oracle/log/GM_contracting_Company_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"GM-Contracting report for company usage"' from dual;
select '"Client Div","Name","Total Users","Expiration","#last month distinct user login","#last 3months distinct user login","#last 6months distinct user login","#last 12months distinct user login"' from dual;

select '"'||p.client_div_identifier||'","'||p.name||'","'||p.tot_users||'","'||p.license_exp_date||'","'||
 q.Last_month_login||'","'||r.Last_3months_login||'","'||
s.Last_6months_login||'","'||t.Last_12months_login||'"' 
from
(SELECT d.id, d.client_div_identifier,d.name, count(*) tot_users, e.license_exp_date
 FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE  
 c.client_div_id=d.id and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='TSN'
 AND EXISTS 
(SELECT 1 from ftuser_to_ftgroup f WHERE f.ftuser_id=c.id AND f.ftgroup_id BETWEEN 30 AND 32 AND c.name NOT LIKE 'fasttrack%')
 GROUP BY d.id, d.client_div_identifier,d.name,e.license_exp_date) p,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_month_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-1) AND
 a.action='auditAction.login_succeeded' AND a.app_type='TSN' GROUP BY b.client_div_id) q,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_3months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-3) AND
 a.action='auditAction.login_succeeded' AND a.app_type='TSN' GROUP BY b.client_div_id) r,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_6months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-6) AND
 a.action='auditAction.login_succeeded' AND a.app_type='TSN' GROUP BY b.client_div_id) s,
(SELECT b.client_div_id id,count(distinct a.ftuser_id) Last_12months_login FROM audit_hist a, ftuser b 
 WHERE a.ftuser_id=b.id and modify_date > add_months(sysdate,-12) AND
 a.action='auditAction.login_succeeded' AND a.app_type='TSN' GROUP BY b.client_div_id) t 
where p.id=q.id(+) and p.id=r.id(+) and p.id=s.id(+) and p.id=t.id(+)  
ORDER BY 1;


spool off
*/
exit;
EOF



mv /export/home/oracle/log/GM_Company_Usage.csv /export/home/oracle/log/GM_Company_Usage_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_Company_Usage_$(date +%m%d%y).csv | \
uuencode GM_Company_Usage_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM Company Usage" -c $cclist $mailinglist

mv /export/home/oracle/log/CROCAS_Company_Usage.csv /export/home/oracle/log/CROCAS_Company_Usage_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/CROCAS_Company_Usage_$(date +%m%d%y).csv | \
uuencode CROCAS_Company_Usage_$(date +%m%d%y).csv | \
mailx -r $sender -s "CROCAS Company Usage" -c $cclist $mailinglist

mv /export/home/oracle/log/GM_Analysis_Company_Usage.csv /export/home/oracle/log/GM_Analysis_Company_Usage_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_Analysis_Company_Usage_$(date +%m%d%y).csv | \
uuencode GM_Analysis_Company_Usage_$(date +%m%d%y).csv | \
mailx -r $sender -s "GM-Analysis Company Usage" -c $cclist $mailinglist

mv /export/home/oracle/log/CRO_Contractor_Analysis_Company_Usage.csv /export/home/oracle/log/CRO_Contractor_Analysis_Company_Usage_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/CRO_Contractor_Analysis_Company_Usage_$(date +%m%d%y).csv | \
uuencode CRO_Contractor_Analysis_Company_Usage_$(date +%m%d%y).csv | \
mailx -r $sender -s "CRO Contractor-Analysis Company Usage" -c $cclist $mailinglist

#mv /export/home/oracle/log/GM_contracting_Company_Usage.csv /export/home/oracle/log/GM_contracting_Company_Usage_$(date +%m%d%y).csv

#sed "s/$/`echo \\\r`/" /export/home/oracle/log/GM_contracting_Company_Usage_$(date +%m%d%y).csv | \
#uuencode GM_contracting_Company_Usage_$(date +%m%d%y).csv | \
#mailx -r $sender -s "GM Contracting Company Usage" -c $cclist $mailinglist

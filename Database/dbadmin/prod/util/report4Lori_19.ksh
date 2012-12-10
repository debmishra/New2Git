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
spool /export/home/oracle/log/Active_users.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"Active Users List"' from dual;
Select ' ' from dual;
select '"Note: If a user is removed from a iMedidata study group after using GM3.0, it will still appear as active GM3.0 user in this report."' from dual;
select '"Client Div","Login ID","User Name","GM2.0 User?","GM3.0 User?","CRO Contractor User?","GM-A User?","CRO-C-A User?","GM-C User?"' from dual;
select '"'||client_div_identifier||'","'||userid||'","'||name||'","'||GM2User||'","'||GM3User||'","'||CCUser||
'","'||GMAUser||'","'||CCAUser||'","'||GMCUser||'"' from
(select u.client_div_identifier,u.userid,u.name,decode(v.id,null,'No','Yes') GM2User,decode(v1.id,null,'No','Yes') GM3User,
decode(w.id,null,'No','Yes') CCUser,decode(x.id,null,'No','Yes') GMAUser,
decode(y.id,null,'No','Yes') CCAUser,decode(z.id,null,'No','Yes') GMCUser
from 
(SELECT c.id, c.NAME userid, d.client_div_identifier,c.first_name||' '||c.last_name name
 FROM  ftuser c, client_div d  WHERE c.client_div_id=d.id
 AND (EXISTS  (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id) or c.active_crocas_user=1)
 AND EXISTS (SELECT 1 FROM client_div_to_lic_app e WHERE e.client_div_id=d.id AND e.license_exp_date > SYSDATE )) u,
(SELECT c.id FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='PICASE'
 AND EXISTS  (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) v,
(SELECT c.id FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='GM30' and 
 c.active_tsm_user=1 and c.imed_name is not null and c.imed_key is not null
 AND EXISTS  (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) v1,
(SELECT c.id FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE c.client_div_id=d.id AND
 d.id=e.client_div_id and e.app_name='CROCAS' and e.license_exp_date > sysdate and c.active_crocas_user=1) w,
(SELECT c.id FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='GMOWN'
 AND EXISTS  (SELECT 1 from ftuser_to_ftgroup g WHERE g.ftuser_id=c.id and g.ftgroup_id=34)
 AND EXISTS  (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) x,
(SELECT c.id FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE c.client_div_id=d.id AND
 d.id=e.client_div_id and e.app_name='CROCAS' and e.license_exp_date > sysdate and c.active_crocas_user=1
 AND EXISTS  (SELECT 1 from ftuser_to_ftgroup g WHERE g.ftuser_id=c.id and g.ftgroup_id=33)) y,
(SELECT c.id FROM  ftuser c, client_div d, client_div_to_lic_app e WHERE   c.client_div_id=d.id
 and e.client_div_id=d.id and e.license_exp_date > sysdate and e.app_name='TSN'
 AND EXISTS  (SELECT 1 from ftuser_to_ftgroup g WHERE g.ftuser_id=c.id and g.ftgroup_id in (30,31,32))
 AND EXISTS (SELECT 1 from ftuser_to_client_group f WHERE f.ftuser_id=c.id)) z
where u.id=v.id(+) and u.id=w.id(+) and u.id=x.id(+) and u.id=y.id(+) and u.id=z.id(+) and u.id=v1.id(+)
ORDER BY 1,2)
where GM2User='Yes' or CCUser='Yes' or GMAUser='yes' or CCAUser='Yes' or GMCUser='Yes' or GM3User='Yes';

spool off

exit;
EOF

mv /export/home/oracle/log/Active_users.csv /export/home/oracle/log/Active_users_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Active_users_$(date +%m%d%y).csv | \
uuencode Active_users_$(date +%m%d%y).csv | \
mailx -r $sender -s "Active Users" -c $cclist $mailinglist

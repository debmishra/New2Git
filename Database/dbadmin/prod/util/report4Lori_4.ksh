sqlplus -s tsm10t/`get_pwd tsm10t` <<EOF

set feedback off
set lin 300
set pages 1000
column name format a40
column id format a5
column user_name format a22
column last_login_date format a25
break on id
spool /export/home/oracle/log/Report4Lori_tsdbeta.txt



set heading off
select 'Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' PDT' from dual;
select '==========================================================' from dual;
Select 'Summary Report of Total Users and Trials created last week' from dual;
select '==========================================================' from dual;
set heading on

select x.name,x.id,x.num_users "#users",nvl(y.num_trial_last_week,0) "LastWeekTrials" from
(select b.name, b.client_div_identifier id, count(*) num_users from
ftuser a, client_div b  where a.client_div_id = b.id and
a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 17 and 23)
GROUP BY b.name, b.client_div_identifier ) x ,
(select f.client_div_identifier id, count(*) num_trial_last_week
from tspd_trial d,trial e,client_div f where
d.trial_id=e.id and e.client_div_id = f.id and
d.create_date between sysdate-7 and sysdate
group by f.client_div_identifier) y
where x.id = y.id(+)
order by x.id;

column user_name format a30
column last_login_date format a25
break on id

set heading off
select '===============================================' from dual;
Select 'Detail Report of Users in each Client Division' from dual;
select '===============================================' from dual;
set heading on

SELECT b.client_div_identifier id,a.First_name||' '||a.Last_name user_name,c.num_login "#LOGIN",
to_char(a.last_login_date,'mm/dd/yy hh24:mi') last_login_date
FROM ftuser a,client_div b,
(select ftuser_id, count(*) num_login from ftuser_login_history 
WHERE LAST_LOGIN_CHANGE_DATE > To_Date('12-10-2003','mm-dd-yyyy') group by ftuser_id) c
WHERE a.client_div_id = b.id and a.id=c.ftuser_id(+) 
AND  a.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 17 and 23)
ORDER BY b.client_div_identifier;

set heading off
select '=====================================================================' from dual;
Select 'Detail Report of # of Trials created by users in each Client Division' from dual;
select '=====================================================================' from dual;
set heading on

select c.client_div_identifier id,
b.first_name||' '||b.last_name user_name,
count(*) "#trial"
from tspd_trial a, ftuser b, client_div c where
b.id in (select ftuser_id from ftuser_to_ftgroup where ftgroup_id between 17 and 23) and
a.creator_ftuser_id = b.id and b.client_div_id=c.id
group by c.client_div_identifier, b.first_name||' '||b.last_name;

spool off
exit;
EOF

cat /export/home/oracle/log/Report4Lori_tsdbeta.txt | mailx -r dmishra@mdsol.com -s "TSD Beta Usage report" dmishra@mdsol.com


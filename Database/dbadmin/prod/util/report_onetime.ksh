### Used for one time report generation only and not to be scheduled.
### Created on 04/13/09

cd /export/home/oracle
. /etc/profile
. ./.profile

export ORACLE_SID=prod
export current_date=`date`
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

set feedback off
set lin 300
set pages 1000
column name format a33
column display_name format a40
alter session set nls_date_format='DD-MON-YYYY HH24:MI';
set markup html on 
spool /export/home/oracle/log/report_onetime.html

SELECT c.client_div_identifier "Client Div", c.display_name "Name",  c.name "LoginId", 
       MAX(DECODE(c.ftgroup_id,11,'Yes','No')) "GM Client Admin",
       MAX(DECODE(c.ftgroup_id,24,'Yes','No')) "GM Data Admin"
FROM (SELECT a.ftuser_id, a.ftgroup_id, b.display_name, b.name, d.client_div_identifier
      FROM ftuser_to_ftgroup a, ftuser b, client_div d, 
           client_div_to_lic_app e
      WHERE a.ftgroup_id IN (11,24)
      AND a.ftuser_id=b.id
      AND b.name NOT LIKE 'fasttrack%'
      AND b.client_div_id=d.id
      AND e.client_div_id= d.id
      AND e.license_exp_date>sysdate
      AND e.app_name='PICASE'
      AND exists (SELECT 1 from ftuser_to_client_group f
                  WHERE f.ftuser_id=b.id)
     ) c
GROUP BY c.client_div_identifier, c.name,  c.display_name
order by c.client_div_identifier,c.display_name;

spool off
set markup html off;
exit;
EOF

cat /export/home/oracle/log/report_onetime.html | \
uuencode system_admin_gm.html | mailx -s "Sys Admin Users-gm" dmishra@mdsol.com

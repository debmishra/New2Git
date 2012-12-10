#!/bin/ksh
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="jhartman@mdsol.com chotter@mdsol.com tbrophy@mdsol.com mdanishefsky@mdsol.com spepe@mdsol.com lshields@mdsol.com jdolfi@mdsol.com dmishra@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
#cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF


drop table cpt_code_usage_josh;
drop table picas_code_usage_josh;

create table cpt_code_usage_josh(code varchar2(80),obsolete varchar2(3),hide varchar2(3), cnt number(10),last_used_date date,
last_used_by varchar2(10), total_clients number(5), active_clients number(5), client_list varchar2(2000));
create table picas_code_usage_josh(code varchar2(80),obsolete varchar2(3),hide varchar2(3), cnt number(10), last_used_date date,
last_used_by varchar2(10), total_clients number(5), active_clients number(5),client_list varchar2(2000));

declare

cursor c1 is select distinct procedure_def_id from cost_item a, trial_budget b, trial c, client_div d
             where a.procedure_def_id is not null
             and a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id and
             d.client_div_identifier not like 'FTS%';

tot_num number(10);
proc_name varchar2(80);
client_list varchar2(2000);
last_used_date date;
last_used_by  varchar2(10);
obs_flg varchar2(3);
hide_flg varchar2(3);
total_clients number(5);
active_clients number(5);

begin

  for ix1 in c1 loop

    select count(*) into tot_num from cost_item where procedure_def_id=ix1.procedure_def_id
    and trial_budget_id not in (select a.id from trial_budget a, trial b, client_div c where
    a.trial_id=b.id and b.client_div_id=c.id and c.client_div_identifier like 'FTS%') ;

    SELECt cpt_code into proc_name from procedure_def where id=ix1.procedure_def_id;
    SELECt decode(obsolete_flg,1,'Yes',0,'No') into obs_flg from procedure_def where id=ix1.procedure_def_id;
    SELECt decode(hide,1,'Yes',0,'No') into hide_flg from procedure_def where id=ix1.procedure_def_id;

    select max(x.create_date) into last_used_date from trial_budget x, cost_item y where
    x.id=y.trial_budget_id and y.procedure_def_id=ix1.procedure_def_id and x.id not in
    (select a.id from trial_budget a, trial b, client_div c where
    a.trial_id=b.id and b.client_div_id=c.id and c.client_div_identifier like 'FTS%');

    select distinct s.client_div_identifier into last_used_by from cost_item p, trial_budget q,
    trial r, client_div s where p.trial_budget_id=q.id and q.trial_id=r.id
    and r.client_div_id=s.id and q.create_date=last_used_date and
    p.procedure_def_id=ix1.procedure_def_id and s.client_div_identifier not like 'FTS%';

    select count(distinct d.id) into total_clients 
    from cost_item a, trial_budget b, trial c,client_div d
    where a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id
    and a.procedure_def_id=ix1.procedure_def_id and d.client_div_identifier not like 'FTS%' ;

    select count(distinct d.id) into active_clients 
    from cost_item a, trial_budget b, trial c,client_div d, client_div_to_lic_app e
    where a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id and d.id=e.client_div_id 
    and e.app_name in ('PICASE','GM30') and e.LICENSE_EXP_DATE > sysdate
    and a.procedure_def_id=ix1.procedure_def_id and d.client_div_identifier not like 'FTS%' ;

   declare

            cursor c2 is select distinct d.client_div_identifier client_div_identifier
            from cost_item a, trial_budget b, trial c,client_div d
            where a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id
            and a.procedure_def_id=ix1.procedure_def_id and d.client_div_identifier not like 'FTS%' ;
   begin
    client_list:=null;
    for ix2 in c2 loop
      client_list:=client_list||','||ix2.client_div_identifier;
    end loop;
   end;

    Insert into cpt_code_usage_josh values (proc_name,obs_flg,hide_flg,tot_num,last_used_date,last_used_by,total_clients,active_clients,substr(client_list,2));
  end loop;
commit;

end;
/



declare

cursor c1 is select distinct odc_def_id from cost_item a, trial_budget b, trial c, client_div d
             where a.odc_def_id is not null
             and a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id and
             d.client_div_identifier not like 'FTS%';

tot_num number(10);
proc_name varchar2(80);
client_list varchar2(2000);
last_used_date date;
last_used_by  varchar2(10);
obs_flg varchar2(3);
hide_flg varchar2(3);
total_clients number(5);
active_clients number(5);

begin

  for ix1 in c1 loop

    select count(*) into tot_num from cost_item where odc_def_id=ix1.odc_def_id
    and trial_budget_id not in (select a.id from trial_budget a, trial b, client_div c where
    a.trial_id=b.id and b.client_div_id=c.id and c.client_div_identifier like 'FTS%');

    SELECt picas_code into proc_name from odc_def where id=ix1.odc_def_id;
    SELECt decode(obsolete_flg,1,'Yes',0,'No') into obs_flg from odc_def where id=ix1.odc_def_id;
    SELECt decode(hide,1,'Yes',0,'No') into hide_flg from odc_def where id=ix1.odc_def_id;

    select max(x.create_date) into last_used_date from trial_budget x, cost_item y where
    x.id=y.trial_budget_id and y.odc_def_id=ix1.odc_def_id and x.id not in
    (select a.id from trial_budget a, trial b, client_div c where
    a.trial_id=b.id and b.client_div_id=c.id and c.client_div_identifier like 'FTS%');

    select distinct s.client_div_identifier into last_used_by from cost_item p, trial_budget q,
    trial r, client_div s where p.trial_budget_id=q.id and q.trial_id=r.id
    and r.client_div_id=s.id and q.create_date=last_used_date and
    p.odc_def_id=ix1.odc_def_id and s.client_div_identifier not like 'FTS%';

    select count(distinct d.id) into total_clients 
    from cost_item a, trial_budget b, trial c,client_div d
    where a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id
    and a.odc_def_id=ix1.odc_def_id and d.client_div_identifier not like 'FTS%' ;

    select count(distinct d.id) into active_clients 
    from cost_item a, trial_budget b, trial c,client_div d, client_div_to_lic_app e
    where a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id and d.id=e.client_div_id 
    and e.app_name in ('PICASE','GM30') and e.LICENSE_EXP_DATE > sysdate
    and a.odc_def_id=ix1.odc_def_id and d.client_div_identifier not like 'FTS%' ;


   declare

            cursor c2 is select distinct d.client_div_identifier client_div_identifier
            from cost_item a, trial_budget b, trial c,client_div d
            where a.trial_budget_id=b.id and b.trial_id=c.id and c.client_div_id=d.id
            and a.odc_def_id=ix1.odc_def_id and d.client_div_identifier not like 'FTS%' ;
   begin
    client_list:=null;
    for ix2 in c2 loop
      client_list:=client_list||','||ix2.client_div_identifier;
    end loop;
   end;

    Insert into picas_code_usage_josh values (proc_name,obs_flg,hide_flg,tot_num,last_used_date,last_used_by,total_clients,active_clients,substr(client_list,2));
  end loop;
commit;
end;
/


insert into cpt_code_usage_josh(code,obsolete, hide, cnt) select a.cpt_code,
decode(obsolete_flg,1,'Yes',0,'No'),decode(hide,1,'Yes',0,'No'),0 from procedure_def a
where not exists (select 1 from cpt_code_usage_josh b where b.code=a.cpt_code);

insert into picas_code_usage_josh(code,obsolete, hide,cnt) select a.picas_code,
decode(obsolete_flg,1,'Yes',0,'No'),decode(hide,1,'Yes',0,'No'),0 from odc_def a
where not exists (select 1 from picas_code_usage_josh b where b.code=a.picas_code);

commit;


set heading off
set feedback off
set lin 400
set pages 10000
spool /export/home/oracle/log/Proc_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"CPT code usage report"' from dual;
select '"code","obsolete","Hide","Usage count","LAst Used Date","Last used by","#of Clients","#of Active Clients","used By"' from dual;


select '"'||code||'","'||obsolete||'","'||Hide||'","'||cnt||'","'||
 last_used_date||'","'||last_used_by||'","'||total_clients||'","'||active_clients||'","'||client_list||'"'
from cpt_code_usage_josh
ORDER BY cnt desc;


spool off


spool /export/home/oracle/log/ODC_Usage.csv

select '"Report run date: '||To_char(sysdate,'mm/dd/yy hh24:mi')||' Pacific Time"' from dual;
Select '"ODC usage report"' from dual;
select '"ODC","obsolete","Hide","Usage count","LAst Used Date","Last used by","#of Clients","#of Active Clients","used By"' from dual;


select '"'||code||'","'||obsolete||'","'||Hide||'","'||cnt||'","'||
 last_used_date||'","'||last_used_by||'","'||total_clients||'","'||active_clients||'","'||client_list||'"'
from picas_code_usage_josh
ORDER BY cnt desc;


spool off

drop table cpt_code_usage_josh;
drop table picas_code_usage_josh;

exit;
EOF

mv /export/home/oracle/log/Proc_Usage.csv /export/home/oracle/log/Proc_Usage_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/Proc_Usage_$(date +%m%d%y).csv | \
uuencode Proc_Usage_$(date +%m%d%y).csv | \
mailx -r $sender -s "CPT Code Usage" -c $cclist $mailinglist


mv /export/home/oracle/log/ODC_Usage.csv /export/home/oracle/log/ODC_Usage_$(date +%m%d%y).csv

sed "s/$/`echo \\\r`/" /export/home/oracle/log/ODC_Usage_$(date +%m%d%y).csv | \
uuencode ODC_Usage_$(date +%m%d%y).csv | \
mailx -r $sender -s "ODC Usage" -c $cclist $mailinglist



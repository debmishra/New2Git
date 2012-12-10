drop table dmishra.Intrinsyc_client_div;
create table dmishra.Intrinsyc_client_div as 
select substr(client_div_identifier,1,3) parent_client_div,
client_div_identifier, id from tsm10.client_div 
WHERE Id IN (SELECT client_div_id FROM tsm10.client_div_to_lic_app 
WHERE app_name='TSPD' AND license_exp_date > SYSDATE) 
ORDER BY 1;

update dmishra.Intrinsyc_client_div set parent_client_div='MDT' 
where client_div_identifier in ('FTS','FTD','FTD25','FCS');

commit;

select parent_client_div, count(distinct email) from
Intrinsyc_client_div a, tsm10.ftuser b, tsm10.audit_hist c where
a.id=b.client_div_id and b.id=c.ftuser_id and 
b.email not like '%mdsol.com' and 
b.email not like '%fast-track.com' and
c.app_type='TSPD' and 
c.modify_date between add_months(trunc(sysdate,'Q'),-3) and trunc(sysdate,'Q')
group by a.parent_client_div;


-- New Intrinsyc reporting steps


create table dmishra.audit_hist_2011Q2 as 
select distinct ftuser_id, app_type  from tsm10.audit_hist 
where modify_date >='01-APR-2011' and modify_date < '01-JUL-2011'
and APP_TYPE in ('TSPD','CROCAS') and action = 'auditAction.login_succeeded' ;
Alter table  dmishra.audit_hist_2011Q2 add email varchar2(128);
update dmishra.audit_hist_2011Q2 a set a.email=(select b.email from tsm10.ftuser b where b.id=a.ftuser_id);

Create table dmishra.audit_hist_rest as select 
distinct ftuser_id, app_type  from tsm10.audit_hist 
where modify_date < '01-APR-2011'
and APP_TYPE in ('TSPD','CROCAS') and action = 'auditAction.login_succeeded' ;
Alter table  dmishra.audit_hist_rest add email varchar2(128);
update dmishra.audit_hist_rest a set a.email=(select b.email from tsm10.ftuser b where b.id=a.ftuser_id);

--select 'Designer' App,client_div_identifier, first_name||' '||last_name User_name, a.name
--from tsm10.ftuser a, tsm10.client_div b where a.client_div_id=b.id and a.id in (
--select x.ftuser_id from dmishra.audit_hist_2011Q2 x where x.app_type='TSPD' and
--not exists (select 1 from dmishra.audit_hist_rest y where y.app_type='TSPD' and
--y.ftuser_id=x.ftuser_id))
--and a.email not like '%mdsol.com%' and email not like '%fast-track.com%' AND a.nAME NOT LIKE 'fasttrack%'
--and a.email not in (select email from dmishra.audit_hist_rest)
--UNION all
--select 'CRO Contractor' app,client_div_identifier, first_name||' '||last_name User_name, a.name
--from tsm10.ftuser a, tsm10.client_div b where a.client_div_id=b.id and a.id in (
--select x.ftuser_id from dmishra.audit_hist_2011Q2 x where x.app_type='CROCAS' and
--not exists (select 1 from dmishra.audit_hist_rest y where y.app_type='CROCAS' and
--y.ftuser_id=x.ftuser_id))
--and a.email not like '%mdsol.com%' and email not like '%fast-track.com%' AND a.nAME NOT LIKE 'fasttrack%'
--and a.email not in (select email from dmishra.audit_hist_rest)
--ORDER BY 1,2,3;

select 'Designer' App,client_div_identifier, first_name||' '||last_name User_name, a.NAME,a.email
from tsm10.ftuser a, tsm10.client_div b where a.client_div_id=b.id and a.id in (
select x.ftuser_id from dmishra.audit_hist_2011Q2 x where x.app_type='TSPD' and
not exists (select 1 from dmishra.audit_hist_rest y where y.app_type='TSPD' and
y.ftuser_id=x.ftuser_id) AND
NOT EXISTS (SELECT 1 FROM dmishra.audit_hist_rest y where y.app_type='CROCAS' AND
Lower(Trim(x.email))=Lower(Trim(y.email))))
and a.email not like '%mdsol.com%' and email not like '%fast-track.com%' AND a.nAME NOT LIKE 'fasttrack%'
UNION all
select 'CRO Contractor' app,client_div_identifier, first_name||' '||last_name User_name, a.NAME , a.email
from tsm10.ftuser a, tsm10.client_div b where a.client_div_id=b.id and a.id in (
select x.ftuser_id from dmishra.audit_hist_2011Q2 x where x.app_type='CROCAS' and
not exists (select 1 from dmishra.audit_hist_rest y where y.app_type='CROCAS' and
y.ftuser_id=x.ftuser_id) AND
NOT EXISTS (SELECT 1 FROM dmishra.audit_hist_rest y where y.app_type='CROCAS' AND
Lower(Trim(x.email))=Lower(Trim(y.email))))
and a.email not like '%mdsol.com%' and email not like '%fast-track.com%' AND a.nAME NOT LIKE 'fasttrack%'
ORDER BY 1,2,3;



drop table  dmishra.audit_hist_2011Q2;
drop table  dmishra.audit_hist_rest;




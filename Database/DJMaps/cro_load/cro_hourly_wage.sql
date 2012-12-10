create sequence tsm_stage.hourrate2_seq;

alter table tsm_stage.hourrate add(country_id number(10), 
currency_id number(10),CRO_HOURLY_WORK_TYPE_ID number(10));

update tsm_stage.hourrate a set a.country_id=(select b.id from tc10.country b where
b.abbreviation=a.country);
commit;
update tsm_stage.hourrate a set a.currency_id=(select b.id from tc10.currency b,
tc10.country c where b.id=c.currency_id and c.abbreviation=a.currency);
commit;
update tsm_stage.hourrate a set a.CRO_HOURLY_WORK_TYPE_ID=(select b.id from 
tc10.cro_hourly_work_type b where b.work_type=a.descript and
b.parent_work_type_id=a.class);
commit;
insert into tc10.cro_hourly_wage(ID,CONTRACT_NAME,
CRO_HOURLY_WORK_TYPE_ID,HOURLY_RATE,COUNTRY_ID,
CURRENCY_ID,YEAR_ENTERED,CATEGORY,NUM_HOURS,COMPANY_NAME)                    
select tsm_stage.hourrate2_seq.nextval,CONTRACT,
CRO_HOURLY_WORK_TYPE_ID,HOURLY_R,COUNTRY_ID,
CURRENCY_ID,to_date(year,'YYYY'),
CATEGORY,NUMHOURS,COMPANY
from tsm_stage.hourrate where CRO_HOURLY_WORK_TYPE_ID is not null;

commit; 

drop sequence tsm_stage.hourrate2_seq;

set serveroutput on
declare

cursor c1 is select
distinct '%'||upper(company_name)||'%' co_name
from tc10.cro_hourly_wage;

num_exists   number(5):=0;
not_found    number(5):=0;
more_found   number(5):=0;
exact_found  number(5):=0;

begin

for ix1 in c1 loop
     select count(*) into num_exists from tc10.cro_company
     where upper(name) like ix1.co_name;

     if num_exists = 0 then
            not_found:=not_found+1;
     elsif num_exists > 1 then
            more_found:=more_found+1;
     else
            exact_found:=exact_found+1;

         update tc10.cro_hourly_wage set cro_company_id=
         (select id from tc10.cro_company where upper(name)
         like ix1.co_name) where 
	 '%'||upper(company_name)||'%' = ix1.co_name;     

     end if;

end loop;

dbms_output.put_line('not_found: '||not_found);
dbms_output.put_line('more_found: '||more_found);
dbms_output.put_line('exact_found: '||exact_found);

end;
/
set serveroutput off
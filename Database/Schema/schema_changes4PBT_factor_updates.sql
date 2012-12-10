--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_changes4PBT_factor_updates.sql$ 
--
-- $Revision: 10$        $Date: 2/22/2008 11:55:59 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop table temp_cro_country_factor;
drop table temp_cro_bgmaster;
drop table TEMP_CRO_CATEGORY_FACTOR;
drop table TEMP_CRO_CHOICE;
drop table TEMP_CRO_COMPONENT;
drop table temp_cro_adjusted_salary;
drop table temp_cro_job_type;
drop table TEMP_CRO_PHASE_FACTOR;
drop table TEMP_CRO_TA_FACTOR;



create table temp_cro_country_factor as 
select a.ID ORACLE_ID, b.abbreviation COUNTRY,
a.FACTOR           
from cro_country_factor a, country b 
where a.country_id=b.id;

create table temp_cro_ta_factor as 
select a.ID ORACLE_ID, b.code TA,
a.TA_FACTOR, c.short_desc category             
from cro_ta_factor a, indmap b, cro_category c
where a.indmap_id=b.id and a.cro_category_id=c.id(+);

create table temp_cro_phase_factor as 
select a.ID ORACLE_ID, b.short_desc PHASE,
a.FACTOR factor, c.short_desc category             
from cro_phase_factor a, phase b, cro_category c
where a.phase_id=b.id and a.cro_category_id=c.id(+);


create table temp_cro_job_type as 
select id oracle_id, short_desc job_type from cro_job_type;

create table temp_cro_adjusted_salary as select 
a.ID oracle_id,b.abbreviation country,c.code TA,      
d.short_desc phase,e.short_desc job_type,
a.LOW_SALARY, a.MED_SALARY,a.HIGH_SALARY 
from cro_adjusted_salary a, country b, indmap c, 
phase d, cro_job_type e where
a.country_id=b.id and
a.indmap_id=c.id and
a.phase_id=d.id(+) and
a.cro_job_type_id=e.id;  

--create table temp_cro_bgmaster as 
--select a.id oracle_id,a.cro_type, d.short_desc category, d.category_account fp_account,
--c.component_label, c.component_type, c.weight component_weight, b.choice_label, a.factor choice_factor,
--b.low_range, b.high_range
--from cro_choice_factor a, cro_choice b, 
--cro_component c, cro_category d where
--a.cro_choice_id(+)=b.id and
--b.cro_component_id(+)=c.id and
--c.cro_category_id=d.id;


create table temp_cro_bgmaster as 
select a.id oracle_id,a.cro_type, d.short_desc category, d.category_account fp_account,e.short_desc SubCategory,
c.component_label, c.component_type, c.weight component_weight, b.choice_label, a.factor choice_factor,
b.low_range, b.high_range
from cro_choice_factor a, cro_choice b, 
cro_component c, cro_category d, cro_category e where
a.cro_choice_id(+)=b.id and
b.cro_component_id(+)=c.id and
c.sub_category_id=e.id(+) and
c.cro_category_id=d.id;

create table temp_cro_category_factor as select
a.ID oracle_id, b.name country, c.short_desc category, a.CRO_TYPE,
a.LOW_PRICE,a.MED_PRICE,a.HIGH_PRICE,
a.MEAN_PRICE     
from cro_category_factor a, country b, cro_category c 
where a.country_id=b.id(+) 
and a.cro_category_id=c.id(+);

create table temp_cro_component as select
a.ID ORACLE_ID,a.PARENT_COMPONENT_ID PARENT_ORACLE_COMPONENT_ID,
b.short_desc category,a.COMPONENT_TYPE,a.COMPONENT_LABEL,
a.COMPONENT_SEQ,a.LABEL_COL,a.VALUE_COL,a.WEIGHT,a.SHORT_DESC
from cro_component a, cro_category b 
where a.cro_category_id=b.id(+);

create table temp_cro_choice as select a.ID oracle_id,                
b.short_desc CRO_COMPONENT,a.CHOICE_LABEL,a.SEQUENCE,
a.LOW_RANGE,a.HIGH_RANGE,a.SHORT_DESC  
from cro_choice a, cro_component b 
where a.cro_component_id=b.id(+);           


create or replace trigger temp_cro_bgmaster_trg1
before update of choice_factor on temp_cro_bgmaster
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20130,'Sorry! Can not update factor with null Oracle ID');
end;
/

create or replace trigger temp_cro_category_factor_trg1 
before update of LOW_PRICE,MED_PRICE,HIGH_PRICE,MEAN_PRICE on temp_cro_category_factor
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20131,'Sorry! Can not update price with null Oracle ID');
end;
/

create or replace trigger temp_cro_component_trg1 
before update of weight on temp_cro_component
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update weight with null Oracle ID');
end;
/


create or replace trigger temp_cro_choice_trg1 
before update of LOW_RANGE, HIGH_RANGE on temp_cro_choice
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update weight with null Oracle ID');
end;
/

create or replace trigger temp_cro_ta_factor_trg1 
before update of ta_factor on temp_cro_ta_factor
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update TA factor with null Oracle ID');
end;
/

create or replace trigger temp_cro_phase_factor_trg1 
before update of factor on temp_cro_phase_factor
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update phase factor with null Oracle ID');
end;
/

create or replace trigger temp_cro_job_type_trg1 
before update of job_type on temp_cro_job_type
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update job type with null Oracle ID');
end;
/

create or replace trigger temp_cro_adjusted_salary_trg1 
before update of LOW_SALARY,MED_SALARY,HIGH_SALARY  
on temp_cro_adjusted_salary
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update salary range with null Oracle ID');
end;
/

create or replace trigger temp_cro_country_factor_trg1 
before update of factor on temp_cro_country_factor
referencing new as n old as o
for each row
when (o.oracle_id is null)
declare
cant_update exception;
begin
raise cant_update;
exception
when cant_update then 
Raise_application_error(-20132,'Sorry! Can not update factor with null Oracle ID');
end;
/

create or replace procedure update_cro_factors as
begin

update cro_country_factor a set a.factor=(
select b.factor from temp_cro_country_factor b
where b.oracle_id=a.id);

update cro_ta_factor a set a.ta_factor=(
select b.ta_factor from temp_cro_ta_factor b
where b.oracle_id=a.id);

update cro_phase_factor a set a.factor=(
select b.factor from temp_cro_phase_factor b
where b.oracle_id=a.id);

--insert into cro_job_type 
--select * from temp_cro_job_type where oracle_id
--not in (select id from cro_job_type);  

update cro_adjusted_salary a set (a.low_salary, a.med_salary, a.high_salary)
=(select b.low_salary,b.med_salary,b.high_salary from 
temp_cro_adjusted_salary b
where b.oracle_id=a.id);

update cro_choice_factor a set a.factor=(
select b.choice_factor from temp_cro_bgmaster b
where b.oracle_id=a.id);

update cro_category_factor a set 
(a.low_price,a.med_price,a.high_price,a.mean_price)=
(select b.low_price,b.med_price,b.high_price,b.mean_price
from temp_cro_category_factor b where b.oracle_id=a.id);

update cro_component a set a.weight=(select b.weight 
from temp_cro_component b where b.oracle_id=a.id);

update cro_choice a set 
(a.low_range, a.high_range)=
(select b.low_range, b.high_range from temp_cro_choice b 
where b.oracle_id=a.id);

commit;

end;
/

grant select on temp_cro_job_type to cro_stage;
grant select on temp_cro_adjusted_salary to cro_stage;
grant select on temp_cro_country_factor to cro_stage;
grant select on temp_cro_ta_factor to cro_stage;
grant select on temp_cro_phase_factor to cro_stage;
grant select on temp_cro_bgmaster to cro_stage;
grant select on temp_cro_category_factor to cro_stage;
grant select on cro_category to cro_stage;
grant select on temp_cro_component to cro_stage;
grant select on temp_cro_choice to cro_stage;
grant update (low_salary, med_salary, high_salary) on temp_cro_adjusted_salary to cro_stage;
grant update (ta_factor) on temp_cro_ta_factor to cro_stage;
grant update (factor) on temp_cro_country_factor to cro_stage;
grant update (factor) on temp_cro_phase_factor to cro_stage;
grant update (choice_factor) on temp_cro_bgmaster to cro_stage;
grant update (low_price,med_price,high_price,mean_price) on temp_cro_category_factor to cro_stage; 
grant update (weight) on temp_cro_component to cro_stage;    
grant update (low_range, high_range) on temp_cro_choice to cro_stage;
grant execute on update_cro_factors to cro_stage;

--conn cro_stage/***@????

--create or replace view cro_ta_factor as select * from tsm10.temp_cro_ta_factor;
--create or replace view cro_phase_factor as select * from tsm10.temp_cro_phase_factor;
--create or replace view cro_job_type as select * from tsm10.temp_cro_job_type;
--create or replace view cro_adjusted_salary as select * from tsm10.temp_cro_adjusted_salary;
--create or replace view cro_country_factor as select * from tsm10.temp_cro_country_factor;

--create or replace view cro_category as select * from tsm10.cro_category;
--create or replace view cro_category_factor as select * from tsm10.temp_cro_category_factor;
--create or replace view cro_bgmaster as select * from tsm10.temp_cro_bgmaster;
--create or replace view cro_component as select * from tsm10.temp_cro_component;
--create or replace view cro_choice as select * from tsm10.temp_cro_choice;
--create synonym update_cro_factors for tsm10.update_cro_factors;

--conn tsm10/****8@????


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  10   DevTSM    1.9         2/22/2008 11:55:59 AMDebashish Mishra  
--  9    DevTSM    1.8         9/11/2007 5:12:02 PM Debashish Mishra  
--  8    DevTSM    1.7         9/19/2006 12:11:21 AMDebashish Mishra   
--  7    DevTSM    1.6         5/23/2006 8:27:31 AM Debashish Mishra  
--  6    DevTSM    1.5         4/28/2006 6:21:22 AM Debashish Mishra  
--  5    DevTSM    1.4         3/26/2006 10:38:12 AMDebashish Mishra  
--  4    DevTSM    1.3         3/19/2006 11:45:47 PMDebashish Mishra  
--  3    DevTSM    1.2         3/1/2006 8:32:25 AM  Debashish Mishra  
--  2    DevTSM    1.1         2/3/2006 1:01:13 PM  Debashish Mishra New view
--       cro_choice
--  1    DevTSM    1.0         12/21/2005 6:29:07 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_tsm10_1.sql$ 
--
-- $Revision: 3$        $Date: 4/15/2011 3:48:20 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
set timing on;
spool c:\mahesh\load_45master\load_tsm10_q003_1.log

select to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;

truncate table "&1".temp_procedure;
truncate table "&1".temp_odc;
truncate table "&1".temp_overhead;
truncate table "&1".temp_ip_study_price;
truncate table "&1".temp_inst_to_company;

declare
  maxid number(10);
  num_exists number(10);
 begin
  select nvl(max(id),0)+1 into maxid from "&1".build_tag;
 -- Insert into "&1".build_tag values (maxid,'01-APR-2011','2011Q2');
 
 -- select count(*) into num_exists from "&1".build_tag where id=-1;
 --If num_exists = 0 then
 --   Insert into "&1".build_tag values (-1,'01-OCT-2008','Build tag for migrated archived and published trials');
 -- end if;
  commit;
end;
/


sho err

-- As discussed with DB country load commented on 01/10/2011
--select 'country_inc' from dual;
--@c:\tsm\database\djmaps\inc_load\country_inc &1

select 'currency_inc' from dual;
@c:\tsm\database\djmaps\inc_load\currency_inc &1

select 'build_code_inc' from dual;
@c:\tsm\database\djmaps\inc_load\build_code_inc &1

alter system flush shared_pool;

select 'indmap_inc' from dual;
@c:\tsm\database\djmaps\inc_load\indmap_inc &1


select 'affiliation_factor_inc' from dual;
@c:\tsm\database\djmaps\inc_load\affiliation_factor_inc &1
select 'ip_duration_factor_inc' from dual;
@c:\tsm\database\djmaps\inc_load\ip_duration_factor_inc &1
select 'ip_weight_inc' from dual;
@c:\tsm\database\djmaps\inc_load\ip_weight_inc &1
select 'ip_cpp_inc' from dual;
@c:\tsm\database\djmaps\inc_load\ip_cpp_inc &1
select 'ip_duration_inc' from dual;
@c:\tsm\database\djmaps\inc_load\ip_duration_inc &1
select 'ip_business_factors_inc' from dual;
@c:\tsm\database\djmaps\inc_load\ip_business_factors_inc &1
select 'region_inc' from dual;
@c:\tsm\database\djmaps\inc_load\region_inc &1  
select 'institution_inc' from dual;
@c:\tsm\database\djmaps\inc_load\institution_inc &1
select 'procedure_def_inc' from dual;
@c:\tsm\database\djmaps\inc_load\procedure_def_inc &1
select 'odc_def_inc' from dual;
@c:\tsm\database\djmaps\inc_load\odc_def_inc &1
select 'mapper_inc' from dual;
@c:\tsm\database\djmaps\inc_load\mapper_inc &1
select 'pap_odc_pct_inc' from dual;
@c:\tsm\database\djmaps\inc_load\pap_odc_pct_inc &1
select 'pap_euro_overhead_inc' from dual;
@c:\tsm\database\djmaps\inc_load\pap_euro_overhead_inc &1
select 'add_study' from dual;
@c:\tsm\database\djmaps\inc_load\add_study_inc &1
select 'protocol_inc' from dual;
@c:\tsm\database\djmaps\inc_load\protocol_inc &1

select to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;
spool off


--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_tsm10_initial.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:17:05 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

spool c:\tsm\database\djmaps\inc_load\load_tsm10.log

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
  Insert into "&1".build_tag values (maxid,sysdate,'New Build on :'||sysdate);
  select count(*) into num_exists from "&1".build_tag where id=-1;
  /* if num_exists <> 0 then
     delete from "&1".build_tag where id=-1;
  end if;*/
  If num_exists = 0 then
    Insert into "&1".build_tag values (-1,sysdate,'Build tag for migrated archived and published trials');
  end if;
  commit;
end;
/



sho err

select 'static_data_country_inc' from dual;
-- (only first time)
@c:\tsm\database\djmaps\inc_load\static_data_country_inc &1

select 'country_inc' from dual;
@c:\tsm\database\djmaps\inc_load\country_inc &1
select 'currency_inc' from dual;
@c:\tsm\database\djmaps\inc_load\currency_inc &1


-- (only first time)
select 'static_data_local_to_euro_inc' from dual;
@c:\tsm\database\djmaps\inc_load\static_data_local_to_euro_inc &1
-- (only first time)
select 'static_data_client_inc' from dual;
@c:\tsm\database\djmaps\inc_load\static_data_client_inc &1 
-- (only first time)
select 'static_data_phase_inc' from dual;
@c:\tsm\database\djmaps\inc_load\static_data_phase_inc &1   


select 'build_code_inc' from dual;
@c:\tsm\database\djmaps\inc_load\build_code_inc &1
select 'indmap_inc' from dual;
@c:\tsm\database\djmaps\inc_load\indmap_inc &1

-- (only first time)
select 'industry_build_required_data_inc' from dual;
@c:\tsm\database\djmaps\inc_load\industry_build_required_data_inc &1
 
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
select 'investig_inc' from dual;
@c:\tsm\database\djmaps\inc_load\investig_inc &1
select 'payments_inc' from dual;
@c:\tsm\database\djmaps\inc_load\payments_inc &1
select 'protocol_to_indmap_inc' from dual;
@c:\tsm\database\djmaps\inc_load\protocol_to_indmap_inc &1
select 'price_level_inc' from dual;
@c:\tsm\database\djmaps\inc_load\price_level_inc &1
select 'procedure_to_protocol_inc' from dual;
@c:\tsm\database\djmaps\inc_load\procedure_to_protocol_inc &1
select 'euro_updates_inc' from dual;
@c:\tsm\database\djmaps\inc_load\euro_updates_inc &1



exec "&1".temp_role_inst_update

update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".country) where table_name='country';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".currency) where table_name='currency';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".build_code) where table_name='build_code';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".indmap) where table_name='indmap';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".affiliation_factor) where table_name='affiliation_factor';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ip_duration_factor) where table_name='ip_duration_factor';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ip_weight) where table_name='ip_weight';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ip_cpp) where table_name='ip_cpp';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ip_duration) where table_name='ip_duration';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".ip_business_factors) where table_name='ip_business_factors';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".region) where table_name='region';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".institution) where table_name='institution';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".procedure_def) where table_name='procedure_def';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".odc_def) where table_name='odc_def';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".mapper) where table_name='mapper';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".pap_odc_pct) where table_name='pap_odc_pct';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".pap_odc_pct_to_indmap) where table_name='pap_odc_pct_to_indmap';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".pap_euro_overhead) where table_name='pap_euro_overhead';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".add_study) where table_name='add_study';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".protocol) where table_name='protocol';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".investig) where table_name='investig';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".payments) where table_name='payments';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".protocol_to_indmap) where table_name='protocol_to_indmap';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".price_level) where table_name='price_level';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".procedure_to_protocol) where table_name='procedure_to_protocol';
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".build_tag) where table_name='build_tag';

update "&1".protocol a set earliest_grant_date = (
select min(grant_date) from "&1".investig b where
b.protocol_id =a.id);

commit;

select 'version_45master_inc' from dual;
@c:\tsm\database\djmaps\inc_load\version_45master_inc &1


spool off

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:17:05 PM Debashish Mishra  
--  8    DevTSM    1.7         2/7/2007 10:27:55 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:40:19 AM  Debashish Mishra  
--  6    DevTSM    1.5         9/9/2003 8:40:10 AM  Debashish Mishra added
--       version_45master to import scripts
--  5    DevTSM    1.4         7/30/2003 4:44:03 PM Debashish Mishra  
--  4    DevTSM    1.3         7/9/2003 5:10:30 PM  Debashish Mishra  
--  3    DevTSM    1.2         2/19/2003 1:49:16 PM Debashish Mishra  
--  2    DevTSM    1.1         10/23/2002 3:50:24 PMDebashish Mishra Modified for
--       adding -1 id to build_tag table
--  1    DevTSM    1.0         9/25/2002 4:14:04 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

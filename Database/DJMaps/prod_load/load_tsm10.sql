--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: load_tsm10.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
spool c:\tsm\database\djmaps\prod_load\load_tsm10.log 

create user "&1" identified by welcome default tablespace tsmsmall
temporary tablespace temp;

grant connect,resource to "&1";

create public database link prodload connect to "&1" identified by welcome using 'test1';

create synonym "&1".country for country@prodload;
create synonym "&1".currency for currency@prodload;
create synonym "&1".build_code for build_code@prodload;
create synonym "&1".indmap for indmap@prodload;
create synonym "&1".affiliation_factor for affiliation_factor@prodload;
create synonym "&1".ip_duration_factor for ip_duration_factor@prodload;
create synonym "&1".ip_weight for ip_weight@prodload;
create synonym "&1".ip_cpp for ip_cpp@prodload;
create synonym "&1".ip_duration for ip_duration@prodload;
create synonym "&1".ip_business_factors for ip_business_factors@prodload;
create synonym "&1".region for region@prodload;
create synonym "&1".institution for institution@prodload;
create synonym "&1".procedure_def for procedure_def@prodload;
create synonym "&1".odc_def for odc_def@prodload;
create synonym "&1".odc_def_mapper for odc_def_mapper@prodload;
create synonym "&1".mapper for mapper@prodload;
create synonym "&1".pap_odc_pct for pap_odc_pct@prodload;
create synonym "&1".pap_odc_pct_to_indmap for pap_odc_pct_to_indmap@prodload;
create synonym "&1".pap_euro_overhead for pap_euro_overhead@prodload;
create synonym "&1".add_study for add_study@prodload;

create synonym "&1".protocol for protocol@prodload;
create synonym "&1".investig for investig@prodload;
create synonym "&1".payments for payments@prodload;
create synonym "&1".protocol_to_indmap for protocol_to_indmap@prodload;
create synonym "&1".price_level for price_level@prodload;
create synonym "&1".procedure_to_protocol for procedure_to_protocol@prodload;
create synonym "&1".build_tag for build_tag@prodload;
create synonym "&1".id_control for id_control@prodload;
create synonym "&1".data_load_history for data_load_history@prodload;
create synonym "&1".temp_role_inst_update for temp_role_inst_update@prodload;
create synonym "&1".local_to_euro for local_to_euro@prodload;

create synonym "&1".mapper_seq for mapper_seq@prodload;
create synonym "&1".add_study_seq for add_study_seq@prodload;
create synonym "&1".price_level_seq for price_level_seq@prodload;

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


select 'country_inc' from dual;
@c:\tsm\database\djmaps\prod_load\country_inc &1
select 'currency_inc' from dual;
@c:\tsm\database\djmaps\prod_load\currency_inc &1

select 'build_code_inc' from dual;
@c:\tsm\database\djmaps\prod_load\build_code_inc &1
select 'indmap_inc' from dual;
@c:\tsm\database\djmaps\prod_load\indmap_inc &1
 
select 'affiliation_factor_inc' from dual;
@c:\tsm\database\djmaps\prod_load\affiliation_factor_inc &1
select 'ip_duration_factor_inc' from dual;
@c:\tsm\database\djmaps\prod_load\ip_duration_factor_inc &1
select 'ip_weight_inc' from dual;
@c:\tsm\database\djmaps\prod_load\ip_weight_inc &1
select 'ip_cpp_inc' from dual;
@c:\tsm\database\djmaps\prod_load\ip_cpp_inc &1
select 'ip_duration_inc' from dual;
@c:\tsm\database\djmaps\prod_load\ip_duration_inc &1
select 'ip_business_factors_inc' from dual;
@c:\tsm\database\djmaps\prod_load\ip_business_factors_inc &1
select 'region_inc' from dual;
@c:\tsm\database\djmaps\prod_load\region_inc &1  
select 'institution_inc' from dual;
@c:\tsm\database\djmaps\prod_load\institution_inc &1
select 'procedure_def_inc' from dual;
@c:\tsm\database\djmaps\prod_load\procedure_def_inc &1
select 'odc_def_inc' from dual;
@c:\tsm\database\djmaps\prod_load\odc_def_inc &1
select 'mapper_inc' from dual;
@c:\tsm\database\djmaps\prod_load\mapper_inc &1
select 'pap_odc_pct_inc' from dual;
@c:\tsm\database\djmaps\prod_load\pap_odc_pct_inc &1
select 'pap_euro_overhead_inc' from dual;
@c:\tsm\database\djmaps\prod_load\pap_euro_overhead_inc &1
select 'add_study' from dual;
@c:\tsm\database\djmaps\prod_load\add_study_inc &1

select 'protocol_inc' from dual;
@c:\tsm\database\djmaps\prod_load\protocol_inc &1
select 'investig_inc' from dual;
@c:\tsm\database\djmaps\prod_load\investig_inc &1
select 'payments_inc' from dual;
@c:\tsm\database\djmaps\prod_load\payments_inc &1
select 'protocol_to_indmap_inc' from dual;
@c:\tsm\database\djmaps\prod_load\protocol_to_indmap_inc &1
select 'price_level_inc' from dual;
@c:\tsm\database\djmaps\prod_load\price_level_inc &1
select 'procedure_to_protocol_inc' from dual;
@c:\tsm\database\djmaps\prod_load\procedure_to_protocol_inc &1
select 'euro_updates_inc' from dual;
@c:\tsm\database\djmaps\prod_load\euro_updates_inc &1



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


drop synonym "&1".country;
drop synonym "&1".currency;
drop synonym "&1".build_code;
drop synonym "&1".indmap;
drop synonym "&1".affiliation_factor;
drop synonym "&1".ip_duration_factor;
drop synonym "&1".ip_weight;
drop synonym "&1".ip_cpp;
drop synonym "&1".ip_duration;
drop synonym "&1".ip_business_factors;
drop synonym "&1".region;
drop synonym "&1".institution;
drop synonym "&1".procedure_def;
drop synonym "&1".odc_def;
drop synonym "&1".mapper;
drop synonym "&1".pap_odc_pct;
drop synonym "&1".pap_odc_pct_to_indmap;
drop synonym "&1".pap_euro_overhead;
drop synonym "&1".add_study;
drop synonym "&1".protocol;
drop synonym "&1".investig;
drop synonym "&1".payments;
drop synonym "&1".protocol_to_indmap;
drop synonym "&1".price_level;
drop synonym "&1".procedure_to_protocol;
drop synonym "&1".build_tag;
drop synonym "&1".id_control;
drop synonym "&1".temp_role_inst_update;
drop synonym "&1".data_load_history;
create synonym "&1".local_to_euro;

drop public database link prodload;
Drop user "&1";

spool off

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:19:42 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:41:46 AM  Debashish Mishra  
--  4    DevTSM    1.3         9/9/2003 8:40:18 AM  Debashish Mishra added
--       version_45master to import scripts
--  3    DevTSM    1.2         7/30/2003 4:45:14 PM Debashish Mishra  
--  2    DevTSM    1.1         7/9/2003 5:10:39 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:04 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

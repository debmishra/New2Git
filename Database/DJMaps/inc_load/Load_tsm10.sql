--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_tsm10.sql$ 
--
-- $Revision: 36$        $Date: 5/14/2008 6:00:48 PM$
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

truncate table "&1".own_investig; 
truncate table "&1".own_protocol; 
truncate table "&1".own_site; 
truncate table "&1".own_procedure; 
truncate table "&1".own_odc;


declare
  maxid number(10);
  num_exists number(10);
 begin
  select nvl(max(id),0)+1 into maxid from "&1".build_tag;
  Insert into "&1".build_tag values (maxid,'11-APR-2008','2008Q2');
  commit;
end;
/


sho err

select 'country_inc' from dual;
@c:\tsm\database\djmaps\inc_load\country_inc &1
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
select 'investig_inc' from dual;
@c:\tsm\database\djmaps\inc_load\investig_inc &1
select 'payments_inc' from dual;
@c:\tsm\database\djmaps\inc_load\payments_inc &1
select 'protocol_to_indmap_inc' from dual;
@c:\tsm\database\djmaps\inc_load\protocol_to_indmap_inc &1
select 'price_level_inc' from dual;
@c:\tsm\database\djmaps\inc_load\price_level_inc &1
select 'derived_price_inc' from dual;
@c:\tsm\database\djmaps\inc_load\derived_price_inc &1
select 'procedure_to_protocol_inc' from dual;
@c:\tsm\database\djmaps\inc_load\procedure_to_protocol_inc &1
select 'euro_updates_inc' from dual;
@c:\tsm\database\djmaps\inc_load\euro_updates_inc &1
select 'reference_prices' from dual;
@c:\tsm\database\djmaps\inc_load\reference_prices &1

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
update "&1".id_control set next_id=(select nvl(max(id),0)+1 from "&1".reference_prices) where table_name='reference_prices';

update "&1".protocol a set earliest_grant_date = (
select min(grant_date) from "&1".investig b where
b.protocol_id =a.id);

commit;

select 'version_45master_inc' from dual;
@c:\tsm\database\djmaps\inc_load\version_45master_inc &1

--declare
-- gname varchar2(50);
 
--begin
-- select * into gname from global_name;
-- if ( '&1' = 'TSM10E' and gname = 'PREV.FASTTRACK.COM') or ('&1' = 'TSM10E' and gname = 'PROD.FASTTRACK.COM') or
--    ('&1' = 'TSM10' and gname = 'PROD.FASTTRACK.COM') then
--     update "&1".procedure_def set short_desc = null;
--     commit;
-- end if;
--end;
--/  


--update "&1".procedure_def a set a.long_desc=
--(select b.long_desc from tsm_stage.deleted_proc_desc b
--where b."PROCEDURE"=a.cpt_code)
--where exists 
--(select 1 from tsm_stage.deleted_proc_desc c
--where c."PROCEDURE"=a.cpt_code)
--commit;

spool off

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  36   DevTSM    1.35        5/14/2008 6:00:48 PM Debashish Mishra  
--  35   DevTSM    1.34        2/27/2008 3:17:05 PM Debashish Mishra  
--  34   DevTSM    1.33        1/25/2008 4:17:55 AM Debashish Mishra  
--  33   DevTSM    1.32        10/16/2007 1:45:41 PMDebashish Mishra  
--  32   DevTSM    1.31        7/18/2007 11:04:51 PMDebashish Mishra  
--  31   DevTSM    1.30        5/8/2007 5:58:33 PM  Debashish Mishra  
--  30   DevTSM    1.29        3/5/2007 7:28:30 PM  Debashish Mishra updated for
--       drug
--  29   DevTSM    1.28        2/15/2007 4:47:14 PM Debashish Mishra  
--  28   DevTSM    1.27        2/7/2007 10:30:26 PM Debashish Mishra  
--  27   DevTSM    1.26        12/4/2006 3:28:56 PM Debashish Mishra  
--  26   DevTSM    1.25        10/27/2006 12:49:23 PMDebashish Mishra  
--  25   DevTSM    1.24        10/26/2006 1:07:46 PMDebashish Mishra  
--  24   DevTSM    1.23        10/26/2006 12:53:12 PMDebashish Mishra  
--  23   DevTSM    1.22        8/16/2006 1:48:41 PM Debashish Mishra  
--  22   DevTSM    1.21        2/2/2006 12:41:14 PM Debashish Mishra  
--  21   DevTSM    1.20        10/26/2005 3:44:11 PMDebashish Mishra  
--  20   DevTSM    1.19        8/19/2005 6:22:31 AM Debashish Mishra  
--  19   DevTSM    1.18        5/9/2005 1:01:58 AM  Debashish Mishra  
--  18   DevTSM    1.17        3/3/2005 6:40:18 AM  Debashish Mishra  
--  17   DevTSM    1.16        10/13/2004 8:01:53 AMDebashish Mishra  
--  16   DevTSM    1.15        8/31/2004 9:44:34 AM Debashish Mishra  
--  15   DevTSM    1.14        5/6/2004 8:15:05 PM  Debashish Mishra  
--  14   DevTSM    1.13        1/30/2004 3:26:33 PM Debashish Mishra  
--  13   DevTSM    1.12        11/18/2003 4:07:34 PMDebashish Mishra Modified for
--       going to production
--  12   DevTSM    1.11        9/9/2003 8:40:08 AM  Debashish Mishra added
--       version_45master to import scripts
--  11   DevTSM    1.10        7/30/2003 4:44:01 PM Debashish Mishra  
--  10   DevTSM    1.9         7/9/2003 5:10:28 PM  Debashish Mishra  
--  9    DevTSM    1.8         2/19/2003 1:49:15 PM Debashish Mishra  
--  8    DevTSM    1.7         10/23/2002 3:50:23 PMDebashish Mishra Modified for
--       adding -1 id to build_tag table
--  7    DevTSM    1.6         8/30/2002 12:43:04 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  6    DevTSM    1.5         7/12/2002 3:41:54 PM Debashish Mishra  
--  5    DevTSM    1.4         7/11/2002 4:31:00 PM Debashish Mishra Added the
--       procedure to populate role_inst table at the end of data load
--  4    DevTSM    1.3         4/22/2002 3:24:25 PM Debashish Mishra Modification
--       for add_study
--  3    DevTSM    1.2         4/3/2002 6:58:05 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/22/2002 12:51:38 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:04 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Load_tsm10_2.sql$ 
--
-- $Revision: 3$        $Date: 4/15/2011 3:48:20 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
set timing on;
spool c:\mahesh\load_45master\load_tsm10_q003_2.log

select to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;

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

update "&1".protocol a set earliest_grant_date = (
select min(grant_date) from "&1".investig b where
b.protocol_id =a.id);

commit;

--Update complexity values.
select '--Update Complexity Values--' from dual;
 
UPDATE "&1".procedure_def  a
SET (a.complexity_val)=(SELECT b.complex FROM tsm_stage.proccomplx b
                                           WHERE a.cpt_code=b.procedure)
WHERE EXISTS (SELECT 1 from tsm_stage.proccomplx c WHERE c.procedure=a.cpt_code);

commit;
update "&1".protocol a set (complexity_val) = ( select             
        complex from tsm_stage.protocol1 b where 
        b.picas_protocol = a.picas_protocol and b.build_code_id = a.build_code_id)
        where exists (select 1 from tsm_stage.protocol1 c where
        c.picas_protocol = a.picas_protocol and c.build_code_id = a.build_code_id);
commit;

select 'version_45master_inc' from dual;

@c:\tsm\database\djmaps\inc_load\version_45master_inc &1

select to_char(sysdate,'DD-MON-YYYY HH24:MI:SS') from dual;

spool off


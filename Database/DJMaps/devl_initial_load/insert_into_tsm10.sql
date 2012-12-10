--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: insert_into_tsm10.sql$ 
--
-- $Revision: 13$        $Date: 2/27/2008 3:16:39 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
Insert into tsm10.currency select * from tsm_stage.currency where id <> 0;
Insert into tsm10.country select * from tsm_stage.country where id <> 0;
Insert into tsm10.LOCAL_TO_EURO select * from tsm_stage.LOCAL_TO_EURO;
Insert into tsm10.phase select * from tsm_stage.phase;
Insert into tsm10.build_code select * from tsm_stage.build_code;
Insert into tsm10.indmap select ID,PARENT_INDMAP_ID,CODE,SHORT_DESC,TYPE,                   
	EXECUTION_TYPE,EXECUTION_IND_ID from tsm_stage.indmap;
commit;
Insert into tsm10.pap_euro_overhead select * from tsm_stage.pap_euro_overhead;
Insert into tsm10.affiliation_factor select * from tsm_stage.affiliation_factor;
Insert into tsm10.ip_duration_factor select * from tsm_stage.ip_duration_factor;
Insert into tsm10.ip_weight select * from tsm_stage.ip_weight;
Insert into tsm10.ip_cpp select * from tsm_stage.ip_cpp;
Insert into tsm10.ip_duration select * from tsm_stage.ip_duration;
Insert into tsm10.ip_business_factors select * from tsm_stage.ip_business_factors;
Insert into tsm10.region select * from tsm_stage.region;
commit;
Insert into tsm10.institution select * from tsm_stage.institution;
Insert into tsm10.procedure_def select * from tsm_stage.procedure_def;
Insert into tsm10.odc_def select * from tsm_stage.odc_def;
Insert into tsm10.mapper select * from tsm_stage.mapper;
Insert into tsm10.client(ID,NAME,MAIN_CONTACT_ID,CLIENT_IDENTIFIER,CLIENT_ACRONYM,         
        DE_ACRONYM) select ID,NAME,MAIN_CONTACT_ID,CLIENT_IDENTIFIER,
        CLIENT_ACRONYM,DE_ACRONYM from tsm_stage.client where 
        client_identifier not in ('DUMMY');
update tsm10.client set de_acronym = 'AMG' where client_identifier = 'Amgen';
commit;
Insert into tsm10.client_div select * from tsm_stage.client_div where id <> 0;
commit;
Insert into tsm10.protocol select * from tsm_stage.protocol;
commit;
Insert into tsm10.investig select * from tsm_stage.investig;
commit;
Insert into tsm10.payments select * from tsm_stage.payments;
commit;
Insert into tsm10.protocol_to_indmap select * from tsm_stage.protocol_to_indmap;
Insert into tsm10.report_template select * from tsm_stage.report_template;
Insert into tsm10.study_level_service_master select * from tsm_stage.study_level_service_master;
Insert into tsm10.study_level_service_inst select * from tsm_stage.study_level_service_inst;
Insert into tsm10.price_level select * from tsm_stage.price_level;
Insert into tsm10.pap_odc_pct select * from tsm_stage.pap_odc_pct;
Insert into tsm10.pap_odc_pct_to_indmap select * from tsm_stage.pap_odc_pct_to_indmap;
commit;
Insert into tsm10.procedure_to_protocol select * from tsm_stage.procedure_to_protocol;
commit;


Insert into tsm10.client_div_to_lic_country select * from tsm_stage.client_div_to_lic_country;
Insert into tsm10.client_div_to_lic_indmap select * from tsm_stage.client_div_to_lic_indmap;
Insert into tsm10.client_div_to_lic_phase select * from tsm_stage.client_div_to_lic_phase;
Insert into tsm10.client_div_to_build_code select * from tsm_stage.client_div_to_build_code;
commit;

declare

procdef_maxid number(10);
odcdef_maxid number(10);
mapper_maxid number(10);

cursor c1 is select id from tsm10.procedure_def where procedure_level = 'PatientOrVisit';
cursor c2 is select id from tsm10.procedure_def where procedure_level = 'PatientOrSite';
cursor c3 is select id from tsm10.odc_def where procedure_level = 'PatientOrVisit';
cursor c4 is select id from tsm10.odc_def where procedure_level = 'PatientOrSite';


begin

select max(id)+1 into procdef_maxid from tsm10.procedure_def;
select max(id)+1 into odcdef_maxid from tsm10.odc_def;
select max(id)+1 into mapper_maxid from tsm10.mapper;

for ix1 in c1 loop

  Insert into tsm10.procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Patient' from tsm10.procedure_def
  where id = ix1.id;

  Insert into tsm10.mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into tsm10.procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Visit' from tsm10.procedure_def
  where id = ix1.id;

  Insert into tsm10.mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;
 

 end loop;

for ix2 in c2 loop

  Insert into tsm10.procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Patient' from tsm10.procedure_def
  where id = ix2.id;

  Insert into tsm10.mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into tsm10.procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Site' from tsm10.procedure_def
  where id = ix2.id;

  Insert into tsm10.mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

end loop;

for ix3 in c3 loop

  Insert into tsm10.odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Patient', ADDED_IN_BUILD_ID,hide from tsm10.odc_def
  where id = ix3.id;

  Insert into tsm10.mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into tsm10.odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Visit', ADDED_IN_BUILD_ID,hide from tsm10.odc_def
  where id = ix3.id;

  Insert into tsm10.mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

end loop;

for ix4 in c4 loop

  Insert into tsm10.odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Patient', ADDED_IN_BUILD_ID,hide from tsm10.odc_def
  where id = ix4.id;

  Insert into tsm10.mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into tsm10.odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Site', ADDED_IN_BUILD_ID,hide from tsm10.odc_def
  where id = ix4.id;

  Insert into tsm10.mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

end loop;

commit;

end;
/

sho err

declare
  maxid number(10);
 begin
  select nvl(max(id),0)+1 into maxid from tsm10.build_tag;
  Insert into tsm10.build_tag values (maxid,sysdate,'New Build on :'||sysdate);
  commit;
end;
/

sho err


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  13   DevTSM    1.12        2/27/2008 3:16:39 PM Debashish Mishra  
--  12   DevTSM    1.11        3/3/2005 6:38:55 AM  Debashish Mishra  
--  11   DevTSM    1.10        8/29/2003 5:11:42 PM Debashish Mishra  
--  10   DevTSM    1.9         3/14/2002 4:04:38 PM Debashish Mishra  
--  9    DevTSM    1.8         3/8/2002 10:54:11 AM Debashish Mishra  
--  8    DevTSM    1.7         2/22/2002 6:35:25 PM Debashish Mishra  
--  7    DevTSM    1.6         2/21/2002 3:32:26 PM Debashish Mishra  
--  6    DevTSM    1.5         2/18/2002 5:07:11 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2002 3:10:05 PM  Debashish Mishra  
--  4    DevTSM    1.3         2/5/2002 2:54:44 PM  Debashish Mishra  
--  3    DevTSM    1.2         2/4/2002 6:16:48 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 6:18:51 PM Debashish Mishra  
--  1    DevTSM    1.0         1/23/2002 12:54:29 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

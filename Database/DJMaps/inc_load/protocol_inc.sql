--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: protocol_inc.sql$ 
--
-- $Revision: 11$        $Date: 4/9/2009 2:28:54 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
truncate table "&1".payments;
truncate table "&1".procedure_to_protocol;
truncate table "&1".protocol_to_indmap;
--truncate table "&1".STUDY_LEVEL_SERVICE_INST;
delete from "&1".investig;
commit;

--delete from "&1".study_level_service_master;
--commit;

alter table tsm_stage.protocol1 add countryid number(10);
alter table tsm_stage.protocol1 add build_code_id number(10);

update tsm_stage.protocol1 set countryid = (select id from "&1".country where
  tsm_stage.protocol1.country_id = "&1".country.abbreviation); 
commit;

update tsm_stage.protocol1 set build_code_id = (select id from "&1".build_code
   where "&1".build_code.code = tsm_stage.protocol1.client_id);
commit;

drop sequence seq1;

declare
  stmt varchar2(512);
  protocol_maxid number(10);

begin
 select nvl(max(id),0)+1 into protocol_maxid from "&1".protocol;
 stmt:='create sequence seq1 start with ' || protocol_maxid ;
 execute immediate(stmt);
end;
/

drop index tsm_stage.protocol1_index1;
drop index "&1".protocol_index1;

create index tsm_stage.protocol1_index1 on tsm_stage.protocol1 
    (picas_protocol, build_code_id) tablespace tsmsmall_indx pctfree 1;

create index "&1".protocol_index1 on "&1".protocol 
    (picas_protocol, build_code_id) tablespace tsmsmall_indx pctfree 1;
 

update "&1".protocol a set (COUNTRY_ID,DE_INTERNAL_ID,COMMENTS,                       
        PHASE_ID,PHASE1TYPE_ID,DOSING,INPATIENT_STATUS,AGE_RANGE,INPATIENT_DAYS,                 
        TOTAL_CONFINEMENT,HOURS_CONFINED,ADMIN_ROUTE,TOTAL_VISIT,STUDY_TYPE,
        STUDY_BLIND_TYPE,DURATION,DURATION_UNIT,CENTRAL_LAB_USED,ENTRY_DATE,                    
        ACTIVE_FLAG,COMPLETED_PATIENTS,RANDOMIZED_FLAG,TREATMENT_CYCLE_CNT,            
        STUDY_STRUCT_TYPE,NUM_TREATMENTS,SCREEN_DAYS,
	GROUP1_PRETREAT_DAYS,GROUP1_TREAT_DAYS,GROUP1_POST_TREAT_DAYS,
	GROUP2_TREAT_DAYS,GROUP2_POST_TREAT_DAYS ,
	GROUP3_TREAT_DAYS,GROUP3_POST_TREAT_DAYS,         
        GROUP4_TREAT_DAYS,GROUP4_POST_TREAT_DAYS,GROUP5_TREAT_DAYS,              
        GROUP5_POST_TREAT_DAYS,GROUP6_TREAT_DAYS,GROUP6_POST_TREAT_DAYS,         
        GROUP7_TREAT_DAYS,GROUP7_POST_TREAT_DAYS,GROUP8_TREAT_DAYS,             
        GROUP8_POST_TREAT_DAYS,GROUP9_TREAT_DAYS,GROUP9_POST_TREAT_DAYS,         
        GROUPA_TREAT_DAYS,GROUPA_POST_TREAT_DAYS,GROUP1_EXTENSION_EXISTS,        
        GROUP2_EXTENSION_EXISTS,GROUP3_EXTENSION_EXISTS,GROUP4_EXTENSION_EXISTS,        
        GROUP5_EXTENSION_EXISTS,GROUP6_EXTENSION_EXISTS,GROUP7_EXTENSION_EXISTS,        
        GROUP8_EXTENSION_EXISTS,GROUP9_EXTENSION_EXISTS,GROUPA_EXTENSION_EXISTS,        
        CENT_LAB_CONTRACT_EXISTS,CRO_LAB_CONTRACT_EXISTS,CENT_LAB_PRICE_MODEL,           
        EXTENSION_EXISTS,TREATMENT_CONTROL,DRUG,TITLE) = ( select             
        COUNTRYID,DE_INTERNAL_ID,COMMENTS,                       
        PHASE_ID,PHASE1TYPE_ID,DOSING,INPATIENT_STATUS,AGE_RANGE,INPATIENT_DAYS,                 
        TOTAL_CONFINEMENT,HOURS_CONFINED,ADMIN_ROUTE,TOTAL_VISIT,STUDY_TYPE,
        STUDY_BLIND_TYPE,DURATION,DURATION_UNIT,CENTRAL_LAB_USED,ENTRY_DATE,                    
        ACTIVE_FLAG,COMPLETED_PATIENTS,RANDOMIZED_FLAG,TREATMENT_CYCLE_CNT,            
        STUDY_STRUCT_TYPE,NUM_TREATMENTS,SCREEN_DAYS,GROUP1_PRETREAT_DAYS,           
        GROUP1_TREAT_DAYS,GROUP1_POST_TREAT_DAYS,GROUP2_TREAT_DAYS,
        GROUP2_POST_TREAT_DAYS ,GROUP3_TREAT_DAYS,GROUP3_POST_TREAT_DAYS,         
        GROUP4_TREAT_DAYS,GROUP4_POST_TREAT_DAYS,GROUP5_TREAT_DAYS,              
        GROUP5_POST_TREAT_DAYS,GROUP6_TREAT_DAYS,GROUP6_POST_TREAT_DAYS,         
        GROUP7_TREAT_DAYS,GROUP7_POST_TREAT_DAYS,GROUP8_TREAT_DAYS,             
        GROUP8_POST_TREAT_DAYS,GROUP9_TREAT_DAYS,GROUP9_POST_TREAT_DAYS,         
        GROUPA_TREAT_DAYS,GROUPA_POST_TREAT_DAYS,GROUP1_EXTENSION_EXISTS,        
        GROUP2_EXTENSION_EXISTS,GROUP3_EXTENSION_EXISTS,GROUP4_EXTENSION_EXISTS,        
        GROUP5_EXTENSION_EXISTS,GROUP6_EXTENSION_EXISTS,GROUP7_EXTENSION_EXISTS,        
        GROUP8_EXTENSION_EXISTS,GROUP9_EXTENSION_EXISTS,GROUPA_EXTENSION_EXISTS,        
        CENT_LAB_CONTRACT_EXISTS,CRO_LAB_CONTRACT_EXISTS,CENT_LAB_PRICE_MODEL,           
        EXTENSION_EXISTS,TREATMENT_CONTROL,DRUG,TITLE from tsm_stage.protocol1 b where 
        b.picas_protocol = a.picas_protocol and b.build_code_id = a.build_code_id)
        where exists (select 1 from tsm_stage.protocol1 c where
        c.picas_protocol = a.picas_protocol and c.build_code_id = a.build_code_id);
commit;



Insert into "&1".protocol select
      seq1.nextval, a.countryid,a.DE_INTERNAL_ID,a.PICAS_PROTOCOL,a.COMMENTS,a.PHASE_ID,                      
      a.PHASE1TYPE_ID,a.DOSING,a.INPATIENT_STATUS,a.AGE_RANGE,a.INPATIENT_DAYS,                 
      a.TOTAL_CONFINEMENT,a.HOURS_CONFINED,a.ADMIN_ROUTE,a.TOTAL_VISIT,                    
      a.STUDY_TYPE,a.STUDY_BLIND_TYPE,a.DURATION,a.DURATION_UNIT,                  
      a.CENTRAL_LAB_USED,a.ENTRY_DATE,a.ACTIVE_FLAG,a.COMPLETED_PATIENTS,             
      a.RANDOMIZED_FLAG,a.TREATMENT_CYCLE_CNT,a.STUDY_STRUCT_TYPE,              
      a.NUM_TREATMENTS,a.SCREEN_DAYS,                    
      a.GROUP1_PRETREAT_DAYS,a.GROUP1_TREAT_DAYS,a.GROUP1_POST_TREAT_DAYS,         
      a.GROUP2_TREAT_DAYS,a.GROUP2_POST_TREAT_DAYS,a.GROUP3_TREAT_DAYS,              
      a.GROUP3_POST_TREAT_DAYS,a.GROUP4_TREAT_DAYS,a.GROUP4_POST_TREAT_DAYS,         
      a.GROUP5_TREAT_DAYS,a.GROUP5_POST_TREAT_DAYS,a.GROUP6_TREAT_DAYS,              
      a.GROUP6_POST_TREAT_DAYS,a.GROUP7_TREAT_DAYS,a.GROUP7_POST_TREAT_DAYS,         
      a.GROUP8_TREAT_DAYS,a.GROUP8_POST_TREAT_DAYS,a.GROUP9_TREAT_DAYS,              
      a.GROUP9_POST_TREAT_DAYS,a.GROUPA_TREAT_DAYS,a.GROUPA_POST_TREAT_DAYS,         
      a.GROUP1_EXTENSION_EXISTS,a.GROUP2_EXTENSION_EXISTS,a.GROUP3_EXTENSION_EXISTS,        
      a.GROUP4_EXTENSION_EXISTS,a.GROUP5_EXTENSION_EXISTS,a.GROUP6_EXTENSION_EXISTS,        
      a.GROUP7_EXTENSION_EXISTS,a.GROUP8_EXTENSION_EXISTS,a.GROUP9_EXTENSION_EXISTS,        
      a.GROUPA_EXTENSION_EXISTS,a.CENT_LAB_CONTRACT_EXISTS,a.CRO_LAB_CONTRACT_EXISTS,        
      a.CENT_LAB_PRICE_MODEL,a.EXTENSION_EXISTS,a.TREATMENT_CONTROL,a.build_code_id,
      null,null,null,TITLE,null,DRUG, null
      from tsm_stage.protocol1 a where not exists
      ( select 1 from "&1".protocol b where b.picas_protocol = a.picas_protocol and
          b.build_code_id = a.build_code_id);

commit;


delete from "&1".protocol a where not exists ( select 1 from tsm_stage.protocol1 b 
 where b.picas_protocol = a.picas_protocol and b.build_code_id = a.build_code_id);
commit;

-- If the above statement fails, run the following ... Its actually a bad design.

--select id from "&1".protocol a where not exists ( select 1 from tsm_stage.protocol1 b
--where b.picas_protocol = a.picas_protocol and b.build_code_id = a.build_code_id);
-- Then use the protocol id to delete the following
--delete from <all master client schema>.TEMP_OVERHEAD where protocol_id=<protocol id from above>;
--delete from <all master client schema>.TEMP_ODC where protocol_id=<protocol id from above>;
-- Then try the delete statement again and it will succeed
   
drop index tsm_stage.protocol1_index1;
drop index "&1".protocol_index1;
drop sequence seq1;
      
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        4/9/2009 2:28:54 PM  Mahesh Pasupuleti Include
--       changes for complexity values.
--  10   DevTSM    1.9         2/27/2008 3:17:13 PM Debashish Mishra  
--  9    DevTSM    1.8         3/5/2007 7:28:30 PM  Debashish Mishra updated for
--       drug
--  8    DevTSM    1.7         2/7/2007 10:11:28 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:40:54 AM  Debashish Mishra  
--  6    DevTSM    1.5         7/30/2003 4:44:05 PM Debashish Mishra  
--  5    DevTSM    1.4         7/9/2003 5:10:32 PM  Debashish Mishra  
--  4    DevTSM    1.3         8/30/2002 12:43:15 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  3    DevTSM    1.2         4/25/2002 2:31:54 PM Debashish Mishra  
--  2    DevTSM    1.1         4/3/2002 6:58:10 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:12 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

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
-- $Revision: 5$        $Date: 2/27/2008 3:19:43 PM$
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
Delete from "&1".protocol;
commit;
--delete from "&1".study_level_service_master;
--commit;

Insert into "&1".protocol select
a.ID,b.ID,a.DE_INTERNAL_ID,a.PICAS_PROTOCOL,a.COMMENTS,a.PHASE_ID,                      
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
a.CENT_LAB_PRICE_MODEL,a.EXTENSION_EXISTS,a.TREATMENT_CONTROL,c.ID,
null,null,null,null,null   
from tsm_stage.protocol1 a, "&1".country b, "&1".build_code c
where a.country_id = b.abbreviation and
a.client_id = c.code;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:43 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:51 AM  Debashish Mishra  
--  3    DevTSM    1.2         7/30/2003 4:45:15 PM Debashish Mishra  
--  2    DevTSM    1.1         7/9/2003 5:10:41 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:07 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

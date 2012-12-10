--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: protocol.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:16:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Insert into protocol select
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
a.CENT_LAB_PRICE_MODEL,a.EXTENSION_EXISTS,a.TREATMENT_CONTROL,c.ID   
from protocol1 a, country b, build_code c
where a.country_id = b.abbreviation and
a.client_id = c.code;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:16:43 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:39:18 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:12:02 PM Debashish Mishra  
--  5    DevTSM    1.4         2/12/2002 12:19:58 PMDebashish Mishra  
--  4    DevTSM    1.3         2/7/2002 3:10:13 PM  Debashish Mishra  
--  3    DevTSM    1.2         2/5/2002 2:54:47 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:53 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/8/2002 6:37:19 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

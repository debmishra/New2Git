--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_activity_detail.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:52 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 


alter table tsm_stage.cro_activity_detail1 add cro_category_id number(10);

update tsm_stage.cro_activity_detail1 a set a.cro_category_id=
  (select b.id from "&1".cro_category b where b.category_account=a.act_id); 
commit;

insert into "&1".cro_activity_detail (id,CRO_CATEGORY_ID,SUB_TXT,CHOICE_TEXT,DECIMALS,INPUT,USE_DATA,DEFAULT_VAL,SUB_ID,         
CHOICE_ID) select id, CRO_CATEGORY_ID,SUB_TXT,CHOICE_TEX,USE_DEC,INPUT,nvl(USE_DATA,0),DEFAULT_val1, SUB_ID,CHOICE_ID 
from tsm_stage.cro_activity_detail1;
commit; 

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:52 PM Debashish Mishra  
--  3    DevTSM    1.2         11/10/2006 12:29:44 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:06:59 PMDebashish Mishra  
--  1    DevTSM    1.0         9/28/2006 12:13:29 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------
          
--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_cost_overlap.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:53 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 


drop sequence tsm_stage.cro_cost_overlap_seq;
create sequence tsm_stage.cro_cost_overlap_seq;


insert into "&1".cro_cost_overlap (id,CRO_COST_ID,CRO_CATEGORY_ID,other)
 select tsm_stage.cro_cost_overlap_seq.nextval,a.id,null, a.overlapw from tsm_stage.cro_cost1 a, "&1".cro_cost b
 WHERE a.overlap = 1 AND a.overlapw IS NOT null and a.id = b.id ;
commit;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:53 PM Debashish Mishra  
--  3    DevTSM    1.2         11/10/2006 12:29:46 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:07:01 PMDebashish Mishra  
--  1    DevTSM    1.0         9/28/2006 12:13:30 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

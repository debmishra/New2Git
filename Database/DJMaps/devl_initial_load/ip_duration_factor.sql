--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_duration_factor.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:16:40 PM$
--
--
-- Description:  ip_duration_factor
--
---------------------------------------------------------------------
 
DROP SEQUENCE IP_DURATION_FACTOR_SEQ;
CREATE SEQUENCE IP_DURATION_FACTOR_SEQ;

Insert into ip_duration_factor select ip_duration_factor_seq.nextval,
c.id,r.phase2,r.phase3,r.y3phase2,r.y3phase3 from country c,
ratio r where r.country = c.abbreviation;

--update ip_duration_factor set PHASE2_FACTOR = null where PHASE2_FACTOR = -1;
--update ip_duration_factor set PHASE3_FACTOR = null where PHASE3_FACTOR = -1;
--update ip_duration_factor set Y3PHASE2_FACTOR = null where Y3PHASE2_FACTOR = -1;
--update ip_duration_factor set Y3PHASE2_FACTOR = null where Y3PHASE2_FACTOR = -1;

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:16:40 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:39:00 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:11:48 PM Debashish Mishra  
--  3    DevTSM    1.2         3/18/2002 7:42:19 PM Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:48 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/8/2002 6:37:16 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

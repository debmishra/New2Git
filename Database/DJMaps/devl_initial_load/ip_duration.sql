--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_duration.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:16:40 PM$
--
--
-- Description:  ip_duration
--
---------------------------------------------------------------------

DROP SEQUENCE IP_DURATION_SEQ;
CREATE SEQUENCE IP_DURATION_SEQ;

--update cppyear set low1year = null where low1year = -1;
--update cppyear set mid1year = null where mid1year = -1;
--update cppyear set high1year = null where high1year = -1;
--update cppyear set low2year = null where low2year = -1;
--update cppyear set mid2year = null where mid2year = -1;
--update cppyear set high2year = null where high2year = -1;
--update cppyear set low3year = null where low3year = -1;
--update cppyear set mid3year = null where mid3year = -1;
--update cppyear set high3year = null where high3year = -1;
--commit;

Insert into ip_duration select ip_duration_seq.nextval, d.phase,
i.id,LOW1YEAR,MID1YEAR,HIGH1YEAR,LOW2YEAR,MID2YEAR,HIGH2YEAR,
LOW3YEAR,MID3YEAR,HIGH3YEAR from cppyear d, indmap i where
d.INDICATION= i.code ;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:16:40 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:39:00 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:11:47 PM Debashish Mishra  
--  3    DevTSM    1.2         3/18/2002 7:42:18 PM Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:48 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/8/2002 6:37:16 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

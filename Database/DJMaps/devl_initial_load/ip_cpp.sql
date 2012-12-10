--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_cpp.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:16:40 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

DROP SEQUENCE IP_CPP_SEQ;
CREATE SEQUENCE IP_CPP_SEQ;

insert into ip_cpp select ip_cpp_seq.nextval,c.phase,i.id,LOW,
MED,HIGH,SLOPE,INTERCEPT,CLOW,CMED,CHIGH,CSLOPE,CINTERCEPT,
OLOW,OMED,OHIGH,OSLOPE,OINTERCEPT,c.cpv,
decode(status,'I','Inpatient','O','Outpatient')
from cpp c,indmap i where
c.indcode = i.code and i.de_code is null;

--update ip_cpp set OLOW = null where olow = -1;
--update ip_cpp set OMID = null where OMID = -1;
--update ip_cpp set OHIGH = null where OHIGH = -1;
--update ip_cpp set OSLOPE = null where OSLOPE = -1;
--update ip_cpp set OINTERCEPT = null where OINTERCEPT = -1;
--update ip_cpp set CPV = null where CPV = -1;
--update ip_cpp set LOW = null where low = -1;
--update ip_cpp set MID = null where MID = -1;
--update ip_cpp set HIGH = null where HIGH = -1;
--update ip_cpp set SLOPE = null where SLOPE = -1;
--update ip_cpp set INTERCEPT = null where INTERCEPT = -1;
--update ip_cpp set CLOW = null where clow = -1;
--update ip_cpp set CMID = null where cMID = -1;
--update ip_cpp set CHIGH = null where cHIGH = -1;
--update ip_cpp set CSLOPE = null where cSLOPE = -1;
--update ip_cpp set CINTERCEPT = null where cINTERCEPT = -1;






commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:16:40 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:38:59 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:11:46 PM Debashish Mishra  
--  5    DevTSM    1.4         3/18/2002 7:42:17 PM Debashish Mishra  
--  4    DevTSM    1.3         1/28/2002 3:16:05 PM Debashish Mishra  
--  3    DevTSM    1.2         1/24/2002 5:01:19 PM Debashish Mishra problem of
--       -1's solved
--  2    DevTSM    1.1         1/23/2002 12:53:47 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/8/2002 6:37:15 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

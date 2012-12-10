--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_after_picase_beta_4patch#1.sql$ 
--
-- $Revision: 5$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  changes to production after first patch
--
---------------------------------------------------------------------
 
--Following chnages are as per the request of Joel on 06/16/2002 at 11am


update "&1".country set name = 'Russia, Estonia, Latvia, Lithuania' 
where abbreviation='FSU';
commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/22/2008 11:56:01 AMDebashish Mishra  
--  4    DevTSM    1.3         9/19/2006 12:11:29 AMDebashish Mishra   
--  3    DevTSM    1.2         3/2/2005 10:51:02 PM Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:17:44 PM Debashish Mishra  
--  1    DevTSM    1.0         7/2/2002 1:26:02 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

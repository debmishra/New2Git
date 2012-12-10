--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4GM2dot0.sql$ 
--
-- $Revision: 5$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

conn ft15/****@????


--Following changes are as per the discussion with Gary on 08/12/2004 at 16:11
 
Alter table trial modify (PROTOCOL_IDENTIFIER varchar2(300));


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/22/2008 11:56:00 AMDebashish Mishra  
--  4    DevTSM    1.3         9/19/2006 12:11:23 AMDebashish Mishra   
--  3    DevTSM    1.2         3/2/2005 10:50:57 PM Debashish Mishra  
--  2    DevTSM    1.1         8/17/2004 9:18:14 AM Debashish Mishra  
--  1    DevTSM    1.0         8/8/2004 4:12:26 AM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

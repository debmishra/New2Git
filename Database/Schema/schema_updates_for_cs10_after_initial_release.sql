--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_cs10_after_initial_release.sql$ 
--
-- $Revision: 3$        $Date: 2/22/2008 11:56:03 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
insert into person values (person_seq.nextval,'Ophthalmologist');
commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/22/2008 11:56:03 AMDebashish Mishra  
--  2    DevTSM    1.1         9/19/2006 12:11:35 AMDebashish Mishra   
--  1    DevTSM    1.0         8/19/2005 6:24:50 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

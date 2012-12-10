--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_client_inserts.sql$ 
--
-- $Revision: 2$        $Date: 2/27/2008 3:17:45 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 

insert into mapper select * from "&1".mapper;
commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  2    DevTSM    1.1         2/27/2008 3:17:45 PM Debashish Mishra  
--  1    DevTSM    1.0         11/7/2006 1:59:33 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

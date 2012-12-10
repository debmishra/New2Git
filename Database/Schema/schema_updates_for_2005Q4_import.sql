--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2005Q4_import.sql$ 
--
-- $Revision: 3$        $Date: 2/22/2008 11:56:02 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update "&1".country set currency_id=4 where id=70;
delete from "&1".currency where id=55;

commit;

update "&1".country set currency_id=10 where id=72;
delete from "&1".currency where id=57;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/22/2008 11:56:02 AMDebashish Mishra  
--  2    DevTSM    1.1         9/19/2006 12:11:31 AMDebashish Mishra   
--  1    DevTSM    1.0         10/26/2005 3:43:55 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

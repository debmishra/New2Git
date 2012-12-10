--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_temp_protocol.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Insert into "&1".temp_protocol select * from tsm_stage.temp_protocol;
Insert into "&1".temp_protocol select * from tsm_stage.temp_protocol1;

commit;

delete from "&1".temp_protocol where rowid in
(select min(rowid) from "&1".temp_protocol where
ENTRY_CRITERIA = 'Healthy subjects' group by CODE having count(*) > 1);

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:09 PM Debashish Mishra  
--  4    DevTSM    1.3         2/7/2007 10:28:16 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:40:37 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:13:22 PM Debashish Mishra  
--  1    DevTSM    1.0         3/26/2003 10:04:32 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_rate_set.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:17:30 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Insert into rate_set(ID,NAME,CLIENT_DIV_ID,COUNTRY_ID,DEFAULT_FLG)
values(1,'Industry Standards',null,null,1);

commit; 





exit;        

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:17:30 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:31:40 AM  Debashish Mishra  
--  3    DevTSM    1.2         6/5/2002 8:40:27 AM  Debashish Mishra Changes for
--       exit at the end
--  2    DevTSM    1.1         5/23/2002 5:25:52 PM Debashish Mishra  
--  1    DevTSM    1.0         5/17/2002 1:57:04 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

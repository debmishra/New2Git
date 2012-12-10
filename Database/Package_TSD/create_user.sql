--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: create_user.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


drop user ft15 cascade;
drop user tsm10 cascade;
drop user ftcommon cascade;

create user ft15 identified by welcome default tablespace
ftsmall temporary tablespace temp;
create user tsm10 identified by welcome default tablespace
tsmsmall temporary tablespace temp;
create user ftcommon identified by welcome default tablespace
tsmsmall temporary tablespace temp;

grant connect,resource to ft15;
grant connect,resource to tsm10;
grant connect,resource to ftcommon;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:51 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:49 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

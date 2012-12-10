--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ftcommon_tables.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create table application(
	id number(10),
	app_name varchar2(50),
	external_name varchar2(80),
	short_desc varchar2(128))
	tablespace tsmsmall
	pctused 80 pctfree 10;








exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:56 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:53 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

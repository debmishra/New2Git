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
-- $Revision: 5$        $Date: 2/22/2008 11:55:25 AM$
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
--  5    DevTSM    1.4         2/22/2008 11:55:25 AMDebashish Mishra  
--  4    DevTSM    1.3         9/19/2006 12:11:01 AMDebashish Mishra   
--  3    DevTSM    1.2         3/2/2005 10:48:56 PM Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:15:47 PM Debashish Mishra  
--  1    DevTSM    1.0         9/16/2002 3:46:47 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

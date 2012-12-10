--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ftcommon_required_data.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Insert into application values
(1,'TRACE','TrialSpace Resource and Cost Estimator',null);
Insert into application values
(2,'PICASE','TrialSpace Grants Manager',null);
Insert into ftcommon.application(ID,APP_NAME,EXTERNAL_NAME) values
(3,'TSPD','TrialSpace Designer');

commit;	







exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:55 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:53 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

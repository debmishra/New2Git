--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_milestone_template.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into milestone_template (ID,NAME,SEQUENCE) values
--('||ID||','||decode(name,null,'null',
--''''||name||'''')||','||decode(SEQUENCE,null,'null',SEQUENCE)||');'
--from milestone_template;


Insert into milestone_template (ID,NAME,SEQUENCE) values
(1,'StartDt',1);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(2,'FirstPtEnrolled',2);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(3,'LastSiteInit',3);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(4,'LastPtEnrolled',4);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(5,'LastPtComp',5);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(6,'DbaseClosed',6);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(7,'DraftReport',7);

Insert into milestone_template (ID,NAME,SEQUENCE) values
(8,'EndReport',8);




exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:08 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:58 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:55 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

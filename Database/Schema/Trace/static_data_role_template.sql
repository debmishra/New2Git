--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_role_template.sql$ 
--
-- $Revision: 11$        $Date: 2/27/2008 3:17:30 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
--('||ID||','||decode(name,null,'null',
--''''||name||'''')||','||decode(CATEGORY,null,'null',''''||CATEGORY||'''')||','||
--decode(SEQUENCE,null,'null',SEQUENCE)||');'
--from role_template;


Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(1,'PA_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(2,'MM_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(3,'PM_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(4,'CO_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(5,'DM_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(6,'ST_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(7,'MW_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(8,'RA_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(12,'CO_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(10,'IT_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(11,'PA_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(13,'DM_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(14,'ST_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(15,'MW_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(16,'RA_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(17,'SF_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(18,'PM_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(19,'Snr_CRA','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(20,'CRA','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(21,'PA_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(22,'MM_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(23,'PM_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(24,'DM_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(25,'MW_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(26,'RA_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(27,'SF_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(28,'IT_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(29,'DM_SrDataCoord','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(30,'DM_DataCoord','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(32,'ST_SrStats','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(33,'ST_Stats','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(34,'MW_SrMedWriter','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(35,'MW_MedWriter','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(36,'RA_Auditor','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(37,'RA_QCTech','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(38,'SF_SrSafety','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(39,'SF_Safety','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(40,'IT_SrProg','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(41,'IT_Prog','Associate',4);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(42,'IT_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(43,'CO_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(44,'ST_Admin','Admin',5);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(45,'SF_VP','Snr Staff',1);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(46,'MM_PM','Mgr',2);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(47,'MM_Mgr','Snr Associate',3);

Insert into role_template (ID,NAME,CATEGORY,SEQUENCE) values
(48,'DM_DataEntry','Admin',5);


exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/27/2008 3:17:30 PM Debashish Mishra  
--  10   DevTSM    1.9         3/3/2005 6:31:41 AM  Debashish Mishra  
--  9    DevTSM    1.8         5/17/2002 2:12:38 PM Debashish Mishra Modified the
--       initial sql in the comment section
--  8    DevTSM    1.7         5/17/2002 1:54:07 PM Kelly Kingdon   fixed
--       misspelled name and added sequence.
--  7    DevTSM    1.6         4/30/2002 7:27:34 AM Kelly Kingdon   added
--       DM_DataEntry
--  6    DevTSM    1.5         4/29/2002 2:52:13 PM Kelly Kingdon   added 2 more
--       med managment roles
--  5    DevTSM    1.4         4/26/2002 4:59:37 PM Debashish Mishra Modified for
--       the name changes
--  4    DevTSM    1.3         4/15/2002 3:26:19 PM Debashish Mishra  
--  3    DevTSM    1.2         3/13/2002 5:09:02 PM Debashish Mishra  
--  2    DevTSM    1.1         3/13/2002 1:03:49 PM Debashish Mishra  
--  1    DevTSM    1.0         3/12/2002 4:39:39 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

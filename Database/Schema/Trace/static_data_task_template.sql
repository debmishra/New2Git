--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_task_template.sql$ 
--
-- $Revision: 17$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,         
--START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values 
--('||ID||','||decode(name,null,'null',''''||name||'''')||','||  
--decode(SEQUENCE,null,'null',SEQUENCE)||','||
--decode(TASK_GROUP_TEMPLATE_ID,null,'null',TASK_GROUP_TEMPLATE_ID)||','||
--decode(START_MILESTONE_TEMPLATE_ID,null,'null',START_MILESTONE_TEMPLATE_ID)||','||
--decode(END_MILESTONE_TEMPLATE_ID,null,'null',END_MILESTONE_TEMPLATE_ID)||');'
--from task_template;

set define off

---  Project Administration

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(1,'InvestCntrctNegot',1,1,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(2,'GrantAdmin',2,1,2,6);

--  Medical Management

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(3,'MedMonitoring',1,2,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(4,'RevLabData',2,2,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(5,'RevOthData',3,2,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(6,'InterpTestRes',4,2,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(7,'PrepOfRep',5,2,2,6);

-- Project Management

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(8,'StsReporting',1,3,1,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(9,'EnrollTrcking',2,3,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(10,'SumRptTrcking',3,3,1,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(11,'TeleContLogging',4,3,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(12,'CentralLab',5,3,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(13,'CentralLabOng',6,3,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(14,'CentralIRB',7,3,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(15,'CentralIRBOng',8,3,2,6);


Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(16,'PrintFulfSvcs',9,3,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(17,'PrintFulfSvcsOng', 10,3,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(18,'DrugSupMng',11,3,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(19,'DrugSupMngOng',12,3,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(20,'OtherVendors',13,3,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(21,'OtherVendorsOng',14,3,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(22,'CrStudyNews',15,3,2,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(23,'CrStudyNewsOng',16,3,3,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(24,'MtgsSubCont',17,3,1,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(25,'IntProjTeamMtgs',18 ,3 ,1 ,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(26,'ConfClientAndInvest',19,3,1,8);


-- Clinical Operations

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(27,'ProtPrep',1,4,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(28,'InvestRecrAdmin',2,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(29,'OthPreStudyDocPrep',3,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(30,'WriteICF',4,4,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(31,'SiteMonitPreStudy',5,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(32,'CRFPrep',6,4,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(33,'RegDocPrep',7,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(34,'InvestMtg',8,4,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(35,'SiteMonitInit',9,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(36,'MaintWorkFiles',10,4,1,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(37,'SiteMonitRoutine',11,4,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(38,'SiteMonitCloseout',13,4,5,6);

-- Data Management

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(39,'DataMngPlan',1,5,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(40,'DbaseDesSetup',2,5,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(41,'CRFGeneral',3,5,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(42,'DataMngAdmin',4,5, 2 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(43,'CRFTracking',5,5, 2 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(44,'DataEntry',6,5, 2 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(45,'Coding',7,5, 2 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(46,'QueryMng',8,5, 2 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(47,'CRFDataCleanup',9,5, 2 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(48,'QC',10,5, 5 ,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(49,'DbaseCloseout',11,5, 5 ,6);

-- Stats 

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(50, 'StatPlan',1,6,1,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(51,'DesignShells',2,6,1,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(52,'GenAnalysis',3,6,6,7);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(53,'StatRep',4,6,6,8);

-- Medical Writing and Informatics

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(54,'PrepFinalInvestBrochure',1,7,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(55,'WriteClinRep',2,7,6,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(56,'RevClinRep',3,7,7,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(57,'Manuscript',4,7,7,8);

-- Reg.  Affairs / Compliance Services

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(58,'MaintCentFiles',1,8,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(59,'MaintCentFilesOng',2,8,3,8);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(60,'SiteAuditing',3,8,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(61,'DataQASup',4,8,2,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(62,'DataQA',5,8,2,7);

-- Safety

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(63,'FDAAnnRep',1,9,1,8);

-- Imformation Technology

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(64,'IVR',1,10,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(65,'IVRMaint',2,10,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(66,'WebPortal',3,10,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(67,'WebPortalMaint',4,10,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(68,'CrImageFiles',5,10,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(69,'CrImageFilesOng',6,10,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(70,'DbaseMng',7,10,1,2);

-------------------------------------------------------
-- Miscellaneous tasks
-------------------------------------------------------

-- Project Admin
Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(71,'MiscPlanning',4,1,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(72,'MiscInvRecruit',5,1,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(73,'MiscSiteContr',6,1,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(74,'MiscPatEnroll',7,1,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(75,'MiscTreatment',8,1,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(76,'MiscSiteCloseout',9,1,5,6);

-- Medical Management

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(77,'MiscPlanning',6,2,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(78,'MiscInvRecruit',7,2,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(79,'MiscPatEnroll',8,2,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(80,'MiscTreatment',9,2,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(81,'MiscSiteCloseout',10,2,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(82,'MiscAnalysis',11,2,6,7);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(83,'MiscRepGen',12,2,6,8);


-- Project Management

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(84,'MiscPlanning',20,3,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(85,'MiscInvRecruit',21,3,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(86,'MiscSiteContr',22,3,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(87,'MiscPatEnroll',23,3,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(88,'MiscTreatment',24,3,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(89,'MiscSiteCloseout',25,3,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(90,'MiscRepGen',26,3,6,8);

-- Clin Ops


Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(91,'MiscPlanning',14,4,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(92,'MiscInvRecruit',15,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(93,'MiscSiteContr',16,4,1,3);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(94,'MiscPatEnroll',17,4,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(95,'MiscTreatment',18,4,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(96,'MiscSiteCloseout',19,4,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(97,'MiscRepGen',20,4,6,8);


-- Data Management

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(98,'MiscPlanning',12,5,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(99,'MiscTreatment',13,5,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(100,'MiscSiteCloseout',14,5,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(101,'MiscDBQA',15,5,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(102,'MiscAnalysis',16,5,6,7);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(103,'MiscRepGen',17,5,6,8);

-- Stats

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(104,'MiscPlanning',5,6,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(105,'MiscDBQA',6,6,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(106,'MiscAnalysis',7,6,6,7);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(107,'MiscRepGen',8,6,6,8);

-- Medical Writing & Informatics

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(108,'MiscPlanning',6,7,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(109,'MiscAnalysis',7,7,6,7);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(110,'MiscRepGen',8,7,6,8);

-- Reg Affairs

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(111,'MiscPlanning',6,8,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(112,'MiscSiteCloseout',7,8,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(113,'MiscRepGen',8,8,6,8);


-- Safety
Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(114,'MiscPlanning',2,9,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(115,'MiscTreatment',3,9,2,5);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(116,'MiscSiteCloseout',4,9,5,6);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(117,'MiscAnalysis',5,9,6,7);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(118,'MiscRepGen',6,9,6,8);

-- IT

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(119,'MiscPlanning',8,10,1,2);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(120,'MiscPatEnroll',9,10,2,4);

Insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID,
START_MILESTONE_TEMPLATE_ID,END_MILESTONE_TEMPLATE_ID) values
(121,'MiscSiteCloseout',10,10,5,6);




insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID, 
START_MILESTONE_TEMPLATE_ID, END_MILESTONE_TEMPLATE_ID) values
(122, 'QueryResolution', 12, 4, 2, 6);

insert into task_template (ID,NAME,SEQUENCE,TASK_GROUP_TEMPLATE_ID, 
START_MILESTONE_TEMPLATE_ID, END_MILESTONE_TEMPLATE_ID) values
(123, 'DocumentCollection', 3, 1, 1, 5);



set define on

exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  17   DevTSM    1.16        2/27/2008 3:17:31 PM Debashish Mishra  
--  16   DevTSM    1.15        3/3/2005 6:31:44 AM  Debashish Mishra  
--  15   DevTSM    1.14        10/9/2002 4:50:38 PM Debashish Mishra  
--  14   DevTSM    1.13        10/2/2002 5:17:30 PM Debashish Mishra Updated
--       task_template set end milestone=7 where id=62
--  13   DevTSM    1.12        10/2/2002 10:05:39 AMDebashish Mishra updated start
--       and end milestone id to 6,7 for id's = 82,102,106,109,117 id's 52,101,105
--       remains unchanged.
--  12   DevTSM    1.11        9/30/2002 5:00:44 PM Debashish Mishra Updated 
--       task_template static data 
--  11   DevTSM    1.10        9/17/2002 9:17:06 AM Debashish Mishra Update to
--       task_template
--  10   DevTSM    1.9         8/7/2002 12:13:03 PM Debashish Mishra changes for
--       Peter
--  9    DevTSM    1.8         6/13/2002 11:52:14 AMDebashish Mishra all changes
--       after picas-e beta
--  8    DevTSM    1.7         5/30/2002 8:38:19 AM Kelly Kingdon   added misc
--       tasks and rtt for misc tasks.
--  7    DevTSM    1.6         5/1/2002 8:34:39 AM  Kelly Kingdon   fixed sql
--       syntax errors
--  6    DevTSM    1.5         4/30/2002 11:39:23 AMPeter Abramowitsch Added
--       misssing comma
--  5    DevTSM    1.4         4/29/2002 2:52:27 PM Kelly Kingdon   chnaged task
--       descriptions to dbkeys
--  4    DevTSM    1.3         4/29/2002 12:22:29 PMPeter Abramowitsch added all
--       tasks
--  3    DevTSM    1.2         4/17/2002 3:48:00 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2002 3:26:20 PM Debashish Mishra  
--  1    DevTSM    1.0         3/12/2002 4:39:40 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

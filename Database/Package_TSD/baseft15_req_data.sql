--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_req_data.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Create required default data.
--
---------------------------------------------------------------------
 
insert into Site (ID, site_identifier, name,time_zone_id,locale) values
(0, '0','FastTrack','PST','ENG');

insert into HandHeld_Group values
(1, 'DEFAULT', 0, '1234');

insert into Stage values
(1, 'Recurrent', 'Recurrent');
insert into Stage values
(2, 'Inflammatory', 'Inflammatory');
insert into Stage values
(3, 'Extensive', 'Extensive');
insert into Stage values
(4, 'Limited', 'Limited');
insert into Stage values
(5, 'IV', 'Stage IV');
insert into Stage values
(6, 'IVb', 'Stage IVb');
insert into Stage values
(7, 'IVa', 'Stage IVa');
insert into Stage values
(8, 'IIIb', 'Stage III');
insert into Stage values
(9, 'IIIa', 'Stage III');
insert into Stage values
(10, 'III', 'Stage III');
insert into Stage values
(13, 'II', 'Stage II');
insert into Stage values
(14, 'I', 'Stage I');
insert into Stage values
(15, 'O', 'Stage O');
insert into Stage values
(16, 'in situ', 'in situ');
insert into Stage values
(17, 'Occult', 'Occult');
insert into Stage values
(18, 'Not applicable', 'N/A');
insert into Stage values
(19, 'Metastatic', 'Metastatic');
insert into Stage values
(20, 'Hormone refractory', 'Hormone refractory');
insert into Stage values
(21, 'Locally advanced', 'Locally advanced');
insert into Stage values
(22, 'Unresectable', 'Unresectable');
insert into Stage values
(23, 'All trials', 'All trials');

insert into Disease values
(1, 'Bladder cancer');
insert into Disease values
(2, 'BMT-treated cancer');
insert into Disease values
(3, 'Brain metastases');
insert into Disease values
(4, 'Breast cancer');
insert into Disease values
(5, 'Colorectal cancer');
insert into Disease values
(6, 'Diarrhea');
insert into Disease values
(7, 'Kidney (renal cell) cancer');
insert into Disease values
(8, 'Lung cancer (non-small cell)');
insert into Disease values
(9, 'Lung cancer (small cell)');
insert into Disease values
(10, 'Melanoma');
insert into Disease values
(11, 'Mucositis / stomatitis');
insert into Disease values
(12, 'Myeloma');
insert into Disease values
(13, 'Nausea / vomiting');
insert into Disease values
(14, 'Ovarian cancer');
insert into Disease values
(15, 'Pancreatic cancer');
insert into Disease values
(16, 'Prostate cancer');
insert into Disease values
(17, 'Solid tumor');
insert into Disease values
(18, 'Unspecified cancer');
insert into Disease values
(19, 'Urethral cancer');

REM Bladder Cancer
insert into Disease_to_Stage values (1,23,1);
insert into Disease_to_Stage values (1,1,2);
insert into Disease_to_Stage values (1,5,3);
insert into Disease_to_Stage values (1,10,4);
insert into Disease_to_Stage values (1,13,5);
insert into Disease_to_Stage values (1,14,6);
insert into Disease_to_Stage values (1,18,7);

REM BMT-treated Cancer
insert into Disease_to_Stage values (2,23,1);
insert into Disease_to_Stage values (2,20,2);
insert into Disease_to_Stage values (2,19,3);
insert into Disease_to_Stage values (2,1,4);
insert into Disease_to_Stage values (2,21,5);
insert into Disease_to_Stage values (2,22,6);
insert into Disease_to_Stage values (2,2,7);
insert into Disease_to_Stage values (2,3,8);
insert into Disease_to_Stage values (2,4,9);
insert into Disease_to_Stage values (2,6,10);
insert into Disease_to_Stage values (2,7,11);
insert into Disease_to_Stage values (2,5,12);
insert into Disease_to_Stage values (2,8,13);
insert into Disease_to_Stage values (2,9,14);
insert into Disease_to_Stage values (2,10,15);
insert into Disease_to_Stage values (2,13,16);
insert into Disease_to_Stage values (2,14,17);
insert into Disease_to_Stage values (2,15,18);
insert into Disease_to_Stage values (2,16,19);
insert into Disease_to_Stage values (2,17,20);
insert into Disease_to_Stage values (2,18,21);

REM  Brain metastases
insert into Disease_to_Stage values (3,23,1);

REM Breast Cancer
insert into Disease_to_Stage values (4,23,1);
insert into Disease_to_Stage values (4,19,2);
insert into Disease_to_Stage values (4,1,3);
insert into Disease_to_Stage values (4,2,4);
insert into Disease_to_Stage values (4,21,5);
insert into Disease_to_Stage values (4,22,6);
insert into Disease_to_Stage values (4,5,7);
insert into Disease_to_Stage values (4,8,8);
insert into Disease_to_Stage values (4,9,9);
insert into Disease_to_Stage values (4,10,10);
insert into Disease_to_Stage values (4,13,11);
insert into Disease_to_Stage values (4,14,12);
insert into Disease_to_Stage values (4,16,13);
insert into Disease_to_Stage values (4,18,14);

REM  Colorectal cancer 
insert into Disease_to_Stage values (5,23,1);
insert into Disease_to_Stage values (5,19,2);
insert into Disease_to_Stage values (5,1,3);
insert into Disease_to_Stage values (5,21,4);
insert into Disease_to_Stage values (5,22,5);
insert into Disease_to_Stage values (5,5,6);
insert into Disease_to_Stage values (5,10,7);
insert into Disease_to_Stage values (5,13,8);
insert into Disease_to_Stage values (5,14,9);
insert into Disease_to_Stage values (5,15,10);
insert into Disease_to_Stage values (5,18,11);

REM  Diarrhea
insert into Disease_to_Stage values (6,23,1);

REM  kidney
insert into Disease_to_Stage values (7,23,1);
insert into Disease_to_Stage values (7,1,2);
insert into Disease_to_Stage values (7,5,3);
insert into Disease_to_Stage values (7,10,4);
insert into Disease_to_Stage values (7,13,5);
insert into Disease_to_Stage values (7,14,6);
insert into Disease_to_Stage values (7,18,7);

REM  Lung cancer (non-small cell)
insert into Disease_to_Stage values (8,23,1);
insert into Disease_to_Stage values (8,19,2);
insert into Disease_to_Stage values (8,1,3);
insert into Disease_to_Stage values (8,21,4);
insert into Disease_to_Stage values (8,22,5);
insert into Disease_to_Stage values (8,5,6);
insert into Disease_to_Stage values (8,8,7);
insert into Disease_to_Stage values (8,9,8);
insert into Disease_to_Stage values (8,10,9);
insert into Disease_to_Stage values (8,13,10);
insert into Disease_to_Stage values (8,14,11);
insert into Disease_to_Stage values (8,15,12);
insert into Disease_to_Stage values (8,17,13);
insert into Disease_to_Stage values (8,18,14);

REM  Lung cancer (small cell)
insert into Disease_to_Stage values (9,23,1);
insert into Disease_to_Stage values (9,1,2);
insert into Disease_to_Stage values (9,3,3);
insert into Disease_to_Stage values (9,4,4);
insert into Disease_to_Stage values (9,18,5);

REM  Melanoma
insert into Disease_to_Stage values (10,23,1);
insert into Disease_to_Stage values (10,19,2);
insert into Disease_to_Stage values (10,1,3);
insert into Disease_to_Stage values (10,21,4);
insert into Disease_to_Stage values (10,5,5);
insert into Disease_to_Stage values (10,10,6);
insert into Disease_to_Stage values (10,13,7);
insert into Disease_to_Stage values (10,14,8);
insert into Disease_to_Stage values (10,18,9);

REM  Mucositis
insert into Disease_to_Stage values (11,23,1);

REM  Myeloma
insert into Disease_to_Stage values (12,23,1);

REM  Nausea
insert into Disease_to_Stage values (13,23,1);

REM  OVarian
insert into Disease_to_Stage values (14,23,1);
insert into Disease_to_Stage values (14,19,2);
insert into Disease_to_Stage values (14,1,3);
insert into Disease_to_Stage values (14,21,4);
insert into Disease_to_Stage values (14,5,5);
insert into Disease_to_Stage values (14,10,6);
insert into Disease_to_Stage values (14,13,7);
insert into Disease_to_Stage values (14,14,8);
insert into Disease_to_Stage values (14,18,9);

REM  Pancreatic
insert into Disease_to_Stage values (15,23,1);
insert into Disease_to_Stage values (15,19,2);
insert into Disease_to_Stage values (15,1,3);
insert into Disease_to_Stage values (15,21,4);
insert into Disease_to_Stage values (15,22,5);
insert into Disease_to_Stage values (15,6,6);
insert into Disease_to_Stage values (15,7,7);
insert into Disease_to_Stage values (15,5,8);
insert into Disease_to_Stage values (15,10,9);
insert into Disease_to_Stage values (15,13,10);
insert into Disease_to_Stage values (15,14,11);
insert into Disease_to_Stage values (15,18,12);

REM  Prostate
insert into Disease_to_Stage values (16,23,1);
insert into Disease_to_Stage values (16,20,2);
insert into Disease_to_Stage values (16,19,3);
insert into Disease_to_Stage values (16,1,4);
insert into Disease_to_Stage values (16,21,5);
insert into Disease_to_Stage values (16,5,6);
insert into Disease_to_Stage values (16,10,7);
insert into Disease_to_Stage values (16,13,8);
insert into Disease_to_Stage values (16,14,9);
insert into Disease_to_Stage values (16,18,10);

REM  Solid Tumor
insert into Disease_to_Stage values (17,23,1);

REM  unspecified cancer
insert into Disease_to_Stage values (18,23,1);
insert into Disease_to_Stage values (18,19,2);
insert into Disease_to_Stage values (18,1,3);
insert into Disease_to_Stage values (18,18,4);

REM  Urethral
insert into Disease_to_Stage values (19,23,1);



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:49 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:48 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

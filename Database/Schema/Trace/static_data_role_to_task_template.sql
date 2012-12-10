--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_role_to_task_template.sql$ 
--
-- $Revision: 15$        $Date: 2/27/2008 3:17:31 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,       
--CALCULATION_NAME) values 
--('||ID||','||decode(TASK_TEMPLATE_ID,null,'null',TASK_TEMPLATE_ID)||','||  
--decode(ROLE_TEMPLATE_ID,null,'null',ROLE_TEMPLATE_ID)||','||
--decode(CALCULATION_NAME,null,'null',''''||CALCULATION_NAME||'''')||','||
--from role_to_task_template;



Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (1,1, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (2,1, 11, 'PA_PM_CONT_NEGO');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (3,1, 19, 'PA_SRCRA_CONT_NEGO');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (4,1, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (5,1, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (6,2, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (7,2, 11, 'PA_PM_GRANT_ADMIN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (8,2, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (9,2, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (10,2, 21, 'PA_ADMIN_GRANT_ADMIN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (11,3, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (12,3, 46, 'MM_MGR_MMON');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (13,3, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (14,3, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (15,4, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (16,4, 46, 'MM_MGR_REV_LAB');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (17,4, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (18,5, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (19,5, 46, 'MM_MGR_REV_OTHER_TEST');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (20,5, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (21,5, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (22,6, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (23,6, 46, 'MM_MGR_INTERP_TEST');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (24,6, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (25,7, 2, 'MM_VP_PREP_SAE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (26,7, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (27,7, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (28,7, 22, 'MM_ADM_PREP_SAE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (29,8, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (30,8, 18, 'PM_PM_STATUS_REP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (31,8, 19, 'PM_SRCRA_STATUS_REP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (32,8, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (33,8, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (34,9, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (35,9, 18, 'PM_PM_ENROLL_TRACK');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (36,9, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (37,9, 20, 'PM_CRA_ENROLL_TRACK');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (38,9, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (39,10, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (40,10, 18, 'PM_PM_SUMMARY_REP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (41,10, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (42,10, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (43,10, 23, 'PM_ADM_SUMMARY_REP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (44,11, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (45,11, 18, 'PM_PM_TELCON_LOGGING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (46,11, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (47,11, 20, 'PM_ADM_TELCON_LOGGING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (48,12, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (49,12, 18, 'PM_PM_CENTRAL_LAB');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (50,12, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (51,12, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (52,12, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (53,13, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (54,13, 18, 'PM_PM_CENTLAB_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (55,13, 19, 'PM_SRCRA_CENTLAB_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (56,13, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (57,13, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (58,14, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (59,14, 18, 'PM_PM_CENTRAL_IRB');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (60,14, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (61,14, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (62,14, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (63,15, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (64,15, 18, 'PM_PM_CENTIRB_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (65,15, 19, 'PM_SRCRA_CENTIRB_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (66,15, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (67,15, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (68,16, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (69,16, 18, 'PM_PM_PRINTSERV');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (70,16, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (71,16, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (72,16, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (73,17, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (74,17, 18, 'PM_PM_PRINTSERV_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (75,17, 19, 'PM_SRCRA_PRINTSERV_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (76,17, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (77,17, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (78,18, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (79,18, 18, 'PM_PM_DRUGSUPP_MGT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (80,18, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (81,18, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (82,18, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (83,19, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (84,19, 18, 'PM_PM_DRUGSUPP_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (85,19, 19, 'PM_SRCRA_DRUGSUPP_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (86,19, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (87,19, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (88,20, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (89,20, 18, 'PM_PM_OTHER_VENDORS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (90,20, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (91,20, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (92,20, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (93,21, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (94,21, 18, 'PM_PM_OTHVENDOR_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (95,21, 19, 'PM_SRCRA_OTHVENDOR_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (96,21, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (97,21, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (98,22, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (99,22, 18, 'PM_PM_NEWSLETTER');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (100,22, 19, 'PM_SRCRA_NEWSLETTER');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (101,22, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (102,22, 23, 'PM_ADMIN_NEWSLETTER');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (103,23, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (104,23, 18, 'PM_PM_NEWSLETTER_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (105,23, 19, 'PM_SRCRA_NEWSLETTER_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (106,23, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (107,23, 23, 'PM_ADMIN_NEWSLETTER_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (108,24, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (109,24, 18, 'PM_PM_MEETSUBCON');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (110,24, 19, 'PM_SRCRA_MEETSUBCON');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (111,24, 20, 'PM_CRA_SUBCON');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (112,24, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (113,25, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (114,25, 18, 'PM_PM_INTERNAL_MEETINGS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (115,25, 19, 'PM_SRCRA_INTERNAL_MEETINGS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (116,25, 20, 'PM_CRA_INTERNAL_MEETINGS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (117,25, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (118,26, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (119,26, 18, 'PM_PM_TELECONF_INV');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (120,26, 19, 'PM_SRCRA_TELECONF_INV');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (121,26, 20, 'PM_CRA_TELECONF_INV');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (122,26, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (123,27, 4, 'CO_VP_PROTOCOL_PREP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (124,27, 12, 'CO_PM_PROTOCOL_PREP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (125,27, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (126,27, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (127,27, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (128,28, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (129,28, 12, 'CO_PM_INV_RECRUIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (130,28, 19, 'CO_SRCRA_INV_RECRUIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (131,28, 20, 'CO_CRA_INV_RECRUIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (132,28, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (133,29, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (134,29, 12, 'CO_PM_OTH_PRESTUDY_DOC');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (135,29, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (136,29, 20, 'CO_CRA_OTH_PRESTUDY_DOC');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (137,29, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (138,30, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (139,30, 12, 'CO_PM_WRITE_ICF');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (140,30, 19, 'CO_SRCRA_WRITE_CRF');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (141,30, 20, 'CO_CRA_WRITE_CRF');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (142,30, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (143,31, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (144,31, 12, 'CO_PM_SITE_EVAL');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (145,31, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (146,31, 20, 'CO_CRA_SITE_EVAL');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (147,31, 43, 'CO_ADMIN_SITE_EVAL');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (148,32, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (149,32, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (150,32, 19, 'CO_SRCRA_CRF_PREP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (151,32, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (152,32, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (153,33, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (154,33, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (155,33, 19, 'CO_SRCRA_REGDOC_PREP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (156,33, 20, 'CO_CRA_REGDOC_PREP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (157,33, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (158,34, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (159,34, 12, 'CO_PM_INVESTIGATOR_MEET');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (160,34, 19, 'CO_SRCRA_INVESTIGATOR_MEET');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (161,34, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (162,34, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (163,35, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (164,35, 12, 'CO_PM_SITEMON_INIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (165,35, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (166,35, 20, 'CO_CRA_SITEMON_INIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (167,35, 43, 'CO_ADMIN_SITEMON_INIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (168,36, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (169,36, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (170,36, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (171,36, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (172,36, 43, 'CO_ADMIN_MAINT_WORKFILES');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (173,37, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (174,37, 12, 'CO_PM_SITEMON_ROUTINE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (175,37, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (176,37, 20, 'CO_CRA_SITEMON_ROUTINE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (177,37, 43, 'CO_ADMIN_SITEMON_ROUTINE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (178,38, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (179,38, 12, 'CO_PM_SITEMON_CLOSE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (180,38, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (181,38, 20, 'CO_CRA_SITEMON_CLOSE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (182,38, 43, 'CO_ADMIN_SITEMON_CLOSE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (183,39, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (184,39, 13, 'DM_PM_MANAGEMENT_PLAN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (185,39, 29, 'DM_SDC_MANAGEMENT_PLAN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (186,39, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (187,39, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (188,39, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (189,40, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (190,40, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (191,40, 29, 'DM_SDC_DB_DESIGN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (192,40, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (193,40, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (194,40, 42, 'DM_DBA_DB_DESIGN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (195,41, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (196,41, 13, 'DM_PM_CRF_GENERAL');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (197,41, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (198,41, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (199,41, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (200,41, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (201,42, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (202,42, 13, 'DM_PM_DMADMINISTRATION');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (203,42, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (204,42, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (205,42, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (206,42, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (207,43, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (208,43, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (209,43, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (210,43, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (211,43, 24, 'DM_ADMIN_CRF_TRACKING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (212,43, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (213,44, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (214,44, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (215,44, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (216,44, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (217,44, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (218,44, 48, 'DM_DATAENTRY_DATA_ENTRY');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (219,45, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (220,45, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (221,45, 29, 'DM_SRCOORD_CODING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (222,45, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (223,45, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (224,46, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (225,46, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (226,46, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (227,46, 30, 'DM_DATACOORD_QUERYMGT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (228,46, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (229,47, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (230,47, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (231,47, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (232,47, 30, 'DM_DATACOORD_DATACLEANUP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (233,47, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (234,48, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (235,48, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (236,48, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (237,48, 30, 'DM_DATACOORD_QC');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (238,48, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (239,49, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (240,49, 13, 'DM_PM_DATABASE_CLOSE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (241,49, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (242,49, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (243,49, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (244,49, 42, 'DM_DBA_DATABASE_CLOSE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (245,50, 6, 'STAT_VP_PLAN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (246,50, 14, 'STAT_PM_PLAN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (247,50, 32, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (248,50, 33, 'STAT_STAT_PLAN');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (249,50, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (250,51, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (251,51, 14, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (252,51, 32, 'STAT_SRSTAT_CREATE_SHELLS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (253,51, 33, 'STAT_STAT_CREATE_SHELLS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (254,51, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (255,52, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (256,52, 14, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (257,52, 32, 'STAT_SRSTAT_ANALYSIS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (258,52, 33, 'STAT_STAT_ANALYSIS');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (259,52, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (260,53, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (261,53, 14, 'STAT_PM_REPORT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (262,53, 32, 'STAT_SRSTAT_REPORT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (263,53, 33, 'STAT_STAT_REPORT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (264,53, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (265,54, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (266,54, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (267,54, 34, 'MW_SRWRITER_PREPBROCHURE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (268,54, 35, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (269,54, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (270,55, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (271,55, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (272,55, 34, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (273,55, 35, 'MW_WRITER_CLINREPORT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (274,55, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (275,56, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (276,56, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (277,56, 34, 'MW_SRWRITER_REVIEW_RPT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (278,56, 35, 'MW_WRITER_REVIEW_RPT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (279,56, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (280,57, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (281,57, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (282,57, 34, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (283,57, 35, 'MW_WRITER_MANUSCRIPT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (284,57, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (285,58, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (286,58, 16, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (287,58, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (288,58, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (289,58, 26, 'RA_ADMIN_MAINT_FILES');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (290,59, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (291,59, 16, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (292,59, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (293,59, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (294,59, 26, 'RA_ADMIN_MAINTFILE_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (295,60, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (296,60, 16, 'RA_PM_SITEAUDIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (297,60, 36, 'RA_AUDITOR_SITEAUDIT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (298,60, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (299,60, 26, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (300,61, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (301,61, 16, 'RA_PM_DATAQA_SUPERVISION');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (302,61, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (303,61, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (304,61, 26, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (305,62, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (306,62, 16, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (307,62, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (308,62, 37, 'RA_QCTECH_DATAQA');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (309,62, 26, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (310,63, 45, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (311,63, 17, 'SAF_PM_FDA_ANNUALREP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (312,63, 38, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (313,63, 39, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (314,63, 27, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (315,64, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (316,64, 42, 'IT_DBA_IVR');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (317,64, 40, 'IT_SRPROG_IVR');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (318,64, 41, 'IT_PROG_IVR');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (319,64, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (320,65, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (321,65, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (322,65, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (323,65, 41, 'IT_PROG_IVRMAINT');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (324,65, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (325,66, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (326,66, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (327,66, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (328,66, 41, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (329,66, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (330,67, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (331,67, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (332,67, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (333,67, 41, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (334,67, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (335,68, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (336,68, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (337,68, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (338,68, 41, 'IT_PROG_IMAGEFILE_SETUP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (339,68, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (340,69, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (341,69, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (342,69, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (343,69, 41, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (344,69, 28, 'IT_ADMIN_IMAGEFILE_ONGOING');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (345,70, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (346,70, 42, 'IT_DBA_DBMANAGE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (347,70, 40, 'IT_SRPROG_DBMANAGE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (348,70, 41, 'IT_PROG_DBMANAGE');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (349,70, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (350,71, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (351,71, 11, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (352,71, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (353,71, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (354,71, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (355,72, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (356,72, 11, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (357,72, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (358,72, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (359,72, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (360,73, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (361,73, 11, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (362,73, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (363,73, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (364,73, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (365,74, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (366,74, 11, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (367,74, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (368,74, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (369,74, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (370,75, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (371,75, 11, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (372,75, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (373,75, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (374,75, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (375,76, 1, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (376,76, 11, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (377,76, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (378,76, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (379,76, 21, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (380,77, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (381,77, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (382,77, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (383,77, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (384,78, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (385,78, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (386,78, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (387,78, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (388,79, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (389,79, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (390,79, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (391,79, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (392,80, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (393,80, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (394,80, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (395,80, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (396,81, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (397,81, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (398,81, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (399,81, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (400,82, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (401,82, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (402,82, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (403,82, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (404,83, 2, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (405,83, 46, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (406,83, 47, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (407,83, 22, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (408,84, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (409,84, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (410,84, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (411,84, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (412,84, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (413,85, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (414,85, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (415,85, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (416,85, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (417,85, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (418,86, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (419,86, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (420,86, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (421,86, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (422,86, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (423,87, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (424,87, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (425,87, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (426,87, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (427,87, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (428,88, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (429,88, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (430,88, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (431,88, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (432,88, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (433,89, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (434,89, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (435,89, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (436,89, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (437,89, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (438,90, 3, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (439,90, 18, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (440,90, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (441,90, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (442,90, 23, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (443,91, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (444,91, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (445,91, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (446,91, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (447,91, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (448,92, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (449,92, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (450,92, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (451,92, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (452,92, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (453,93, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (454,93, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (455,93, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (456,93, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (457,93, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (458,94, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (459,94, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (460,94, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (461,94, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (462,94, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (463,95, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (464,95, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (465,95, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (466,95, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (467,95, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (468,96, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (469,96, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (470,96, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (471,96, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (472,96, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (473,97, 4, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (474,97, 12, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (475,97, 19, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (476,97, 20, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (477,97, 43, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (478,98, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (479,98, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (480,98, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (481,98, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (482,98, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (483,99, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (484,99, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (485,99, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (486,99, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (487,99, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (488,100, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (489,100, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (490,100, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (491,100, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (492,100, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (493,101, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (494,101, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (495,101, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (496,101, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (497,101, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (498,102, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (499,102, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (500,102, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (501,102, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (502,102, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (503,103, 5, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (504,103, 13, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (505,103, 29, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (506,103, 30, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (507,103, 24, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (508,104, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (509,104, 14, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (510,104, 32, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (511,104, 33, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (512,104, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (513,105, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (514,105, 14, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (515,105, 32, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (516,105, 33, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (517,105, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (518,106, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (519,106, 14, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (520,106, 32, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (521,106, 33, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (522,106, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (523,107, 6, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (524,107, 14, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (525,107, 32, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (526,107, 33, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (527,107, 44, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (528,108, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (529,108, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (530,108, 34, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (531,108, 35, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (532,108, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (533,109, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (534,109, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (535,109, 34, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (536,109, 35, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (537,109, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (538,110, 7, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (539,110, 15, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (540,110, 34, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (541,110, 35, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (542,110, 25, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (543,111, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (544,111, 16, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (545,111, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (546,111, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (547,111, 26, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (548,112, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (549,112, 16, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (550,112, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (551,112, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (552,112, 26, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (553,113, 8, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (554,113, 16, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (555,113, 36, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (556,113, 37, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (557,113, 26, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (558,114, 45, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (559,114, 17, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (560,114, 38, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (561,114, 39, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (562,114, 27, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (563,115, 45, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (564,115, 17, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (565,115, 38, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (566,115, 39, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (567,115, 27, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (568,116, 45, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (569,116, 17, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (570,116, 38, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (571,116, 39, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (572,116, 27, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (573,117, 45, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (574,117, 17, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (575,117, 38, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (576,117, 39, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (577,117, 27, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (578,118, 45, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (579,118, 17, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (580,118, 38, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (581,118, 39, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (582,118, 27, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (583,119, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (584,119, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (585,119, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (586,119, 41, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (587,119, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (588,120, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (589,120, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (590,120, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (591,120, 41, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (592,120, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (593,121, 10, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (594,121, 42, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (595,121, 40, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (596,121, 41, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (597,121, 28, 'NO_OP');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (598,34, 2, 'MM_VP_INVESTIGATOR_MEET');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (599,34, 29, 'DM_SDC_INVESTIGATOR_MEET');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (600,122, 20, 'CO_CRA_QUERY_RES');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (601,122, 4, 'NO_OP');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (602,122, 12, 'NO_OP');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (603,122, 43, 'NO_OP');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (604,123, 1, 'NO_OP');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (605,123, 11, 'NO_OP');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (606,123, 19, 'NO_OP');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (607,123, 20, 'PA_CRA_DOC_COLLECT');

insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID, 
CALCULATION_NAME) values (608,123, 21, 'NO_OP');









exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  15   DevTSM    1.14        2/27/2008 3:17:31 PM Debashish Mishra  
--  14   DevTSM    1.13        3/3/2005 6:31:42 AM  Debashish Mishra  
--  13   DevTSM    1.12        8/16/2002 11:12:25 AMDebashish Mishra Modified
--       calculation_name for id=19
--  12   DevTSM    1.11        8/7/2002 12:13:02 PM Debashish Mishra changes for
--       Peter
--  11   DevTSM    1.10        7/10/2002 4:00:13 PM Kelly Kingdon   added 2 new
--       rows for MM_VP and DM_SDC for investigator meeting and set CRA for
--       investigator_meeting to NO_OP.
--  10   DevTSM    1.9         7/10/2002 2:29:15 PM Kelly Kingdon   fixed
--       pa_admin/cra, they had the reverse calc name for grant admin task.
--  9    DevTSM    1.8         6/13/2002 11:52:13 AMDebashish Mishra all changes
--       after picas-e beta
--  8    DevTSM    1.7         6/3/2002 2:46:42 PM  Kelly Kingdon   changed web
--       portal/maint to be no_op
--  7    DevTSM    1.6         5/31/2002 11:13:51 AMKelly Kingdon   fixed wrong
--       role for DM tasks
--  6    DevTSM    1.5         5/30/2002 8:38:18 AM Kelly Kingdon   added misc
--       tasks and rtt for misc tasks.
--  5    DevTSM    1.4         5/3/2002 3:06:56 PM  Peter Abramowitsch swapped two
--       function names
-- 
--  4    DevTSM    1.3         4/30/2002 5:39:08 PM Peter Abramowitsch minor fixes
--  3    DevTSM    1.2         4/29/2002 7:26:43 PM Peter Abramowitsch added all
--       rtts
--  2    DevTSM    1.1         4/15/2002 3:26:19 PM Debashish Mishra  
--  1    DevTSM    1.0         3/12/2002 4:39:39 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

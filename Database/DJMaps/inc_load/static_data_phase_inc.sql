--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_phase_inc.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:16 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
--select 'Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values
--('||ID||','||decode(SHORT_DESC,null,'null',
--''''||SHORT_DESC||'''')||','||decode(SEQUENCE,null,'null',
--SEQUENCE)||');' from "&1".phase order by id

Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (1,'phaseI',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (2,'phaseII',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (3,'phaseIIIa',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (4,'phaseIIIb',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (5,'PhaseIV',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (6,'p1pkbio',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (7,'p1safedose',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (8,'p1pop',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (9,'p1pkbiodose',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (10,'p1pkbiopop',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (11,'p1dosepop',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (12,'p1pkbiodosepop',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (13,'p1food',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (14,'p1drug',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (15,'p1eff',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (16,'p1pkbiofood',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (17,'p1pkbiodrug',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (18,'p1pkbiosaffood',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (19,'PhaseIII',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (20,'PhaseII/III',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (0,'All',null);

Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (21,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (22,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (23,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (24,'ph1 PK/Bioavailability and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (25,'Ph1 Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (26,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (27,'ph1 PK/Bioavailability and Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (28,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (29,'ph1 Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (30,'ph1 Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (31,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (32,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (33,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy and Radiol',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (34,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (35,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (36,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (37,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (38,'ph1 PK/Bioavailability and Specific Population and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (39,'Ph1 PK/Bioavailability and Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (40,'Ph1 PK/Bioavailability and Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (41,'ph1 PK/Bioavailability and Specific Population and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (42,'ph1 PK/Bioavailability and Food Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (43,'ph1 PK/Bioavailability and Food Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (44,'ph1 PK/Bioavailability and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (45,'Ph1 PK/Bioavailability and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (46,'ph1 PK/Bioavailability and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (47,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (48,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (49,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (50,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (51,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (52,'ph1 Safety/Tolerance/Dose Ranging and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (53,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (54,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (55,'ph1 Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (56,'ph1 Specific Population and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (57,'ph1 Specific Population and Food Interaction and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (58,'ph1 Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (59,'ph1 Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (60,'ph1 Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (61,'ph1 Food Interaction and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (62,'ph1 Drug Interaction and Efficacy',null);

update "&1".phase set short_desc = 'ph1 PK/Bioavailability' where id=6;
update "&1".phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging' where id=7;
update "&1".phase set short_desc = 'ph1 Specific Population' where id=8;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging' where id=9;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Specific Population' where id=10;
update "&1".phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging and Specific Population' where id=11;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population' where id=12;
update "&1".phase set short_desc = 'ph1 Food Interaction' where id=13;
update "&1".phase set short_desc = 'ph1 Drug Interaction' where id=14;
update "&1".phase set short_desc = 'ph1 Efficacy' where id=15;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Food Interaction' where id=16;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Drug Interaction' where id=17;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction' where id=18;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:16 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:55 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:41:11 AM  Debashish Mishra  
--  4    DevTSM    1.3         2/28/2005 9:55:38 AM Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:51 PM Debashish Mishra  
--  2    DevTSM    1.1         8/30/2002 12:43:29 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  1    DevTSM    1.0         3/20/2002 9:24:24 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

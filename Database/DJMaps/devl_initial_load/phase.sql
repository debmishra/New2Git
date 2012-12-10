--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: phase.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  changes to Phase table
--
---------------------------------------------------------------------
 
Update phase set short_desc='phaseI' where id=1;
Update phase set short_desc='phaseII' where id=2;
Update phase set short_desc='phaseIIIa' where id=3;

Insert into  phase(id,short_desc) values (4,'phaseIIIb');

Update phase set short_desc='PhaseIV' where id=5;
Update phase set short_desc='p1pkbio' where id=6;
Update phase set short_desc='p1safedose' where id=7;
Update phase set short_desc='p1pop' where id=8;
Update phase set short_desc='p1pkbiodose' where id=9;
Update phase set short_desc='p1pkbiopop' where id=10;
Update phase set short_desc='p1dosepop' where id=11;
Update phase set short_desc='p1pkbiodosepop' where id=12;
Update phase set short_desc='p1food' where id=13;
Update phase set short_desc='p1drug' where id=14;
Update phase set short_desc='p1eff' where id=15;
Update phase set short_desc='p1pkbiofood' where id=16;
Update phase set short_desc='p1pkbiodrug' where id=17;
Update phase set short_desc='p1pkbiosaffood' where id=18;


Insert into  phase(id,short_desc) values (19,'PhaseIII');
Insert into  phase(id,short_desc) values (20,'PhaseII/III');

Insert into phase values (0,'All',null);


commit;


-- Following chnages are added by Debashish on 03/11/2003 at 4pm
-- This changes are actually posted here on 12/03/2003 at 11:50 AM

Insert into phase(ID,SHORT_DESC,SEQUENCE) values (21,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (22,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (23,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (24,'ph1 PK/Bioavailability and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (25,'Ph1 Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (26,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (27,'ph1 PK/Bioavailability and Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (28,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (29,'ph1 Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (30,'ph1 Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (31,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (32,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (33,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy and Radiol',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (34,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (35,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (36,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (37,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (38,'ph1 PK/Bioavailability and Specific Population and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (39,'Ph1 PK/Bioavailability and Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (40,'Ph1 PK/Bioavailability and Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (41,'ph1 PK/Bioavailability and Specific Population and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (42,'ph1 PK/Bioavailability and Food Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (43,'ph1 PK/Bioavailability and Food Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (44,'ph1 PK/Bioavailability and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (45,'Ph1 PK/Bioavailability and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (46,'ph1 PK/Bioavailability and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (47,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (48,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (49,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (50,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (51,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (52,'ph1 Safety/Tolerance/Dose Ranging and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (53,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (54,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (55,'ph1 Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (56,'ph1 Specific Population and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (57,'ph1 Specific Population and Food Interaction and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (58,'ph1 Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (59,'ph1 Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (60,'ph1 Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (61,'ph1 Food Interaction and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (62,'ph1 Drug Interaction and Efficacy',null);

update phase set short_desc = 'ph1 PK/Bioavailability' where id=6;
update phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging' where id=7;
update phase set short_desc = 'ph1 Specific Population' where id=8;
update phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging' where id=9;
update phase set short_desc = 'ph1 PK/Bioavailability and Specific Population' where id=10;
update phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging and Specific Population' where id=11;
update phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population' where id=12;
update phase set short_desc = 'ph1 Food Interaction' where id=13;
update phase set short_desc = 'ph1 Drug Interaction' where id=14;
update phase set short_desc = 'ph1 Efficacy' where id=15;
update phase set short_desc = 'ph1 PK/Bioavailability and Food Interaction' where id=16;
update phase set short_desc = 'ph1 PK/Bioavailability and Drug Interaction' where id=17;
update phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction' where id=18;

Insert into phase(ID,SHORT_DESC,SEQUENCE) values (-1,'Unknown',null);


commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:16:42 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:39:15 AM  Debashish Mishra  
--  4    DevTSM    1.3         12/3/2003 1:24:31 PM Debashish Mishra updated with
--       GM1.1 changes
--  3    DevTSM    1.2         8/29/2003 5:12:00 PM Debashish Mishra  
--  2    DevTSM    1.1         2/5/2002 2:54:46 PM  Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:19 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_phase_inc_save.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:17:16 PM$
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


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:17:16 PM Debashish Mishra  
--  3    DevTSM    1.2         2/7/2007 10:28:56 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:41:11 AM  Debashish Mishra  
--  1    DevTSM    1.0         2/28/2005 9:57:11 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

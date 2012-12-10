--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_phase.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:16:47 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
--select 'Insert into phase(ID,SHORT_DESC,SEQUENCE) values
--('||ID||','||decode(SHORT_DESC,null,'null',
--''''||SHORT_DESC||'''')||','||decode(SEQUENCE,null,'null',
--SEQUENCE)||');' from phase order by id

Insert into phase(ID,SHORT_DESC,SEQUENCE) values (1,'phaseI',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (2,'phaseII',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (3,'phaseIIIa',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (4,'phaseIIIb',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (5,'PhaseIV',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (6,'p1pkbio',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (7,'p1safedose',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (8,'p1pop',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (9,'p1pkbiodose',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (10,'p1pkbiopop',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (11,'p1dosepop',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (12,'p1pkbiodosepop',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (13,'p1food',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (14,'p1drug',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (15,'p1eff',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (16,'p1pkbiofood',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (17,'p1pkbiodrug',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (18,'p1pkbiosaffood',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (19,'PhaseIII',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (20,'PhaseII/III',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (0,'All',null);


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:16:47 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:39:37 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:12:20 PM Debashish Mishra  
--  2    DevTSM    1.1         2/5/2002 2:54:48 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/1/2002 6:02:54 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

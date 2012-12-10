--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: baseft15_req_data13.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
--
--
-- Description:  Required data for rel1.3
--
---------------------------------------------------------------------
 
Insert into protocol_type values (1,'Treatment',1);
Insert into protocol_type values (2,'Prevention',2);
Insert into protocol_type values (3,'Diagnostic',3);
Insert into protocol_type values (4,'Genetic',4);
Insert into protocol_type values (5,'Screening',5);
Insert into protocol_type values (6,'Supportive care',6);
Insert into protocol_type values (7,'Companion',7);
Insert into protocol_type values (8,'Safety',8);
Insert into protocol_type values (9,'Unknown',9);

Insert into contact values (contact_seq.nextval,'FT','ADMIN',null);
Insert into ftuser values(1,2,'system','scoobydoo',null,null);
Insert into ftgroup values (1,'fasttrack','system');

commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
--  2    DevTSM    1.1         3/3/2005 6:37:50 AM  Debashish Mishra  
--  1    DevTSM    1.0         11/17/2004 8:26:48 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

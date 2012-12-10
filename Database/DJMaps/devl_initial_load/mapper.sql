--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: mapper.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence mapper_seq;
create sequence mapper_seq START WITH 1555;

delete from mapper;

Insert into mapper select mapper_seq.nextval,id,null 
from odc_def;

Insert into mapper select mapper_seq.nextval,null,id  
from procedure_def;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:16:42 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:39:10 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:11:56 PM Debashish Mishra  
--  3    DevTSM    1.2         1/23/2002 12:53:49 PMDebashish Mishra After changing
--       the input source to foxpro
--  2    DevTSM    1.1         1/15/2002 3:05:23 PM Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:17 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

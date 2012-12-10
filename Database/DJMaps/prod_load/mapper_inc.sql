--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: mapper_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 

delete from "&1".mapper;

Insert into "&1".mapper select "&1".mapper_seq.nextval,id,null 
from "&1".odc_def;

Insert into "&1".mapper select "&1".mapper_seq.nextval,null,id  
from "&1".procedure_def;

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:42 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:47 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:42 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:04 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

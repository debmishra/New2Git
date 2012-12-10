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
-- $Revision: 8$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence "&1".mapper_seq;
create sequence "&1".mapper_seq START WITH 857;

alter table "&1".own_procedure disable constraint OWN_PROCEDURE_FK3;
alter table "&1".own_odc disable constraint OWN_odc_FK3;

delete from "&1".mapper;

Insert into "&1".mapper select "&1".mapper_seq.nextval,id,null 
from "&1".odc_def;

Insert into "&1".mapper select "&1".mapper_seq.nextval,null,id  
from "&1".procedure_def;

commit;

alter table "&1".own_procedure enable constraint OWN_PROCEDURE_FK3;
alter table "&1".own_odc enable constraint OWN_odc_FK3;
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:17:09 PM Debashish Mishra  
--  7    DevTSM    1.6         5/8/2007 5:58:34 PM  Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:17 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:38 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:23 PM Debashish Mishra  
--  3    DevTSM    1.2         8/30/2002 12:43:11 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  2    DevTSM    1.1         4/3/2002 6:58:06 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:09 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

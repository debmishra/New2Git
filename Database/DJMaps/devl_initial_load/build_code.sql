--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: build_code.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:16:38 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

Insert into build_code (id,code,name) select id,code,name from build_code1;
commit;

declare

maxid number(10);

begin 

select max(id)+1 into maxid from build_code;

Insert into build_code(id,code,name) values(maxid,'UNK','Unknown');
commit;
end;
/
 
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:16:38 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:38:50 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:11:37 PM Debashish Mishra  
--  1    DevTSM    1.0         2/12/2002 12:20:14 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

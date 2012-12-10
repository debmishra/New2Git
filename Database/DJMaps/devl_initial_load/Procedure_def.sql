--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Procedure_def.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:16:38 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence procedure_def_seq;
create sequence procedure_def_seq;

Insert into procedure_def select procedure_def_seq.nextval,
PROCEDURE,"DESC",0,null,null,proctype from procdesc where
isproc <> 0 ;

Insert into procedure_def values(procedure_def_seq.nextval,
70539,null,1,sysdate,null,'Other');

Insert into procedure_def values(procedure_def_seq.nextval,
92025,null,1,sysdate,null,'Other');

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:16:38 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:38:48 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:11:35 PM Debashish Mishra  
--  3    DevTSM    1.2         1/23/2002 12:53:43 PMDebashish Mishra After changing
--       the input source to foxpro
--  2    DevTSM    1.1         1/15/2002 12:30:54 PMDebashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:11 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

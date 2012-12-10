--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: odc_def.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence odc_def_seq;
create sequence odc_def_seq;

Insert into odc_def select odc_def_seq.nextval,
PROCEDURE,"DESC",0,null,PROCTYPE,null,hide from procdesc where
isproc=0 ;

commit;

--update odc_def set hide = 1 where picas_code in 
--('*CARD','*ENCR','*GYNE','*NURS','*OPHT','*PSYC','V1138','V1139','V1140','V1143');

--commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:16:42 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:39:11 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:11:57 PM Debashish Mishra  
--  5    DevTSM    1.4         3/22/2002 4:40:18 PM Debashish Mishra  
--  4    DevTSM    1.3         3/6/2002 7:03:23 PM  Debashish Mishra  
--  3    DevTSM    1.2         1/23/2002 12:53:50 PMDebashish Mishra After changing
--       the input source to foxpro
--  2    DevTSM    1.1         1/15/2002 12:30:57 PMDebashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:18 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

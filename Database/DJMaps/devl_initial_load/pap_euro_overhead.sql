--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pap_euro_overhead.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 



drop sequence pap_euro_overhead_seq;
create sequence pap_euro_overhead_seq;

--Insert into pap_euro_overhead select
--pap_euro_overhead_seq.nextval, c.id,
--decode(e.seqno-(floor(e.seqno/2)*2),0,1,1,0),
--decode(e.PCT25,'n/a',null,'-1',null,e.PCT25),
--decode(e.PCT50,'n/a',null,'-1',null,e.PCT50),
--decode(e.PCT75,'n/a',null,'-1',null,e.PCT75) from country c,
--euroover e where 
--e.abr = c.ABBREVIATION;

-- changes for bugid#f8P9HA00014I

Insert into pap_euro_overhead select
pap_euro_overhead_seq.nextval, c.id,
e.seqno-(floor(e.seqno/2)*2),
decode(e.PCT25,'n/a',null,'-1',null,e.PCT25),
decode(e.PCT50,'n/a',null,'-1',null,e.PCT50),
decode(e.PCT75,'n/a',null,'-1',null,e.PCT75) from country c,
euroover e where 
e.abr = c.ABBREVIATION;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:16:42 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:39:11 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:11:57 PM Debashish Mishra  
--  2    DevTSM    1.1         3/12/2002 4:40:11 PM Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:18 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2004Q3_import.sql$ 
--
-- $Revision: 4$        $Date: 2/22/2008 11:56:02 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update country set currency_id=null where
abbreviation='YUG';

commit;


--IMP**IMP**
--**************************************
--FOLLOWING NEED TO BE RUN AFTER IMPORT
--AND NOT BEFORE IMPORT
--**************************************

update currency set viewable_flg=1 where id = (select currency_id
from country where abbreviation='YUG') and id <> (select currency_id
from country where abbreviation='USA');

commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/22/2008 11:56:02 AMDebashish Mishra  
--  3    DevTSM    1.2         9/19/2006 12:11:31 AMDebashish Mishra   
--  2    DevTSM    1.1         3/2/2005 10:51:05 PM Debashish Mishra  
--  1    DevTSM    1.0         6/10/2004 12:43:56 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

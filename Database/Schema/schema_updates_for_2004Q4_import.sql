--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2004Q4_import.sql$ 
--
-- $Revision: 6$        $Date: 2/22/2008 11:56:02 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

-- This was required after merging cvmstr.dbf with cntrylst.dbf

update country set currency_id=null where
abbreviation in ('PAN','BAH');

commit;

-- Following chnages are as per the new columns that are being added to region.dbf file
-- done on 10-14-2004

-- alter table region add (
-- USREGION_SHORT varchar2(10),
-- USREGION_LONG varchar2(20),
-- USSTATES varchar2(5));

-- Following changes are as per the request of Kelly on 10-19-2004

alter table payments add (checked varchar2(20));

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/22/2008 11:56:02 AMDebashish Mishra  
--  5    DevTSM    1.4         9/19/2006 12:11:31 AMDebashish Mishra   
--  4    DevTSM    1.3         3/2/2005 10:51:06 PM Debashish Mishra  
--  3    DevTSM    1.2         10/22/2004 6:04:52 AMDebashish Mishra support for
--       temp13* tables
--  2    DevTSM    1.1         10/19/2004 10:16:01 PMDebashish Mishra  
--  1    DevTSM    1.0         10/13/2004 8:01:02 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

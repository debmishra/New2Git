--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsmclient0_special_synonyms.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:46 PM$
--
--
-- Description:  special synonyms required only by tsmclient0
--
---------------------------------------------------------------------
 
drop synonym client_div;
drop synonym client_div_to_lic_country;

create synonym client_div for "&1".client_div;
create synonym client_div_to_lic_country for "&1".client_div_to_lic_country;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:46 PM Debashish Mishra  
--  5    DevTSM    1.4         9/19/2006 12:08:12 AMDebashish Mishra  removed
--       references to obsolete tables
--  4    DevTSM    1.3         3/3/2005 6:33:33 AM  Debashish Mishra   
--  3    DevTSM    1.2         3/3/2005 6:32:24 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:19:16 PM Debashish Mishra  
--  1    DevTSM    1.0         6/20/2003 11:27:12 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

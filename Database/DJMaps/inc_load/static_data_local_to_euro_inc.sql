--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_local_to_euro_inc.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:16 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--select 'Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO)
--values ('||ID||','||decode(COUNTRY_ID,null,'null',
--COUNTRY_ID)||','||decode(CNV_RATE_TO_EURO,null,'null',
--CNV_RATE_TO_EURO)||');' from "&1".local_to_euro order by id;
                                 
                                                           
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (1,3,40.3399);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (2,11,1.9558);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (3,20,166.386);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (4,10,6.5596);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (5,13,.7876);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (6,15,1936.27);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (7,16,2.2037);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (8,2,13.7603);
Insert into "&1".local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (9,8,5.9457);                                 
                        

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:16 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:54 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:10 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:50 PM Debashish Mishra  
--  2    DevTSM    1.1         8/30/2002 12:43:29 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  1    DevTSM    1.0         3/20/2002 9:24:24 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

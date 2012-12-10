--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_local_to_euro.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:16:47 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--select 'Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO)
--values ('||ID||','||decode(COUNTRY_ID,null,'null',
--COUNTRY_ID)||','||decode(CNV_RATE_TO_EURO,null,'null',
--CNV_RATE_TO_EURO)||');' from local_to_euro order by id;
                                 
                                                           
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (1,3,40.3399);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (2,11,1.9558);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (3,20,166.386);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (4,10,6.5596);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (5,13,.7876);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (6,15,1936.27);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (7,16,2.2037);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (8,2,13.7603);
Insert into local_to_euro(ID,COUNTRY_ID,CNV_RATE_TO_EURO) values (9,8,5.9457);                                 
                        

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:16:47 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:39:36 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:12:19 PM Debashish Mishra  
--  1    DevTSM    1.0         2/1/2002 5:54:12 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

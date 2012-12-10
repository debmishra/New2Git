--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_currency.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:45 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--select 'Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
--('||ID||','||decode(NAME,null,'null',
--''''||NAME||'''')||','||decode(SYMBOL,null,'null',
--''''||SYMBOL||'''')||','||decode(CNV_RATE,null,'null',
--CNV_RATE)||');'
--from currency order by id;


Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(0,'Dummy',null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(1,'Australian dollar','AUD',1.9099);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(2,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(3,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(4,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(5,'Canadian dollar','CAD',1.5945);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(6,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(7,'Danish krone','DKK',8.3284);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(8,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(9,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(10,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(11,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(12,'Forint','HUF',273.63);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(13,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(14,'Israeli shekel','ILS',4.465);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(15,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(16,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(17,'Norwegian krone','NOK',8.9254);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(18,'Zloty','PLN',3.9625);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(19,'Rand','ZAR',11.495);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(20,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(21,'Swedish krona','SEK',10.3994);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(22,'Swiss franc','CHF',1.6553);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(23,'British pound','GBP',.6949);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(24,'US-Dollar','USD',1);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(25,null,null,null);

Insert into currency(ID,NAME,SYMBOL,CNV_RATE) values
(26,'EURO','EUR',1.1198);                                 
                        

--Delete from currency where name is null and symbol is null and
--	cnv_rate is null;
commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:45 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:26 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:10 PM Debashish Mishra  
--  4    DevTSM    1.3         2/22/2002 6:35:27 PM Debashish Mishra  
--  3    DevTSM    1.2         2/21/2002 3:32:28 PM Debashish Mishra  
--  2    DevTSM    1.1         2/7/2002 3:10:18 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/1/2002 5:54:12 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

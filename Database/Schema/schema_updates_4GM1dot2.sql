--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4GM1dot2.sql$ 
--
-- $Revision: 5$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

-- Following changes are as per the request of Tonya on 02-19-2004 at 11:30 am


update country set IS_VIEWABLE=1 where
ABBREVIATION in ('ARG','BRA','CHI','MEX');

-- Following changes are as per the request of Tonya on 02-20-2004 at 8:20 am

Update currency set name='Argenintinian Peso' where id in 
	(select currency_id from country where abbreviation='ARG'); 
Update currency set name='Brazilian Real' where id in 
	(select currency_id from country where abbreviation='BRA'); 
Update currency set name='Chilean Peso' where id in 
	(select currency_id from country where abbreviation='CHI');
Update currency set name='Mexican Peso' where id in 
	(select currency_id from country where abbreviation='MEX');

commit;


--****************************************************************************
-- Applied database changes to tsm10@TEST upto this on 02-24-2004 at 12:28pm
-- Applied database changes to tsm10e@TEST upto this on 03-02-2004 at 10:21am
-- Applied database changes to tsm10e@PREV upto this on 03-15-2004 at 1:45pm
-- Applied database changes to tsm10p@PREV upto this on 03-15-2004 at 5:22pm
-- Applied database changes to tsm10@PROD upto this on 04-17-2004 at 19:28pm
-- Applied database changes to tsm10e@PROD upto this on 04-17-2004 at 19:28Pm
-- Apllied database changes to tsm10g@prod upto this on 05-01-2004 at 1:10am
--****************************************************************************



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/22/2008 11:56:00 AMDebashish Mishra  
--  4    DevTSM    1.3         9/19/2006 12:11:22 AMDebashish Mishra   
--  3    DevTSM    1.2         3/2/2005 10:50:56 PM Debashish Mishra  
--  2    DevTSM    1.1         5/6/2004 8:15:31 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/19/2004 6:18:38 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

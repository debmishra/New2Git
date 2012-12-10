--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_afterGM2.sql$ 
--
-- $Revision: 8$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

-- This is as per the request of Phil on 8-18-2005 at 7am

alter table country add(is_cro_viewable NUMBER(1,0)  DEFAULT 0 NOT NULL);

update country set is_cro_viewable=is_viewable;

alter table country add constraint Country_is_cro_viewable_check
check(is_cro_viewable in (0,1));

update id_control set next_id=93 where table_name='country';
commit;

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Albania','ALB',2,1,0,1);
 
insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Andorra','AND',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Baltic','BAL',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Cuba','CUB',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Dominican Republic','DOM',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'European Union','EEC',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Georgia','GEO',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Indian Subcontinent','ISB',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Macedonia','MAC',2,1,0,1);
  
insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Other Africa(not listed)','OAF',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Other Eastern/Central Europe','ECE',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Other Far East (not Japan, not China)','OFE',2,1,0,1);
 
insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Other Middle East  (not listed)','MDE',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'San Marino','RSM',2,1,0,1);

insert into country(id,name,abbreviation,country_level,
currency_id,is_viewable,is_cro_viewable) values 
(increment_sequence('country_seq'),'Nepal','NEP',2,1,0,1);

commit;

--************************************************************************
-- Implemented upto this in tsm10g@devl on 09/21/2005 at 1:50pm
--Implemented upto this in tsm10e@test on 09/21/2005 at 1:50 pm
--Implemented upto this in tsm10t@prev on 02/28/2006 at 1:10 pm
--Implemented upto this in tsm10e@prev on 06/11/2006 at 6:10 pm
-- Implemented upto this in tsm10g@prod on 07/08/2006 at 5:15pm
--Implemented upto this in tsm10@prod on 07/16/2006 at 10:10 am
--Implemented upto this in tsm10e@prod on 07/16/2006 at 10:15 am

--************************************************************************

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/22/2008 11:56:01 AMDebashish Mishra  
--  7    DevTSM    1.6         9/19/2006 12:11:27 AMDebashish Mishra   
--  6    DevTSM    1.5         8/16/2006 1:48:06 PM Debashish Mishra  
--  5    DevTSM    1.4         6/23/2006 7:57:54 AM Debashish Mishra  
--  4    DevTSM    1.3         3/1/2006 8:32:25 AM  Debashish Mishra  
--  3    DevTSM    1.2         11/29/2005 5:15:26 AMDebashish Mishra  
--  2    DevTSM    1.1         9/29/2005 11:17:32 AMDebashish Mishra  
--  1    DevTSM    1.0         8/19/2005 6:24:49 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

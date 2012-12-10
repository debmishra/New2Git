--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: region.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:44 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence region_seq;
create sequence region_seq;

Insert into region select region_seq.nextval, c.id,r.abbr,
r.type,r.name,r.factor from reg r, country c where
trim(r.country)=c.abbreviation;

commit;

declare

countryid number(10);

begin

select id into countryid from country where abbreviation = 'CAN';

Insert into region values (region_seq.nextval,countryid,'BC',
'State','British Columbia',1);
Insert into region values (region_seq.nextval,countryid,'AB',
'State','Alberta',1);
Insert into region values (region_seq.nextval,countryid,'MB',
'State','Manitoba',1);
Insert into region values (region_seq.nextval,countryid,'NB',
'State','New Brunswick',1);
Insert into region values (region_seq.nextval,countryid,'NF',
'State','Newfoundland',1);
Insert into region values (region_seq.nextval,countryid,'NS',
'State','Nova Scotia',1);
Insert into region values (region_seq.nextval,countryid,'ON',
'State','Ontario',1);
Insert into region values (region_seq.nextval,countryid,'PE',
'State','Prince Edward Island',1);
Insert into region values (region_seq.nextval,countryid,'QC',
'State','Quebec',1);
Insert into region values (region_seq.nextval,countryid,'SK',
'State','Saskatchewan',1);

select id into countryid from country where abbreviation = 'USA';
Insert into region values (region_seq.nextval,countryid,'AE',
'State','Armed Forces Europe',1);
Insert into region values (region_seq.nextval,countryid,'AP',
'State','Armed Forces Pacific',1);
Insert into region values (region_seq.nextval,countryid,'DC',
'State','Washington DC',1);
Insert into region values (region_seq.nextval,countryid,'GU',
'State','Guam',1);
Insert into region values (region_seq.nextval,countryid,'NG',
'State','Not Given',1);
Insert into region values (region_seq.nextval,countryid,'NH',
'State','New Hampshire',1);
Insert into region values (region_seq.nextval,countryid,'SS',
'State','Entered In Error',1);
Insert into region values (region_seq.nextval,countryid,'VI',
'State','Virgin Islands',1);

end;
/

commit;
delete from region where name = '(All)'  and factor = 1;

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:44 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:19 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:04 PM Debashish Mishra  
--  4    DevTSM    1.3         2/13/2002 12:11:14 PMDebashish Mishra  
--  3    DevTSM    1.2         2/7/2002 3:10:14 PM  Debashish Mishra  
--  2    DevTSM    1.1         1/23/2002 12:53:54 PMDebashish Mishra After changing
--       the input source to foxpro
--  1    DevTSM    1.0         1/8/2002 6:37:21 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

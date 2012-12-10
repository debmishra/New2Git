--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: affiliation_factor.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:16:38 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop sequence affiliation_factor_seq;
create sequence affiliation_factor_seq;

declare
countryid number(10);
cursor c1 is select distinct country from aff where ther_area is null;
cursor c2 is select distinct ther_area from aff where ther_area is not null;

indmapid number(10);
procafffactor number(10,5);
procunafffactor number(10,5);
cppafffactor number(10,5);
cppunafffactor number(10,5);
cnt1 number(1);

begin

for ix1 in c1 loop

  select count(*) into cnt1 from aff where country=ix1.country and
  ther_area is null;

  select id into countryid from country where abbreviation=ix1.country;

 if cnt1=4 then

  select factor into procafffactor from aff 
  where country = ix1.country and not upper("DESC") like '%UNAFF%'
  and upper(category) like '%PRO%' 
  and ther_area is null;

  select factor into procunafffactor from aff 
  where country = ix1.country and upper("DESC") like '%UNAFF%'
  and upper(category) like '%PRO%' 
  and ther_area is null;

  select factor into cppafffactor from aff 
  where country = ix1.country and not upper("DESC") like '%UNAFF%'
  and upper(category) like '%CPP%' 
  and ther_area is null;

  select factor into cppunafffactor from aff 
  where country = ix1.country and upper("DESC") like '%UNAFF%'
  and upper(category) like '%CPP%' 
  and ther_area is null;

  Insert into affiliation_factor values (affiliation_factor_seq.nextval,
  countryid,null,'PAP',procafffactor,procunafffactor);

  Insert into affiliation_factor values (affiliation_factor_seq.nextval,
  countryid,null,'IP',cppafffactor,cppunafffactor);

 else

  select factor into cppafffactor from aff 
  where country = ix1.country and not upper("DESC") like '%UNAFF%'
  and upper(category) like '%CPP%' 
  and ther_area is null;

  select factor into cppunafffactor from aff 
  where country = ix1.country and upper("DESC") like '%UNAFF%'
  and upper(category) like '%CPP%' 
  and ther_area is null;  

  Insert into affiliation_factor values (affiliation_factor_seq.nextval,
  countryid,null,'IP',cppafffactor,cppunafffactor);

 end if;

end loop;


for ix2 in c2 loop

  select id into indmapid from indmap where de_code = ix2.ther_area 
  and type = 'Therapeutic Area';

  select id into countryid from country where abbreviation='USA';

  select factor into cppafffactor from aff 
  where ther_area = ix2.ther_area 
  and not upper("DESC") like '%UNAFF%';

  select factor into cppunafffactor from aff 
  where ther_area = ix2.ther_area 
   and upper("DESC") like '%UNAFF%';

  insert into affiliation_factor values (affiliation_factor_seq.nextval,
  countryid,indmapid,'IP',cppafffactor,cppunafffactor);

end loop;

end;
/
commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:16:38 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:38:49 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:11:36 PM Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:11 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

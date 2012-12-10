--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: institution.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:39 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update inst set state = 'OK' where upper(state) = 'OK';
commit;


--create table inst1 as select id,COUNTRY,NAME,ZIPCODE,
--decode(i.metro,null,(decode(i.region,null,i.state,i.region)),i.metro)
--region, 
--decode(i.metro,null,(decode(i.region,null,'State','Region')),'Metro')
--reg_type, burdpct,instit from inst i;
 
create table inst1 as select "ID",COUNTRY,
decode(i.region,null,i.state,i.region) region, 
decode(i.region,null,decode(i.state,null,null,'State'),'Region') reg_type, 
NAME,ZIPCODE,instit,addr1,addr2,addr3,
decode(affiliation,'A','Affiliated','U','Unaffiliated') affiliation,
city,county,comments,fax,phone,pobox,prov_terr,
decode(queriable,'T',1,'F',0) queriable,
timzused,burdpct from inst i;

--update inst1 set region = 'HOU' where region = 'HOUSTON';
--update inst1 set region = 'HOU' where trim(region)= 'HOUSTON';
--update inst1 set region = 'ATL' where trim(region)= 'ATLANTA';
--update inst1 set region = 'BOS' where trim(region)= 'BOSTON';
--update inst1 set region = 'CHI' where trim(region)= 'CHICAGO';
--update inst1 set region = 'DET' where trim(region)= 'DETROIT';
--update inst1 set region = 'MIA' where trim(region)= 'MIAMI';
--update inst1 set region = 'PHO' where trim(region)= 'PHOENIX';
--update inst1 set region = 'PHI' where trim(region)= 'PHIL';

--commit;

alter table inst1 add (country_id number(10));

Update inst1 a set a.country_id = (select b.id from country b
	where b.abbreviation = a.country);

commit;

--insert into institution(id,country_id,region_id,name,zip_code,
--burden_pct,abbreviation) select i.id,i.country_id,r.id,
--i.name,i.zipcode,i.burdpct,i.instit from inst1 i,region r where
--i.region = r.abbreviation and i.reg_type = r.type;

--insert into institution(id,country_id,region_id,name,zip_code,
--burden_pct,abbreviation) select i.id,i.country_id,null,
--i.name,i.zipcode,i.burdpct,i.instit from inst1 i  where
--i.region is null;

insert into institution select i.id,i.country_id,r.id,
i.name,i.zipcode, i.instit, i.addr1, i.addr2, i.addr3, 
i.affiliation, i.city, i.county, i.comments, i.fax, i.phone,
i.pobox, i.prov_terr, i.queriable,0,i.timzused,i.burdpct 
from inst1 i,region r where
i.region = r.abbreviation and upper(i.reg_type) = 'STATE'
and upper(r.type) = 'STATE';

insert into institution select i.id,i.country_id,null,
i.name,i.zipcode, i.instit, i.addr1, i.addr2, i.addr3, 
i.affiliation, i.city, i.county, i.comments, i.fax, i.phone,
i.pobox, i.prov_terr, i.queriable,0,i.timzused,i.burdpct 
from inst1 i where upper(nvl(i.reg_type,'AAA')) <> 'STATE';

commit;

drop table inst1;

update institution set city = substr(NAME,instr(NAME,'(',-1)+1,
length(NAME)-instr(NAME,'(',-1)-1) where name like '%)' 
and city is null;

update institution set name=substr(name,1,instr(name,'(',-1)-1)
where name like '%)';

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:39 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:38:55 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:11:43 PM Debashish Mishra  
--  4    DevTSM    1.3         3/18/2002 7:42:15 PM Debashish Mishra  
--  3    DevTSM    1.2         1/23/2002 12:53:46 PMDebashish Mishra After changing
--       the input source to foxpro
--  2    DevTSM    1.1         1/15/2002 3:05:44 PM Debashish Mishra Updated with
--       city info
--  1    DevTSM    1.0         1/8/2002 6:37:14 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: region_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','BC','State','British Columbia',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','AB','State','Alberta',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','MB','State','Manitoba',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','NB','State','New Brunswick',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','NF','State','Newfoundland',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','NS','State','Nova Scotia',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','ON','State','Ontario',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','PE','State','Prince Edward Island',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','QC','State','Quebec',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('CAN','SK','State','Saskatchewan',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','AE','State','Armed Forces Europe',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','AP','State','Armed Forces Pacific',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','DC','State','Washington DC',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','GU','State','Guam',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','NG','State','Not Given',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','NH','State','New Hampshire',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','SS','State','Entered In Error',1);
Insert into tsm_stage.reg(COUNTRY,ABBR,TYPE,NAME,FACTOR) 
values ('USA','VI','State','Virgin Islands',1);

commit;


declare

  region_maxid number(10);
  region_exist number(3);
  countryid number(10);
  country_exist number(3);
  invalid_cntry exception;
  cursor c1 is select country,abbr,type,name,factor from tsm_stage.reg where name <> '(All)';

begin

  select nvl(max(id),0)+1 into region_maxid from "&1".region;

  for ix1 in c1 loop

    select count(*) into country_exist from "&1".country
    where abbreviation = ix1.country;
        if country_exist = 0 then 
          raise invalid_cntry;
        end if; 

    select id into countryid from "&1".country where abbreviation = ix1.country;

    select count(*) into region_exist from "&1".region where country_id = countryid and
    abbreviation = ix1.abbr and type = ix1.type;

    If region_exist = 0 then

      Insert into "&1".region values(region_maxid,countryid,ix1.abbr,ix1.type,ix1.name,ix1.factor);
      region_maxid:=region_maxid+1;

    else
  
      update "&1".region set (name,factor) = (select ix1.name,ix1.factor from dual) where
      country_id = countryid and abbreviation = ix1.abbr and type = ix1.type;

    end if;

  end loop;
  commit;

exception

   when invalid_cntry then
	raise_application_error(-20204,'Country exists in reg, but not in country table');
end;
/
sho err



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:43 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:52 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:47 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:08 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

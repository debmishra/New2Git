--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_duration_factor_inc.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:07 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
declare

  idf_exist number(3);
  idf_maxid number(10);
  countryid number(10);
  country_exist number(3);
  invalid_cntry exception;
  cursor c1 is select country from tsm_stage.ratio;
  /* assumption: country is unique in ratio*/

begin
  
  select nvl(max(id),0)+1 into idf_maxid from "&1".ip_duration_factor;

  for ix1 in c1 loop

    select count(*) into country_exist from "&1".country where abbreviation = ix1.country;

    if country_exist = 0 then 
      raise invalid_cntry;
    end if;

    select id into countryid from "&1".country where abbreviation = ix1.country;

    select count(*) into idf_exist from "&1".ip_duration_factor where country_id=countryid;

    If idf_exist = 0 then

       Insert into "&1".ip_duration_factor select idf_maxid,countryid,
       phase2,phase3,y3phase2,y3phase3 from tsm_stage.ratio where country = ix1.country;       

       idf_maxid:=idf_maxid+1;

    else
      
       update "&1".ip_duration_factor set (PHASE2_FACTOR,PHASE3_FACTOR,
       Y3PHASE2_FACTOR,Y3PHASE3_FACTOR)=(select phase2,phase3,y3phase2,y3phase3 from tsm_stage.ratio
       where country = ix1.country) where country_id = countryid;

    end if;

  end loop;
  commit; 
 
exception

   when invalid_cntry then
	raise_application_error(-20203,'Country exists in ratio, but not in country table');

end;
/
sho err

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:07 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:04 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:40:26 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:14 PM Debashish Mishra  
--  2    DevTSM    1.1         8/30/2002 12:43:09 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  1    DevTSM    1.0         3/20/2002 9:24:08 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

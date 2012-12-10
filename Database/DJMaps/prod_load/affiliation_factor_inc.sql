--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: affiliation_factor_inc.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:41 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
declare

 countryid number(10);
 cursor c1 is select distinct country from tsm_stage.aff where ther_area is null;
 cursor c2 is select distinct ther_area from tsm_stage.aff where ther_area is not null;

 indmapid number(10);
 procafffactor number(10,5);
 procunafffactor number(10,5);
 cppafffactor number(10,5);
 cppunafffactor number(10,5);
 cnt1 number(1);
 aff_maxid number(10);
 aff_exist number(3);
 indmap_exist number(3);

begin

 select nvl(max(id),0)+1 into aff_maxid from "&1".affiliation_factor;

 for ix1 in c1 loop

  select count(*) into cnt1 from tsm_stage.aff where country=ix1.country and
  ther_area is null;

  select id into countryid from "&1".country where abbreviation=ix1.country;

  select count(*) into aff_exist from "&1".affiliation_factor where 
  indmap_id is null and country_id = countryid;

  if cnt1=4 then

    select factor into procafffactor from tsm_stage.aff 
    where country = ix1.country and not upper("DESC") like '%UNAFF%'
    and upper(category) like '%PRO%' 
    and ther_area is null;

    select factor into procunafffactor from tsm_stage.aff 
    where country = ix1.country and upper("DESC") like '%UNAFF%'
    and upper(category) like '%PRO%' 
    and ther_area is null;

    select factor into cppafffactor from tsm_stage.aff 
    where country = ix1.country and not upper("DESC") like '%UNAFF%'
    and upper(category) like '%CPP%' 
    and ther_area is null;

    select factor into cppunafffactor from tsm_stage.aff 
    where country = ix1.country and upper("DESC") like '%UNAFF%'
    and upper(category) like '%CPP%' 
    and ther_area is null;

     if aff_exist = 0 then 

      Insert into "&1".affiliation_factor values (aff_maxid,
      countryid,null,'PAP',procafffactor,procunafffactor);

      aff_maxid:=aff_maxid+1;

      Insert into "&1".affiliation_factor values (aff_maxid,
      countryid,null,'IP',cppafffactor,cppunafffactor);

      aff_maxid:=aff_maxid+1;

     else

      update "&1".affiliation_factor set (affiliated_factor,unaffiliated_factor)=
      (select procafffactor,procunafffactor from dual) 
      where country_id=countryid and type = 'PAP';

      update "&1".affiliation_factor set (affiliated_factor,unaffiliated_factor)=
      (select cppafffactor,cppunafffactor from dual) 
      where country_id=countryid and type = 'IP';
  
     end if;

    else

       select factor into cppafffactor from tsm_stage.aff 
       where country = ix1.country and not upper("DESC") like '%UNAFF%'
       and upper(category) like '%CPP%' 
       and ther_area is null;

       select factor into cppunafffactor from tsm_stage.aff 
       where country = ix1.country and upper("DESC") like '%UNAFF%'
       and upper(category) like '%CPP%' 
       and ther_area is null;  

     if aff_exist = 0 then 

       Insert into "&1".affiliation_factor values (aff_maxid,
       countryid,null,'IP',cppafffactor,cppunafffactor);      

       aff_maxid:=aff_maxid+1;

      else

       update "&1".affiliation_factor set (affiliated_factor,unaffiliated_factor)=
       (select cppafffactor,cppunafffactor from dual) 
       where country_id=countryid and type = 'IP';

      end if;
    end if;
 end loop;

 for ix2 in c2 loop

   select id into indmapid from "&1".indmap where code = 
   decode(ix2.ther_area,'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
   'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY',
   'I','ENDOCRINE','K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY',
   'N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
   'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA')
   and type = 'Therapeutic Area';

   select id into countryid from "&1".country where abbreviation='USA';

   select count(*) into indmap_exist from "&1".affiliation_factor where
   country_id = countryid and indmap_id=indmapid and type='IP';

   select factor into cppafffactor from tsm_stage.aff 
   where ther_area = ix2.ther_area 
   and not upper("DESC") like '%UNAFF%';

   select factor into cppunafffactor from tsm_stage.aff 
   where ther_area = ix2.ther_area 
   and upper("DESC") like '%UNAFF%';

   If indmap_exist=0 then

     insert into "&1".affiliation_factor values (aff_maxid,
     countryid,indmapid,'IP',cppafffactor,cppunafffactor);

     aff_maxid:=aff_maxid+1;

   else

     update "&1".affiliation_factor set (affiliated_factor,unaffiliated_factor)=
     (select cppafffactor,cppunafffactor from dual) 
     where country_id=countryid and type = 'IP' and indmap_id=indmapid;  

   end if;
 end loop;
 commit;
end;
/

sho err

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:41 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:39 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:14:35 PM Debashish Mishra  
--  2    DevTSM    1.1         5/6/2003 9:37:08 AM  Debashish Mishra fixed the
--       spelling mistake in ophthalmology
--  1    DevTSM    1.0         2/19/2003 1:50:58 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_name_master.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:53 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------



alter table tsm_stage.cro_name_master1 add country_id number(10);

alter table tsm_stage.cro_name_master1 add region_id number(10);
 
update tsm_stage.cro_name_master1 set cntry = 'UK' where cro = 'VANTX Research Ltd'
  and cntry is null;

 update tsm_stage.cro_name_master1 a set a.country_id  = (select b.id from "&1".country b where
 b.abbreviation = a.cntry);

 update tsm_stage.cro_name_master1 a set a.region_id  = (select b.id from "&1".region b where
 b.abbreviation = a.state and b.type = 'State' and b.country_id = a.country_id);
commit;

declare
rowexists number(5);
maxid  number(10);
cursor c1 is select crocode from tsm_stage.cro_name_master1 where country_id is not null;
begin

select nvl(max(id),0)+1 into maxid from "&1".cro_name_master;

for ix1 in c1 loop

  select count(*) into rowexists from "&1".cro_name_master where cro_code=ix1.crocode;
  
   if rowexists > 0 then 

       update "&1".cro_name_master a set (a.CRO_NAME,a.COUNTRY_ID,a.CRO_SIZE,a.ADDRESS,a.CITY,           
       a.REGION_ID,a.ZIPCODE,a.COMMENTS)= (select b.cro,country_id,b.cro_size,b.address,b.city,
       b.region_id,b.zipcode,b.comments  from tsm_stage.cro_name_master1 b where b.crocode=ix1.crocode)
       where a.cro_code=ix1.crocode;

   else

      insert into "&1".cro_name_master(ID,CRO_CODE,CRO_NAME,COUNTRY_ID,CRO_SIZE,ADDRESS,CITY,           
      REGION_ID,ZIPCODE,COMMENTS) select maxid,CROCODE,cro,country_id,cro_size,address,city,
      region_id,zipcode,comments  from tsm_stage.cro_name_master1 where crocode=ix1.crocode;

     maxid:=maxid+1;
   end if;
end loop;
end;
/

commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:53 PM Debashish Mishra  
--  4    DevTSM    1.3         1/4/2007 6:38:04 PM  Debashish Mishra  
--  3    DevTSM    1.2         11/10/2006 12:29:47 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:07:01 PMDebashish Mishra  
--  1    DevTSM    1.0         9/19/2006 12:14:07 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

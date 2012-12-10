--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: country_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:41 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
-- can be directly inserted into tsm10 from build_code1
-- initial step required

update tsm_stage.country2 set name = 'Russia, Estonia, Latvia, Lithuania' 
where abbreviation='FSU';
commit;

 
declare

 cursor c1 is select abbreviation,name from tsm_stage.country2;
 cntry_exist number(3);
 cntry_viewable varchar2(1);
 cntry_maxid  number(10);
 inserted_rows number(10):=0;
 updated_rows number(10):=0;
 need_update number(3);

begin

 select max(id)+1 into cntry_maxid from "&1".country;

 for ix1 in c1 loop
  
   select count(*) into cntry_exist from "&1".country where abbreviation = ix1.abbreviation;
   select substr(ix1.name,1,1) into cntry_viewable from dual;


	If cntry_exist = 0 and cntry_viewable = 'a' then

	   Insert into "&1".country(id,name,abbreviation,is_viewable) select
           cntry_maxid, substr(name,2),abbreviation,0 from tsm_stage.country2 where 
           abbreviation = ix1.abbreviation;

           cntry_maxid:=cntry_maxid+1;
           inserted_rows:=inserted_rows+1;

        elsif cntry_exist = 0 and cntry_viewable <> 'a' then

	   Insert into "&1".country(id,name,abbreviation,is_viewable) select
           cntry_maxid, name,abbreviation,1 from tsm_stage.country2 where 
           abbreviation = ix1.abbreviation;

           cntry_maxid:=cntry_maxid+1;
           inserted_rows:=inserted_rows+1;
 
        elsif cntry_exist > 0 and cntry_viewable = 'a' then
 
           select count(*) into need_update from "&1".country where
           abbreviation = ix1.abbreviation and name = substr(ix1.name,2);

           If need_update = 0 then

	     update "&1".country set name  =  substr(ix1.name,2)
             where abbreviation = ix1.abbreviation;

             updated_rows:=updated_rows+1;

           End if;

        elsif cntry_exist > 0 and cntry_viewable <> 'a' then

           select count(*) into need_update from "&1".country where
           abbreviation = ix1.abbreviation and name = ix1.name;

           If need_update = 0 then

	     update "&1".country set name  =  ix1.name
             where abbreviation = ix1.abbreviation;

             updated_rows:=updated_rows+1;

           End if;

        End if;
 end loop;

  Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Country',inserted_rows,updated_rows);

 commit;
end;
/


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:41 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:40 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:36 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:50:59 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: c:\tsm\Database\DJMaps\inc_load\country_inc.sql$ 
--
-- $Revision: 14$        $Date: 3/3/2010 3:21:22 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
-- can be directly inserted into tsm10 from build_code1
-- initial step required

update tsm_stage.country2 set name = 'Russia, Estonia, Latvia, Lithuania' 
where abbreviation='FSU';

--Following updates commented on 10/07/2009 as part of GM3.0 conflicts
--with 2009Q4 45master.
--update tsm_stage.country2 set name = 'Australia, New Zealand' 
--where abbreviation='AUS';
--update tsm_stage.country2 set name = 'India, Pakistan' 
--where abbreviation='IND';

update tsm_stage.country2 set name = 'South Korea' 
where abbreviation='KOR';
update tsm_stage.country2 set name='Eastern Europe' 
where abbreviation='EAE';


update tsm_stage.country2 set abbreviation='EEU' where abbreviation='EAE';
update tsm_stage.country2 set abbreviation='WEU' where abbreviation='WE';


-- Remove following two lines after CRO PBT is deployed in production

update "&1".country set abbreviation='EEU' where abbreviation='EAE';
update "&1".country set abbreviation='WEU' where abbreviation='WE';


commit;



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
           cntry_maxid, name,abbreviation,0 from tsm_stage.country2 where 
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
--  14   DevTSM    1.13        3/3/2010 3:21:22 PM  Mahesh Pasupuleti Include
--       latest changes
--  13   DevTSM    1.12        2/27/2008 3:17:06 PM Debashish Mishra  
--  12   DevTSM    1.11        2/7/2007 10:27:58 PM Debashish Mishra  
--  11   DevTSM    1.10        5/23/2006 8:28:03 AM Debashish Mishra  
--  10   DevTSM    1.9         4/9/2006 1:05:51 PM  Debashish Mishra  
--  9    DevTSM    1.8         10/26/2005 3:44:11 PMDebashish Mishra  
--  8    DevTSM    1.7         9/29/2005 11:18:53 AMDebashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:40:22 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:13:10 PM Debashish Mishra  
--  5    DevTSM    1.4         8/30/2002 12:43:06 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  4    DevTSM    1.3         7/1/2002 11:32:57 AM Debashish Mishra name change
--       for FSU
--  3    DevTSM    1.2         6/17/2002 10:58:11 AMDebashish Mishra name changed
--       from former soviet union block to Lithuania, Latvia, Estonia, Russia
--  2    DevTSM    1.1         5/6/2002 8:03:51 AM  Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:05 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

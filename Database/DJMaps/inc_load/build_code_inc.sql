--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: build_code_inc.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:06 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
-- can be directly inserted into tsm10 from build_code1
-- No initial step required

declare

 build_code_exist number(3);
 cursor c1 is select code,name from tsm_stage.build_code1;
 build_code_maxid number(10);
 inserted_rows number(10):=0;
 updated_rows number(10):=0;
 need_update number(3);

begin

 select nvl(max(id),0)+1 into build_code_maxid from "&1".build_code;

 for ix1 in c1 loop
 
 select count(*) into build_code_exist from "&1".build_code where
 code = ix1.code;

 if build_code_exist = 0 then 
   Insert into "&1".build_code(id,code,name) values(build_code_maxid,
   ix1.code, ix1.name);

   build_code_maxid:=build_code_maxid+1;
   inserted_rows:=inserted_rows+1;

 else

   select count(*) into need_update from "&1".build_code where 
   code = ix1.code and name = ix1.name;

   If need_update = 0 then

     update "&1".build_code set name = ix1.name where code = ix1.code;

     updated_rows:=updated_rows+1;

   End if;

 end if;

 end loop;

 select count(*) into build_code_exist from "&1".build_code where code = 'UNK';

 if build_code_exist = 0 then 
   Insert into "&1".build_code(id,code,name) values(build_code_maxid,
   'UNK','Unknown');

   build_code_maxid:=build_code_maxid+1;
   inserted_rows:=inserted_rows+1;

 else

   select count(*) into need_update from "&1".build_code where 
   code = 'UNK' and name = 'Unknown';

   If need_update = 0 then

     update "&1".build_code set name = 'Unknown' where code = 'UNK';

     updated_rows:=updated_rows+1;

   End if;

 end if;

 Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Build_code',inserted_rows,updated_rows);

 commit;

end;
/



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:06 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:27:57 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:21 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:10 PM Debashish Mishra  
--  3    DevTSM    1.2         8/30/2002 12:43:05 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  2    DevTSM    1.1         5/6/2002 8:03:51 AM  Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:05 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

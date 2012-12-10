--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: indmap_inc.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:17:06 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
-- can be directly inserted into tsm10 from build_code1
-- no initial step required

drop table tsm_stage.indmap1;
create table tsm_stage.indmap1 as select * from "&1".indmap where 1=2;


Delete from tsm_stage.indmstr where rowid not in (select min(rowid)
from tsm_stage.indmstr group by INDCODE, "GROUP");

commit;

drop sequence tsm_stage.indmap1_seq;
create sequence tsm_stage.indmap1_seq;


declare

cursor c1 is select distinct category from tsm_stage.indmstr;
id1 number(10);

begin

for ix1 in c1 loop

select tsm_stage.indmap1_seq.nextval into id1 from dual;

Insert into tsm_stage.indmap1 values(id1,null,ix1.category,'Therapeutic Area', 
'Therapeutic Area',null,null);

declare

cursor c2 is select distinct "GROUP" from tsm_stage.indmstr where category=ix1.category
	and trim("GROUP") is not null;
id2 number(10);

begin

for ix2 in c2 loop

select tsm_stage.indmap1_seq.nextval into id2 from dual;

Insert into tsm_stage.indmap1 values(id2,id1,ix2."GROUP",'Indication Group',
'Indication Group',null,null);

declare

cursor c3 is select rowid from tsm_stage.indmstr where "GROUP" = ix2."GROUP"
	and category = ix1.category;
id3 number(10);

begin

for ix3 in c3 loop

select tsm_stage.indmap1_seq.nextval into id3 from dual;

Insert into tsm_stage.indmap1 select id3,id2,indcode,"DESC",'Indication',
null,null from tsm_stage.indmstr where  rowid = ix3.rowid;


end loop;
end;
end loop;
end;
end loop;
end;
/


Alter table tsm_stage.indmap1 add(de_code varchar2(1));

update tsm_stage.indmap1 set de_code = code where type = 'Therapeutic Area';

commit;

update tsm_stage.indmap1 set code = 'CARDIOVASCULAR' where de_code = 'A';
update tsm_stage.indmap1 set code = 'GASTROINTESTINAL' where de_code = 'B';
update tsm_stage.indmap1 set code = 'CENTRAL NERVOUS SYSTEM' where de_code = 'C';
update tsm_stage.indmap1 set code = 'ANTI-INFECTIVE' where de_code = 'D';
update tsm_stage.indmap1 set code = 'ONCOLOGY' where de_code = 'E';
update tsm_stage.indmap1 set code = 'IMMUNOMODULATION' where de_code = 'F';
update tsm_stage.indmap1 set code = 'DERMATOLOGY' where de_code = 'H';
update tsm_stage.indmap1 set code = 'ENDOCRINE' where de_code = 'I';
update tsm_stage.indmap1 set code = 'PHARMACOKINETIC' where de_code = 'K';
update tsm_stage.indmap1 set code = 'HEMATOLOGY' where de_code = 'L';
update tsm_stage.indmap1 set code = 'OPHTHALMOLOGY' where de_code = 'M';
update tsm_stage.indmap1 set code = 'GENITOURINARY SYSTEM' where de_code = 'N';
update tsm_stage.indmap1 set code = 'RESPIRATORY SYSTEM' where de_code = 'O';
update tsm_stage.indmap1 set code = 'PAIN AND ANESTHESIA' where de_code = 'P';
update tsm_stage.indmap1 set code = 'DEVICES AND DIAGNOSTICS' where de_code = 'Q';
update tsm_stage.indmap1 set code = 'UNKNOWN THERAPEUTIC AREA' where de_code = 'Z';

commit;

--insert into tsm_stage.indmap1 (id,code,short_desc,type) values (0,'All','All','Therapeutic Area');

--commit;

-- Following changes are done after the data meeting held with DE on 02/18/2002 at 12:30 

declare

parentid number(10);

cursor c1 is select indcode,"DESC",category from tsm_stage.indmstr where indcode in
        (select indcode from tsm_stage.indmstr  where "GROUP" is null minus
	select a.code from tsm_stage.indmap1 a, tsm_stage.indmstr b where
	a.code = b.indcode and b."GROUP" is null and
	a.type = 'Indication Group');

begin

   for ix1 in c1 loop

   select id into parentid from tsm_stage.indmap1 where de_code = ix1.category and
   type = 'Therapeutic Area';

   Insert into tsm_stage.indmap1(id,parent_indmap_id,code,short_desc,type,de_code) 
   values (tsm_stage.indmap1_seq.nextval,parentid,ix1.indcode,ix1."DESC",'Indication Group',ix1.category);

   end loop;

   commit;

end;
/
sho err

update tsm_stage.indmap1 a set a.short_desc = (select b."DESC" from tsm_stage.indmstr b where
b.indcode = a.code and b."GROUP" is null) where
a.type = 'Indication Group';

update tsm_stage.indmap1 set short_desc = 'Special Group' where code = 'SPECIAL' and
type = 'Indication Group';

commit;

--update tsm_stage.indmap1 set code = 'All' where id=0 and code is null;

--commit;

--************************************
--Differential load starts here
--************************************

declare

 cursor c1 is select id,code,short_desc from tsm_stage.indmap1 where type = 'Therapeutic Area';
 indmap_maxid number(10);
 ta_exist number(3);
 group_exist number(3);
 ind_exist number(3);
 ta_id number(10);
 group_id number(10);
 ta_insert number(1);
 group_insert number(1);
 inserted_rows number(10):=0;
 updated_rows number(10):=0;
 need_update number(3);

begin

 select nvl(max(id),0)+1 into indmap_maxid from "&1".indmap;

 for ix1 in c1 loop 
  select count(*) into ta_exist from "&1".indmap where code = ix1.code and
  type = 'Therapeutic Area';

  If ta_exist = 0 then
    Insert into "&1".indmap values (indmap_maxid,null,ix1.code,ix1.short_desc,
    'Therapeutic Area',null,null);

    ta_id:=indmap_maxid;
    indmap_maxid:=indmap_maxid+1;
    ta_insert:=1;
    inserted_rows:=inserted_rows+1;
    
  else

    select count(*) into need_update from "&1".indmap where code = ix1.code and
    type = 'Therapeutic Area' and short_desc = ix1.short_desc;
 
    If need_update = 0 then

      update "&1".indmap set short_desc = ix1.short_desc where 
      code = ix1.code and type = 'Therapeutic Area';

      updated_rows:=updated_rows+1;
    
    End if;
  
    select id into ta_id from "&1".indmap where code = ix1.code and
    type = 'Therapeutic Area';

    ta_insert:=0;

  end if;

  declare
    cursor c2 is select id,parent_indmap_id,code,short_desc from tsm_stage.indmap1 
    where parent_indmap_id=ix1.id and type = 'Indication Group';
    
  begin

    for ix2 in c2 loop

    If ta_insert=1 then 

       Insert into "&1".indmap values (indmap_maxid,ta_id,ix2.code,ix2.short_desc,
       'Indication Group',null,null);
       
       group_id:=indmap_maxid;
       indmap_maxid:=indmap_maxid+1;
       group_insert:=1;
       inserted_rows:=inserted_rows+1;

    else

       select count(*) into group_exist from "&1".indmap where code=ix2.code and
       type = 'Indication Group';

       If group_exist = 0 then

         Insert into "&1".indmap values (indmap_maxid,ta_id,ix2.code,ix2.short_desc,
         'Indication Group',null,null);

         group_id:=indmap_maxid;
         indmap_maxid:=indmap_maxid+1;
         group_insert:=1;
         inserted_rows:=inserted_rows+1;

       else

         select count(*) into need_update from "&1".indmap where code = ix2.code and
         type = 'Indication Group' and short_desc = ix2.short_desc;

         If need_update = 0 then

            update "&1".indmap set short_desc = ix2.short_desc where
            code = ix2.code and type = 'Indication Group';
            
            updated_rows:=updated_rows+1;

         End if;

         select id into group_id from "&1".indmap where code=ix2.code and
         type = 'Indication Group';

         group_insert:=0;

       end if;
     end if;

     declare

      cursor c3 is select id,parent_indmap_id,code,short_desc from tsm_stage.indmap1 
      where parent_indmap_id=ix2.id and type = 'Indication';

     begin

       for ix3 in c3 loop

       If group_insert=1 then 

          Insert into "&1".indmap values (indmap_maxid,group_id,ix3.code,ix3.short_desc,
          'Indication',null,null);
       
          indmap_maxid:=indmap_maxid+1;
          inserted_rows:=inserted_rows+1;

       else
          
          select count(*) into ind_exist from "&1".indmap where code=ix3.code and
          type = 'Indication';          
     
      
         If ind_exist = 0 then

           Insert into "&1".indmap values (indmap_maxid,group_id,ix3.code,ix3.short_desc,
          'Indication',null,null);

           indmap_maxid:=indmap_maxid+1;
           inserted_rows:=inserted_rows+1;

         else

           select count(*) into need_update from "&1".indmap where code = ix3.code and
           type = 'Indication' and short_desc = ix3.short_desc;

           If need_update = 0 then

             update "&1".indmap set short_desc = ix3.short_desc where
             code = ix3.code and type = 'Indication';

             updated_rows:=updated_rows+1;

           End if;

         end if;
       end if;
       end loop;
       end;
    end loop;
    end;
  end loop;

 Insert into "&1".data_load_history(table_name,num_inserted,num_updated) values 
 ('Indmap',inserted_rows,updated_rows);

  commit;
end;
/



declare

 parent_missing exception;
 InvalidTA exception;
 cnt  number(10);

begin

  select count(*) into cnt from "&1".indmap where  parent_indmap_id is null and
  type <> 'Therapeutic Area';

  If cnt > 0 then
    Raise parent_missing;
  end if;
 
  select count(*) into cnt from "&1".indmap where type = 'Therapeutic Area' and
  parent_indmap_id is not null;

  If cnt > 0 then
    Raise InvalidTA;
  end if;

exception

  when parent_missing then
     Raise_application_error(-20208,'parent missing for either a group or an indication');
  when InvalidTA then
     Raise_application_error(-20209,'TA can not have a parent indmap id');

end;
/
sho err








---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:17:06 PM Debashish Mishra  
--  8    DevTSM    1.7         2/7/2007 10:28:01 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:40:23 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:13:11 PM Debashish Mishra  
--  5    DevTSM    1.4         5/6/2003 9:36:30 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  4    DevTSM    1.3         8/30/2002 12:43:07 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  3    DevTSM    1.2         5/6/2002 8:03:52 AM  Debashish Mishra  
--  2    DevTSM    1.1         3/22/2002 4:40:35 PM Debashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:06 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

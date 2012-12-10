--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: indmap.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:16:39 PM$
--
--
-- Description:  Load data into indmap
--
---------------------------------------------------------------------
 
Delete from indmstr where rowid not in (select min(rowid)
from indmstr group by INDCODE, "GROUP");

commit;

drop sequence indmap_seq;
create sequence indmap_seq;


declare

cursor c1 is select distinct category from indmstr;
id1 number(10);

begin

for ix1 in c1 loop

select indmap_seq.nextval into id1 from dual;

Insert into indmap values(id1,null,ix1.category,'Therapeutic Area', 
'Therapeutic Area',null,null);

declare

cursor c2 is select distinct "GROUP" from indmstr where category=ix1.category
	and trim("GROUP") is not null;
id2 number(10);

begin

for ix2 in c2 loop

select indmap_seq.nextval into id2 from dual;

Insert into indmap values(id2,id1,ix2."GROUP",'Indication Group',
'Indication Group',null,null);

declare

cursor c3 is select rowid from indmstr where "GROUP" = ix2."GROUP"
	and category = ix1.category;
id3 number(10);

begin

for ix3 in c3 loop

select indmap_seq.nextval into id3 from dual;

Insert into indmap select id3,id2,indcode,"DESC",'Indication',
null,null from indmstr where  rowid = ix3.rowid;


end loop;
end;
end loop;
end;
end loop;
end;
/


Alter table indmap add(de_code varchar2(1));

update indmap set de_code = code where type = 'Therapeutic Area';

commit;

update indmap set code = 'CARDIOVASCULAR' where de_code = 'A';
update indmap set code = 'GASTROINTESTINAL' where de_code = 'B';
update indmap set code = 'CENTRAL NERVOUS SYSTEM' where de_code = 'C';
update indmap set code = 'ANTI-INFECTIVE' where de_code = 'D';
update indmap set code = 'ONCOLOGY' where de_code = 'E';
update indmap set code = 'IMMUNOMODULATION' where de_code = 'F';
update indmap set code = 'DERMATOLOGY' where de_code = 'H';
update indmap set code = 'ENDOCRINE' where de_code = 'I';
update indmap set code = 'PHARMACOKINETIC' where de_code = 'K';
update indmap set code = 'HEMATOLOGY' where de_code = 'L';
update indmap set code = 'OPHTHALMOLOGY' where de_code = 'M';
update indmap set code = 'GENITOURINARY SYSTEM' where de_code = 'N';
update indmap set code = 'RESPIRATORY SYSTEM' where de_code = 'O';
update indmap set code = 'PAIN AND ANESTHESIA' where de_code = 'P';
update indmap set code = 'DEVICES AND DIAGNOSTICS' where de_code = 'Q';
update indmap set code = 'UNKNOWN THERAPEUTIC AREA' where de_code = 'Z';

commit;

insert into indmap (id,code,short_desc,type) values (0,'All','All','Therapeutic Area');

commit;

-- Following changes are done after the data meeting held with DE on 02/18/2002 at 12:30 

declare

parentid number(10);

cursor c1 is select indcode,"DESC",category from indmstr where indcode in
        (select indcode from indmstr  where "GROUP" is null minus
	select a.code from indmap a, indmstr b where
	a.code = b.indcode and b."GROUP" is null and
	a.type = 'Indication Group');

begin

   for ix1 in c1 loop

   select id into parentid from indmap where de_code = ix1.category and
   type = 'Therapeutic Area';

   Insert into indmap(id,parent_indmap_id,code,short_desc,type,de_code) 
   values (indmap_seq.nextval,parentid,ix1.indcode,ix1."DESC",'Indication Group',ix1.category);

   end loop;

   commit;

end;
/
sho err

update indmap a set a.short_desc = (select b."DESC" from indmstr b where
b.indcode = a.code and b."GROUP" is null) where
a.type = 'Indication Group';

update indmap set short_desc = 'Special Group' where code = 'SPECIAL' and
type = 'Indication Group';

commit;

update indmap set code = 'All' where id=0 and code is null;

commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:16:39 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:38:54 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:11:41 PM Debashish Mishra  
--  6    DevTSM    1.5         5/6/2003 9:37:26 AM  Debashish Mishra Fixed the
--       spelling of ophthalmology
--  5    DevTSM    1.4         3/6/2002 7:03:21 PM  Debashish Mishra  
--  4    DevTSM    1.3         2/27/2002 1:46:23 PM Debashish Mishra  
--  3    DevTSM    1.2         2/18/2002 5:07:10 PM Debashish Mishra  
--  2    DevTSM    1.1         2/5/2002 2:54:44 PM  Debashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:13 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

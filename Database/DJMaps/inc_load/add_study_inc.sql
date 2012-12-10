--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: add_study_inc.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:17:06 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

truncate table "&1".add_study;

drop sequence "&1".add_study_seq;
create sequence "&1".add_study_seq;


Alter table tsm_stage.add_study1 add(country_id number(10),
payment_country_id number(10),
odc_def_id number(10));


declare

 odcdef_maxid number(10);
 mapper_maxid number(10);
 cursor c1 is select proc_code, min(rowid) minrowid 
	from tsm_stage.add_study1 group by proc_code;
 od_exist number(3);

begin

  select nvl(max(id),0)+1 into mapper_maxid from "&1".mapper;
  select nvl(max(id),0)+1 into odcdef_maxid from "&1".odc_def;   

 for ix1 in c1 loop

  select count(*) into od_exist from "&1".odc_def where picas_code = ix1.proc_code;

  if od_exist = 0 then


    Insert into "&1".odc_def (ID, PICAS_CODE, LONG_DESC, PROCEDURE_LEVEL) select
    odcdef_maxid,ix1.proc_code,proc_desc,'Study' from
    tsm_stage.add_study1 where rowid = ix1.minrowid;

    Insert into "&1".mapper values (mapper_maxid,odcdef_maxid,null);

    mapper_maxid:=mapper_maxid+1;
    odcdef_maxid:=odcdef_maxid+1;


  else

    update "&1".odc_def set long_desc = (select proc_desc from 
    tsm_stage.add_study1 where rowid = ix1.minrowid)
    where picas_code = ix1.proc_code and procedure_level='Study';

  end if;

 end loop;
end;
/
sho err

update tsm_stage.add_study1 a set a.country_id = (select b.id
from "&1".country b where b.ABBREVIATION = a.country);

update tsm_stage.add_study1 a set a.payment_country_id = (select b.id
from "&1".country b where b.abbreviation = a.payment_country);

update tsm_stage.add_study1 a set a.odc_def_id = (select b.id
from "&1".odc_def b where b.picas_code = a.proc_code);


Insert into "&1".add_study select "&1".add_study_seq.nextval,
COUNTRY_ID,ODC_DEF_ID,PAYMENT_COUNTRY_ID,PCT25,PCT50,PCT75,9
from tsm_stage.add_study1;

commit;
















---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:17:06 PM Debashish Mishra  
--  8    DevTSM    1.7         2/7/2007 10:27:56 PM Debashish Mishra  
--  7    DevTSM    1.6         1/11/2006 12:16:42 PMDebashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:40:20 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:13:09 PM Debashish Mishra  
--  4    DevTSM    1.3         1/21/2003 6:07:45 PM Debashish Mishra dropped and
--       recreated the sequence
--  3    DevTSM    1.2         1/21/2003 1:14:46 PM Debashish Mishra no change
--  2    DevTSM    1.1         8/30/2002 12:43:04 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  1    DevTSM    1.0         4/22/2002 3:24:02 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

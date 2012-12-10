--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: add_study.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:16:38 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

declare

 odcdef_maxid number(10);
 mapper_maxid number(10);
 cursor c1 is select proc_code, min(rowid) minrowid 
	from tsm_stage.add_study1 group by proc_code;

begin

  select nvl(max(id),0)+1 into mapper_maxid from tsm10.mapper;
  select nvl(max(id),0)+1 into odcdef_maxid from tsm10.odc_def;   

 for ix1 in c1 loop

    Insert into tsm10.odc_def (ID, PICAS_CODE, LONG_DESC, PROCEDURE_LEVEL) select
    odcdef_maxid,ix1.proc_code,proc_desc,'Study' from
    tsm_stage.add_study1 where rowid = ix1.minrowid;

    Insert into tsm10.mapper values (mapper_maxid,odcdef_maxid,null);

    mapper_maxid:=mapper_maxid+1;
    odcdef_maxid:=odcdef_maxid+1;

 end loop;
end;
/
sho err


Alter table tsm_stage.add_study1 add(country_id number(10),
payment_country_id number(10),
odc_def_id number(10));

update tsm_stage.add_study1 a set a.country_id = (select b.id
from tsm10.country b where b.ABBREVIATION = a.country);

update tsm_stage.add_study1 a set a.payment_country_id = (select b.id
from tsm10.country b where b.abbreviation = a.payment_country);

update tsm_stage.add_study1 a set a.odc_def_id = (select b.id
from tsm10.odc_def b where b.picas_code = a.proc_code);

Insert into tsm10.add_study select tsm10.add_study_seq.nextval,
COUNTRY_ID,ODC_DEF_ID,PAYMENT_COUNTRY_ID,PCT25,PCT50,PCT75
from tsm_stage.add_study1;

commit;






---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:16:38 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:38:48 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:11:36 PM Debashish Mishra  
--  1    DevTSM    1.0         4/22/2002 3:26:19 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

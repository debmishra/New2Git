--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: md_odc_oh_pct.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
delete from tsm_stage.md_odc_oh_pct1 where country = 'xcntry1';

Alter table tsm_stage.md_odc_oh_pct1 add(country_id number(10), 
TA_DESC varchar2(128), TA_ID number(10));

update tsm_stage.md_odc_oh_pct1 set country = trim(country);
update tsm_stage.md_odc_oh_pct1 set ta = trim(ta);
update tsm_stage.md_odc_oh_pct1 set ohp = trim(ohp);
update tsm_stage.md_odc_oh_pct1 set odcp = trim(odcp);

update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'CARDIOVASCULAR' where ta = 'A';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'GASTROINTESTINAL' where ta = 'B';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'CENTRAL NERVOUS SYSTEM' where ta = 'C';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'ANTI-INFECTIVE' where ta = 'D';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'ONCOLOGY' where ta = 'E';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'IMMUNOMODULATION' where ta = 'F';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'DERMATOLOGY' where ta = 'H';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'ENDOCRINE' where ta = 'I';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'PHARMACOKINETIC' where ta = 'K';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'HEMATOLOGY' where ta = 'L';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'OPHTHALMOLOGY' where ta = 'M';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'GENITOURINARY SYSTEM' where ta = 'N';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'RESPIRATORY SYSTEM' where ta = 'O';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'PAIN AND ANESTHESIA' where ta = 'P';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'DEVICES AND DIAGNOSTICS' where ta = 'Q';
update tsm_stage.md_odc_oh_pct1 set TA_DESC = 'UNKNOWN THERAPEUTIC AREA' where ta = 'Z';

commit;

update tsm_stage.md_odc_oh_pct1 a set a.ta_id = (select b.id from 
"&1".indmap b where b.code = a.ta_desc and b.parent_indmap_id is null);

update tsm_stage.md_odc_oh_pct1 set country_id=0 where country = 'EU';

update tsm_stage.md_odc_oh_pct1 a set a.country_id = (select b.id from 
"&1".country b where b.abbreviation = trim(a.country) )
where a.country <> 'EU';

commit;

drop sequence "&1".md_odc_oh_pct_seq;
create sequence "&1".md_odc_oh_pct_seq;

truncate table "&1".md_odc_oh_pct;

Insert into "&1".md_odc_oh_pct(ID,COUNTRY_ID,TA_ID,OH_PCT,ODC_PCT)
select  "&1".md_odc_oh_pct_seq.nextval, COUNTRY_ID,TA_ID,to_number(OHP),to_number(ODCP)
from tsm_stage.md_odc_oh_pct1 where ta_id is not null;
    
commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:09 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:17 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:38 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:24 PM Debashish Mishra  
--  3    DevTSM    1.2         5/6/2003 9:36:33 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  2    DevTSM    1.1         9/12/2002 11:45:06 AMDebashish Mishra  
--  1    DevTSM    1.0         9/6/2002 2:24:18 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

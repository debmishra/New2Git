--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: modelled_upfence.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:11 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table tsm_stage.modelled_upfence add(country_id number(10), ta_id number(10));

delete from tsm_stage.modelled_upfence where lower(country) = 'xcntry';

update tsm_stage.modelled_upfence set country = 'AUS' where country='AUS1';
update tsm_stage.modelled_upfence set country = 'AUS' where country='UK1';

update tsm_stage.modelled_upfence a set a.country_id = (select id from "&1".country b
where b.abbreviation = a.country);

update tsm_stage.modelled_upfence a set a.ta_id = (select id from "&1".indmap b
where b.code = decode(a.category,'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
	'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE',
	'K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM',
	'O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA','Q','DEVICES AND DIAGNOSTICS',
	'Z','UNKNOWN THERAPEUTIC AREA') and b.type = 'Therapeutic Area' and b.parent_indmap_id is null);


commit;

drop sequence "&1".modelled_upfence_seq;
create sequence "&1".modelled_upfence_seq;

truncate table "&1".modelled_upfence;

Insert into "&1".modelled_upfence(ID,COUNTRY_ID,TA_ID,UPFENCE)
select "&1".modelled_upfence_seq.nextval,COUNTRY_ID,TA_ID,UPFENCE
from tsm_stage.modelled_upfence where ta_id is not null;

commit;





---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:11 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:27 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:42 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:27 PM Debashish Mishra  
--  3    DevTSM    1.2         5/6/2003 9:36:34 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  2    DevTSM    1.1         9/26/2002 4:09:55 PM Debashish Mishra replaced tsm10
--       with &1
--  1    DevTSM    1.0         9/25/2002 4:14:58 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

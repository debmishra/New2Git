--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: modelled_inclusion.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create table tsm_stage.modelled_inclusion (name varchar2(40),
coeff_type varchar2(7) ,
coeff_value varchar2(20));

truncate table tsm_stage.modelled_inclusion;

Insert into tsm_stage.modelled_inclusion (name,coeff_type) select 
name,'COMPANY' from tsm_stage.xcompany where lower(name) not like 'xcompany%' ;
Insert into tsm_stage.modelled_inclusion (name,coeff_type) select 
name,'INDGRP' from tsm_stage.xcategory where lower(name) not like 'xcategory%' ;
Insert into tsm_stage.modelled_inclusion (name,coeff_type) select 
name,'PROC' from tsm_stage.xprocedure where lower(name) not like 'xprocedure%' ;
Insert into tsm_stage.modelled_inclusion (name,coeff_type) select 
name,'COUNTRY' from tsm_stage.xcntry where lower(name) not like 'xcntry%' ;

update tsm_stage.modelled_inclusion set name = trim(name);

update tsm_stage.modelled_inclusion set coeff_type = 'TA' where
coeff_type='INDGRP' and length(name)=6 and name like 'OTHR%';

update tsm_stage.modelled_inclusion set name=substr(name,6,1) where
coeff_type = 'TA';

update tsm_stage.modelled_inclusion set name='AUS' where name='AUS1';
update tsm_stage.modelled_inclusion set name='UK' where name='UK1';

update tsm_stage.modelled_inclusion set name=substr(name,2) where
substr(name,1,1)='_' and coeff_type='PROC';

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".country a where a.abbreviation = b.name) where
b.coeff_type='COUNTRY';

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".build_code a where a.code = decode(b.name,'OTHR','UNK',b.name)) 
where b.coeff_type='COMPANY';

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".indmap a where a.code = b.name and a.type = 'Indication Group') where
b.coeff_type='INDGRP';

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".indmap a where a.code = decode(b.name,'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
	'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE',
	'K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM',
	'O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA','Q','DEVICES AND DIAGNOSTICS',
	'Z','UNKNOWN THERAPEUTIC AREA')
and a.type = 'Therapeutic Area' and a.parent_indmap_id is null) where
b.coeff_type='TA';

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".procedure_def a where a.cpt_code = b.name) where
b.coeff_type='PROC' and b.coeff_value is null;

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".procedure_def a where a.cpt_code = '*'||b.name) where
b.coeff_type='PROC' and b.coeff_value is null;

update tsm_stage.modelled_inclusion b set b.coeff_value = (select 
a.id from "&1".procedure_def a where a.cpt_code = '*'||b.name||'*') where
b.coeff_type='PROC' and b.coeff_value is null;

commit;
 
drop sequence "&1".modelled_inclusion_seq;
create sequence "&1".modelled_inclusion_seq;

truncate table "&1".modelled_inclusion;

Insert into "&1".modelled_inclusion(ID,COEFF_TYPE,COEFF_VALUE)
select "&1".modelled_inclusion_seq.nextval,COEFF_TYPE,COEFF_VALUE
from tsm_stage.modelled_inclusion;

commit;

drop table tsm_stage.modelled_inclusion;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:09 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:20 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:40 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:26 PM Debashish Mishra  
--  3    DevTSM    1.2         5/6/2003 9:36:34 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  2    DevTSM    1.1         9/26/2002 4:09:53 PM Debashish Mishra replaced tsm10
--       with &1
--  1    DevTSM    1.0         9/25/2002 4:14:57 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

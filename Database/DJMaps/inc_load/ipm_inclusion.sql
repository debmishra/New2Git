--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_inclusion.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.ipm_xcategory set short_desc = trim(short_desc);
delete from tsm_stage.ipm_xcategory where short_desc='xcategory';

drop sequence tsm_stage.ipm_inclusion_seq;
create sequence tsm_stage.ipm_inclusion_seq;

truncate table "&1".ipm_inclusion;

Insert into "&1".ipm_inclusion select tsm_stage.ipm_inclusion_seq.nextval,'TA',b.id 
from "&1".indmap b, tsm_stage.ipm_xcategory a where b.parent_indmap_id is null and 
b.code= decode(substr(a.short_desc,6,1),'A','CARDIOVASCULAR',
'B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM', 'D','ANTI-INFECTIVE','E','ONCOLOGY',
'F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE', 'K','PHARMACOKINETIC','L','HEMATOLOGY',
'M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA') and a.short_desc like 'OTHR%' and 
length(a.short_desc)=6;

Insert into "&1".ipm_inclusion select tsm_stage.ipm_inclusion_seq.nextval,'INDGRP',b.id 
from "&1".indmap b, tsm_stage.ipm_xcategory a where not a.short_desc like 'OTHR%' and
b.code=a.short_desc;

commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:08 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:11 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:32 AM  Debashish Mishra  
--  4    DevTSM    1.3         8/29/2003 5:13:19 PM Debashish Mishra  
--  3    DevTSM    1.2         5/6/2003 9:36:31 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  2    DevTSM    1.1         4/1/2003 5:24:06 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/14/2003 6:00:22 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_weight.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.ipm_weight set country = trim(country);
--update tsm_stage.ipm_weight set ther_area = trim(ther_area);

delete from tsm_stage.ipm_weight where upper(country) ='COUNTRY';

drop sequence tsm_stage.ipm_weight_seq;
create sequence tsm_stage.ipm_weight_seq;

truncate table "&1".ipm_weight;

--Insert into "&1".ipm_weight select a.id, b.id,a.phase, c.id, a.affiliation,
--a.complex_minvalue, a.minvalue,a.inpatient_status from tsm_stage.ipm_weight a, "&1".country b,
--"&1".indmap c where a.country = b.abbreviation and 
--c.code=decode(a.ther_area,'A','CARDIOVASCULAR',
--'B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM', 'D','ANTI-INFECTIVE','E','ONCOLOGY',
--'F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE', 'K','PHARMACOKINETIC','L','HEMATOLOGY',
--'M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
--'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA')
--and c.parent_indmap_id is null ;

--commit;

-- Following insert statement is for Foxpro ipm_weight file
-- that tonya sent on 11/03/2003. Just run the ipm_weight_foxpro
-- conversion map and then this insert statement


Insert into "&1".ipm_weight select a.id, b.id,a.phase, c.id, a.aff,
a.cmin, a.min,a.p_status from tsm_stage.ipm_weight a, "&1".country b,
"&1".indmap c where a.country = b.abbreviation and 
c.code=decode(a.indication,'A','CARDIOVASCULAR',
'B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM', 'D','ANTI-INFECTIVE','E','ONCOLOGY',
'F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE', 'K','PHARMACOKINETIC','L','HEMATOLOGY',
'M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA')
and c.parent_indmap_id is null ;

commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:17:09 PM Debashish Mishra  
--  8    DevTSM    1.7         2/7/2007 10:28:16 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:40:37 AM  Debashish Mishra  
--  6    DevTSM    1.5         11/19/2003 12:50:16 PMDebashish Mishra Cleaned them
--       up for 1.1 patch release
--  5    DevTSM    1.4         11/4/2003 11:00:56 AMDebashish Mishra MNodified
--       after Tonya's request on11/4/2003
--  4    DevTSM    1.3         8/29/2003 5:13:23 PM Debashish Mishra  
--  3    DevTSM    1.2         5/6/2003 9:36:32 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  2    DevTSM    1.1         3/20/2003 12:09:54 PMDebashish Mishra added
--       inpatient_status to ipm_weight
--  1    DevTSM    1.0         3/14/2003 6:00:23 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

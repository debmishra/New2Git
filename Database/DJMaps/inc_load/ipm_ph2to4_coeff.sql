--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_ph2to4_coeff.sql$ 
--
-- $Revision: 13$        $Date: 2/27/2008 3:17:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update tsm_stage.ipm_ph2to4_canx_ap set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_canx_av set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_canx_bp set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_eeux_ap set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_eeux_av set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_eeux_bp set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_usax_ap set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_usax_av set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_usax_bp set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_weux_ap set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_weux_av set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph2to4_weux_bp set word1='duration' where trim(name)='duration1';

update tsm_stage.ipm_ph2to4_canx_bp set word1='IPT COMPLEX' where trim(name)='IPTcomplex';
update tsm_stage.ipm_ph2to4_usax_bp set word1='IPT COMPLEX' where trim(name)='IPTcomplex';
update tsm_stage.ipm_ph2to4_eeux_bp set word1='IPT COMPLEX' where trim(name)='IPTcomplex';
update tsm_stage.ipm_ph2to4_weux_bp set word1='IPT COMPLEX' where trim(name)='IPTcomplex';


commit;

drop table tsm_stage.ipm_ph2to4_coeff;
drop sequence tsm_stage.ipm_ph2to4_coeff_seq;

create sequence tsm_stage.ipm_ph2to4_coeff_seq;

create table tsm_stage.ipm_ph2to4_coeff (
	GEOGRAPHICAL_LOCATION VARCHAR2(10),
	INPATIENT_STATUS VARCHAR2(20),
	CPP_CPV VARCHAR2(3),
	word1 varchar2(20) not null,
	word2  varchar2(40),
	word3 varchar2(20),
	word4 varchar2(40),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

truncate table tsm_stage.ipm_ph2to4_coeff;

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_canx_ap where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ') ;

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_canx_av where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPVSQ'); 

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_canx_bp where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ');

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_usax_ap where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ') ;

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_usax_av where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ'); 

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_usax_bp where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ');

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_eeux_ap where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ') ;

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_eeux_av where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPVSQ'); 

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_eeux_bp where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ');

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_weux_ap where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ') ;

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_weux_av where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPVSQ'); 

Insert into tsm_stage.ipm_ph2to4_coeff select GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph2to4_weux_bp where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ');


update tsm_stage.ipm_ph2to4_coeff set word1 = trim(word1);
update tsm_stage.ipm_ph2to4_coeff set word2 = trim(word2);
update tsm_stage.ipm_ph2to4_coeff set word3 = trim(word3);
update tsm_stage.ipm_ph2to4_coeff set word4 = trim(word4);

update tsm_stage.ipm_ph2to4_coeff set word1='DURATION' where word1='duration';
update tsm_stage.ipm_ph2to4_coeff set word1='AFFILIATION' where word1='aff';
update tsm_stage.ipm_ph2to4_coeff set word1='PHASE' where word1='phase';
update tsm_stage.ipm_ph2to4_coeff set word1='COUNTRY GROUP' where word1='xcntry';
update tsm_stage.ipm_ph2to4_coeff set word1='TA' where word1='xcategory' 
and word2 like 'OTHR%' and length(word2)=6;
update tsm_stage.ipm_ph2to4_coeff set word1='INDGRP' where word1='xcategory' 
and not word2 like 'OTHR%';
update tsm_stage.ipm_ph2to4_coeff set word1='YEAR' where word1='year';


update tsm_stage.ipm_ph2to4_coeff set word3='DURATION' where word3='duration';
update tsm_stage.ipm_ph2to4_coeff set word3='AFFILIATION' where word3='aff';
update tsm_stage.ipm_ph2to4_coeff set word3='PHASE' where word3='phase';
update tsm_stage.ipm_ph2to4_coeff set word3='COUNTRY GROUP' where word3='xcntry';
update tsm_stage.ipm_ph2to4_coeff set word3='TA' where word3='xcategory' 
and word4 like 'OTHR%' and length(word4)=6;
update tsm_stage.ipm_ph2to4_coeff set word3='INDGRP' where word3='xcategory' 
and not word4 like 'OTHR%';
update tsm_stage.ipm_ph2to4_coeff set word3='YEAR' where word3='year';



commit;

update tsm_stage.ipm_ph2to4_coeff set word2 = decode (word2,'A','Affiliated','U','Unaffiliated') 
where word1 = 'AFFILIATION';
update tsm_stage.ipm_ph2to4_coeff set word4 = decode (word4,'A','Affiliated','U','Unaffiliated') 
where word3 = 'AFFILIATION';
update tsm_stage.ipm_ph2to4_coeff set word2 = decode (word2,'B',2,'C',3,'D',4,'E',5) 
where word1 = 'PHASE';
update tsm_stage.ipm_ph2to4_coeff set word4 = decode (word4,'B',2,'C',3,'D',4,'E',5) 
where word3 = 'PHASE';


update tsm_stage.ipm_ph2to4_coeff a set a.word2 = (select b.id from "&1".indmap b where 
b.parent_indmap_id is null and b.code= decode(substr(a.word2,6,1),'A','CARDIOVASCULAR',
'B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM', 'D','ANTI-INFECTIVE','E','ONCOLOGY',
'F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE', 'K','PHARMACOKINETIC','L','HEMATOLOGY',
'M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA'))  
where a.word1 = 'TA';

update tsm_stage.ipm_ph2to4_coeff a set a.word4 = (select b.id from "&1".indmap b where 
b.parent_indmap_id is null and b.code= decode(substr(a.word2,6,1),'A','CARDIOVASCULAR',
'B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM', 'D','ANTI-INFECTIVE','E','ONCOLOGY',
'F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE', 'K','PHARMACOKINETIC','L','HEMATOLOGY',
'M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA'))  
where a.word3 = 'TA';

update tsm_stage.ipm_ph2to4_coeff a set a.word2 = (select b.id from "&1".indmap b where 
b.type = 'Indication Group' and b.code=a.word2) where a.word1 = 'INDGRP';

update tsm_stage.ipm_ph2to4_coeff a set a.word4 = (select b.id from "&1".indmap b where 
b.type = 'Indication Group' and b.code=a.word4) where a.word3 = 'INDGRP';


commit;

truncate table "&1".ipm_ph2to4_coeff;

Insert into "&1".ipm_ph2to4_coeff select tsm_stage.ipm_ph2to4_coeff_seq.nextval,
GEOGRAPHICAL_LOCATION||'X',INPATIENT_STATUS,CPP_CPV,word1, word2, word3, word4, coeff 
from tsm_stage.ipm_ph2to4_coeff where word1 <> 'USIPTCPVsq';


update "&1".ipm_ph2to4_coeff set coeff_value=19 where coeff_type='PHASE' and coeff_value=to_char(3);
update "&1".ipm_ph2to4_coeff set coeff_value=5 where coeff_type='PHASE' and coeff_value=to_char(4);

commit;


--**********************************************************
-- IMPORTANT: PLEASE READ THE COMMENT HERE:
-- Following changes are as per the request of Tonya on 07/15/2003 
-- Not sure how these things will be implemented in production
-- Need to discuss this issue with Chik
--***********************************************************

update  "&1".ipm_ph2to4_coeff set coeff=.00467937 
WHERE coeff_type = 'DURATION' AND 
cpp_cpv = 'cpv' AND coeff = -.00467937;

commit;

--**********************************************************
-- IMPORTANT: PLEASE READ THE COMMENT HERE:
-- Following changes are as per the request of Tonya on 11/03/2003 
-- Not sure how these things will be implemented in production
-- Need to discuss this issue with Tim
--***********************************************************

update "&1".ipm_ph2to4_coeff set coeff=0 where 
coeff_type='DURATION' AND inpatient_status='Outpatient' AND
cpp_cpv='cpv';

commit;

 
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  13   DevTSM    1.12        2/27/2008 3:17:08 PM Debashish Mishra  
--  12   DevTSM    1.11        2/7/2007 10:28:14 PM Debashish Mishra  
--  11   DevTSM    1.10        3/3/2005 6:40:35 AM  Debashish Mishra  
--  10   DevTSM    1.9         11/19/2003 12:50:15 PMDebashish Mishra Cleaned them
--       up for 1.1 patch release
--  9    DevTSM    1.8         11/18/2003 4:07:39 PMDebashish Mishra Modified for
--       going to production
--  8    DevTSM    1.7         11/4/2003 11:00:55 AMDebashish Mishra MNodified
--       after Tonya's request on11/4/2003
--  7    DevTSM    1.6         7/16/2003 4:48:53 PM Debashish Mishra  
--  6    DevTSM    1.5         7/9/2003 5:27:11 PM  Debashish Mishra Modified to
--       include X in geographical location
--  5    DevTSM    1.4         5/29/2003 5:39:30 PM Debashish Mishra  
--  4    DevTSM    1.3         5/6/2003 9:36:32 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  3    DevTSM    1.2         4/1/2003 5:24:07 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/21/2003 6:14:11 PM Debashish Mishra  
--  1    DevTSM    1.0         3/14/2003 6:00:22 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

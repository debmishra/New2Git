--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_ph2to4_lkup_coeff.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:17:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

/*
drop table tsm_stage.ipm_ph2to4_lkup_coeff;


create table tsm_stage.ipm_ph2to4_lkup_coeff(
	id number (10),
	country varchar2(10),
	phase varchar2(10),
	indication varchar2(64),
	country_id number(10), 
	phase_id number(10),
	indmap_id number(10),
	pct25 number(20,12),
	pct50 number(20,12),
	pct75 number(20,12),
	bin  varchar2(40),
	duration number(6,2),
	cpp_cpv varchar2(10))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

truncate table tsm_stage.ipm_ph2to4_lkup_coeff;

Insert into tsm_stage.ipm_ph2to4_lkup_coeff (country,phase,
indication,pct25, pct50, pct75, bin, cpp_cpv) select country,phase,
indication,pct25, pct50, pct75, bin, 'cpp' 
from tsm_stage.ipm_ocpp_lkup where upper(phase) <> 'PHASE';

Insert into tsm_stage.ipm_ph2to4_lkup_coeff (country,phase,
indication,pct25, pct50, pct75, bin, cpp_cpv) select country,phase,
indication,pct25, pct50, pct75, bin, 'cpv' 
from tsm_stage.ipm_ocpv_lkup where upper(phase) <> 'PHASE';


commit;

update tsm_stage.ipm_ph2to4_lkup_coeff a set a.indmap_id = 
(select b.id from "&1".indmap b where b.code=a.indication);

update tsm_stage.ipm_ph2to4_lkup_coeff a set a.country_id = 
(select b.id from "&1".country b where b.abbreviation=a.country);

update tsm_stage.ipm_ph2to4_lkup_coeff a set a.phase_id = 2 where phase='B';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.phase_id = 19 where phase='C';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.phase_id = 5 where phase='E';
commit;

update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 14  where lower(trim(bin))='1-3 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 38.5  where lower(trim(bin))='4-7 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 66.5  where lower(trim(bin))='8-11 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 112  where lower(trim(bin))='12-20 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 161  where lower(trim(bin))='21-25 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 203  where lower(trim(bin))='26-32 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 255.5  where lower(trim(bin))='33-40 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 297.5  where lower(trim(bin))='41-44 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 339.5  where lower(trim(bin))='45-52 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 388.5  where lower(trim(bin))='53-58 weeks';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 547.5  where lower(trim(bin))='1-2 years';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 912.5  where lower(trim(bin))='2-3 years';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 1277.5  where lower(trim(bin))='>3 years';
update tsm_stage.ipm_ph2to4_lkup_coeff a set a.duration = 1277.5  where lower(trim(bin))='over 3 years';

commit;

drop sequence tsm_stage.ipm_ph2to4_lkup_coeff_seq;
create sequence tsm_stage.ipm_ph2to4_lkup_coeff_seq;


truncate table "&1".ipm_ph2to4_lkup_coeff;

Insert into "&1".ipm_ph2to4_lkup_coeff(ID,COUNTRY_ID,PHASE_ID,INDMAP_ID,PCT25,PCT50,PCT75,
DURATION,CPP_CPV) select tsm_stage.ipm_ph2to4_lkup_coeff_seq.nextval,COUNTRY_ID,PHASE_ID,
INDMAP_ID,PCT25,PCT50,PCT75,DURATION,CPP_CPV from tsm_stage.ipm_ph2to4_lkup_coeff;

commit;
*/

-- Following insert statement is for Foxpro ipm_weight file
-- that tonya sent on 11/03/2003. Just run the ipm_weight_foxpro
-- conversion map and then this insert statement
--

drop sequence tsm_stage.ipm_ph2to4_lkup_coeff_seq;
create sequence tsm_stage.ipm_ph2to4_lkup_coeff_seq;

truncate table "&1".ipm_ph2to4_lkup_coeff;

Insert into "&1".ipm_ph2to4_lkup_coeff(ID,COUNTRY_ID,PHASE_ID,INDMAP_ID,PCT25,PCT50,PCT75,
DURATION,CPP_CPV) select tsm_stage.ipm_ph2to4_lkup_coeff_seq.nextval,c.ID,PHASE_ID,
b.ID,a.PCT25,a.PCT50,a.PCT75,a.DURATION,a.CPP_CPV from tsm_stage.ipm_ph2to4_lkup_coeff a,
"&1".indmap b, "&1".country c where 
a.indication=b.code and
a.country=c.abbreviation;

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:17:08 PM Debashish Mishra  
--  6    DevTSM    1.5         2/7/2007 10:28:15 PM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2005 6:40:36 AM  Debashish Mishra  
--  4    DevTSM    1.3         11/19/2003 12:50:15 PMDebashish Mishra Cleaned them
--       up for 1.1 patch release
--  3    DevTSM    1.2         11/4/2003 11:00:55 AMDebashish Mishra MNodified
--       after Tonya's request on11/4/2003
--  2    DevTSM    1.1         8/29/2003 5:13:21 PM Debashish Mishra  
--  1    DevTSM    1.0         4/29/2003 9:02:40 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

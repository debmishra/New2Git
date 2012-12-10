--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_ph2to4_adj_coeff.sql$ 
--
-- $Revision: 14$        $Date: 2/27/2008 3:17:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop table tsm_stage.ipm_ph2to4_adj_coeff;

create table tsm_stage.ipm_ph2to4_adj_coeff(
	geographical_location varchar2(10),
	INPATIENT_STATUS  VARCHAR2(20),
	cpp_cpv varchar2(7),
	coeff_type varchar2(20) not null,
	coeff_value varchar2(40),
	coeff_raw_value varchar2(128),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

truncate table tsm_stage.ipm_ph2to4_adj_coeff;

Insert into tsm_stage.ipm_ph2to4_adj_coeff (inpatient_status,cpp_cpv,
coeff_type,coeff_raw_value, coeff) select 'Inpatient','complex',
'INDGRP',INDCODE,FACTOR from tsm_stage.ipm_adjust_complex where
upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (inpatient_status,cpp_cpv,
coeff_type,coeff_raw_value, coeff) select 'Inpatient','cpp',
'INDGRP',INDCODE,FACTOR from tsm_stage.ipm_inpatient_indcode where
upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (inpatient_status,cpp_cpv,
coeff_type,coeff_raw_value, coeff) select 'Inpatient','cpp',
'LOCATION',COUNTRY,FACTOR from tsm_stage.ipm_inpatient_location where
upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'CANX','Outpatient','cpp','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factorcanxcpp where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'CANX','Outpatient','cpv','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factorcanxcpv where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'USAX','Outpatient','cpp','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factorusaxcpp where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'USAX','Outpatient','cpv','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factorusaxcpv where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'EEUX','Outpatient','cpp','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factoreeuxcpp where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'EEUX','Outpatient','cpv','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factoreeuxcpv where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'WEUX','Outpatient','cpp','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factorweuxcpp where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff (geographical_location,
inpatient_status,cpp_cpv,coeff_type,coeff_raw_value, coeff)
select 'WEUX','Outpatient','cpv','INDGRP',INDCODE,FACTOR from 
tsm_stage.ipm_factorweuxcpv where upper(FACTOR) <> 'FACTOR';


--Insert into tsm_stage.ipm_ph2to4_adj_coeff(coeff_type,coeff_raw_value, coeff)
--select 'DURATION',duration,factor from tsm_stage.ipm_duradj where upper(FACTOR) <> 'FACTOR';

Insert into tsm_stage.ipm_ph2to4_adj_coeff(coeff_type,coeff_raw_value, coeff)
select 'DURATION',duration,factor from tsm_stage.ipm_duradj where upper(FACTOR) <> 'CPP_G';



Insert into tsm_stage.ipm_ph2to4_adj_coeff(coeff_type,coeff_raw_value, coeff)
select 'PHASE',phase,factor from tsm_stage.ipm_adj_phase where upper(FACTOR) <> 'FACTOR';

commit;

update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value = 
(select b.id from "&1".indmap b where 
b.type = 'Indication Group' and b.code=a.coeff_raw_value) 
where a.coeff_type = 'INDGRP';

update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value = 'OTHER'
where upper(a.coeff_raw_value) = 'OTHER';


update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value = 
(select b.id from "&1".indmap b where 
b.type = 'Indication Group' and substr(b.code,1,9)=a.coeff_raw_value) 
where a.coeff_type = 'INDGRP' and a.coeff_value is null;

update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value = a.coeff_raw_value
where a.coeff_type = 'LOCATION';

update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value = decode(a.coeff_raw_value,'A',1,'B',2,'C',19,'E',5)
where a.coeff_type = 'PHASE';

update tsm_stage.ipm_ph2to4_adj_coeff a set a.coeff_value = decode(lower(trim(a.coeff_raw_value)),
'1-3 weeks',14,'4-7 weeks',38.5,'8-11 weeks',66.5,'12-20 weeks',112,'21-25 weeks',161,'26-32 weeks',203
,'33-40 weeks',255.5,'41-44 weeks',297.5,'45-52 weeks',339.5,'53-58 weeks',388.5,'1-2 years',547.5
,'2-3 years',912.5,'over 3 years',1277.5) where a.coeff_type = 'DURATION';

commit;



drop sequence tsm_stage.ipm_ph2to4_adj_coeff_seq;
create sequence tsm_stage.ipm_ph2to4_adj_coeff_seq;

truncate table "&1".ipm_ph2to4_adj_coeff;

Insert into "&1".ipm_ph2to4_adj_coeff select 
tsm_stage.ipm_ph2to4_adj_coeff_seq.nextval,GEOGRAPHICAL_LOCATION,
INPATIENT_STATUS,CPP_CPV,COEFF_TYPE,COEFF_VALUE,COEFF  from
tsm_stage.ipm_ph2to4_adj_coeff;


commit;

drop sequence tsm_stage.ipm_ph2_adj_country_ratio_seq;
create sequence tsm_stage.ipm_ph2_adj_country_ratio_seq;


truncate table "&1".ipm_ph2to4_adj_country_ratio;

Insert into "&1".ipm_ph2to4_adj_country_ratio select
tsm_stage.ipm_ph2_adj_country_ratio_seq.nextval, b.id, 
a.geographical_location, a.p2, a.p3, a.y3p2, a.y3p3
from tsm_stage.ipm_country_ratio a, "&1".country b
where a.country = b.abbreviation;

commit;


--**********************************************************
-- IMPORTANT: PLEASE READ THE COMMENT HERE:
-- Following changes are as per the request of Tonya on 07/15/2003 
-- Not sure how these things will be implemented in production
-- Need to discuss this issue with Chik
--***********************************************************

update "&1".ipm_ph2to4_adj_coeff set coeff=.85 
where coeff_type='DURATION' and coeff_value=to_char(14);

update "&1".ipm_ph2to4_adj_coeff set coeff=1 
where coeff_type='DURATION' and coeff_value=to_char(38.5);

update "&1".ipm_ph2to4_adj_coeff set coeff=1.16
where coeff_type='DURATION' and coeff_value=to_char(66.5);

update "&1".ipm_ph2to4_adj_coeff set coeff=1.24
where coeff_type='DURATION' and coeff_value=to_char(112);

update "&1".ipm_ph2to4_adj_coeff set coeff=1.3
where coeff_type='DURATION' and coeff_value=to_char(161);

update "&1".ipm_ph2to4_adj_coeff set coeff=1.34
where coeff_type='DURATION' and coeff_value in ('203','255.5','297.5','339.5','388.5') ;

update "&1".ipm_ph2to4_adj_coeff set coeff=1.33
where coeff_type='DURATION' and coeff_value=to_char(547.5);

update "&1".ipm_ph2to4_adj_coeff set coeff=1.32
where coeff_type='DURATION' and coeff_value=to_char(912.5);

update "&1".ipm_ph2to4_adj_coeff set coeff=1.3
where coeff_type='DURATION' and coeff_value=to_char(1277.5);

commit;



--***************************************************************************
-- IMPORTANT: PLEASE READ THE COMMENT HERE:
-- Following changes are as per the request of Tonya on 09/03/2003 
-- Probably this requires datajunction map changes and chnage to this script
-- something somewhere need to be done to decide what the 
-- future  data import process will be. Again following statements are 
-- temporary in nature as the project is still in test phase. 
-- 
--***************************************************************************


-- Not sure, what to do with this line as it belongs to a different table
-- update ipm_ph2to4_coeff set coeff=0 where coeff_type = 'DURATION' AND cpp_cpv = 'cpv';

delete from "&1".ipm_ph2to4_adj_coeff where coeff_type = 'DURATION';
commit;

Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(800,'cpp','DURATION',14,.85);                                            
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(801,'cpp','DURATION',38.5,1);                                            
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(802,'cpp','DURATION',66.5,1.12);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(803,'cpp','DURATION',112,1.17);                                          
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(804,'cpp','DURATION',161,1.24);                                          
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(805,'cpp','DURATION',203,1.27);                                          
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(806,'cpp','DURATION',255.5,1.29);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(807,'cpp','DURATION',297.5,1.31);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(808,'cpp','DURATION',339.5,1.33);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(809,'cpp','DURATION',388.5,1.32);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(810,'cpp','DURATION',547.5,1.3);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(811,'cpp','DURATION',912.5,1.27);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(812,'cpp','DURATION',1277.5,1.25);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(900,'cpv','DURATION',14,.85);                                            
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(901,'cpv','DURATION',38.5,1);                                            
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(902,'cpv','DURATION',66.5,1.04);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(903,'cpv','DURATION',112,1.07);                                          
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(904,'cpv','DURATION',161,1.1);                                           
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(905,'cpv','DURATION',203,1.13);                                          
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(906,'cpv','DURATION',255.5,1.15);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(907,'cpv','DURATION',297.5,1.17);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(908,'cpv','DURATION',339.5,1.18);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(909,'cpv','DURATION',388.5,1.19);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(910,'cpv','DURATION',547.5,1.16);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(911,'cpv','DURATION',912.5,1.14);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(912,'cpv','DURATION',1277.5,1.11);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(920,'icpp','DURATION',14,.85);                                           
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(921,'icpp','DURATION',38.5,1);                                           
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(922,'icpp','DURATION',66.5,1.18);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(923,'icpp','DURATION',112,1.25);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(924,'icpp','DURATION',161,1.28);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(925,'icpp','DURATION',203,1.33);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(926,'icpp','DURATION',255.5,1.36);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(927,'icpp','DURATION',297.5,1.39);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(928,'icpp','DURATION',339.5,1.43);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(929,'icpp','DURATION',388.5,1.47);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(930,'icpp','DURATION',547.5,1.61);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(931,'icpp','DURATION',912.5,1.78);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(932,'icpp','DURATION',1277.5,1.98);                                      
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(940,'icpv','DURATION',14,.94);                                           
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(941,'icpv','DURATION',38.5,1);                                           
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(942,'icpv','DURATION',66.5,104);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(943,'icpv','DURATION',112,1.07);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(944,'icpv','DURATION',161,1.12);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(945,'icpv','DURATION',203,1.14);                                         
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(946,'icpv','DURATION',255.5,1.17);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(947,'icpv','DURATION',297.5,1.2);                                        
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(948,'icpv','DURATION',339.5,1.23);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(949,'icpv','DURATION',388.5,1.26);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(950,'icpv','DURATION',547.5,1.24);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(951,'icpv','DURATION',912.5,1.21);                                       
                                                                                
Insert into "&1".ipm_ph2to4_adj_coeff (id,cpp_cpv,coeff_type,coeff_value,coeff)      
values(952,'icpv','DURATION',1277.5,1.18);                                      
                                                                                
commit;



--***************************************************************************
-- IMPORTANT: PLEASE READ THE COMMENT HERE:
-- Following changes are as per the request of Tonya on 11/03/2003 
-- Probably this requires datajunction map changes and change to this script
-- something somewhere need to be done to decide what the 
-- future  data import process will be. Again following statements are 
-- temporary in nature. 
-- 
--***************************************************************************

--change CAN (country_id = 5) to 0.67

--update "&1".ipm_ph2to4_adj_country_ratio set p2=0.67 where country_id=5;
--update "&1".ipm_ph2to4_adj_country_ratio set p3=0.67 where country_id=5;
--update "&1".ipm_ph2to4_adj_country_ratio set y3p2=0.67 where country_id=5;
--update "&1".ipm_ph2to4_adj_country_ratio set y3p3=0.67 where country_id=5;
--commit;


-- Following changes are as per the request of Tonya on 11/4/2003 at 10:59 AM

update "&1".ipm_ph2to4_adj_coeff set coeff=1.04 where cpp_cpv='icpv' and 
coeff_type='DURATION' and coeff_value=to_char(66.5);
commit;










---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  14   DevTSM    1.13        2/27/2008 3:17:08 PM Debashish Mishra  
--  13   DevTSM    1.12        2/7/2007 10:28:13 PM Debashish Mishra  
--  12   DevTSM    1.11        8/19/2005 6:22:35 AM Debashish Mishra  
--  11   DevTSM    1.10        3/3/2005 6:40:35 AM  Debashish Mishra  
--  10   DevTSM    1.9         11/19/2003 12:50:14 PMDebashish Mishra Cleaned them
--       up for 1.1 patch release
--  9    DevTSM    1.8         11/18/2003 4:07:38 PMDebashish Mishra Modified for
--       going to production
--  8    DevTSM    1.7         11/4/2003 11:00:54 AMDebashish Mishra MNodified
--       after Tonya's request on11/4/2003
--  7    DevTSM    1.6         9/3/2003 11:32:43 AM Debashish Mishra Added new
--       duration coeff values as per the request of tonya 
--  6    DevTSM    1.5         7/16/2003 4:48:52 PM Debashish Mishra  
--  5    DevTSM    1.4         5/29/2003 5:39:29 PM Debashish Mishra  
--  4    DevTSM    1.3         5/19/2003 1:17:39 PM Debashish Mishra  
--  3    DevTSM    1.2         4/28/2003 1:25:06 PM Debashish Mishra modified for
--       the eeu to weu bug 
--  2    DevTSM    1.1         4/23/2003 4:15:13 PM Debashish Mishra  
--  1    DevTSM    1.0         4/18/2003 8:09:25 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

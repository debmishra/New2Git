--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: IPT_additional_schema_updates_for_reports.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:18:12 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
drop table ipm_phase2to4_2000;

create table ipm_phase2to4_2000 as select * from ipm_phase2to4_g;

update ipm_phase2to4_2000 set (OCPP_GRANTS_LOW,OCPP_GRANTS_MED,OCPP_GRANTS_HIGH,       
OCPP_AVG,OCPP_GRANTS_COUNT,OCPP_GRANTS_INVCODE,OCPV_GRANTS_LOW,OCPV_GRANTS_MED,        
OCPV_GRANTS_HIGH,OCPV_GRANTS_AVG,OCPV_GRANTS_COUNT,OCPV_GRANTS_INVCODE,ISMP_GRANTS_LOW,
ISMP_GRANTS_MED,ISMP_GRANTS_HIGH,ISMP_GRANTS_AVG,ISMP_GRANTS_COUNT,ISMP_GRANTS_INVCODE) = 
(select 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 from dual);

commit;

Alter table ipm_phase2to4_2000 add (country_id number(10),phase_id number(10),
indmap_id number(10), duration_id number(10), cpp_act_grants_2000_parent_id number(10),
cpv_act_grants_2000_parent_id number(10), ismp_act_grants_2000_parent_id number(10));

update ipm_phase2to4_2000 a set a.country_id = (select b.id from country b
where b.abbreviation = a.country);

commit;

update ipm_phase2to4_2000 a set a.phase_id = 2 where phase = 'PhaseII';
update ipm_phase2to4_2000 a set a.phase_id = 19 where phase = 'PhaseIII';   
update ipm_phase2to4_2000 a set a.phase_id = 5 where phase = 'PhaseIV';  

commit;

update ipm_phase2to4_2000 a set a.indmap_id = (select b.id from indmap b
where b.code = a.indcode and b.id <> 950);

-- The number 950 above was creating problem as hematology can be a TA as well as group

commit;

update ipm_phase2to4_2000 set duration_id = 110 where duration=14;
update ipm_phase2to4_2000 set duration_id = 111 where duration=38.5;
update ipm_phase2to4_2000 set duration_id = 112 where duration=66.5;
update ipm_phase2to4_2000 set duration_id = 113 where duration=112;
update ipm_phase2to4_2000 set duration_id = 114 where duration=161;
update ipm_phase2to4_2000 set duration_id = 115 where duration=203;
update ipm_phase2to4_2000 set duration_id = 116 where duration=255.5;
update ipm_phase2to4_2000 set duration_id = 117 where duration=297.5;
update ipm_phase2to4_2000 set duration_id = 118 where duration=339.5;
update ipm_phase2to4_2000 set duration_id = 119 where duration=388.5;
update ipm_phase2to4_2000 set duration_id = 120 where duration=547.5;
update ipm_phase2to4_2000 set duration_id = 121 where duration=912.5;
update ipm_phase2to4_2000 set duration_id = 122 where duration=1277.5;

commit;


create index ipm_phase2to4_2000_index1 on 
ipm_phase2to4_2000(COUNTRY_ID,PHASE_ID,INDMAP_ID,site,DURATION_ID)
tablespace tsmlarge_indx pctfree 20;

drop index ipt_grants_ph2_2000_index1;
create index ipt_grants_ph2_2000_index1 on 
ipt_grants_ph2_2000(COUNTRY_ID,PHASE_ID,INDMAP_ID,AFF,DURATION_ID)
tablespace tsmlarge_indx pctfree 20; 
 

update ipm_phase2to4_2000 a set (a.ocpp_grants_low, a.ocpp_grants_med, a.ocpp_grants_high,
a.ocpp_avg, a.ocpp_grants_count, a.ocpp_grants_invcode,a.cpp_act_grants_2000_parent_id) = 
(select b.PCT25,b.PCT50,b.PCT75,b.AVG,b.CNT,b.INVCODE,b.id 
from ipt_grants_ph2_2000 b where 
b.country_id = a.country_id and
b.phase_id=a.phase_id and
b.indmap_id=a.indmap_id and
b.aff=a.site and
b.duration_id=a.duration_id and
b.iostatus_id=124 and b.cpp_code='cpp');

commit;

update ipm_phase2to4_2000 a set (a.ocpv_grants_low, a.ocpv_grants_med, a.ocpv_grants_high,
a.ocpv_grants_avg, a.ocpv_grants_count, a.ocpv_grants_invcode,a.cpv_act_grants_2000_parent_id) = 
(select b.PCT25,b.PCT50,b.PCT75,b.AVG,b.CNT,b.INVCODE,b.id 
from ipt_grants_ph2_2000 b where 
b.country_id = a.country_id and
b.phase_id=a.phase_id and
b.indmap_id=a.indmap_id and
b.aff=a.site and
b.duration_id=a.duration_id and
b.iostatus_id=124 and b.cpp_code='cpv');

commit;

update ipm_phase2to4_2000 a set (a.ismp_grants_low, a.ismp_grants_med, a.ismp_grants_high,
a.ismp_grants_avg, a.ismp_grants_count, a.ismp_grants_invcode,a.ismp_act_grants_2000_parent_id) = 
(select b.PCT25,b.PCT50,b.PCT75,b.AVG,b.CNT,b.INVCODE,b.id 
from ipt_grants_ph2_2000 b where 
b.country_id = a.country_id and
b.phase_id=a.phase_id and
b.indmap_id=a.indmap_id and
b.aff=a.site and
b.duration_id=a.duration_id and
b.iostatus_id=123 and b.cpp_code='cpp');

commit;

delete from ipm_phase2to4_2000 where OCPP_GRANTS_LOW is null and OCPP_GRANTS_MED is null and 
OCPP_GRANTS_HIGH is null and OCPP_AVG is null and OCPP_GRANTS_COUNT is null and 
OCPP_GRANTS_INVCODE is null and OCPV_GRANTS_LOW is null and OCPV_GRANTS_MED is null and 
OCPV_GRANTS_HIGH is null and OCPV_GRANTS_AVG is null and OCPV_GRANTS_COUNT is null and
OCPV_GRANTS_INVCODE is null and ISMP_GRANTS_LOW is null and ISMP_GRANTS_MED is null and 
ISMP_GRANTS_HIGH is null and ISMP_GRANTS_AVG is null and ISMP_GRANTS_COUNT is null and
ISMP_GRANTS_INVCODE is null;

commit;

update ipm_phase2to4_2000 set OCPP_GRANTS_LOW =0 where OCPP_GRANTS_LOW is null;
update ipm_phase2to4_2000 set OCPP_GRANTS_MED =0 where OCPP_GRANTS_MED is null;
update ipm_phase2to4_2000 set OCPP_GRANTS_HIGH =0 where OCPP_GRANTS_HIGH is null;
update ipm_phase2to4_2000 set OCPP_AVG =0 where OCPP_AVG is null;
update ipm_phase2to4_2000 set OCPP_GRANTS_COUNT =0 where OCPP_GRANTS_COUNT is null;

update ipm_phase2to4_2000 set OCPV_GRANTS_LOW =0 where OCPV_GRANTS_LOW is null;
update ipm_phase2to4_2000 set OCPV_GRANTS_MED =0 where OCPV_GRANTS_MED is null;
update ipm_phase2to4_2000 set OCPV_GRANTS_HIGH =0 where OCPV_GRANTS_HIGH is null;
update ipm_phase2to4_2000 set OCPV_GRANTS_AVG =0 where OCPV_GRANTS_AVG is null;
update ipm_phase2to4_2000 set OCPV_GRANTS_COUNT =0 where OCPV_GRANTS_COUNT is null;

update ipm_phase2to4_2000 set ISMP_GRANTS_LOW =0 where ISMP_GRANTS_LOW is null;
update ipm_phase2to4_2000 set ISMP_GRANTS_MED =0 where ISMP_GRANTS_MED is null;
update ipm_phase2to4_2000 set ISMP_GRANTS_HIGH =0 where ISMP_GRANTS_HIGH is null;
update ipm_phase2to4_2000 set ISMP_GRANTS_AVG =0 where ISMP_GRANTS_AVG is null;
update ipm_phase2to4_2000 set ISMP_GRANTS_COUNT =0 where ISMP_GRANTS_COUNT is null;

commit;



rename ipm_phase2to4_2000 to ipm_phase2to4_2000_old;
create table ipm_phase2to4_2000 as select * from ipm_phase2to4_2000_old;
drop table ipm_phase2to4_2000_old;

create index ipm_phase2to4_2000_index1 on ipm_phase2to4_2000(country_id)
tablespace tsmsmall;



drop table ipm_phase2to4_report;

create table ipm_phase2to4_report (
id number(10),
geographical_location varchar2(4),
report_type varchar2(20),
old_formula_output_exist number(1),
pct_range number(3),
tot_cnt number(8),
old_cnt number(8),
new_cnt number(8))
tablespace tsmsmall pctused 60 pctfree 20;

drop table ipm_phase2to4_report_range;
create table ipm_phase2to4_report_range (
range number(3));

Insert into ipm_phase2to4_report_range values (5);
Insert into ipm_phase2to4_report_range values (10);
Insert into ipm_phase2to4_report_range values (20);
Insert into ipm_phase2to4_report_range values (30);
Insert into ipm_phase2to4_report_range values (40);
Insert into ipm_phase2to4_report_range values (50);
Insert into ipm_phase2to4_report_range values (60);
Insert into ipm_phase2to4_report_range values (70);
Insert into ipm_phase2to4_report_range values (80);
Insert into ipm_phase2to4_report_range values (90);
Insert into ipm_phase2to4_report_range values (100);
Insert into ipm_phase2to4_report_range values (125);
Insert into ipm_phase2to4_report_range values (150);
Insert into ipm_phase2to4_report_range values (175);
Insert into ipm_phase2to4_report_range values (200);
Insert into ipm_phase2to4_report_range values (225);
Insert into ipm_phase2to4_report_range values (250);
Insert into ipm_phase2to4_report_range values (275);
Insert into ipm_phase2to4_report_range values (300);
Insert into ipm_phase2to4_report_range values (325);
Insert into ipm_phase2to4_report_range values (350);
Insert into ipm_phase2to4_report_range values (375);
Insert into ipm_phase2to4_report_range values (400);
commit;

drop sequence ipm_phase2to4_report_seq;
create sequence ipm_phase2to4_report_seq;
 

declare

  cursor c1 is select distinct geographical_location gl from ipm_geographical_location;
  cursor c2 is select range/100 rnge from  ipm_phase2to4_report_range;

begin

 for ix1 in c1 loop

  for ix2 in c2 loop

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpp_med',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_grants_med <> 0 and a.ocpp_med <> 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_grants_med <> 0 and a.ocpp_med <> 0 and
   a.ocpp_med between a.ocpp_grants_med*(1-ix2.rnge) and a.ocpp_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_grants_med <> 0 and a.ocpp_med <> 0 and
   a.ocpp_new_med between a.ocpp_grants_med*(1-ix2.rnge) and a.ocpp_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpp_avg',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_avg <> 0 and a.ocpp_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_avg <> 0 and a.ocpp_med <> 0 and
   a.ocpp_med between a.ocpp_avg*(1-ix2.rnge) and a.ocpp_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_avg <> 0 and a.ocpp_med <> 0 and
   a.ocpp_new_med between a.ocpp_avg*(1-ix2.rnge) and a.ocpp_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpp_actual',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpp_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpp_med <> 0 and
   a.ocpp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.cpp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpp_med <> 0 and
   a.ocpp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpp_med',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_grants_med <> 0 and a.ocpp_med = 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_grants_med <> 0 and a.ocpp_med = 0 and
   a.ocpp_med between a.ocpp_grants_med*(1-ix2.rnge) and a.ocpp_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_grants_med <> 0 and a.ocpp_med = 0 and
   a.ocpp_new_med between a.ocpp_grants_med*(1-ix2.rnge) and a.ocpp_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpp_avg',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_avg <> 0 and a.ocpp_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_avg <> 0 and a.ocpp_med = 0 and
   a.ocpp_med between a.ocpp_avg*(1-ix2.rnge) and a.ocpp_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpp_avg <> 0 and a.ocpp_med = 0 and
   a.ocpp_new_med between a.ocpp_avg*(1-ix2.rnge) and a.ocpp_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpp_actual',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpp_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpp_med = 0 and
   a.ocpp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.cpp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpp_med = 0 and
   a.ocpp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;


  end loop;
 end loop;
commit;
end;
/

declare

  cursor c1 is select distinct geographical_location gl from ipm_geographical_location;
  cursor c2 is select range/100 rnge from  ipm_phase2to4_report_range;

begin

 for ix1 in c1 loop

  for ix2 in c2 loop

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpv_med',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_med <> 0 and a.ocpv_med <> 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_med <> 0 and a.ocpv_med <> 0 and
   a.ocpv_med between a.ocpv_grants_med*(1-ix2.rnge) and a.ocpv_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_med <> 0 and a.ocpv_med <> 0 and
   a.ocpv_new_med between a.ocpv_grants_med*(1-ix2.rnge) and a.ocpv_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpv_avg',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_avg <> 0 and a.ocpv_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_avg <> 0 and a.ocpv_med <> 0 and
   a.ocpv_med between a.ocpv_grants_avg*(1-ix2.rnge) and a.ocpv_grants_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_avg <> 0 and a.ocpv_med <> 0 and
   a.ocpv_new_med between a.ocpv_grants_avg*(1-ix2.rnge) and a.ocpv_grants_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpv_actual',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpv_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpv_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpv_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpv_med <> 0 and
   a.ocpv_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.cpv_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpv_med <> 0 and
   a.ocpv_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpv_med',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_med <> 0 and a.ocpv_med = 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_med <> 0 and a.ocpv_med = 0 and
   a.ocpv_med between a.ocpv_grants_med*(1-ix2.rnge) and a.ocpv_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_med <> 0 and a.ocpv_med = 0 and
   a.ocpv_new_med between a.ocpv_grants_med*(1-ix2.rnge) and a.ocpv_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpv_avg',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_avg <> 0 and a.ocpv_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_avg <> 0 and a.ocpv_med = 0 and
   a.ocpv_med between a.ocpv_grants_avg*(1-ix2.rnge) and a.ocpv_grants_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ocpv_grants_avg <> 0 and a.ocpv_med = 0 and
   a.ocpv_new_med between a.ocpv_grants_avg*(1-ix2.rnge) and a.ocpv_grants_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ocpv_actual',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpv_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpv_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.cpv_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpv_med = 0 and
   a.ocpv_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.cpv_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ocpv_med = 0 and
   a.ocpv_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;


  end loop;
 end loop;
commit;
end;
/

declare

  cursor c1 is select distinct geographical_location gl from ipm_geographical_location;
  cursor c2 is select range/100 rnge from  ipm_phase2to4_report_range;

begin

 for ix1 in c1 loop

  for ix2 in c2 loop

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ismp_med',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.ismp_med <> 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.ismp_med <> 0 and
   a.ismp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.ismp_med <> 0 and
   a.ismp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ismp_avg',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.ismp_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.ismp_med <> 0 and
   a.ismp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.ismp_med <> 0 and
   a.ismp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ismp_actual',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ismp_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ismp_med <> 0 and
   a.ismp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ismp_med <> 0 and
   a.ismp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ismp_med',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.ismp_med = 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.ismp_med = 0 and
   a.ismp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.ismp_med = 0 and
   a.ismp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ismp_avg',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.ismp_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.ismp_med = 0 and
   a.ismp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.ismp_med = 0 and
   a.ismp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ismp_actual',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ismp_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ismp_med = 0 and
   a.ismp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.ismp_med = 0 and
   a.ismp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;


  end loop;
 end loop;
commit;
end;
/

declare

  cursor c1 is select distinct geographical_location gl from ipm_geographical_location;
  cursor c2 is select range/100 rnge from  ipm_phase2to4_report_range;

begin

 for ix1 in c1 loop

  for ix2 in c2 loop

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'icmp_med',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.icmp_med <> 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.icmp_med <> 0 and
   a.icmp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.icmp_med <> 0 and
   a.icmp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'icmp_avg',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.icmp_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.icmp_med <> 0 and
   a.icmp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.icmp_med <> 0 and
   a.icmp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'icmp_actual',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.icmp_med <> 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.icmp_med <> 0 and
   a.icmp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.icmp_med <> 0 and
   a.icmp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'icmp_med',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.icmp_med = 0) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.icmp_med = 0 and
   a.icmp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and a.icmp_med = 0 and
   a.icmp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'icmp_avg',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.icmp_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.icmp_med = 0 and
   a.icmp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and a.icmp_med = 0 and
   a.icmp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'icmp_actual',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.icmp_med = 0) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.icmp_med = 0 and
   a.icmp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and a.icmp_med = 0 and
   a.icmp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) z;


  end loop;
 end loop;
commit;
end;
/


declare

  cursor c1 is select distinct geographical_location gl from ipm_geographical_location;
  cursor c2 is select range/100 rnge from  ipm_phase2to4_report_range;

begin

 for ix1 in c1 loop

  for ix2 in c2 loop

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ibest_med',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 )) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 ) and
   ((a.icmp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) or
   (a.ismp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 ) and
   ((a.icmp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) or
   (a.ismp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ibest_avg',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med <> 0  or a.ismp_med <> 0 )and
   ((a.icmp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) or
   (a.ismp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med <> 0  or a.ismp_med <> 0 )and
   ((a.icmp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) or
   (a.ismp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ibest_actual',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 ) and
   ((a.icmp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) or
   (a.ismp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med <> 0 or a.ismp_med <> 0 ) and
   ((a.icmp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) or
   (a.ismp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ibest_med',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 )) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 ) and
   ((a.icmp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) or
   (a.ismp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 ) and
   ((a.icmp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) or
   (a.ismp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ibest_avg',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med = 0  and a.ismp_med = 0 )and
   ((a.icmp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) or
   (a.ismp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med = 0  and a.ismp_med = 0 )and
   ((a.icmp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) or
   (a.ismp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'ibest_actual',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 ) and
   ((a.icmp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) or
   (a.ismp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med = 0 and a.ismp_med = 0 ) and
   ((a.icmp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) or
   (a.ismp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) z;


  end loop;
 end loop;
commit;
end;
/

declare

  cursor c1 is select distinct geographical_location gl from ipm_geographical_location;
  cursor c2 is select range/100 rnge from  ipm_phase2to4_report_range;

begin

 for ix1 in c1 loop

  for ix2 in c2 loop

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'iWorst_med',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 )) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 ) and
   ((a.icmp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) and
   (a.ismp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 ) and
   ((a.icmp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) and
   (a.ismp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'iWorst_avg',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med <> 0  and a.ismp_med <> 0 )and
   ((a.icmp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) and
   (a.ismp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med <> 0  and a.ismp_med <> 0 )and
   ((a.icmp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) and
   (a.ismp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'iWorst_actual',1,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 ) and
   ((a.icmp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) and
   (a.ismp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med <> 0 and a.ismp_med <> 0 ) and
   ((a.icmp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) and
   (a.ismp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'iWorst_med',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 )) x,
   (select count(*) old_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 ) and
   ((a.icmp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) and
   (a.ismp_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_phase2to4_2000 a, ipm_geographical_location b
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_med <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 ) and
   ((a.icmp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge)) and
   (a.ismp_new_med between a.ismp_grants_med*(1-ix2.rnge) and a.ismp_grants_med*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'iWorst_avg',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med = 0  or a.ismp_med = 0 )and
   ((a.icmp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) and
   (a.ismp_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, ipm_phase2to4_2000 a 
   where a.country_id = b.country_id and b.geographical_location = ix1.gl
   and a.ismp_grants_avg <> 0 and (a.icmp_med = 0  or a.ismp_med = 0 )and
   ((a.icmp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge)) and
   (a.ismp_new_med between a.ismp_grants_avg*(1-ix2.rnge) and a.ismp_grants_avg*(1+ix2.rnge))) ) z;

   insert into ipm_phase2to4_report
   select ipm_phase2to4_report_seq.nextval,ix1.gl,'iWorst_actual',0,(ix2.rnge*100),x.tot_cnt,
   y.old_cnt,z.new_cnt from
   (select count(*) tot_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 )) x,
   (select count(*) old_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c 
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 ) and
   ((a.icmp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) and
   (a.ismp_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) y,
   (select count(*) new_cnt from ipm_geographical_location b, 
   ipm_phase2to4_2000 a, act_grants_2000 c  
   where a.country_id = b.country_id and a.ismp_act_grants_2000_parent_id=c.parent_id
   and b.geographical_location = ix1.gl
   and c.grant_tot <> 0 and (a.icmp_med = 0 or a.ismp_med = 0 ) and
   ((a.icmp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge)) and
   (a.ismp_new_med between c.grant_tot*(1-ix2.rnge) and c.grant_tot*(1+ix2.rnge))) ) z;


  end loop;
 end loop;
commit;
end;
/



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:18:12 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:35:40 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:19:37 PM Debashish Mishra  
--  2    DevTSM    1.1         5/8/2003 3:05:42 PM  Debashish Mishra  
--  1    DevTSM    1.0         5/2/2003 10:14:24 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipt_query.sql$ 
--
-- $Revision: 8$        $Date: 2/27/2008 3:18:15 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create or replace procedure ipt_ph1_query (CountryId in number, DosingType in varchar2,
StudyType in number, EntryCriteria in varchar2, AgeRange in varchar2, 
StudySiteType in varchar2, StudyDuration in varchar2, PatientStatus in varchar2, 
TreatmentTime in varchar2, avggranttot out number, cntgranttot out number,
uqcntgranttot out number, t25thgranttot out number, t50thgranttot out number,
t75thgranttot out number) as


dt protocol.dosing%type;
ar protocol.age_range%type;
sst protocol.inpatient_status%type;
sd1  protocol.duration%type;
sd2  protocol.duration%type;
sdu  protocol.duration_unit%type;
ps1  protocol.inpatient_days%type;
ps2  protocol.inpatient_days%type;
tt1  number(10);	
tt2  number(10);

begin


if lower(trim(DosingType))='single dose' 
  then
    dt:='A';
 elsif lower(trim(DosingType))='multiple dose' 
  then
    dt:='B';
end if;

if lower(trim(AgeRange))='all ages' 
  then
    ar:='Any';
 elsif lower(trim(AgeRange))='adult' 
  then
    ar:='Adult';
 elsif lower(trim(AgeRange))='post menopausal' 
  then
    ar:='Postmenopause';
 elsif lower(trim(AgeRange))='geriatric' 
  then
    ar:='Geriatric';
 elsif lower(trim(AgeRange))='pediatric' 
  then
    ar:='Pediatric';
end if;



if lower(trim(StudySiteType))='allsites' 
  then
    sst:='Mixed';
 elsif lower(trim(StudySiteType))='hospital' 
  then
    sst:='Inpatient';
 elsif lower(trim(StudySiteType))='clinresearchcenter' 
  then
    sst:='Inpatient';
 elsif lower(trim(StudySiteType))='physclinic' 
  then
    sst:='Outpatient';
end if;


if lower(trim(StudyDuration))='<one week' 
  then
    sd1:=0;
    sd2:=6;
    sdu:='d';
 elsif lower(trim(StudyDuration))='1 to 2 weeks' 
  then
    sd1:=1;
    sd2:=2;
    sdu:='w';
 elsif lower(trim(StudyDuration))='3 to 4 weeks' 
  then
    sd1:=3;
    sd2:=4;
    sdu:='w';
 elsif lower(trim(StudyDuration))='5 to 6 weeks' 
  then
    sd1:=5;
    sd2:=6;
    sdu:='w';
 elsif lower(trim(StudyDuration))='7 to 8 weeks' 
  then
    sd1:=7;
    sd2:=8;
    sdu:='w';
 elsif lower(trim(StudyDuration))='9 to 12 weeks' 
  then
    sd1:=9;
    sd2:=12;
    sdu:='w';
 elsif lower(trim(StudyDuration))='13 to 20 weeks' 
  then
    sd1:=13;
    sd2:=20;
    sdu:='w';
 elsif lower(trim(StudyDuration))='21 to 25 weeks' 
  then
    sd1:=21;
    sd2:=25;
    sdu:='w';
 elsif lower(trim(StudyDuration))='26 to 52 weeks' 
  then
    sd1:=26;
    sd2:=52;
    sdu:='w';
 elsif lower(trim(StudyDuration))='over 52 weeks' 
  then
    sd1:=52;
    sd2:=5200;
    sdu:='w';
end if;

if lower(trim(PatientStatus))='<24 hours confinement' 
  then
    ps1:=0;
    ps2:=0;
 elsif lower(trim(PatientStatus))='24 to 48 hours confinement' 
  then
    ps1:=1;
    ps2:=2;
 elsif lower(trim(PatientStatus))='3 to 4 days confinement' 
  then
    ps1:=3;
    ps2:=4;
 elsif lower(trim(PatientStatus))='5 to 6 days confinement' 
  then
    ps1:=5;
    ps2:=6;
 elsif lower(trim(PatientStatus))='7 to 13 days confinement' 
  then
    ps1:=7;
    ps2:=13;
 elsif lower(trim(PatientStatus))='14 to 28 days confinement' 
  then
    ps1:=14;
    ps2:=28;
 elsif lower(trim(PatientStatus))='over 28 days confinement' 
  then
    ps1:=29;
    ps2:=10000;
end if;

if lower(trim(TreatmentTime))='1 to 7 days' 
  then
    tt1:=1;
    tt2:=7;
 elsif lower(trim(TreatmentTime))='8 to 14 days' 
  then
    tt1:=8;
    tt2:=14;
 elsif lower(trim(TreatmentTime))='15 to 21 days' 
  then
    tt1:=15;
    tt2:=21;
 elsif lower(trim(TreatmentTime))='22 to 28 days' 
  then
    tt1:=22;
    tt2:=28;
 elsif lower(trim(TreatmentTime))='over 28 days' 
  then
    tt1:=29;
    tt2:=10000;
end if;


If lower(trim(EntryCriteria))='healthy subjects'  
 then
   if lower(trim(PatientStatus)) in ('all patients','no confinement')
     then

	select avg(i.grant_total), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;


	select  
	percentile_disc(0.25) within group (order by grant_total),
	percentile_disc(0.5) within group (order by grant_total),
	percentile_disc(0.75) within group (order by grant_total)
	into  t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;



   else

	select avg(i.grant_total), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;
 
	select	percentile_disc(0.25) within group (order by grant_total),
	percentile_disc(0.5) within group (order by grant_total),
	percentile_disc(0.75) within group (order by grant_total)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;






   end if;

else

   if lower(trim(PatientStatus)) in ('all patients','no confinement')
     then

	select avg(i.grant_total), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;

	select percentile_disc(0.25) within group (order by grant_total),
	percentile_disc(0.5) within group (order by grant_total),
	percentile_disc(0.75) within group (order by grant_total)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;

   else

	select avg(i.grant_total), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;

	select percentile_disc(0.25) within group (order by grant_total),
	percentile_disc(0.5) within group (order by grant_total),
	percentile_disc(0.75) within group (order by grant_total)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2;


   End if;




End if;

end;
/



create or replace procedure ipt_ph2to4_query (CountryId in number, PhaseID in number,
IndmapID in number, StudySiteType in varchar2, PatientStaus in varchar2,
StudyDuration in varchar2, avggranttot out number, cntgranttot out number, 
uqcntgranttot out number, t25thgranttot out number, t50thgranttot out number, 
t75thgranttot out number) as

sst investig.affiliation%type;
ps1  protocol.inpatient_status%type;
sd1  protocol.duration%type;
sd2  protocol.duration%type;
sdu  protocol.duration_unit%type;
sd3  protocol.duration%type;
sd4  protocol.duration%type;
sdu1  protocol.duration_unit%type;

begin

if lower(trim(StudySiteType))='all site types' 
  then
    sst:='ZZZZZZZZZZ';
 elsif lower(trim(StudySiteType))='affiliated' 
  then
    sst:='Affiliated';
 elsif lower(trim(StudySiteType))='unaffiliated' 
  then
    sst:='Unaffiliated';
end if;

if lower(trim(PatientStaus))='inpatient'
   then
      ps1:='Inpatient' ;
  elsif lower(trim(PatientStaus))='outpatient'
   then
      ps1:='Outpatient' ;
end if;


if lower(trim(StudyDuration))='1-3 weeks' 
  then
    sd1:=0;
    sd2:=6;
    sdu:='d';
    sd3:=1;
    sd4:=3;
    sdu1:='w';
 elsif lower(trim(StudyDuration))='4-7 weeks' 
  then
    sd1:=4;
    sd2:=7;
    sdu:='w';
 elsif lower(trim(StudyDuration))='8-11 weeks' 
  then
    sd1:=8;
    sd2:=11;
    sdu:='w';
 elsif lower(trim(StudyDuration))='12-20 weeks' 
  then
    sd1:=12;
    sd2:=20;
    sdu:='w';
 elsif lower(trim(StudyDuration))='21-25 weeks' 
  then
    sd1:=21;
    sd2:=25;
    sdu:='w';
 elsif lower(trim(StudyDuration))='26-32 weeks' 
  then
    sd1:=26;
    sd2:=32;
    sdu:='w';
 elsif lower(trim(StudyDuration))='33-40 weeks' 
  then
    sd1:=33;
    sd2:=40;
    sdu:='w';
 elsif lower(trim(StudyDuration))='41-44 weeks' 
  then
    sd1:=41;
    sd2:=44;
    sdu:='w';
 elsif lower(trim(StudyDuration))='45-52 weeks' 
  then
    sd1:=45;
    sd2:=52;
    sdu:='w';
 elsif lower(trim(StudyDuration))='53-58 weeks' 
  then
    sd1:=53;
    sd2:=58;
    sdu:='w';
 elsif lower(trim(StudyDuration))='1-2 years' 
  then
    sd1:=53;
    sd2:=124;
    sdu:='w';
 elsif lower(trim(StudyDuration))='2-3 years' 
  then
    sd1:=125;
    sd2:=176;
    sdu:='w';
 elsif lower(trim(StudyDuration))='>3 years' 
  then
    sd1:=177;
    sd2:=5200;
    sdu:='w';
end if;

 If lower(trim(StudyDuration))='1-3 weeks' 
  then

	select avg(i.grant_total), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
        from protocol p, protocol_to_indmap pti,investig i
	where p.id=pti.protocol_id
	and p.id=i.protocol_id  
	and p.phase_id = PhaseId 
	and p.country_id = CountryId
	and pti.indmap_id = IndmapID
	and p.inpatient_status = ps1
	and ((p.duration between sd1 and sd2 and p.duration_unit = sdu)
             or (p.duration between sd3 and sd4 and p.duration_unit = sdu1))
	and nvl(i.affiliation,'ZZZZZZZZZZ') = sst;

	select percentile_disc(0.25) within group (order by grant_total),
	percentile_disc(0.5) within group (order by grant_total),
	percentile_disc(0.75) within group (order by grant_total)
	into t25thgranttot, t50thgranttot,t75thgranttot
        from protocol p, protocol_to_indmap pti,investig i
	where p.id=pti.protocol_id
	and p.id=i.protocol_id  
	and p.phase_id = PhaseId 
	and p.country_id = CountryId
	and pti.indmap_id = IndmapID
	and p.inpatient_status = ps1
	and ((p.duration between sd1 and sd2 and p.duration_unit = sdu)
             or (p.duration between sd3 and sd4 and p.duration_unit = sdu1))
	and nvl(i.affiliation,'ZZZZZZZZZZ') = sst;

  else

	select avg(i.grant_total), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
        from protocol p, protocol_to_indmap pti,investig i
	where p.id=pti.protocol_id
	and p.id=i.protocol_id  
	and p.phase_id = PhaseId 
	and p.country_id = CountryId
	and pti.indmap_id = IndmapID
	and p.inpatient_status = ps1
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and nvl(i.affiliation,'ZZZZZZZZZZ') = sst;

	select percentile_disc(0.25) within group (order by grant_total),
	percentile_disc(0.5) within group (order by grant_total),
	percentile_disc(0.75) within group (order by grant_total)
	into t25thgranttot, t50thgranttot, t75thgranttot
        from protocol p, protocol_to_indmap pti,investig i
	where p.id=pti.protocol_id
	and p.id=i.protocol_id  
	and p.phase_id = PhaseId 
	and p.country_id = CountryId
	and pti.indmap_id = IndmapID
	and p.inpatient_status = ps1
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and nvl(i.affiliation,'ZZZZZZZZZZ') = sst;

 End if;

end;
/

-- Modified ph1 query on 03/18/2003

create or replace procedure ipt_ph1_query (CountryId in number, DosingType in varchar2,
StudyType in number, EntryCriteria in varchar2, AgeRange in varchar2, 
StudySiteType in varchar2, StudyDuration in varchar2, PatientStatus in varchar2, 
TreatmentTime in varchar2, avggranttot out number, cntgranttot out number,
uqcntgranttot out number, t25thgranttot out number, t50thgranttot out number,
t75thgranttot out number) as


dt protocol.dosing%type;
ar protocol.age_range%type;
sst protocol.inpatient_status%type;
sd1  protocol.duration%type;
sd2  protocol.duration%type;
sdu  protocol.duration_unit%type;
ps1  protocol.inpatient_days%type;
ps2  protocol.inpatient_days%type;
tt1  number(10);	
tt2  number(10);

begin


if lower(trim(DosingType))='single dose' 
  then
    dt:='A';
 elsif lower(trim(DosingType))='multiple dose' 
  then
    dt:='B';
end if;

if lower(trim(AgeRange))='all ages' 
  then
    ar:='Any';
 elsif lower(trim(AgeRange))='adult' 
  then
    ar:='Adult';
 elsif lower(trim(AgeRange))='post menopausal' 
  then
    ar:='Postmenopause';
 elsif lower(trim(AgeRange))='geriatric' 
  then
    ar:='Geriatric';
 elsif lower(trim(AgeRange))='pediatric' 
  then
    ar:='Pediatric';
end if;



if lower(trim(StudySiteType))='allsites' 
  then
    sst:='Mixed';
 elsif lower(trim(StudySiteType))='hospital' 
  then
    sst:='Inpatient';
 elsif lower(trim(StudySiteType))='clinresearchcenter' 
  then
    sst:='Inpatient';
 elsif lower(trim(StudySiteType))='physclinic' 
  then
    sst:='Outpatient';
end if;


if lower(trim(StudyDuration))='<one week' 
  then
    sd1:=0;
    sd2:=6;
    sdu:='d';
 elsif lower(trim(StudyDuration))='1 to 2 weeks' 
  then
    sd1:=1;
    sd2:=2;
    sdu:='w';
 elsif lower(trim(StudyDuration))='3 to 4 weeks' 
  then
    sd1:=3;
    sd2:=4;
    sdu:='w';
 elsif lower(trim(StudyDuration))='5 to 6 weeks' 
  then
    sd1:=5;
    sd2:=6;
    sdu:='w';
 elsif lower(trim(StudyDuration))='7 to 8 weeks' 
  then
    sd1:=7;
    sd2:=8;
    sdu:='w';
 elsif lower(trim(StudyDuration))='9 to 12 weeks' 
  then
    sd1:=9;
    sd2:=12;
    sdu:='w';
 elsif lower(trim(StudyDuration))='13 to 20 weeks' 
  then
    sd1:=13;
    sd2:=20;
    sdu:='w';
 elsif lower(trim(StudyDuration))='21 to 25 weeks' 
  then
    sd1:=21;
    sd2:=25;
    sdu:='w';
 elsif lower(trim(StudyDuration))='26 to 52 weeks' 
  then
    sd1:=26;
    sd2:=52;
    sdu:='w';
 elsif lower(trim(StudyDuration))='over 52 weeks' 
  then
    sd1:=52;
    sd2:=5200;
    sdu:='w';
end if;

if lower(trim(PatientStatus))='<24 hours confinement' 
  then
    ps1:=0;
    ps2:=0;
 elsif lower(trim(PatientStatus))='24 to 48 hours confinement' 
  then
    ps1:=1;
    ps2:=2;
 elsif lower(trim(PatientStatus))='3 to 4 days confinement' 
  then
    ps1:=3;
    ps2:=4;
 elsif lower(trim(PatientStatus))='5 to 6 days confinement' 
  then
    ps1:=5;
    ps2:=6;
 elsif lower(trim(PatientStatus))='7 to 13 days confinement' 
  then
    ps1:=7;
    ps2:=13;
 elsif lower(trim(PatientStatus))='14 to 28 days confinement' 
  then
    ps1:=14;
    ps2:=28;
 elsif lower(trim(PatientStatus))='over 28 days confinement' 
  then
    ps1:=29;
    ps2:=10000;
end if;

if lower(trim(TreatmentTime))='1 to 7 days' 
  then
    tt1:=1;
    tt2:=7;
 elsif lower(trim(TreatmentTime))='8 to 14 days' 
  then
    tt1:=8;
    tt2:=14;
 elsif lower(trim(TreatmentTime))='15 to 21 days' 
  then
    tt1:=15;
    tt2:=21;
 elsif lower(trim(TreatmentTime))='22 to 28 days' 
  then
    tt1:=22;
    tt2:=28;
 elsif lower(trim(TreatmentTime))='over 28 days' 
  then
    tt1:=29;
    tt2:=10000;
end if;


If lower(trim(EntryCriteria))='healthy subjects'  
 then
   if lower(trim(PatientStatus)) in ('all patients','no confinement')
     then

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


	select  
	percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into  t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;



   else

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;
 
	select	percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;






   end if;

else

   if lower(trim(PatientStatus)) in ('all patients','no confinement')
     then

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

	select percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

   else

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

	select percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = dt or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


   End if;




End if;

end;
/


-- Modified on 03/19/2003 to return both single and multiple dose values
create or replace procedure ipt_ph1_query (CountryId in number,
StudyType in number, EntryCriteria in varchar2, AgeRange in varchar2, 
StudySiteType in varchar2, StudyDuration in varchar2, PatientStatus in varchar2, 
TreatmentTime in varchar2, avggranttot out number, cntgranttot out number,
uqcntgranttot out number, t25thgranttot out number, t50thgranttot out number,
t75thgranttot out number,m_avggranttot out number, m_cntgranttot out number,
m_uqcntgranttot out number, m_t25thgranttot out number, m_t50thgranttot out number,
m_t75thgranttot out number) as


ar protocol.age_range%type;
sst protocol.inpatient_status%type;
sd1  protocol.duration%type;
sd2  protocol.duration%type;
sdu  protocol.duration_unit%type;
ps1  protocol.inpatient_days%type;
ps2  protocol.inpatient_days%type;
tt1  number(10);	
tt2  number(10);

begin


if lower(trim(AgeRange))='all ages' 
  then
    ar:='Any';
 elsif lower(trim(AgeRange))='adult' 
  then
    ar:='Adult';
 elsif lower(trim(AgeRange))='post menopausal' 
  then
    ar:='Postmenopause';
 elsif lower(trim(AgeRange))='geriatric' 
  then
    ar:='Geriatric';
 elsif lower(trim(AgeRange))='pediatric' 
  then
    ar:='Pediatric';
end if;



if lower(trim(StudySiteType))='allsites' 
  then
    sst:='Mixed';
 elsif lower(trim(StudySiteType))='hospital' 
  then
    sst:='Inpatient';
 elsif lower(trim(StudySiteType))='clinresearchcenter' 
  then
    sst:='Inpatient';
 elsif lower(trim(StudySiteType))='physclinic' 
  then
    sst:='Outpatient';
end if;


if lower(trim(StudyDuration))='<one week' 
  then
    sd1:=0;
    sd2:=6;
    sdu:='d';
 elsif lower(trim(StudyDuration))='1 to 2 weeks' 
  then
    sd1:=1;
    sd2:=2;
    sdu:='w';
 elsif lower(trim(StudyDuration))='3 to 4 weeks' 
  then
    sd1:=3;
    sd2:=4;
    sdu:='w';
 elsif lower(trim(StudyDuration))='5 to 6 weeks' 
  then
    sd1:=5;
    sd2:=6;
    sdu:='w';
 elsif lower(trim(StudyDuration))='7 to 8 weeks' 
  then
    sd1:=7;
    sd2:=8;
    sdu:='w';
 elsif lower(trim(StudyDuration))='9 to 12 weeks' 
  then
    sd1:=9;
    sd2:=12;
    sdu:='w';
 elsif lower(trim(StudyDuration))='13 to 20 weeks' 
  then
    sd1:=13;
    sd2:=20;
    sdu:='w';
 elsif lower(trim(StudyDuration))='21 to 25 weeks' 
  then
    sd1:=21;
    sd2:=25;
    sdu:='w';
 elsif lower(trim(StudyDuration))='26 to 52 weeks' 
  then
    sd1:=26;
    sd2:=52;
    sdu:='w';
 elsif lower(trim(StudyDuration))='over 52 weeks' 
  then
    sd1:=52;
    sd2:=5200;
    sdu:='w';
end if;

if lower(trim(PatientStatus))='<24 hours confinement' 
  then
    ps1:=0;
    ps2:=0;
 elsif lower(trim(PatientStatus))='24 to 48 hours confinement' 
  then
    ps1:=1;
    ps2:=2;
 elsif lower(trim(PatientStatus))='3 to 4 days confinement' 
  then
    ps1:=3;
    ps2:=4;
 elsif lower(trim(PatientStatus))='5 to 6 days confinement' 
  then
    ps1:=5;
    ps2:=6;
 elsif lower(trim(PatientStatus))='7 to 13 days confinement' 
  then
    ps1:=7;
    ps2:=13;
 elsif lower(trim(PatientStatus))='14 to 28 days confinement' 
  then
    ps1:=14;
    ps2:=28;
 elsif lower(trim(PatientStatus))='over 28 days confinement' 
  then
    ps1:=29;
    ps2:=10000;
end if;

if lower(trim(TreatmentTime))='1 to 7 days' 
  then
    tt1:=1;
    tt2:=7;
 elsif lower(trim(TreatmentTime))='8 to 14 days' 
  then
    tt1:=8;
    tt2:=14;
 elsif lower(trim(TreatmentTime))='15 to 21 days' 
  then
    tt1:=15;
    tt2:=21;
 elsif lower(trim(TreatmentTime))='22 to 28 days' 
  then
    tt1:=22;
    tt2:=28;
 elsif lower(trim(TreatmentTime))='over 28 days' 
  then
    tt1:=29;
    tt2:=10000;
end if;


If lower(trim(EntryCriteria))='healthy subjects'  
 then
   if lower(trim(PatientStatus)) in ('all patients','no confinement')
     then

/* single dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


	select  
	percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into  t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

/* multiple dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into m_avggranttot, m_cntgranttot, m_uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


	select  
	percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into  m_t25thgranttot, m_t50thgranttot,m_t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


   else


/* single dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;
 
	select	percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


/* multiple dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into m_avggranttot, m_cntgranttot, m_uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;
 
	select	percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into m_t25thgranttot, m_t50thgranttot,m_t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.phase1type_id <> 3
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;





   end if;

else

   if lower(trim(PatientStatus)) in ('all patients','no confinement')
     then


/* single dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

	select percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


/* multiple dose*/


	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into m_avggranttot, m_cntgranttot, m_uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

	select percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into m_t25thgranttot, m_t50thgranttot,m_t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and i.facility=decode(lower(trim(PatientStatus)),'no confinement','Z',i.facility)
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


   else



/* single dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into avggranttot, cntgranttot, uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

	select percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into t25thgranttot, t50thgranttot,t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'A' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

/* multiple dose*/

	select avg(i.grant_total_usd), count(i.id), count(distinct p.id)
	into m_avggranttot, m_cntgranttot, m_uqcntgranttot
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;

	select percentile_disc(0.25) within group (order by grant_total_usd),
	percentile_disc(0.5) within group (order by grant_total_usd),
	percentile_disc(0.75) within group (order by grant_total_usd)
	into m_t25thgranttot, m_t50thgranttot,m_t75thgranttot 
	from  protocol p, investig i  
	where p.id=i.protocol_id  
	and p.phase_id = 1 
	and p.country_id = CountryId
	and p.picas_protocol in (select code from temp_protocol where
            lower(entry_criteria) = lower(trim(EntryCriteria)))
	and (p.dosing = 'B' or p.dosing = 'E')
	and p.phase1type_id = decode(StudyType,-1,p.phase1type_id,StudyType)
	and p.age_range = ar
	and p.inpatient_status = sst
	and p.duration between sd1 and sd2 
	and p.duration_unit = sdu
	and p.inpatient_days between ps1 and ps2
        and nvl(GROUP1_PRETREAT_DAYS,0)+nvl(GROUP1_TREAT_DAYS,0)+nvl(GROUP2_TREAT_DAYS,0)+
	    nvl(GROUP3_TREAT_DAYS,0)+nvl(GROUP4_TREAT_DAYS,0)+nvl(GROUP5_TREAT_DAYS,0)+
	    nvl(GROUP6_TREAT_DAYS,0)+nvl(GROUP7_TREAT_DAYS,0)+nvl(GROUP8_TREAT_DAYS,0)+
	    nvl(GROUP9_TREAT_DAYS,0)+nvl(GROUPA_TREAT_DAYS,0) between tt1 and tt2
	and i.sampled=0 
	and i.managed=0
	and i.incomplete=0
	and i.payment_country_id is not null;


   End if;




End if;

end;
/

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/27/2008 3:18:15 PM Debashish Mishra  
--  7    DevTSM    1.6         3/3/2005 6:35:59 AM  Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:19:44 PM Debashish Mishra  
--  5    DevTSM    1.4         3/19/2003 2:24:19 PM Debashish Mishra  
--  4    DevTSM    1.3         3/12/2003 10:25:38 AMDebashish Mishra Modiified
--       after modifying the phase table
--  3    DevTSM    1.2         3/11/2003 4:49:08 PM Debashish Mishra Modified
--       single/multiple to single dose/multiple dose and added studytype -1 for
--       all studies
--  2    DevTSM    1.1         3/6/2003 6:38:32 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/5/2003 7:20:45 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

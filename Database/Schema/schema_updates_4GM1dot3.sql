--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4GM1dot3.sql$ 
--
-- $Revision: 42$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following changes are as per the request of Tonya on 02-02-2004 at 8:10AM

Alter table trial_budget add(num_entered_patients number(6),
			     num_enrolled_patients number(6));

update trial_budget set num_entered_patients=num_patients;
commit;

Alter table client_div add(def_input_pref varchar2(40) default 'Entering');

conn ft15/****@????
alter table ftuser add (input_pref varchar2(40));
conn tsm10/*****@?????

-- Following database changes are as per the request of Tonya on 02-06-2004 at 8:30am

Alter table ip_session add(comments varchar2(256));
Alter table trial_budget add(total_cost_pvb number(10),
	total_cost_pvb_local number(10));
Alter table tsm_trial_rollup add(total_cost_pvb number(10));
Alter table PICAS_VISIT drop constraint PV_TRIAL_PHASE_CHECK;
Alter table PICAS_VISIT add constraint PV_TRIAL_PHASE_CHECK check(trial_phase in 
   ('Screening','Treatment','Follow Up','Other','Withdrawal','Discontinuation'));

-- Following database changes are as per the request of Tonya on 02-10-2004 at 8:25am

alter table trial_budget add(local_currency_id number(10));
alter table client_div add(messaging_opt number(1) default 1 not null);

Alter table trial_budget add constraint TRIAL_BUDGET_FK11
foreign key (LOCAL_CURRENCY_ID) references currency(id);

Alter table client_div add constraint cd_messaging_opt_check 
check(messaging_opt in (0,1));

-- Applied database changes to tsm10@TEST upto this on 02-17-2004 at 3pm

-- Following changes are as per the request of Tonya on 02-19-2004 at 9:30 am

Alter table ip_session add (GRP_LOCAL_CURRENCY_ID number(10));
Alter table ip_session add constraint ip_session_fk17
 foreign key (GRP_LOCAL_CURRENCY_ID) references currency(id);

Alter table trial_budget add(final number(1));
Alter table trial_budget add constraint tb_final_check 
	check(final in (0,1));

Alter table client_div drop constraint cd_messaging_opt_check;
Alter table client_div add constraint cd_messaging_opt_check 
check(messaging_opt in (0,1,2));

Alter table ftuser_to_client_group add (dflt_group number(1));
Alter table ftuser_to_client_group add constraint 
	ftcg_dflt_group_check check(dflt_group in (0,1));

conn ft15/*****@????
Alter table ftuser add (creation_date date, 
			messaging_opt number(1));
Alter table ftuser add constraint ftuser_messaging_opt_check 
	check(messaging_opt in (0,1,2));

conn tsm10/*****@????

-- Following changes are as per the request of Tonya on 02-19-2004 at 11:30 am

--update currency set IS_VIEWABLE=1 where id in (
--select CURRENCY_ID from country where
--ABBREVIATION in ('ARG','BRA','CHI','MEX'));

update currency set VIEWABLE_FLG=1 where id in (
select CURRENCY_ID from country where
ABBREVIATION in ('ARG','BRA','CHI','MEX'));

commit;


-- Applied database changes to tsm10@TEST upto this on 02-24-2004 at 12:28pm
-- Applied database changes to tsm10e@TEST upto this on 03-02-2004 at 10:21am

-- Following procedures are added by Debashish to augment the client data build proceudres
-- on 03-11-2004 at 10:40 AM

create or replace procedure TGM_client_build_1 (clientDivIdentifier in varchar2)
as 
begin
update client_div set (country_id,using_webstart)=(select id,0 from country where
abbreviation = 'USA') where client_div_identifier = ClientDivIdentifier;
Insert into client_group(id,client_div_id,name) select 
	increment_sequence('client_group_seq'),id,'Default Group' from client_div
	where client_div_identifier = ClientDivIdentifier;
commit;
end;
/

create or replace procedure TGM_client_build_2 (clientDivIdentifier in varchar2,
PrincipalContact in varchar2,
AppType in varchar2 default 'PICASE',
tel# in varchar2 default null, GMVersion in varchar2 default null,
FrontEndVersion in varchar2 default null, 
PatchAvailable in number default 0,
PatchVersion in varchar2 default null)
as
begin
update ftuser set last_password_update=sysdate 
where name='fasttrack@'||clientDivIdentifier;

update client_div_to_lic_app set principal_contact_id = (Select id from ftuser
where name=PrincipalContact||'@'||clientDivIdentifier)
where client_div_id = (select id from client_div where
client_div_identifier = clientDivIdentifier
and app_name = AppType);

If tel# is not null then
  update ftuser set WORK_PHONE = tel# where name=PrincipalContact||'@'||clientDivIdentifier;
end if;

If GMVersion is not null then
  update client_div_to_lic_app set version = GMVersion 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

If FrontEndVersion is not null then 
  update client_div_to_lic_app set frontend_version = FrontEndVersion 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

If PatchAvailable=1 then
  update client_div_to_lic_app set patch_available = PatchAvailable 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

If PatchVersion is not null then 
  update client_div_to_lic_app set patch_version = PatchVersion 
  where client_div_id = (select id from client_div where
  client_div_identifier = clientDivIdentifier
  and app_name = AppType);
end if;

commit;
end;
/

--**************************************************
-- updated scripts upto this on 11-16-04 at 7:15am
--**************************************************

-- Applied database changes to tsm10e@TEST upto this on 03-09-2004 at 8:50am
-- Applied database changes to tsm10t@PREV upto this on 04-05-2004 at 18:00pm
-- Applied database changes to tsm10g@PROD upto this on 05-01-2004 at 1:15am

--**************************************************************************
-- Applied database changes to tsm10@TEST upto this on 03-24-2004 at 16:14pm
--**************************************************************************

-- Following chnages are as per the request of Kelly on 04/26/2004 at 4pm

alter table country add (parent_country_id number(10));

alter table country add constraint COUNTRY_FK3 
foreign key(parent_country_id) references country(id);

-- Following changes are as per the request of Kelly on 04-26-2004

update trial_budget a set local_currency_id=(select
currency_id from country b where b.id=a.country_id)
where a.country_id in (4,6,9,25);
commit;

-- Following changes are as per the request of Kelly on 04-27-2004

Update currency set viewable_flg=1 where id in (
  select currency_id from country where abbreviation in
  ('BLG','RUM','CZE','SVK','RIA','EST','LAT','LIT',
   'YUG','SLO','CRO'));

--update currency a set (a.name,a.symbol)= (select 'Lev','Lw' from dual)
--  where id in (select currency_id from country where abbreviation='BLG');
--update currency a set (a.name,a.symbol)= (select 'Lei','L' from dual)
--  where id in (select currency_id from country where abbreviation='RUM');
--update currency a set (a.name,a.symbol)= (select 'Koruny','Kc' from dual)
--  where id in (select currency_id from country where abbreviation='CZE');
--update currency a set (a.name,a.symbol)= (select 'Koruny','Sk' from dual)
--  where id in (select currency_id from country where abbreviation='SVK');
--update currency a set (a.name,a.symbol)= (select 'Rouble','Rb' from dual)
--  where id in (select currency_id from country where abbreviation='RIA');
--update currency a set (a.name,a.symbol)= (select 'Krooni','KR' from dual)
--  where id in (select currency_id from country where abbreviation='EST');
--update currency a set (a.name,a.symbol)= (select 'Lati','Ls' from dual)
--  where id in (select currency_id from country where abbreviation='LAT');
--update currency a set (a.name,a.symbol)= (select 'Litai','L' from dual)
--  where id in (select currency_id from country where abbreviation='LIT');
--update currency a set (a.name,a.symbol)= (select 'Dinar','Din' from dual)
--  where id in (select currency_id from country where abbreviation='YUG');
--update currency a set (a.name,a.symbol)= (select 'Tolars','SIT' from dual)
--  where id in (select currency_id from country where abbreviation='SLO');
--update currency a set (a.name,a.symbol)= (select 'Kuna','HRK' from dual)
--  where id in (select currency_id from country where abbreviation='CRO');
--commit;


-- Following changs are as per request of Kelly on 04-27-2004 at 3:30pm

Update country set parent_country_id=(select id from country where
   abbreviation = 'SCY') where abbreviation in ('YUG','SLO','CRO');
Update country set parent_country_id=(select id from country where
   abbreviation = 'BUL') where abbreviation in ('BLG','RUM');
Update country set parent_country_id=(select id from country where
   abbreviation = 'PHC') where abbreviation in ('CZE','SVK');
Update country set parent_country_id=(select id from country where
   abbreviation = 'FSU') where abbreviation in ('LAT','EST','LIT','RIA');
commit;

-- Following chnages are as per the request of Tonya on 05-06-2004 at 7pm

Insert into ftgroup values(24,'GM Client Data Admin');

Alter table unlisted_procedure add(
	low number(12,2),
	mid number(12,2),
	high number(12,2),
	delete_flg number(1));

Alter table unlisted_procedure add constraint
up_delete_flg_check check(delete_flg in (0,1));

--Implemented upto this in tsm10e@TEST on 05-07-2004 at 7pm

-- added for kelly 5/13
Alter table picase_trial add(
   price_cmp_indmap_id number(10,0));

conn ft15/*****@???

-- added for tonya 5/14:
Alter table ftuser add (
	messaging_flg number (1,0) default 1 not null);

Alter table ftuser add constraint ftuser_messaging_flg_check 
check(messaging_flg in (0,1));

-- Implemented upto this in tsm10e@TEST on 05-17-2004 at 4:00pm
-- Implemented upto this in tsm10t@PREV on 05-17-2004 at 4:00pm

-- this not needed after all, ok to drop, no code released using it
alter table ip_session drop column grp_local_currency_id;

-- not needed, we already had obsolete flag, ok to drop, no code ever used it
alter table unlisted_procedure drop column delete_flg;

conn tsm10e/*****@????

-- created for kelly 5/18

CREATE TABLE ip_session_detail (
id number(10,0) NOT NULL,
ip_session_id number(10,0) NOT NULL,
country_id NUMBER(10,0) NOT NULL,
num_patients NUMBER(10,0))
TABLESPACE tsmsmall
PCTUSED 60 PCTFREE 25;

ALTER TABLE ip_session_detail ADD CONSTRAINT ip_session_detail_pk
PRIMARY KEY (id) using INDEX TABLESPACE
tsmsmall_indx PCTFREE 25;

ALTER TABLE ip_session_detail ADD CONSTRAINT ip_session_detail_fk1
foreign KEY(ip_session_id) REFERENCES ip_session(id);

ALTER TABLE ip_session_detail ADD CONSTRAINT ip_session_detail_fk2
foreign KEY(country_id) REFERENCES country(id);


ALTER TABLE ip_session ADD
(factor VARCHAR2(30),
pricing VARCHAR2(10));

Alter table ip_session add constraint ip_session_pricing_check check(pricing in 
   ('Low','Med','High','Co_Med'));


Alter table ip_session add constraint ip_session_factor_check check(factor in 
   ('SingleDose','MultipleDose','CPP_Simple','CPP_Complex','CPP','CPV'));

-- Following chnages are as per the request of Kelly on 5/27/2004 at 8AM

Alter table ip_session modify(location_set_id null);

-- Implemented upto this in tsm10e@TEST on 05-28-2004 at 4:00pm

-- Following changes are done by Debashish on 6-1-2004 at 9AM

Insert into id_control values ('tsm10','ip_session_detail',1);
commit;

-- Following changes are as per the request of Kelly on 6-4-2004 at 11am

Alter table user_pref drop constraint UP_APP_TYPE_CHECK;
Alter table user_pref add constraint UP_APP_TYPE_CHECK
check ( app_type in ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN'));

Alter table audit_hist drop constraint AUDIT_HIST_APP_TYPE_CHECK;
Alter table audit_hist add constraint AUDIT_HIST_APP_TYPE_CHECK
check ( app_type in ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN'));

conn ftcommon/********@??????

Alter table application drop constraint application_app_name_check;
Alter table application add constraint application_app_name_check check(
app_name in ('PICASE', 'TRACE','TSPD','FTADMIN'));

--Insert into application values (4,'FTADMIN','FTADMIN',null);
--Commit;

conn tsm10/******@????????

-- Following changes are as per the request of Kelly on 06-10-2004

Alter table procedure_def add (short_desc varchar2(256));
Alter table odc_def add (short_desc varchar2(256));

-- Implemented upto this in tsm10g@PROD on 07-01-2004 at 10:55am

--Following changes are made on 07-17-2004 at 7:40pm as per Kelly

alter table PICAS_VISIT_SET_ITEM drop constraint PVS_TRIAL_PHASE_CHECK;

alter table PICAS_VISIT_SET_ITEM add constraint
PVS_TRIAL_PHASE_CHECK check(trial_phase in
('Screening','Treatment','Follow Up','Other','Withdrawal','Discontinuation'));

-- Implemented upto this in tsm10e@TEST on 07-17-2004 at 19:40am
-- Implemented upto this in tsm10t@PREV on 07-17-2004 at 19:40am

-- Following changes are as per the request of Kelly on 07-22-2004 at 13:20

Alter table ip_session modify (comments varchar2(4000));

-- Following chnages are as per the request of Kelly on 07-27-2004 at 3:20 am

alter table temp_procedure add(entry_date date);

-- Following changes are as per the request of Kelly on 07-30-2004 at 14:40

Alter table temp_procedure add (Primary_indication_flg number(1) default 1 not null);

-- Implemented upto this in tsm10e@TEST on 08-20-2004 at 9:20am
-- Implemented upto this in tsm10t@PREV on 08-20-2004 at 19:20am
-- Following changes are as per the request of Nancy on 07-30-2004 at 15:45 

update trial_budget set final=0 where final is null;
commit;
alter table trial_budget modify(final default 0 not null);

-- Following request is as per the request of Tonya on 8-17-2004 at 8:27AM

Alter table trial_budget drop column final;

-- Following changes are as per the request of Kelly on8-25-2004 at 9AM

Alter table country add(geo_location varchar2(20));

update country set geo_location='EE' where abbreviation='FSU';
update country set geo_location='OTHER' where abbreviation='AUS';
update country set geo_location='WE' where abbreviation='ARI';
update country set geo_location='WE' where abbreviation='BEL';
update country set geo_location='EE' where abbreviation='BUL';
update country set geo_location='NA' where abbreviation='CAN';
update country set geo_location='EE' where abbreviation='PHC';
update country set geo_location='WE' where abbreviation='DEN';
update country set geo_location='WE' where abbreviation='FIN';
update country set geo_location='WE' where abbreviation='FRA';
update country set geo_location='WE' where abbreviation='DEU';
update country set geo_location='EE' where abbreviation='HUN';
update country set geo_location='WE' where abbreviation='IRL';
update country set geo_location='OTHER' where abbreviation='ISR';
update country set geo_location='WE' where abbreviation='ITA';
update country set geo_location='WE' where abbreviation='NET';
update country set geo_location='WE' where abbreviation='NOR';
update country set geo_location='EE' where abbreviation='POL';
update country set geo_location='OTHER' where abbreviation='SAF';
update country set geo_location='WE' where abbreviation='ESP';
update country set geo_location='WE' where abbreviation='SWE';
update country set geo_location='WE' where abbreviation='SWI';
update country set geo_location='WE' where abbreviation='UK';
update country set geo_location='NA' where abbreviation='USA';
update country set geo_location='EE' where abbreviation='SCY';
update country set geo_location='LA' where abbreviation='ARG';
update country set geo_location='LA' where abbreviation='CHI';
update country set geo_location='LA' where abbreviation='MEX';
update country set geo_location='LA' where abbreviation='BRA';

commit;

-- Following chnages are as per the request of Kelly on 08-27-2004 at 3:40pm

conn ft15e/****@???

Alter table ftuser modify (MESSAGING_FLG null);
ALTER TABLE FTUSER MODIFY (MESSAGING_FLG  DEFAULT NULL);

-- Implemented upto this in tsm10e@TEST on 08-31-2004 at 9:20am

conn tsm10/****@???

-- Following changes are as per the request of Kelly on 09-01-2004 at 16:18

Alter table ip_session_detail add(num_visits number(10));

-- Implemented upto this in tsm10e@TEST on 09-08-2004 at 16:35am

-- Implemented upto this in tsm10t@PREV on 09-09-2004 at 14:30am

-- Following changes are as per the request of Kelly on 09/13/2004 at 1:50pm

declare

popti_maxid number(10);
zero_exists number(1);
cursor c1 is select id from pap_odc_pct where country_id is not null;

begin

select nvl(max(id),0)+1 into popti_maxid from
pap_odc_pct_to_indmap;

 for ix1 in c1 loop

  select count(*) into zero_exists from pap_odc_pct_to_indmap
  where indmap_id=0 and pap_odc_pct_id=ix1.id;

  If zero_exists=0 then
    Insert into pap_odc_pct_to_indmap values(popti_maxid,ix1.id,0,0);
    popti_maxId:=popti_maxid+1;
  end if;

 end loop;
commit;
end;
/

--**************************************************************
-- Implemented upto this in tsm10e@TEST on 09-14-2004 at 19:10
-- Implemented upto this in tsm10t@PREV on 09-30-2004 at 14:17am
-- Implemented upto this in tsm10e@PREV on 11-05-2004 at 9:10 pm
-- Implemented upto this in tsm10e@PROD on 11-06-2004 at 1:10 am
-- Implemented upto this in tsm10@PROD on 11-06-2004 at 1:10 am
-- Implemented upto this in tsm10g@PROD on 05-07-2005 at 11:55pm
--***************************************************************


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  42   DevTSM    1.41        2/22/2008 11:56:00 AMDebashish Mishra  
--  41   DevTSM    1.40        9/19/2006 12:11:22 AMDebashish Mishra   
--  40   DevTSM    1.39        5/9/2005 1:00:51 AM  Debashish Mishra  
--  39   DevTSM    1.38        3/2/2005 10:50:56 PM Debashish Mishra  
--  38   DevTSM    1.37        1/26/2005 7:00:39 AM Debashish Mishra  
--  37   DevTSM    1.36        11/16/2004 12:38:32 AMDebashish Mishra  
--  36   DevTSM    1.35        10/13/2004 8:00:51 AMDebashish Mishra  
--  35   DevTSM    1.34        9/14/2004 7:00:53 AM Debashish Mishra  
--  34   DevTSM    1.33        9/12/2004 3:15:06 AM Debashish Mishra  
--  33   DevTSM    1.32        8/31/2004 9:44:15 AM Debashish Mishra Moved some
--       tags around
--  32   DevTSM    1.31        8/27/2004 3:50:29 PM Debashish Mishra modified
--       ftuser.messaging_flg
--  31   DevTSM    1.30        8/24/2004 5:15:41 PM Debashish Mishra  
--  30   DevTSM    1.29        8/20/2004 10:36:40 AMDebashish Mishra  
--  29   DevTSM    1.28        8/2/2004 1:31:03 PM  Debashish Mishra  
--  28   DevTSM    1.27        7/27/2004 3:32:07 AM Debashish Mishra New column
--       temp_procedure.entry_date
--  27   DevTSM    1.26        7/22/2004 3:05:56 PM Debashish Mishra increased
--       column width for ip_session.comments
--  26   DevTSM    1.25        7/17/2004 7:47:44 PM Debashish Mishra modified
--       pvs_trial_phase_check
--  25   DevTSM    1.24        7/15/2004 12:35:47 PMDebashish Mishra  
--  24   DevTSM    1.23        6/10/2004 12:43:28 PMDebashish Mishra  
--  23   DevTSM    1.22        6/10/2004 11:32:29 AMDebashish Mishra  
--  22   DevTSM    1.21        6/10/2004 11:25:52 AMDebashish Mishra  
--  21   DevTSM    1.20        6/4/2004 11:15:50 AM Debashish Mishra Added ftadmin
--       to app_type 
--  20   DevTSM    1.19        6/1/2004 9:12:17 AM  Debashish Mishra inserted one
--       row into id_control table for ip_session_detail table
--  19   DevTSM    1.18        5/28/2004 12:27:15 PMDebashish Mishra moved some
--       tags around. No code change
--  18   DevTSM    1.17        5/27/2004 8:34:34 AM Debashish Mishra modified
--       ip_session.location_set_id to null an d moved some tags around
--  17   DevTSM    1.16        5/18/2004 3:01:06 PM Kelly Kingdon   added ipt
--       changes
--  16   DevTSM    1.15        5/18/2004 10:35:23 AMKelly Kingdon   drop couple
--       columns that were added for GM 1.3 but never used.
--  15   DevTSM    1.14        5/18/2004 8:03:42 AM Kelly Kingdon   added comments
--       about when test and prev were updated
--  14   DevTSM    1.13        5/14/2004 1:10:28 PM Kelly Kingdon   added
--       messaging_flg for ftuser
--  13   DevTSM    1.12        5/13/2004 11:45:04 AMKelly Kingdon   added
--       picase_trial column
--  12   DevTSM    1.11        5/7/2004 6:59:24 PM  Debashish Mishra  
--  11   DevTSM    1.10        5/7/2004 10:39:11 AM Debashish Mishra  
--  10   DevTSM    1.9         5/6/2004 8:15:32 PM  Debashish Mishra  
--  9    DevTSM    1.8         4/9/2004 9:03:14 AM  Debashish Mishra Moved tags
--       around
--  8    DevTSM    1.7         4/8/2004 4:09:29 PM  Debashish Mishra  
--  7    DevTSM    1.6         3/19/2004 6:15:24 PM Debashish Mishra  
--  6    DevTSM    1.5         3/8/2004 10:37:14 AM Debashish Mishra  
--  5    DevTSM    1.4         3/3/2004 11:00:31 AM Debashish Mishra  
--  4    DevTSM    1.3         2/25/2004 2:46:13 PM Debashish Mishra Moved
--       deployment labels around
--  3    DevTSM    1.2         2/20/2004 4:54:27 PM Debashish Mishra  
--  2    DevTSM    1.1         2/12/2004 10:41:35 AMDebashish Mishra  
--  1    DevTSM    1.0         2/2/2004 10:53:33 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

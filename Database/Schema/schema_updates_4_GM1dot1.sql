--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4_GM1dot1.sql$ 
--
-- $Revision: 28$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following chnages are as per the request of Joel on 04/11/2003 at 11:15 

Alter table "&2".trial drop constraint TRIAL_STATUS_CHECK;
Alter table "&2".trial add constraint TRIAL_STATUS_CHECK
check (trial_status in ('CREATION', 'ACTIVE', 'CLOSED','TSM_PUB','DELETED'));

-- Following chnages are as per the request of kelly on 04/15/2003 at 10:56 am

Alter table "&1".client_div add (
	g50_col_enabled 	number(1) default 0 not null,
	g50_hdng		varchar2(5),
	g50_spec_hdng		varchar2(5),
	g50_pcklst_desc	varchar2(10));

Alter table "&1".client_div add constraint cd_g50_col_enabled_check
	check(g50_col_enabled in (0,1));

-- Following chnages are as per the request of Kelly on 04/15/2003 at 4pm

Alter table "&1".cost_item drop constraint cost_item_price_range_check;

Alter table "&1".cost_item add constraint cost_item_price_range_check
	check(price_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table "&1".client_div drop constraint cd_def_price_range_check;

Alter table "&1".client_div add constraint cd_def_price_range_check
	check(def_price_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table "&1".trial_budget drop constraint tb_ovhd_pct_range_check;

Alter table "&1".trial_budget add constraint tb_ovhd_pct_range_check
	check(overhead_pct_range in ('Low','Med','High','Co_Med','Custom','G50'));

-- Following changes are as per the request of Kelly on 04/16/2003 at 9:30 am

Alter table "&1".procedure_def add (		
	obsolete_build_tag_id  number(10),
	added_build_tag_id  number(10),
        hide number(1) default 0 not null);

Alter table "&1".procedure_def add constraint procedure_def_hide_check
	check ( hide in (0,1));

Alter table "&1".odc_def add (		
	obsolete_build_tag_id  number(10),
	added_build_tag_id  number(10));

Alter table "&1".procedure_def drop column obsolete_date;
Alter table "&1".procedure_def drop column added_in_build_id;
Alter table "&1".odc_def drop column obsolete_date;
Alter table "&1".odc_def drop column added_in_build_id;

Alter table "&1".procedure_def add constraint procedure_def_fk1
	foreign key (obsolete_build_tag_id) references "&1".build_tag (id);

Alter table "&1".procedure_def add constraint procedure_def_fk2
	foreign key (added_build_tag_id) references "&1".build_tag (id);

Alter table "&1".odc_def add constraint odc_def_fk1
	foreign key (obsolete_build_tag_id) references "&1".build_tag (id);

Alter table "&1".odc_def add constraint odc_def_fk2
	foreign key (added_build_tag_id) references "&1".build_tag (id);


update "&1".procedure_def set obsolete_build_tag_id = 1 where obsolete_flg = 1;
update "&1".procedure_def set added_build_tag_id = 1 ;
update "&1".odc_def set obsolete_build_tag_id = 1 where obsolete_flg = 1;
update "&1".odc_def set added_build_tag_id = 1 ;

commit;


-- Following changes are as per the request of Kelly on 04/16/2003 at 11 am

Alter table "&1".client_div_to_build_code add(
	primary_flg number(1) default 1 not null);

Alter table "&1".client_div_to_build_code add constraint cdtbc_primary_flg_check 
	check ( primary_flg in (0,1));


-- Following changes as as per the request of colin on 04/18/2003 at 3:15 pm

Alter table "&1".trial_budget add(avg_cpp_g50 number(10));

-- Following chnages are as per the request of Colin on 04/22/2003 at 3:50pm

Alter table "&1".cost_item add (
	required_g50_specificity VARCHAR2(10) default 'GSP' not null,
	priced_g50_specificity VARCHAR2(10));


-- Following changes are as per the request of Joel on 04/24/2003 at 10:15 am

Alter table "&1".TRIAL_BUDGET drop constraint TB_OVERHEAD_TYPE_CHECK;

Alter table "&1".TRIAL_BUDGET add constraint TB_OVERHEAD_TYPE_CHECK
check (overhead_type in ('Clientdef','PicasOfficialDef','PicasAdjustedDef','Manual','G50'));


-- Following changes are as per the request of Joel on 04/24/2003 at 10:30 am

Alter table "&1".TRIAL_BUDGET drop constraint TB_ODC_PCT_RANGE_CHECK;

Alter table "&1".TRIAL_BUDGET add constraint TB_ODC_PCT_RANGE_CHECK
check (odc_pct_range in ('Industry','Company','Custom','G50'));

-- Following chnages are as per the request of Kelly on 05/01/2003 at 11:43 AM

Alter table "&1".client_div_to_lic_country add constraint
client_div_to_lic_country_uq1 unique 
(CLIENT_DIV_ID,COUNTRY_ID)
using index tablespace tsmsmall pctfree 10;

-- Following chnages are as per the request of Debashish on 03/06/2003 for IPT queries
-- This changes are actually posted here on 05/06/2003 at 9 AM
 
Alter table "&1".investig add (facility varchar2(40));

Alter table "&1".investig add constraint investig_facility_check
   check(facility in ('Hospital','Unit','Other','No Confinement, Not Phase I','Unknown'));

-- Following chnages are added by Debashish on 03/11/2003 at 4pm
-- This changes are actually posted here on 05/06/2003 at 9 AM

Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (21,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (22,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (23,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (24,'ph1 PK/Bioavailability and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (25,'Ph1 Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (26,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (27,'ph1 PK/Bioavailability and Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (28,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (29,'ph1 Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (30,'ph1 Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (31,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (32,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (33,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy and Radiol',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (34,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (35,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (36,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (37,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (38,'ph1 PK/Bioavailability and Specific Population and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (39,'Ph1 PK/Bioavailability and Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (40,'Ph1 PK/Bioavailability and Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (41,'ph1 PK/Bioavailability and Specific Population and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (42,'ph1 PK/Bioavailability and Food Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (43,'ph1 PK/Bioavailability and Food Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (44,'ph1 PK/Bioavailability and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (45,'Ph1 PK/Bioavailability and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (46,'ph1 PK/Bioavailability and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (47,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (48,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (49,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (50,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (51,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (52,'ph1 Safety/Tolerance/Dose Ranging and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (53,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (54,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (55,'ph1 Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (56,'ph1 Specific Population and Food Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (57,'ph1 Specific Population and Food Interaction and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (58,'ph1 Specific Population and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (59,'ph1 Specific Population and Drug Interaction and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (60,'ph1 Specific Population and Efficacy',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (61,'ph1 Food Interaction and Drug Interaction',null);
Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (62,'ph1 Drug Interaction and Efficacy',null);

update "&1".phase set short_desc = 'ph1 PK/Bioavailability' where id=6;
update "&1".phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging' where id=7;
update "&1".phase set short_desc = 'ph1 Specific Population' where id=8;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging' where id=9;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Specific Population' where id=10;
update "&1".phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging and Specific Population' where id=11;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population' where id=12;
update "&1".phase set short_desc = 'ph1 Food Interaction' where id=13;
update "&1".phase set short_desc = 'ph1 Drug Interaction' where id=14;
update "&1".phase set short_desc = 'ph1 Efficacy' where id=15;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Food Interaction' where id=16;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Drug Interaction' where id=17;
update "&1".phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction' where id=18;

commit;

-- then chnages were made to protocol map

-- Following chnages were done after receiving the mail of Michael Kahn on "shame on us" on 05/06/2003 at 10:07 AM

update "&1".indmap set code = 'OPHTHALMOLOGY' where code = 'OPTHALMOLOGY';
commit;

-- Following chnages are as per the GM1.1 hide procedures for certain procedures on 05/06/2003 at 11 am

update "&1".procedure_def set hide = 1 where cpt_code in ('#4000','#4001','#4002','#4003','#4004','#4005',
'#4006','#4007','#6001','#6005','#6006','#6007','#6008','#6009','#6010','#6011',
'#6012','#6013','#6014','#6015','#6016','#6017','#6018','#6019','#6020','#6021','#6022','cpp','cppv');

update "&1".odc_def set hide=1 where picas_code in ('#6002','#6003','#6004');

commit;

-- Following chnages are as per the request of Kelly on 05/08/2003 at 14:32

Insert into "&1".phase(ID,SHORT_DESC,SEQUENCE) values (-1,'Unknown',null);
commit;

-- Following chnages are as per the request of Kelly on 05/08/2003 at 2:50 pm

alter table "&1".protocol add (
	protocol_family_id varchar2(64),
	collection_country_id number(10),
	same_as_prot number(1),
	title varchar2(4000));

Alter table "&1".protocol add constraint protocol_same_as_prot_check
	check (same_as_prot in (0,1));

Alter table "&1".protocol add constraint protocol_fk5 
	foreign key (collection_country_id) references "&1".country(id);

-- Following chnages are as per the request of Kelly on 05/13/2003

declare

 cursor c1 is select CREATED_BY,CLIENT_DIV_ID,PROTOCOL_IDENTIFIER from "&2".trial 
 group by CREATED_BY,CLIENT_DIV_ID,PROTOCOL_IDENTIFIER having count(*) > 1 ;
 suffix_num number(4);

begin
 
 for ix1 in c1 loop
  
 suffix_num:=1;

   declare

      cursor c2 is select id from "&2".trial where created_by = ix1.created_by and
      client_div_id = ix1.client_div_id and protocol_identifier = ix1.protocol_identifier;

   begin

      for ix2 in c2 loop

        update "&2".trial set protocol_identifier = protocol_identifier||'_'||suffix_num
        where id = ix2.id;

        suffix_num:=suffix_num+1;
      end loop;
   end;

 end loop;
commit;
end;
/

Alter table "&2".trial add constraint trial_uq2 
unique(CLIENT_DIV_ID,CREATED_BY,PROTOCOL_IDENTIFIER)
using index tablespace tsmsmall_indx pctfree 20;


-- Implemented upto this in tsm10e@test on 05/21/2003
-- Implemented upto this in tsm10p@prev on 05/30/2003
-- Implemented upto this in tsm10e@prev on 05/30/2003


-- Following changes are as per the request of Kelly on 05/28/2003 at 3:20 pm

create index "&2".ftuser_indx1 on "&2".ftuser(client_div_id) 
tablespace ftsmall pctfree 20;

-- Following chnages are as per the request of Kelly on 05/28/2003 at 3:50 PM

Alter table "&1".audit_hist add(start_date date);

-- Following changes are as per the request of Joel on 05/30/2003 at 6 PM

Alter table "&2".ftuser add(def_plan_currency_id number(10));
Alter table "&2".ftuser add constraint ftuser_fk5 foreign key (def_plan_currency_id)
references "&1".currency(id);

Alter table "&1".client_div add(allow_create_unlisted number (1) default 0 not null);
Alter table "&1".client_div add constraint cd_allow_create_unlisted_check
check(allow_create_unlisted in (0,1));

-- Following changes are as per the request of Joel on 06/03/2003 at 10 AM

Alter table "&1".client_div_to_lic_app add(patch_version VARCHAR2(30));

-- Implemented upto this in tsm10e@test on 06/06/2003
-- Implemented upto this in tsm10p@prev on 06/09/2003
-- Implemented upto this in tsm10e@prev on 06/18/2003


-- Folowing chnages are as per the bugs found on 07/03 and added by debashish

Alter table "&1".odc_def add (foxpro_flg number(1) default 1 not null);

Alter table "&1".odc_def add constraint od_foxpro_flg_check
check(foxpro_flg in (0,1));

Alter table "&1".procedure_def add (foxpro_flg number(1) default 1 not null);

Alter table "&1".procedure_def add constraint pd_foxpro_flg_check
check(foxpro_flg in (0,1));

-- ***************************************************
-- Implemented upto this in tsm10e@test on 07/03/2003
-- Implemented upto this in tsm10p@prev on 07/03/2003
-- Implemented upto this in tsm10e@prev on 07/03/2003
-- Implemented upto this in tsm10@prod on 07/03/2003
-- Implemented upto this in tsm10d@prod on 07/03/2003
-- Implemented upto this in tsm10e@prod on 07/03/2003
-- Implemented upto this in tsm10@test on 09/24/2003
-- ***************************************************









--**************************************************
--**************************************************
--RECREATE THE FOLLOWING TWO VIEWS MANUALLY
--**************************************************
--**************************************************

---conn ftcommon/****@????

create or replace view CLIENT_DIV as;
--select ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
--DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
--STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
--DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
--ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,
--G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,'tsm10' environment from tsm10.client_div;

--create or replace view FTUSER as
--select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
--FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
--ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
--HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
--CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
--ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,'tsm10' environment 
--from ft15.ftuser;

-- Following is after the request of Joel on 06/03/2003 at 10 AM

--create or replace view CLIENT_DIV_TO_LIC_APP as
--select ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
--PRINCIPAL_CONTACT_ID,VERSION,frontend_version,PATCH_AVAILABLE,
--patch_version ,'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP;







---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  28   DevTSM    1.27        2/22/2008 11:56:00 AMDebashish Mishra  
--  27   DevTSM    1.26        9/19/2006 12:11:24 AMDebashish Mishra   
--  26   DevTSM    1.25        3/2/2005 10:50:58 PM Debashish Mishra  
--  25   DevTSM    1.24        9/26/2003 4:05:55 PM Debashish Mishra  
--  24   DevTSM    1.23        7/7/2003 9:08:37 AM  Debashish Mishra Moved the
--       implementation flag around. No schema changes.
--  23   DevTSM    1.22        7/3/2003 10:51:49 AM Debashish Mishra  
--  22   DevTSM    1.21        7/3/2003 10:30:18 AM Debashish Mishra added
--       procedure_def.foxpro_flg
--  21   DevTSM    1.20        7/3/2003 10:26:25 AM Debashish Mishra Added
--       odc_def.foxpro_flg
--  20   DevTSM    1.19        6/18/2003 1:12:49 PM Debashish Mishra just moved
--       schema update markers around.. no real changes
--  19   DevTSM    1.18        6/10/2003 9:22:45 AM Debashish Mishra moved the
--       schema markers around after updating tsm10p@prev
--  18   DevTSM    1.17        6/3/2003 10:38:09 AM Debashish Mishra Added new
--       column client_div_to_lic_app.patch_version 
--  17   DevTSM    1.16        5/30/2003 6:22:04 PM Debashish Mishra New columns to
--       ftuser and client_div table
--  16   DevTSM    1.15        5/30/2003 4:30:39 PM Debashish Mishra  
--  15   DevTSM    1.14        5/29/2003 5:39:17 PM Debashish Mishra  
--  14   DevTSM    1.13        5/28/2003 3:48:19 PM Debashish Mishra  
--  13   DevTSM    1.12        5/21/2003 3:11:23 PM Debashish Mishra  
--  12   DevTSM    1.11        5/14/2003 3:34:03 PM Debashish Mishra  
--  11   DevTSM    1.10        5/13/2003 4:55:02 PM Debashish Mishra unique
--       constraint in trial table
--  10   DevTSM    1.9         5/12/2003 6:03:04 PM Debashish Mishra Fixed a
--       problem by prefixing schema name to country table
--  9    DevTSM    1.8         5/8/2003 3:05:32 PM  Debashish Mishra  
--  8    DevTSM    1.7         5/2/2003 9:54:44 AM  Debashish Mishra  
--  7    DevTSM    1.6         4/24/2003 12:17:52 PMDebashish Mishra Constraint
--       change in trial budget for Joel
--  6    DevTSM    1.5         4/23/2003 4:15:21 PM Debashish Mishra  
--  5    DevTSM    1.4         4/18/2003 8:09:37 PM Debashish Mishra  
--  4    DevTSM    1.3         4/16/2003 11:27:02 AMDebashish Mishra  
--  3    DevTSM    1.2         4/15/2003 4:36:47 PM Debashish Mishra  
--  2    DevTSM    1.1         4/15/2003 11:06:01 AMDebashish Mishra New columns
--       added to client_div
--  1    DevTSM    1.0         4/11/2003 11:19:06 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

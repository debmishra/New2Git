--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: incremental_changes_to_tsm10_since_012502.sql$ 
--
-- $Revision: 171$        $Date: 2/27/2008 3:18:14 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--Following changes are done as per the request of Gary on 01/25/2002 at 13:00


declare

countryid number(10);

begin

 select id into countryid from country where abbreviation = 'EAE';

	declare

	cursor c1 is select id from ip_weight where country_id=countryid;
	countryid2 number(10);

	begin

	for ix1 in c1 loop

	select id into countryid2 from country where abbreviation='POL';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='HUN';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='PHC';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='SCY';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='BUL';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;

	select id into countryid2 from country where abbreviation='FSU';
	Insert into ip_weight select ip_weight_seq.nextval,countryid2,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from ip_weight where id=ix1.id;
	
        end loop;
	end;

end;
/

commit;

-- Following changes ae done as per the request from Kelly on 01/25/2002 at 14:45

conn ft15/welcome@devl

Alter table client modify (de_acronym varchar2(4));

Alter table client add (active_flg number(1) default 0 not null);

Alter table client add constraint client_active_flg_check check 
	(active_flg in (0,1));

conn tsm10/welcome@devl
Alter table client_div add (active_flg number(1) default 0 not null);

Alter table client_div add constraint client_div_active_flg_check check 
	(active_flg in (0,1));



--Alter table client_div modify (client_id null);

Alter table client_div drop constraint client_div_fk1;

Update client_div a set a.name = (select b.name from client b 
where b.de_acronym=a.client_div_identifier and b.id <> 0) 
where a.id <> 0;

commit;

-- then did manual adjustments for active flag and contact_names in client_div
 

drop table old_client2clientdiv_map;
create table old_client2clientdiv_map as select
client_id, id client_div_id from client_div;

create index indx1 on old_client2clientdiv_map(client_id);


Alter table payments add(client_div_id number(10));


update payments a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table payments modify(client_div_id not null);


Alter table payments drop column client_id;

Alter table payments add constraint payments_fk2
	foreign key (client_div_id) references client_div(id);


Alter table study_level_service_inst add(client_div_id number(10));


update study_level_service_inst a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table study_level_service_inst drop column client_id;

Alter table study_level_service_inst add constraint study_level_service_inst_fk1
	foreign key (client_div_id) references client_div(id);

Alter table study_level_service_inst modify(client_div_id not null);


Alter table Investig add(client_div_id number(10));


update Investig a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table Investig modify(client_div_id not null);


Alter table Investig drop column client_id;

Alter table Investig add constraint Investig_fk2
	foreign key (client_div_id) references client_div(id);


Alter table protocol add(client_div_id number(10));


update protocol a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table protocol modify(client_div_id not null);


Alter table protocol drop column client_id;

Alter table protocol add constraint protocol_fk2
	foreign key (client_div_id) references client_div(id);


Alter table procedure_to_protocol add(client_div_id number(10));


update procedure_to_protocol a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table procedure_to_protocol modify(client_div_id not null);


Alter table procedure_to_protocol drop column client_id;

Alter table procedure_to_protocol add constraint procedure_to_protocol_fk1
	foreign key (client_div_id) references client_div(id);

Alter table temp_procedure add(client_div_id number(10));


update temp_procedure a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table temp_procedure modify(client_div_id not null);


Alter table temp_procedure drop column client_id;

Alter table temp_procedure add constraint temp_procedure_fk3
	foreign key (client_div_id) references client_div(id);



Alter table temp_odc add(client_div_id number(10));


update temp_odc a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table temp_odc modify(client_div_id not null);


Alter table temp_odc drop column client_id;

Alter table temp_odc add constraint temp_odc_fk3
	foreign key (client_div_id) references client_div(id);


Alter table temp_overhead add(client_div_id number(10));


update temp_overhead a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table temp_overhead modify(client_div_id not null);


Alter table temp_overhead drop column client_id;

Alter table temp_overhead add constraint temp_overhead_fk3
	foreign key (client_div_id) references client_div(id);


Alter table temp_inst_to_company add(client_div_id number(10));


update temp_inst_to_company a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table temp_inst_to_company modify(client_div_id not null);


Alter table temp_inst_to_company drop column client_id;

Alter table temp_inst_to_company add constraint temp_inst_to_company_fk2
	foreign key (client_div_id) references client_div(id);


Alter table temp_ip_study_price add(client_div_id number(10));


update temp_ip_study_price a set a.client_div_id = (
select b.client_div_id from old_client2clientdiv_map b
where b.client_id = a.client_id) where a.client_id is not null;

commit;

Alter table temp_ip_study_price modify(client_div_id not null);


Alter table temp_ip_study_price drop column client_id;

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk3
	foreign key (client_div_id) references client_div(id);

drop index indx1;

update client_div set client_id = null;

commit;

Alter table client_div add constraint client_div_fk1
	foreign key (client_id) references 
	client(id);



-- changes for clientdiv_to_bld_clientdiv for kelly

Create table clientdiv_to_bld_clientdiv(
	id number(10),
	client_div_id number(10) not null,
	bld_client_div_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table clientdiv_to_bld_clientdiv add constraint clientdiv_to_bld_clientdiv_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

create sequence clientdiv_to_bld_clientdiv_seq;

Alter table clientdiv_to_bld_clientdiv add constraint clientdiv_to_bld_clientdiv_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table clientdiv_to_bld_clientdiv add constraint clientdiv_to_bld_clientdiv_fk2
	foreign key (bld_client_div_id) references 
	client_div(id);

-- FOLLOWING CHANGES WERE MADE BECAUSE DATA LOAD PROBLEMS

CONN FT15/WELCOME@DEVL

ALTER TABLE CLIENT MODIFY(DE_ACRONYM VARCHAR2(4));

CONN TSM10/WELCOME@DEVL


-- following changes are done as per the request from Phil on 01/31/2002 at 14:00

Update country set is_viewable = 1 where name = 'Yugoslavia, Slovenia, Croatia';

commit;


-- following changes are done as per the request of Peter on 01/31/2002 at 18:05 hrs

Alter table trial_budget drop constraint TB_AFFILIATION_CHECK;

Alter table trial_budget add constraint TB_AFFILIATION_CHECK check(
Affiliation in ('Affiliated','Unaffiliated','Both','Hospital','ClinResearchCenter','PhysClinic','AllSites'));

Alter table ip_session drop constraint ip_session_check;

Alter table ip_session add constraint ip_session_affiliation_check check(
Affiliation in ('Affiliated','Unaffiliated','Both','Hospital','ClinResearchCenter','PhysClinic','AllSites'));

-- Following changes are done as per the request of Peter on 02/04/2002 at 9:25 hrs

Alter table procedure_def drop constraint PROC_DEF_PROC_LEVEL_CHECK;

Alter table procedure_def add constraint PROC_DEF_PROC_LEVEL_CHECK
check( procedure_level in
('Hour','Visit','Patient','Site','Study','PatientOrVisit','PatientOrSite','Other'));

Alter table odc_def drop constraint ODC_DEF_PROC_LEVEL_CHECK;

Alter table odc_def add constraint ODC_DEF_PROC_LEVEL_CHECK
check( procedure_level in
('Hour','Visit','Patient','Site','Study','PatientOrVisit','PatientOrSite','Other'));

-- reimported data for procmstr


declare

procdef_maxid number(10);
odcdef_maxid number(10);
mapper_maxid number(10);

cursor c1 is select id from procedure_def where procedure_level = 'PatientOrVisit';
cursor c2 is select id from procedure_def where procedure_level = 'PatientOrSite';
cursor c3 is select id from odc_def where procedure_level = 'PatientOrVisit';
cursor c4 is select id from odc_def where procedure_level = 'PatientOrSite';


begin

select max(id)+1 into procdef_maxid from procedure_def;
select max(id)+1 into odcdef_maxid from odc_def;
select max(id)+1 into mapper_maxid from mapper;

for ix1 in c1 loop

  Insert into procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Patient' from procedure_def
  where id = ix1.id;

  Insert into mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Visit' from procedure_def
  where id = ix1.id;

  Insert into mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;
 

 end loop;

for ix2 in c2 loop

  Insert into procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Patient' from procedure_def
  where id = ix2.id;

  Insert into mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into procedure_def select procdef_maxid,cpt_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, ADDED_IN_BUILD_ID, 'Site' from procedure_def
  where id = ix2.id;

  Insert into mapper values (mapper_maxid,null,procdef_maxid);

  procdef_maxid:=procdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

end loop;

for ix3 in c3 loop

  Insert into odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Patient', ADDED_IN_BUILD_ID from odc_def
  where id = ix3.id;

  Insert into mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Visit', ADDED_IN_BUILD_ID from odc_def
  where id = ix3.id;

  Insert into mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

end loop;

for ix4 in c4 loop

  Insert into odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Patient', ADDED_IN_BUILD_ID from odc_def
  where id = ix4.id;

  Insert into mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

  Insert into odc_def select odcdef_maxid,picas_code,LONG_DESC,
  OBSOLETE_FLG, OBSOLETE_DATE, 'Site', ADDED_IN_BUILD_ID from odc_def
  where id = ix4.id;

  Insert into mapper values (mapper_maxid,odcdef_maxid,null);

  odcdef_maxid:=odcdef_maxid+1;
  mapper_maxid:=mapper_maxid+1;

end loop;

commit;

end;
/

--following changes are as per the request of Allen on 02/04/2002 at 15:00

conn ft15/welcome@devl

Alter table trial add(budget_type varchar2(40));

Alter table trial add constraint trial_budget_type_check check(
	budget_type in ('Industry Cost','Per Patient Budget','Per Visit Budget'));

conn tsm10/welcome@devl


-- Following changes are as per the request of Colin on 02/04/2002 at 16:15 

Insert into phase values (0,'All',null);
insert into indmap (id,short_desc,type) values (0,'All','Therapeutic Area');

commit;


-- client side change-->

Alter table pap_overhead drop constraint po_affiliation_check;

Alter table pap_overhead add constraint po_affiliation_check 
	check (affiliation in ('Affiliated','Unaffiliated','Both','AllSites'));

-- Following changes are done as per the request of Kelly on 02/06/2002 at 11 am



Create table build_code(
	id number(10),	
	code varchar2(4),	
	name varchar2(128))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table build_code add constraint build_code_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

create sequence build_code_seq;


--Alter table client_div drop column active_flg;

--Alter table client drop column active_flg;


drop table clientdiv_to_bld_clientdiv;

Create table client_div_to_build_code(
	id number(10),
	client_div_id number(10) not null,
	build_code_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table client_div_to_build_code add constraint clientdiv_to_build_code_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

create sequence client_div_to_build_code_seq;

Alter table client_div_to_build_code add constraint client_div_to_build_code_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table client_div_to_build_code add constraint client_div_to_build_code_fk2
	foreign key (build_code_id) references 
	build_code(id);

-- Import complst into build_code


drop table old_clientdiv2bldcode_map;
create table old_clientdiv2bldcode_map as select
a.id client_div_id, b.id build_code_id from 
client_div a, build_code b where a.client_div_identifier = b.code;

drop index indx1;

create index indx1 on old_clientdiv2bldcode_map(client_div_id);


Alter table payments add(build_code_id number(10));


update payments a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id);

commit;

Alter table payments modify(build_code_id not null);


Alter table payments drop column client_div_id;

Alter table payments add constraint payments_fk2
	foreign key (build_code_id) references build_code(id);


Alter table study_level_service_inst add(build_code_id number(10));


update study_level_service_inst a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table study_level_service_inst drop column client_div_id;

Alter table study_level_service_inst add constraint study_level_service_inst_fk1
	foreign key (build_code_id) references build_code(id);

Alter table study_level_service_inst modify(build_code_id not null);


Alter table Investig add(build_code_id number(10));


update Investig a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table Investig modify(build_code_id not null);


Alter table Investig drop column client_div_id;

Alter table Investig add constraint Investig_fk2
	foreign key (build_code_id) references build_code(id);


Alter table protocol add(build_code_id number(10));


update protocol a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table protocol modify(build_code_id not null);


Alter table protocol drop column client_div_id;

Alter table protocol add constraint protocol_fk2
	foreign key (build_code_id) references build_code(id);


Alter table procedure_to_protocol add(build_code_id number(10));


update procedure_to_protocol a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table procedure_to_protocol modify(build_code_id not null);


Alter table procedure_to_protocol drop column client_div_id;

Alter table procedure_to_protocol add constraint procedure_to_protocol_fk1
	foreign key (build_code_id) references build_code(id);

Alter table temp_procedure add(build_code_id number(10));


update temp_procedure a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table temp_procedure modify(build_code_id not null);


Alter table temp_procedure drop column client_div_id;

Alter table temp_procedure add constraint temp_procedure_fk3
	foreign key (build_code_id) references build_code(id);



Alter table temp_odc add(build_code_id number(10));


update temp_odc a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table temp_odc modify(build_code_id not null);


Alter table temp_odc drop column client_div_id;

Alter table temp_odc add constraint temp_odc_fk3
	foreign key (build_code_id) references build_code(id);


Alter table temp_overhead add(build_code_id number(10));


update temp_overhead a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table temp_overhead modify(build_code_id not null);


Alter table temp_overhead drop column client_div_id;

Alter table temp_overhead add constraint temp_overhead_fk3
	foreign key (build_code_id) references build_code(id);


Alter table temp_inst_to_company add(build_code_id number(10));


update temp_inst_to_company a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table temp_inst_to_company modify(build_code_id not null);


Alter table temp_inst_to_company drop column client_div_id;

Alter table temp_inst_to_company add constraint temp_inst_to_company_fk2
	foreign key (build_code_id) references build_code(id);


Alter table temp_ip_study_price add(build_code_id number(10));


update temp_ip_study_price a set a.build_code_id = (
select b.build_code_id from old_clientdiv2bldcode_map b
where b.client_div_id = a.client_div_id) where a.client_div_id is not null;

commit;

Alter table temp_ip_study_price modify(build_code_id not null);


Alter table temp_ip_study_price drop column client_div_id;

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk3
	foreign key (build_code_id) references build_code(id);

drop index indx1;

commit;

-- Manual update of client_div_table for active_flg as indicated by Kelly


delete from client_div where active_flg = 0 and
id <> 0;

Alter table client_div add(country_id number(10));


-- Manual addition of rows

-- Following changes are as per the request of Peter on 02/11/02 at 10 am


delete from price_level where odc_def_id in (select
id from odc_def where picas_code in(
'*CARD','*ENCR','*GYNE','*NURS','*OPHT','*PSYC',
'*RADI','V1138','V1139','V1140','V1143'));

commit;

-- Following changes are as per the request of kelly on 02/11/02 at 15:00

Alter table temp_overhead add(adj18mo_flg number(1) default 0 not null);


Alter table temp_overhead add constraint 
	temp_ovrhd_adj18mo_flg_check
	check (adj18mo_flg in (0,1));


Alter table client_div drop column ACTIVE_FLG;

Alter table client drop column ACTIVE_FLG;


-- Following changes are as per the request from Kelly on 02/15/02 at 14:15

Alter table temp_procedure add (primary_flg number(1) default 0 not null);

Alter table temp_procedure add constraint tp_primary_flg_check check(primary_flg in (0,1));

-- Following changes are as per the request from Kelly on 02/18/02 at 9:00

Alter table temp_overhead add(primary_flg number(1) default 0 not null);

Alter table temp_overhead add constraint to_primary_flg_check
check( primary_flg in(0,1));


-- Following changes are as per the request from Kelly on 02/18/02 at 9:45


Alter table temp_overhead add(
	ta_indmap_id number(10),
	indgroup_indmap_id number(10));

Alter table temp_overhead add constraint temp_overhead_fk7
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_overhead add constraint temp_overhead_fk8
	foreign key (indgroup_indmap_id) references 
	indmap(id);
	
Alter table temp_procedure add(
	ta_indmap_id number(10),
	indgroup_indmap_id number(10));

Alter table temp_procedure add constraint temp_procedure_fk8
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_procedure add constraint temp_procedure_fk9
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp_odc add(
	ta_indmap_id number(10),
	indgroup_indmap_id number(10));

Alter table temp_odc add constraint temp_odc_fk9
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_odc add constraint temp_odc_fk10
	foreign key (indgroup_indmap_id) references 
	indmap(id);


Alter table temp_ip_study_price add(
	ta_indmap_id number(10),
	indgroup_indmap_id number(10));

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk5
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk6
	foreign key (indgroup_indmap_id) references 
	indmap(id);

create or replace view indmap_de_view
as select a.code Ther_area, b.code ind_group, c.code indication, 
decode(c.short_desc,null,b.short_desc,c.short_desc) short_desc from
(select id,code,short_desc from indmap where type='Therapeutic Area') a, 
(select id,parent_indmap_id,code,short_desc from indmap where type='Indication Group') b, 
(select id,parent_indmap_id,code,short_desc from indmap where type='Indication') c where
c.parent_indmap_id(+) = b.id and
b.parent_indmap_id = a.id order by a.code,b.code,c.code;



-- Following changes are as per the request from Kelly on 02/18/2002 at 15:45

Alter table trial_budget drop column build_tag_to_client_div_id ;

Alter table trial_budget add(build_tag_id number(10));

Alter table trial_budget add constraint trial_budget_fk8
	foreign key (build_tag_id) references 
	build_tag(id);

Alter table client_div add(build_tag_id number(10));

Alter table client_div add constraint client_div_fk6
	foreign key (build_tag_id) references 
	build_tag(id);

Alter table build_tag_to_client_div add(
	released number(1) default 0 not null,
	released_date date,	
	released_ftuser_id number(10));

Alter table build_tag_to_client_div add constraint build_tag_to_client_div_fk3
	foreign key (released_ftuser_id) references 
	ftuser(id);

Alter table build_tag_to_client_div add constraint bttcd_released_check 
	check(released in (0,1));


Alter table build_tag_to_client_div add constraint build_tag_to_client_div_uq1
	unique(client_div_id, build_tag_id) using index tablespace
	tsmsmall_indx pctfree 25;


-- Following changes are as per the request of Kelly on 02/19/2002 at 12 noon

update country set is_viewable = 0 where abbreviation in ('SCA','EAE');

commit;

-- Following changes are because of the bug entered by Cindy on 02/19/2002 at 16:25

update currency set cnv_rate = 1.1198 where upper(name) = 'EURO';

commit;

-- Following changes are done by Colin on 02/19/2002 at 16:30

alter table FTGROUP
drop constraint FTGROUP_NAME_CHECK;

 alter table ftgroup add constraint
 FTGROUP_NAME_CHECK  CHECK ( name in ('Fast Track Administrator','Site Administrator',
 'Sponsor Administrator','Site User','CRA','CRA Manager',
 'Site Handheld','CRA Handheld','Client Read Only User',
 'Client User','Client Admin', 'Sysinfo'));

insert into ftgroup values (ftgroup_seq.nextval, 'Sysinfo');

insert into ftuser (id, name, password, first_name, last_name)
values (ftuser_seq.nextval, 'sysinfo','sysinfo','sysinfo','sysinfo');

insert into ftuser_to_ftgroup values (ftuser_to_ftgroup_seq.nextval, 799,12);

-- Following changes are as per the request of Joel on 02/20/02 at 11 am

delete from ftuser_to_ftgroup where id = 829;
delete from ftgroup where id =12;

alter table FTGROUP
drop constraint FTGROUP_NAME_CHECK;

alter table ftgroup add constraint
 FTGROUP_NAME_CHECK  CHECK ( name in ('Fast Track Administrator','Site Administrator',
 'Sponsor Administrator','Site User','CRA','CRA Manager',
 'Site Handheld','CRA Handheld','Client Read Only User',
 'Client User','Client Admin', 'TSM Super Admin','TSM FTAdmin','Sysinfo'));


insert into ftgroup values (12,'TSM Super Admin');
insert into ftgroup values (13,'TSM FTAdmin');
insert into ftgroup values (14,'Sysinfo');
Insert into ftuser_to_ftgroup values (829,799,14);

commit;

-- Following chanmges are done for data related industy build for Nadine on 02/20/02 at 13:30

update client_div set name = 'Fast Track Systems Inc.' where id = 0;
update client_div set CLIENT_DIV_IDENTIFIER= 'FTS' where id = 0;

commit;

-- Following changes are as per the request of Joel on 02/21/2002 at 14:44 

Alter table client_div modify (DEF_BUDGET_TYPE varchar2(40));

Alter table client_div drop constraint CD_DEF_BUDGET_TYPE_CHECK;

update client_div set DEF_BUDGET_TYPE = 'Industry Cost' where
def_budget_type = 'Industry';

Alter table client_div add constraint CD_DEF_BUDGET_TYPE_CHECK
check (DEF_BUDGET_TYPE in
('Industry Cost','Per Patient Budget','Per Visit Budget'));

-- Following changes are as per the request of Cindy/Gary on 02/21/2002

Alter table ip_weight drop constraint IW_AFFILIATION_CHECK;

update ip_weight set affiliation = 'AllSites' where 
	affiliation = 'Both';
commit;

Alter table ip_weight add constraint IW_AFFILIATION_CHECK check(
	affiliation in ('Affiliated','Unaffiliated','AllSites'));

-- Following changes are as per the request of Phil on 02/22/2002 at 16:47

Alter table trial_budget drop constraint tb_overhead_type_check;

Alter table trial_budget add constraint tb_overhead_type_check 
	check (overhead_type in ('Clientdef','PicasOfficalDef','PicasAdjustedDef','Manual'));

-- Following changes are done as per Debashish for report#1 on 02/26/2002 at 15:21

update indmap set code = 'All' where id=0 and code is null;

commit;

-- Following changes are done as per the request of Kelly on 02/27/2002 at 10:30

Alter table client_div add(use_own_cnv_flg number(1) default 0 not null);

Alter table client_div add constraint cd_use_own_cnv_flg_check
check(use_own_cnv_flg in (0,1));

Alter table client_currency_cnv drop column from_currency_id;

Alter table temp_procedure add(active_flg number(1) default 0 not null);

Alter table temp_overhead add(active_flg number(1) default 0 not null);

alter table temp_procedure add constraint tp_active_flg_check
check(active_flg in (0,1));

alter table temp_overhead add constraint to_active_flg_check
check(active_flg in (0,1));

-- Following changes are made as per the DE data meeting on 02/27/2002 at 12:41pm

Alter table investig drop column picas_instit;

Alter table price_level drop column long_desc;

Alter table project add(client_id number(10));
update project set client_id=0;
commit;
alter table project modify (client_id not null);

alter table project add constraint project_fk1 
foreign key (client_id) references client(id);

drop table client_country_list_item;

drop table client_country_list;


-- Following changes are as per the request of Colin on 02/28/2002 at 11:58

Alter table trial_budget add(
	avg_cpp_low number(10),
	avg_cpp_med number(10),
	avg_cpp_high number(10),
	avg_cpp_company number(10),
	avg_cpp_selected number(10),
	total_cost number(10),
	adjusted_overhead_pct number(3),
	odc_pct_range varchar2(20),
	official_overhead_pct_range varchar2(20),
	adjusted_overhead_pct_range varchar2(20),
	total_cost_local number(10),
	avg_cpp_selected_local number(10));

Alter table trial_budget add constraint tb_odc_pct_range_check
	check(odc_pct_range in ('Low','Med','High','Co_Med','Custom'));

Alter table trial_budget add constraint tb_off_ovhd_pct_range_check
	check(official_overhead_pct_range in ('Low','Med','High','Co_Med','Custom'));

Alter table trial_budget add constraint tb_adj_ovhd_pct_range_check
	check(adjusted_overhead_pct_range in ('Low','Med','High','Co_Med','Custom'));

Alter table cost_item add(screening_quantity number(10));

CREATE TABLE PICAS_VISIT_SET(
	ID NUMBER(10,0) NOT NULL,
	CLIENT_DIV_ID NUMBER(10,0) NOT NULL,
	CREATOR_ID NUMBER(10,0) NOT NULL,
	CREATE_DT DATE NOT NULL,
	NAME VARCHAR2(80))
	tablespace tsmsmall
	pctused 60 pctfree 25;

Alter table picas_visit_set add constraint picas_visit_set_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table picas_visit_set add constraint picas_visit_set_fk1
	foreign key (client_div_id) references client_div(id);

Alter table picas_visit_set add constraint picas_visit_set_fk2
	foreign key (creator_id) references ft15.ftuser(id);

CREATE TABLE PICAS_VISIT_SET_ITEM(
	ID NUMBER(10) NOT NULL,
	PICAS_VISIT_SET_ID NUMBER(10) NOT NULL,
        VISIT_ORDER NUMBER(4) NOT NULL,
	NAME VARCHAR2(256) NOT NULL,
	OFFSET_FROM_INDUCTION NUMBER(5),
	OFFSET_UNITS VARCHAR2(1) NOT NULL,
	VISIT_TYPE VARCHAR2(40) NOT NULL,
	NUM_PATIENTS NUMBER(6),
	TRIAL_PHASE VARCHAR2(40) NOT NULL)
	tablespace tsmsmall
	pctused 60 pctfree 25;

Alter table picas_visit_set_item add constraint picas_visit_set_item_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table picas_visit_set_item add constraint picas_visit_set_item_fk1
	foreign key (picas_visit_set_id) references picas_visit_set(id);

Alter table picas_visit_set_item add constraint PVS_OFFSET_UNITS_CHECK  
	CHECK (offset_units in ('y','M','w','d','h','m'));

Alter table picas_visit_set_item add constraint PVS_TRIAL_PHASE_CHECK
	CHECK (trial_phase in ('Screening','Treatment','Follow Up','Other'));

Alter table picas_visit_set_item add constraint PVS_VISIT_TYPE_CHECK
	CHECK (visit_type in ('PayPoint','ClinicalEvent','ClinicalEventCycle','Default'));

create sequence picas_visit_set_seq;
create sequence picas_visit_set_item_seq;

-- Following changes were done as per the request of Allen on 02/28/2002 at 13:50

Alter table picas_visit modify(trial_budget_id null);

-- Following changes are done as per the request of Joel on 02/28/2002 at 14:00

Alter table client_div add(
	def_price_range varchar2(20) default 'Med' not null,
	logon_timeout_secs number(5) default 0 not null);

Alter table client_div add constraint cd_def_price_range_check
	check(def_price_range in ('Low','Med','High','Co_Med','Custom'));

-- Following columns has been added for Kelly to debug

Alter table investig add (no_pay number(8), no_proc number(8));

-- Following changes are as per the request of Kelly on 03/05/2002 at 12:30

update investig set grant_adjustment = 0 where
grant_adjustment is null or grant_adjustment = -1;

create index procedure_protocol_indx1 on procedure_to_protocol (protocol_id,build_code_id)
	tablespace tsmlarge_indx pctfree 20;
-- Following changes are as per the request of Nancy on 03/05/2002 at 12:35

Alter table trial_budget add(is_published number(1) default 0 not null);

Alter table trial_budget add constraint tb_is_published_check 
check(is_published in (0,1));

-- Following changes are done as per the request of Allen on 03/05/2002 at 13:49

Alter table project drop constraint project_fk2;

 -- Following change was as per Colin on 03/06/2002 at 15:06

Alter table cost_item modify(price_range default 'Med' not null);

-- Following changes are as per the mail of Peter on 03/06/2002 at 16:00

Alter table odc_def add(hide number(1) default 0 not null);

Alter table odc_def add constraint odc_def_hide_check check(hide in(0,1));

update odc_def set hide = 1 where picas_code in 
('*CARD','*ENCR','*GYNE','*NURS','*OPHT','*PSYC','V1138','V1139','V1140','V1143');

commit;

update investig set GRANT_TOTAL = 0 where GRANT_TOTAL is null;
commit;
update investig set failure_fee= 0 where failure_fee is null;
commit;
update investig set LAB_COST=0 where lab_COST is null;
commit;
update investig set irb_fee=0 where irb_fee is null;
commit;
update investig set fixed_fee=0 where fixed_fee is null;
commit;

update investig set grant_adjustment = 0 where
grant_adjustment is null or grant_adjustment = -1;

commit;


update investig set GRANT_TOTAL = 0 where GRANT_TOTAL <1;
commit;
update investig set failure_fee= 0 where failure_fee <1;
commit;
update investig set LAB_COST=0 where lab_COST <1;
commit;
update investig set irb_fee=0 where irb_fee <1;
commit;
update investig set fixed_fee=0 where fixed_fee <1;
commit;

-- Implemented in utest upto this point on 03/08/2002


-- Following changes are as per Nancy on 03/07/2002 at 17:00

conn ft15/welcome@devl

Alter table ftuser add(display_name varchar2(128));

conn tsm10/welcome@devl

Alter table def_publish_groups drop column CLIENT_GROUP_ID;

Alter table def_publish_groups drop column FTUSER_ID;

Alter table def_publish_groups add(
 PUBLISHING_CLIENT_GROUP_ID number(10) not null,
 PUBLISH_TO_CLIENT_GROUP_ID number(10) not null,
 RW_FLG number(1) default 0 not null);
 
Alter table def_publish_groups add constraint def_publish_groups_fk1
 foreign key (PUBLISHING_CLIENT_GROUP_ID) references client_group(id);

Alter table def_publish_groups add constraint dpg_rw_flg_check 
 check(rw_flg in (0,1));

Create or replace trigger def_publish_groups_trg1
after insert or update of PUBLISH_TO_CLIENT_GROUP_ID on def_publish_groups
referencing new as n old as o
for each row
declare
clntgrp_cnt number(10);
invalid_clntgrp exception;

begin

  Select count(*) into clntgrp_cnt from client_group where 
	id = :n.PUBLISH_TO_CLIENT_GROUP_ID;

  If clntgrp_cnt = 0 then
	raise invalid_clntgrp;
  end if;

exception

   when invalid_clntgrp then
	Raise_application_error(-20105,'PUBLISH_TO_CLIENT_GROUP_ID not in CLIENT_GROUP');
end;
/
sho err

-- (Code changes checked in)

-- Following changes are for Kelly on 03/11/2002 at 17:00
-- Only implemented in build (yet to be implemented in devl)

truncate table investig;
truncate table payments;

Alter table investig drop column investigator_id;

Alter table investig add (
	INCOMPLETE number(1),
	sampled number(1),
	managed number(1));

Alter table investig add constraint investig_incomplete_check
	check (incomplete in (0,1));

Alter table investig add constraint investig_sampled_check
	check (sampled in (0,1));

Alter table investig add constraint investig_managed_check
	check (managed in (0,1));

Alter table payments add(investig_id number(10) not null);

Alter table payments add constraint payments_fk1
	foreign key (investig_id) references 
	investig(id);

--create index payments_temp_indx1 on 
--	payments(investigator_code,protocol_id,build_code_id)
--	tablespace tsmlarge nologging;

--create index investig_temp_indx1 on 
--	investig(investigator_code,protocol_id,build_code_id)
--	tablespace tsmlarge nologging;

--update payments a set a.investig_id = (select b.id from investig b 
--	where b.investigator_code = a.investigator_code and
--	      b.protocol_id = a.protocol_id and
--	      b.build_code_id = a.build_code_id);

drop index payments_temp_indx1;
drop index investig_temp_indx1;


Alter table payments drop column investigator_id;
Alter table payments drop column investigator_code;
Alter table payments drop column protocol_id;
Alter table payments drop column build_code_id;
 
Insert into tsm10.investig select * from tsm_stage.investig;

commit;

Insert into tsm10.payments select * from tsm_stage.payments;

commit;

-- Following changes are for bug#f8P9HA00012V
-- implemented in devl and test2 on 03/12/2002 at 10:55

Alter table trial_budget drop constraint tb_overhead_type_check;

update trial_budget set overhead_type = 'PicasOfficialDef' where
overhead_type = 'PicasOfficalDef';
commit;


Alter table trial_budget add constraint tb_overhead_type_check 
	check (overhead_type in ('Clientdef','PicasOfficialDef','PicasAdjustedDef','Manual'));


-- Following changes are for bug#f8P9HA00014I
-- implemented in devl and test2 on 03/12/2002 at 10:55

Alter table pap_euro_overhead modify (ADJUSTED_FLG null);
update pap_euro_overhead set ADJUSTED_FLG = null where adjusted_flg = 0;
update pap_euro_overhead set ADJUSTED_FLG = 0 where adjusted_flg =1;
update pap_euro_overhead set ADJUSTED_FLG = 1 where adjusted_flg is null;
Alter table pap_euro_overhead modify (ADJUSTED_FLG not null);

-- Following changes are for NAncy for ECR001
-- implemented in utest only on 03/12/2002 at 11:10


Alter table project_area add (tsm_default number(1) default 0 not null);

Alter table project_area add constraint pa_tsm_default_check check(tsm_default in (0,1));

update project_area set tsm_default = 1 where id = 0  ;

commit;

/*
Create or replace trigger project_area_trg1
after insert or delete or update of tsm_default,client_div_id on project_area
referencing new as n old as o
for each row
declare
clntdiv_cnt number(10);
invalid_max_rows exception;
invalid_min_rows exception;

begin


 If inserting or updating then

   If :n.tsm_default = 1 then

     Select count(*) into clntdiv_cnt from project_area where client_div_id=:n.client_div_id;
   
     If clntdiv_cnt > 1 then
	raise invalid_max_rows;
     end if;
   end if;
 end if;

 If deleting and :o.tsm_default = 1 then

     Select count(*) into clntdiv_cnt from project_area where client_div_id=:o.client_div_id;
   
     If clntdiv_cnt < 1 then
	raise invalid_min_rows;
     end if;
    
 end if;

exception

   when invalid_max_rows then
	Raise_application_error(-20106,'Can have maximum one row per client_div if tsm_default is true');
   when invalid_min_rows then
	Raise_application_error(-20106,'Can''t delete. At least one row per client_div if tsm_default is true');
end;
/
sho err
*/

-- Following chnages are for Gary (as per Suzanne Wampler) on 03/12/2002 at 11:11
-- implemented only in devl

update ip_business_factors set short_desc = '41-44 weeks' where id=117;
update ip_business_factors set short_desc = '53-58 weeks' where id=119;
commit;


-- As per Gary on 03/14/2002 at 12:45


update ip_business_factors set(low,med,high) =
(select .026373,.046042,.065712 from dual) where type='Dosing';

update ip_business_factors set(low,med,high) =
(select .016043,.019149,.022254 from dual) where type='Country';

update ip_business_factors set(low,med,high) =
(select .017566,.020437,.023308 from dual) where type='Study';

update ip_business_factors set(low,med,high) =
(select .003696,.007527,.011359 from dual) where type='Populate';

update ip_business_factors set(low,med,high) =
(select .028426,.03379,.039155 from dual) where type='Ph1dur';

update ip_business_factors set(low,med,high) =
(select .073457,.078195,.082932 from dual) where type='Confine';

commit;

update price_level a set (a.low_price, a.med_price, a.high_price) =
(select a.low_price/b.cnv_rate_to_euro,
a.med_price/b.cnv_rate_to_euro,
a.high_price/b.cnv_rate_to_euro from 
local_to_euro b where b.country_id = a.country_id)
where a.country_id in (select country_id from local_to_euro);

commit;

-- Following changes are as per the request of Nancy on 03/14/2002 at 16:25

conn ft15/welcome
grant select on ftuser_seq to tsm10;

conn tsm10/welcome
create synonym ftuser_seq for ft15.ftuser_seq;




-- Implemented in utest upto this point on 03/14/2002

 
-- Following changes are for Allen for ECR001


Alter table project drop column project_area_id;

grant select,references on client_div to ft15;
grant select,references on project_area to ft15;

conn ft15/welcome

Alter table trial add (client_div_id number(10), project_area_id number(10));

Alter table trial add constraint trial_fk13 foreign key(client_div_id)
	references tsm10.client_div(id);

Alter table trial add constraint trial_fk14 foreign key(project_area_id)
	references tsm10.project_area(id);

conn tsm10/welcome

Alter table ip_session add(client_id number(10), 
	client_div_id number(10), project_area_id number(10));

Alter table ip_session add constraint ip_session_fk14 foreign key(client_id)
	references client(id);

Alter table ip_session add constraint ip_session_fk15 foreign key(client_div_id)
	references client_div(id);

Alter table ip_session add constraint ip_session_fk16 foreign key(project_area_id)
	references project_area(id);



update trial a set a.PROJECT_AREA_ID = (select b.PROJECT_AREA_ID
from project b where b.id = a.project_id) where
a.ft_type = 'TSM';

update trial a set a.CLIENT_DIV_ID = (select c.CLIENT_DIV_ID 
from project b, project_area c where b.id = a.project_id and
b.PROJECT_AREA_ID=c.id) where a.ft_type = 'TSM';

commit;



-- Implemented in utest upto this point on 03/15/2002


-- Following changes are for nancy on 03/14/2002 at 17:07

conn ft15/welcome 

grant select on ftuser_to_ftgroup_seq to tsm10;
 
conn tsm10/welcome 
 
create synonym ftuser_to_ftgroup_seq for ft15.ftuser_to_ftgroup_seq;

-- Following changes are as per Peter on 03/18/2002 at 8:30 

Create tablespace trialblob datafile '/u02/oracle/oradata/utest/trialblob01.dbf' size 100M reuse 
autoextend on next 100m maxsize 800M
extent management local uniform size 256k;

/* change the NOCACHE to cache reads*/

CREATE TABLE working_trial (
	id NUMBER(10),
	trial_id number(10),
	ftuser_id number(10),
        working_trial blob)
        tablespace tsmsmall 
        pctused 80 pctfree 10  
        lob (working_trial) STORE AS working_trial_blob (
	TABLESPACE trialblob 
	disable storage in row
	CHUNK 16k 
        PCTVERSION 20 
        NOCACHE LOGGING); 

Create sequence working_trial_seq;

Alter table working_trial add constraint working_trial_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 10;

Alter table working_trial add constraint working_trial_fk1
	foreign key (trial_id) references trial(id);

Alter table working_trial add constraint working_trial_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table working_trial add constraint working_trial_uq1
	unique (trial_id, ftuser_id) using index tablespace
	tsmsmall_indx pctfree 20;


-- Following changes are as per the request of kelly on 03/19/2002 at 9 am

Alter table temp_overhead add(investig_id number(10));
Alter table temp_ip_study_price add(investig_id number(10));
Alter table temp_procedure add(payments_id number(10));
Alter table temp_odc  add(payments_id number(10));
Alter table temp_inst_to_company   add(payments_id number(10));

-- Following changes are as per the request of Nancy on 03/19/2002 at 12:30

--Alter table ftuser drop column active_tsm_user;
Alter table ftuser add(active_trace_user number(1) default 0 not null);
Alter table ftuser add constraint ftuser_active_trace_user_check
check (active_trace_user in (0,1));

-- Following changes are as per the request of Kelly on 03/19/2002 at 14:45

create index Indmap_index1 on indmap(parent_indmap_id)
tablespace tsmsmall_indx pctfree 20;

-- Following changes are as per the request of Kelly on 03/20/2002 at 8:10
-- only done inb build

Alter table temp_inst_to_company drop column payments_id;
Alter table temp_inst_to_company add(phase_id number(10), 
	ta_indmap_id number(10), country_id number(10));

Alter table temp_inst_to_company add constraint temp_inst_to_company_fk3
	foreign key (phase_id) references phase(id);
Alter table temp_inst_to_company add constraint temp_inst_to_company_fk4
	foreign key (ta_indmap_id) references indmap(id);
Alter table temp_inst_to_company add constraint temp_inst_to_company_fk5
	foreign key (country_id) references country(id);

-- Following chnages are after finding decimals in foxxpro data

Alter table procedure_to_protocol modify(TIMES_PERFORMED number(7,2),
	INVESTIGATOR_TIMES_PERF number(7,2));

-- Following changes are for kelly on 03/20/2002 at 10:16

--update tsm10.odc_def.hide in utest (with devl)

conn tsm10@utest

create database link devllink connect to tsm10 identified by 
welcome using 'devl';

Update odc_def a set a.hide = (select b.hide from
odc_def@devllink b where b.picas_code=a.picas_code and
b.PROCEDURE_LEVEL = a.procedure_level);

commit;
drop database link devllink;

-- Following procedure was created for Kelly on 03/20/2002 at 12:30

create or replace procedure releaseClientBld(BuildTagId in number, 
    ClientDivId in number) as


cnt1 number(10);


begin

  update build_tag_to_client_div set (released, released_date) =
  (select 1,sysdate from dual) where client_div_id=ClientDivId 
   and build_tag_id=BuildTagId;

  update client_div set build_tag_id=BuildTagId where 
  id=ClientDivId;

  select count(*) into cnt1 from build_tag_to_client_div 
  where released=1 and client_div_id=ClientDivId;

  If cnt1 > 2 then
     delete build_tag_to_client_div where client_div_id=ClientDivId 
     and released=1 and build_tag_id = (select min(build_tag_id) from 
     build_tag_to_client_div where client_div_id=ClientDivId and 
     released=1);
  End if;

 commit;
end;
/
sho err

-- Following changes are as per the request of Joel on 03/20/2002 at 14:32
-- why: We need these changes to support audit logs at the trial level along with the budget level.



Alter table budget_audit_hist add(trial_id number(10));

Update budget_audit_hist set trial_id = 225;

Alter table budget_audit_hist modify(trial_id not null,trial_budget_id null);

Alter table budget_audit_hist add constraint budget_audit_hist_fk3
	foreign key (trial_id) references trial(id);

-- Following changes are as per the request of Kelly on 03/20/2002 at 16:36

Alter table temp_ip_study_price add(active_flg number(1) default 0 not null);
Alter table temp_ip_study_price add constraint tisp_active_flg_check
check (active_flg in (0,1));


-- Following changes are as per the request of Peter on 03/20/2002 at 17:12
conn ft15/welcome

Alter table trial drop constraint check_status;

Alter table trial add constraint trial_status_check check(
    trial_status in ('CREATION', 'ACTIVE', 'CLOSED','TSM_PUB'));



-- Implemented in utest upto this point on 03/21/2002


-- Following changes are as per Kelly on 03/22/2002 at 11 am

Alter table temp_ip_study_price add(phase1type_ID number(10));

Alter table temp_ip_study_price add constraint temp_ip_study_price_fk7
	foreign key (phase1type_id) references 
	phase(id);

-- Following chnages are as per Colin on 03/22/2002 at 11 am

CREATE TABLE user_preferences
	(ID NUMBER(10,0),
	ftuser_ID NUMBER(10,0) NOT NULL,
	tree_pane_state varchar(20) default 'Tree' not null,
	sort_type varchar(20) default 'TA' not null,
	ta_filter number(10,0) default -1 not null,
	phase_filter varchar(20) default 'All' not null,
	trial_filter varchar(20) default 'All' not null,
	budget_filter varchar(20) default 'All' not null,
	reset_warning number(1) default 0 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;

Alter table user_preferences add constraint user_preferences_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table user_preferences add CONSTRAINT 
	up_tree_pane_state_CHECK  CHECK 
	(tree_pane_state in ('Tree','Search','Hidden'));

Alter table user_preferences add CONSTRAINT 
	up_sort_type_CHECK  CHECK 
	(sort_type in ('TA','Phase','None'));

Alter table user_preferences add CONSTRAINT 
	up_phase_filter_CHECK  CHECK 
	(phase_filter in ('All','Phase1','Phase2','Phase3','Phase4'));

Alter table user_preferences add CONSTRAINT 
	up_trial_filter_CHECK  CHECK 
	(trial_filter in ('All','My'));

Alter table user_preferences add CONSTRAINT 
	up_budget_filter_CHECK  CHECK 
	(budget_filter in ('All','IP','PAP'));

Alter table user_preferences add constraint user_preferences_fk1
	foreign key (ftuser_id) references ftuser(id);

create sequence user_preferences_seq;

-- FOllowing chnages are as per debashish to tune build phase-1

create index price_level_indx2 on
	price_level(procedure_def_id)
	tablespace tsmlarge_indx pctfree 20;


-- Following chnages are only implemented in build as per request of Kelly on 03/25/2002

 
-- (not required as per kelly on 03/26/2002) 
-- delete it -->Alter table temp_inst_to_company add (investig_id number(10));


-- Following chnages are as per the request of Nancy on 03/26/2002 at 9:30

conn ft15/welcome

Alter table trial add(publish_date date);


-- Following changes are for character set conversion by debashish on 03/26/2002 at 10:42


unix--> exp system/cdn492 file=sys_clob.dmp tables=SYS.METASTYLESHEET

sqlplus /nolog

conn sys/cdn492 as sysdba
truncate table sys.METASTYLESHEET;

shutdown immediate
startup mount
Alter system enable restricted session;
Alter system set job_queue_processes=0;
Alter system set AQ_TM_processes=0;
Alter database open;
Alter database character set UTF8;
shutdown immediate
startup
exit

unix--> imp sys/cdn492 ignore=y file=sys_clob.dmp fromuser=sys touser=sys \
tables=METASTYLESHEET

sys/cdn492 as sysdba


-- Following chnages are as per request of Michael Meyer on 03/26/2002 at 13:45

Alter table user_preferences modify(TRIAL_FILTER default 'My');

-- Following changes are as per the request of Kelly on 03/27/2002 at 11:41

create or replace procedure CreateTsmMessage(ClientDivId in number,
	msg_hdr in varchar2,msg_txt in varchar2) as

admin_userid number(10);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack';

  Insert into tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
  MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select tsm_message_seq.nextval,
  msg_txt,admin_userid,id,sysdate,0,0,msg_hdr from ftuser where client_div_id = ClientDivId;

 commit;
end;
/
sho err


create or replace procedure releaseClientBld(BuildTagId in number, 
    ClientDivId in number) as


cnt1 number(10);


begin

  update build_tag_to_client_div set (released, released_date) =
  (select 1,sysdate from dual) where client_div_id=ClientDivId 
   and build_tag_id=BuildTagId;

  update client_div set build_tag_id=BuildTagId where 
  id=ClientDivId;

  select count(*) into cnt1 from build_tag_to_client_div 
  where released=1 and client_div_id=ClientDivId;

  If cnt1 > 2 then
     delete build_tag_to_client_div where client_div_id=ClientDivId 
     and released=1 and build_tag_id = (select min(build_tag_id) from 
     build_tag_to_client_div where client_div_id=ClientDivId and 
     released=1);
  End if;

  CreateTsmMessage(ClientDivId,'New Build Data','New data is available for your company.  Please update the data accordingly.');

 commit;
end;
/
sho err


-- Following chnages are as per the request of Joel on 03/28/2002 at 11:30

Alter table trial_budget drop constraint tb_odc_pct_range_check;

Alter table trial_budget add constraint tb_odc_pct_range_check
	check(odc_pct_range in ('Industry','Company','Custom'));

-- Following changes are as per the request of Gary on 03/28/2002 at 13:40

update ip_business_factors set short_desc = 'AllSites' 
	where type = 'Sites' and short_desc = 'All sites';

update ip_business_factors set short_desc = 'ClinicalResearchCenter' 
	where type = 'Sites' and short_desc = 'Clinical Research Center';

update ip_business_factors set short_desc = 'PhysClinic' 
	where type = 'Sites' and short_desc = 'Physician''s clinic/outpatient';

commit;


-- Implemented in utest upto this point on 03/29/2002


-- Following chnages are done by debashish on 04/03/2002 at noon

Alter table pap_euro_overhead add(region_id number(10));

Alter table pap_euro_overhead add constraint pap_euro_overhead_fk2
	foreign key (region_id) references region(id);

truncate table tsm10.pap_euro_overhead;

Alter table pap_odc_pct modify(
	BASE_PCT  number(7,2),             
	AFFILIATED_PCT  number(7,2),         
	UNAFFILIATED_PCT  number(7,2),       
	AFF_UNAFF_PCT  number(7,2),         
	PHASE_ONE_PCT  number(7,2),          
	PHASE_TWOTHREE_PCT  number(7,2),
	PHASE_FOUR_PCT  number(7,2),         
	PHASE_ALL_PCT  number(7,2));  

Alter table pap_odc_pct_to_indmap modify (indmap_pct number(7,2)); 

Alter system set open_cursors= 300;       

-- Following changes are as per the request of Nancy on 04/03/2002 at 17:45
-- (Joel need to use this field in the Trial Edit screen)

Alter table trial_budget add(
USE_OH_IN_SCREEN_FAILURES  NUMBER (1) default 1 not null);

Alter table trial_budget add constraint tb_USE_OH_IN_SCREEN_FAIL_check
check (USE_OH_IN_SCREEN_FAILURES in (0,1));

-- Implemented in utest upto this point on 04/04/2002


-- Following changes are as per the request of Colin on 04/04/2002 at 15:41

CREATE TABLE SPECIFICITY
	(ID NUMBER(10,0) NOT NULL,
	SPECIFICITY CHAR(4) not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;

Alter table SPECIFICITY add constraint SPECIFICITY_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

create sequence specificity_seq;

insert into specificity values (1, 'GSP');
insert into specificity values (2, 'GP');
insert into specificity values (3, 'TSP');
insert into specificity values (4, 'TP');
insert into specificity values (5, 'G');
insert into specificity values (6, 'T');
insert into specificity values (7, 'SP');
insert into specificity values (8, 'P');
insert into specificity values (9, 'A');
insert into specificity values (10, 'D');
insert into specificity values (11, 'SITE');
commit;



grant select,references on specificity to tsmclient0;
grant select,references on specificity to tsmclient_pkd_3;
grant select,references on specificity to tsmclient_cen_3;

conn tsmclient0/welcome......

alter table pap_clinical_proc_cost add (specificity number(10) null);

alter table pap_clinical_proc_cost add constraint pap_clinical_proc_cost_fk5
	foreign key (specificity) references tsm10.specificity(id);


update pap_clinical_proc_cost
set specificity = 1
where (phase_id = 1 or phase_id = 5)
and indmap_id in (select id from tsm10.indmap where type = 'Indication Group');

commit;

update pap_clinical_proc_cost
set specificity = 3
where (phase_id = 1 or phase_id = 5)
and indmap_id in (select id from tsm10.indmap where type = 'Therapeutic Area');

commit;

update pap_clinical_proc_cost
set specificity = 5
where (phase_id = 0)
and indmap_id in (select id from tsm10.indmap where type = 'Indication Group');

commit;

update pap_clinical_proc_cost
set specificity = 6
where (phase_id = 0)
and indmap_id in (select id from tsm10.indmap where type = 'Therapeutic Area');

commit;

update pap_clinical_proc_cost
set specificity = 7
where (phase_id = 1 or phase_id = 5 or phase_id = 2 or phase_id = 19)
and indmap_id =0;

commit;

update pap_clinical_proc_cost
set specificity = 9
where (phase_id = 0)
and indmap_id =0;


commit;

update pap_clinical_proc_cost
set specificity = 1
where (phase_id = 2 or phase_id = 19)
and indmap_id in (select id from tsm10.indmap where type = 'Indication Group');

commit;

update pap_clinical_proc_cost
set specificity = 2
where (phase_id = 20)
and indmap_id in (select id from tsm10.indmap where type = 'Indication Group');

commit;

update pap_clinical_proc_cost
set specificity = 3
where (phase_id = 2 or phase_id = 19)
and indmap_id in (select id from tsm10.indmap where type = 'Therapeutic Area');

commit;

update pap_clinical_proc_cost
set specificity = 4
where (phase_id = 20)
and indmap_id in (select id from tsm10.indmap where type = 'Therapeutic Area');

commit;

update pap_clinical_proc_cost
set specificity = 8
where (phase_id = 20)
and indmap_id =0;

commit;

update pap_clinical_proc_cost set specificity = 10 where specificity = 9 and de_price = 1;

commit;


-- Implemented in utest upto this point on 04/04/2002



-- Following changes are as per the request of Kelly on 04/08/2002 at 4 pm

Create table picase_trial(
Trial_ID	NUMBER(10) not null,
ARCHIVED_DATE	DATE,
ARCHIVED_BY_ID	NUMBER(10),
ARCHIVED_FLG	NUMBER(1) default 0 not null,
CREATOR_FTUSER_ID	NUMBER(10),
CREATE_DATE	DATE,
BUDGET_TYPE	VARCHAR2(40),
PUBLISH_DATE	DATE)
tablespace tsmsmall 
pctused 60 pctfree 25;


Alter table picase_trial add constraint picase_trial_pk 
	primary key (trial_id) using index tablespace tsmsmall_indx 
	pctfree 25;

Alter table picase_trial add constraint picase_trial_fk1 
	foreign key (trial_id) references trial(id);

Alter table picase_trial add constraint picase_trial_fk2 
	foreign key (creator_ftuser_id) references ftuser(id);

Alter table picase_trial add constraint picase_trial_fk3 
	foreign key (ARCHIVED_BY_ID) references ftuser(id);

Alter table picase_trial add constraint pt_budget_type_check
	check(budget_type in 
	('Industry Cost', 'Per Patient Budget','Per Visit Budget'));

Alter table picase_trial add constraint pt_ARCHIVED_FLG_check
	check(ARCHIVED_FLG in (0,1));


Insert into picase_trial select ID,
ARCHIVED_DATE,ARCHIVED_BY_ID,         
ARCHIVED_FLG,CREATOR_FTUSER_ID,CREATE_DATE,BUDGET_TYPE,PUBLISH_DATE   
from trial;        

commit;



Create table trace_trial(
Trial_ID	NUMBER(10) NOT NULL,	 
ARCHIVED_DATE	DATE,		
ARCHIVED_BY_ID	NUMBER(10),		
CREATOR_FTUSER_ID	NUMBER(10),	
CREATE_DATE	DATE,		
PUBLISH_DATE	DATE,		
Drug_code_id	NUMBER(10),		
Drug_class_id	NUMBER(10),		
nickname	VARCHAR(256),
FULL_TITLE      VARCHAR2(1024),
SHORT_TITLE     VARCHAR2(256),
ARCHIVED_FLG NUMBER(1) default 0 not null)		
tablespace tsmsmall 
pctused 60 pctfree 25;


Alter table trace_trial add constraint trace_trial_pk 
	primary key (trial_id) using index tablespace tsmsmall_indx 
	pctfree 25;

Alter table trace_trial add constraint trace_trial_fk1 
	foreign key (trial_id) references trial(id);

Alter table trace_trial add constraint trace_trial_fk2 
	foreign key (creator_ftuser_id) references ftuser(id);

Alter table trace_trial add constraint trace_trial_fk3 
	foreign key (ARCHIVED_BY_ID) references ftuser(id);

Alter table trace_trial add constraint trace_trial_fk4
	foreign key (drug_code_ID) references drug_code(id);

Alter table trace_trial add constraint trace_trial_fk5
	foreign key (drug_class_ID) references drug_class(id);

Alter table trace_trial add constraint tt_ARCHIVED_FLG_check 
check(archived_flg in(0,1));

Insert into trace_trial select ID,
ARCHIVED_DATE,ARCHIVED_BY_ID,CREATOR_FTUSER_ID,CREATE_DATE,            
PUBLISH_DATE,DRUG_CODE_ID,DRUG_CLASS_ID,NICKNAME,null,null,archived_flg
from trial;
commit;
              

conn ft15/welcome


Create table Exec_trial(
Trial_ID 		NUMBER(10) NOT NULL,
SPONSOR_ID 		NUMBER(10),	 
ACCRUAL_STATUS 		VARCHAR2(50),	 
PATIENT_MNGMNT_STATUS 	VARCHAR2(50),	 
EXPECTED_ACCRUAL_CLOSE_DATE	DATE,	 
EXPECTED_LPLV_DATE	DATE,	 
START_DATE		DATE,	 
LOGGING			NUMBER(1) default 0 NOT NULL,
TMF			NUMBER(1) default 0 NOT NULL,
EXPECTED_TRIAL_CLOSE_DATE DATE,
TARGET_ENROLLMENT	NUMBER(6),	
ARCHIVED_DATE		DATE,	
ARCHIVED_BY_ID		NUMBER(10),	
ARCHIVED_FLG		NUMBER(1) default 0 NOT NULL,
CREATOR_FTUSER_ID	NUMBER(10),	
CREATE_DATE		DATE)	
tablespace tsmsmall 
pctused 60 pctfree 25;

Insert into exec_trial select ID,SPONSOR_ID,ACCRUAL_STATUS,PATIENT_MNGMNT_STATUS,          
EXPECTED_ACCRUAL_CLOSE_DATE,EXPECTED_LPLV_DATE,START_DATE,LOGGING,TMF,
EXPECTED_TRIAL_CLOSE_DATE,TARGET_ENROLLMENT,ARCHIVED_DATE,ARCHIVED_BY_ID,
ARCHIVED_FLG,CREATOR_FTUSER_ID,CREATE_DATE   from trial;           
commit;

grant select,insert,update,delete,references on exec_trial to tsm10;


Alter table Exec_trial add constraint Exec_trial_pk 
	primary key (trial_id) using index tablespace tsmsmall_indx 
	pctfree 25;

Alter table Exec_trial add constraint Exec_trial_fk1 
	foreign key (trial_id) references trial(id);

Alter table Exec_trial add constraint Exec_trial_fk2 
	foreign key (SPONSOR_ID) references SPONSOR(id);

Alter table Exec_trial add constraint Exec_trial_fk3 
	foreign key (ARCHIVED_BY_ID) references ftuser(id);

Alter table Exec_trial add constraint Exec_trial_fk4 
	foreign key (CREATOR_FTUSER_ID) references ftuser(id);

Alter table Exec_trial add constraint et_ACCRUAL_STATUS_check
	check(ACCRUAL_STATUS in ('ACTIVE', 'HOLD', 'CLOSED', 'TESTING'));

Alter table Exec_trial add constraint et_ARCHIVED_FLG_check
	check(ARCHIVED_FLG in (0,1));

Alter table Exec_trial add constraint et_LOGGING_check
	check(LOGGING in (0,1));

Alter table Exec_trial add constraint et_TMF_check
	check(TMF in (0,1));


Alter table trial drop column SPONSOR_ID;                     
Alter table trial drop column ACCRUAL_STATUS;                 
Alter table trial drop column PATIENT_MNGMNT_STATUS;          
Alter table trial drop column EXPECTED_ACCRUAL_CLOSE_DATE;
Alter table trial drop column EXPECTED_LPLV_DATE;             
Alter table trial drop column START_DATE;                     
Alter table trial drop column LOGGING;
Alter table trial drop column TMF;    
Alter table trial drop column EXPECTED_TRIAL_CLOSE_DATE;
Alter table trial drop column TARGET_ENROLLMENT ;             
Alter table trial drop column ARCHIVED_DATE ;                 
Alter table trial drop column ARCHIVED_BY_ID ;                
Alter table trial drop column ARCHIVED_FLG;
Alter table trial drop column BUDGET_TYPE ;   
Alter table trial drop column PUBLISH_DATE  ; 


Alter table trial add(protocol_identifier varchar2(256));
update trial set protocol_identifier = TSM_TRIAL_NAME;
commit;

Alter table trial drop column TSM_TRIAL_NAME;


Alter table trial drop column NICKNAME;               
Alter table trial drop column DRUG_CODE_ID;          
Alter table trial drop column DRUG_CLASS_ID ;         
Alter table trial drop column TRACE_ARCHIVED ;        
Alter table trial drop column TRACE_ARCHIVED_DATE ;   
Alter table trial drop column TRACE_LOCKED_BY_ID;     
Alter table trial drop column TRACE_AUTHOR_ID;        
Alter table trial drop column TRACE_CREATE_DATE ;     
Alter table trial drop column TRACE_AUDIT_HISTORY_ID ;



conn tsm10/welcome

Create synonym exec_trial for ft15.exec_trial;
--Create synonym exec_trial_seq for ft15.exec_trial_seq;


Alter table trace_audit_history add(modify_date date);

update trace_audit_history set modify_date = history_date;
commit;

Alter table trace_audit_history drop column history_date;
Alter table trace_audit_history drop column type;
Alter table trace_audit_history drop column parent_id ;
Alter table trace_audit_history drop column parent_type;

Alter table trace_audit_history add(
	trace_estimate_id     number(10),
	task_group_inst_id    number(10));

Alter table trace_audit_history add constraint TRACE_AUDIT_HISTORY_FK3
	foreign key (trace_estimate_id) references trace_estimate(id);

Alter table trace_audit_history add constraint TRACE_AUDIT_HISTORY_FK4
	foreign key (task_group_inst_id) references task_group_inst(id);


Alter table task_group_inst drop column TRACE_AUDIT_HISTORY_ID ;

Alter table task_group_inst add constraint tgi_review_status_check
	check(review_status in ('Unreviewed','Reviewed','Approved'));

conn ft15/welcome

Alter table trial drop column ft_type;

Alter table CRA_MANAGER_TO_TRIAL drop constraint CRA_MANAGER_TO_TRIAL_FK2;        
Alter table FTUSER_TRIAL_FILTER drop constraint FTUSER_TRIAL_FILTER_FK2;        
Alter table PATIENT_MANAGEMENT_TASK drop constraint PATIENT_MANAGEMENT_TASK_FK1;   
Alter table PROTOCOL_EVENT_GROUP drop constraint PROTOCOL_EVENT_GROUP_FK1;     
Alter table SUBJECT_DISPOSITION drop constraint SUBJECT_DISPOSITION_FK1;      
Alter table TMF_DELIVERABLE drop constraint TMF_DELIVERABLE_FK1;          
Alter table SITE_CHECKLIST_TEMPLATE drop constraint SITE_CKLST_TEMPLATE_TRIAL_FK1; 
Alter table PROTOCOL_VERSION drop constraint TRIAL_FK;                       
Alter table VISIT_TYPE_SAVE drop constraint VISIT_TYPE_FK1;              
Alter table SITE_TO_TRIAL drop constraint TRIAL_FK2;                     
Alter table PROTOCOL_EVENT drop constraint PROTOCOL_EVENT_FK1;           

Alter table CRA_MANAGER_TO_TRIAL add constraint CRA_MANAGER_TO_TRIAL_FK2
	foreign key (trial_id) references exec_trial(trial_id);       
Alter table FTUSER_TRIAL_FILTER add constraint FTUSER_TRIAL_FILTER_FK2
	foreign key (trial_id) references exec_trial(trial_id);        
Alter table PATIENT_MANAGEMENT_TASK add constraint PATIENT_MANAGEMENT_TASK_FK1
	foreign key (trial_id) references exec_trial(trial_id);   
Alter table PROTOCOL_EVENT_GROUP add constraint PROTOCOL_EVENT_GROUP_FK1
	foreign key (trial_id) references exec_trial(trial_id);     
Alter table SUBJECT_DISPOSITION add constraint SUBJECT_DISPOSITION_FK1
	foreign key (trial_id) references exec_trial(trial_id);      
Alter table TMF_DELIVERABLE add constraint TMF_DELIVERABLE_FK1
	foreign key (trial_id) references exec_trial(trial_id);          
Alter table SITE_CHECKLIST_TEMPLATE add constraint SITE_CKLST_TEMPLATE_TRIAL_FK1
	foreign key (trial_id) references exec_trial(trial_id); 
Alter table PROTOCOL_VERSION add constraint TRIAL_FK
	foreign key (trial_id) references exec_trial(trial_id);                       
Alter table VISIT_TYPE_SAVE add constraint VISIT_TYPE_FK1
	foreign key (trial_id) references exec_trial(trial_id);              
Alter table SITE_TO_TRIAL add constraint TRIAL_FK2
	foreign key (trial_id) references exec_trial(trial_id);                     
Alter table PROTOCOL_EVENT add constraint PROTOCOL_EVENT_FK1
	foreign key (trial_id) references exec_trial(trial_id);   


conn tsm10/welcome

drop table trial_group_permission;
drop sequence trial_group_permission_seq;
   
Alter table BUDGET_AUDIT_HIST drop constraint BUDGET_AUDIT_HIST_FK3;
Alter table TRACE_AUDIT_HISTORY drop constraint TRACE_AUDIT_HISTORY_FK1;
Alter table TRACE_ESTIMATE drop constraint TRACE_ESTIMATE_FK1;
Alter table TRIAL_BUDGET drop constraint TRIAL_BUDGET_FK4;


Alter table BUDGET_AUDIT_HIST add constraint BUDGET_AUDIT_HIST_FK3
	foreign key (trial_id) references picase_trial(trial_id);
Alter table TRACE_AUDIT_HISTORY add constraint TRACE_AUDIT_HISTORY_FK1
	foreign key (trial_id) references trace_trial(trial_id);
Alter table TRACE_ESTIMATE add constraint TRACE_ESTIMATE_FK1
	foreign key (trial_id) references trace_trial(trial_id);
Alter table TRIAL_BUDGET add constraint TRIAL_BUDGET_FK4
	foreign key (trial_id) references picase_trial(trial_id);


conn ft15/welcome

Alter table trial drop column creator_ftuser_id;
Alter table trial drop column create_date;

Alter table trial drop constraint trial_created_by_check;
update trial set created_by = 'PICAS-E' ;
Alter table trial add constraint trial_created_by_check check(
	created_by in ('ExecSuite', 'PICAS-E', 'Trace'));


-- Following changes are as per the request of Joel on 04/09/2002 at 12:38 pm
--This is needed for changes to investigator planning to support "anonymous" 
-- location sets (i.e not shared with other users in the client division)

conn tsm10/welcome


Alter table location_set add(IS_ANONYMOUS number(1) default 0 not null);

Alter table location_set add constraint ls_is_anonymous_check 
	check(is_anonymous in (0,1));

-- Following chnages are as per the request of Joel on 04/09/2002 at 13:27
--Eventually we will want to drop country_id from IP_SESSION 
-- however probably safer to leave it for now.

update ip_session set location_Set_id = 68 where location_set_id is null;
Alter table ip_session modify (country_id null, location_set_id not null);

-- Following changes are as per Kelly on 04/10/2002 at 15:45

--Alter table trace_trial add (ARCHIVED_FLG NUMBER(1) default 0 not null);

--Alter table trace_trial add constraint tt_ARCHIVED_FLG_check 
--check(archived_flg in(0,1));


-- Implemented in utest upto this point on 04/11/2002


-- Following changes are as per the request of kelly on 04/15/2002 at 12:20

Alter table trace_trial drop column drug_class_id;


conn ft15/welcome

alter table FTGROUP
drop constraint FTGROUP_NAME_CHECK;

alter table ftgroup add constraint
 FTGROUP_NAME_CHECK  CHECK ( name in ('Fast Track Administrator','Site Administrator',
 'Sponsor Administrator','Site User','CRA','CRA Manager',
 'Site Handheld','CRA Handheld','Client Read Only User',
 'Client User','Client Admin', 'TSM Super Admin','TSM FTAdmin','Sysinfo',
 'TRACE Author','TRACE Admin'));


insert into ftgroup values (15,'TRACE Author');
insert into ftgroup values (16,'TRACE Admin');

commit;

-- Following changes are as per the request of Allen on 04/16/2002 at 11 am
con tsm10/welcome 

Alter table client_div add(License_Exp_Date date);
update client_div set license_exp_date = sysdate +29;
commit;

-- Following chnages are as per the request of Joel on 04/16/2002 at 14:00 

Alter table ip_business_factors add (num_days number(5));

update ip_business_factors set num_days=6  where type = 'Ph1dur' and
	short_desc like '%<one week%';
update ip_business_factors set num_days=14  where type = 'Ph1dur' and
	short_desc like '%1 to 2 weeks%';
update ip_business_factors set num_days=28  where type = 'Ph1dur' and
	short_desc like '%3 to 4 weeks%';
update ip_business_factors set num_days=42  where type = 'Ph1dur' and
	short_desc like '%5 to 6 weeks%';
update ip_business_factors set num_days=56  where type = 'Ph1dur' and
	short_desc like '%7 to 8 weeks%';
update ip_business_factors set num_days=84  where type = 'Ph1dur' and
	short_desc like '%9 to 12 weeks%';
update ip_business_factors set num_days=140  where type = 'Ph1dur' and
	short_desc like '%13 to 20 weeks%';
update ip_business_factors set num_days=175  where type = 'Ph1dur' and
	short_desc like '%21 to 25 weeks%';
update ip_business_factors set num_days=364  where type = 'Ph1dur' and
	short_desc like '%26 to 52 weeks%';
update ip_business_factors set num_days=365  where type = 'Ph1dur' and
	short_desc like '%over 52 weeks%';

update ip_business_factors set num_days=-1  where type = 'Confine' and
	short_desc like '%No confinement%';
update ip_business_factors set num_days=0  where type = 'Confine' and
	short_desc like '%<24 hours confinement%';
update ip_business_factors set num_days=1  where type = 'Confine' and
	short_desc like '%24 to 48 hours confinement%';
update ip_business_factors set num_days=3  where type = 'Confine' and
	short_desc like '%3 to 4 days confinement%';
update ip_business_factors set num_days=5  where type = 'Confine' and
	short_desc like '%5 to 6 days confinement%';
update ip_business_factors set num_days=7  where type = 'Confine' and
	short_desc like '%7 to 13 days confinement%';
update ip_business_factors set num_days=14  where type = 'Confine' and
	short_desc like '%14 to 28 days confinement%';
update ip_business_factors set num_days=29  where type = 'Confine' and
	short_desc like '%over 28 days confinement%';

update ip_business_factors set num_days=0  where type = 'Treatment' and
	short_desc like '%1 to 7 days%';
update ip_business_factors set num_days=8  where type = 'Treatment' and
	short_desc like '%8 to 14 days%';
update ip_business_factors set num_days=15  where type = 'Treatment' and
	short_desc like '%15 to 21 days%';
update ip_business_factors set num_days=22  where type = 'Treatment' and
	short_desc like '%22 to 28 days%';
update ip_business_factors set num_days=29  where type = 'Treatment' and
	short_desc like '%over 28 days%';

commit;

-- Following changes are as per the request of Joel on 04/16/2002 at 14:30
-- We need this column for ECR 016/ 021 to be able to price a trial 
-- according to a different phase to the phase in which it “truly” belongs.


Alter table picase_trial add (PRICE_CMP_PHASE_ID NUMBER(10));

Alter table picase_trial add constraint picase_trial_fk4 
	foreign key (PRICE_CMP_PHASE_ID) references phase(id);



-- Following changes are as per the request of Cindy on 04/16/2002 at 15:30 

update tsm10.ip_cpp set cintercept=ointercept where intercept is null and ointercept>0;
update tsm10.ip_cpp set slope=oslope where  intercept is null and ointercept>0;
update tsm10.ip_cpp set cslope=oslope where  intercept is null and ointercept>0;
update tsm10.ip_cpp set low=olow where  intercept is null and ointercept>0;
update tsm10.ip_cpp set clow=olow where  intercept is null and ointercept>0;
update tsm10.ip_cpp set mid=omid where  intercept is null and ointercept>0;
update tsm10.ip_cpp set cmid=omid where  intercept is null and ointercept>0;
update tsm10.ip_cpp set high=ohigh where  intercept is null and ointercept>0;
update tsm10.ip_cpp set chigh=ohigh where  intercept is null and ointercept>0;
update tsm10.ip_cpp set intercept=ointercept where  intercept is null and ointercept>0;
update tsm10.ip_cpp set intercept=ointercept where cintercept is null and ointercept>0;
update tsm10.ip_cpp set slope=oslope where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set cslope=oslope where cintercept is null and ointercept>0;
update tsm10.ip_cpp set low=olow where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set clow=olow where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set mid=omid where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set cmid=omid where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set high=ohigh where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set chigh=ohigh where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set cintercept=ointercept where  cintercept is null and ointercept>0;
update tsm10.ip_cpp set slope=cslope where  intercept is null and ointercept is null and cintercept>0;
update tsm10.ip_cpp set low=clow where  intercept is null and ointercept is null and cintercept>0;
update tsm10.ip_cpp set mid=cmid where  intercept is null and ointercept is null and cintercept>0;
update tsm10.ip_cpp set high=chigh where  intercept is null and ointercept is null and cintercept>0;
update tsm10.ip_cpp set intercept=cintercept where intercept is null and ointercept is null and cintercept>0;
update tsm10.ip_cpp set cslope=slope where  cintercept is null and ointercept is null and intercept>0;
update tsm10.ip_cpp set clow=low where  cintercept is null and ointercept is null and intercept>0;
update tsm10.ip_cpp set cmid=mid where  cintercept is null and ointercept is null and intercept>0;
update tsm10.ip_cpp set chigh=high where  cintercept is null and ointercept is null and intercept>0;
update tsm10.ip_cpp set cintercept=intercept where cintercept is null and ointercept is null and intercept>0;

-- Following changes are as per the request of Kelly on 04/17/2002 at 12 noon

conn ft15/welcome

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by on trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace'  then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 

end;
/

-- Following changes are as per the request of Kelly on 04/17/2002 at 15:43

conn tsm10/welcome

Alter table role_inst add(alias  varchar2 (64));


-- Following changes are as per the request of Colin on 04/17/2002 at 17:40
-- Not yet implemented in build


update cost_item set REQUIRED_SPECIFICITY = 'GSP' where REQUIRED_SPECIFICITY is null;
commit;

Alter table cost_item modify(REQUIRED_SPECIFICITY   default 'GSP' not null);
Alter table cost_item add(required_co_specificity VARCHAR2(10) default 'GSP' not null);



-- Following changes are as per the request of Colin on 04/18/2002 at 14:05 

Alter table cost_item add(priced_co_specificity VARCHAR2(10));

-- Following changes are as per the request of Kelly on 04/18/2002 at 15:50 

Alter table milestone_inst modify(MILESTONE_DATE null);


-- Following changes are as per the request of Debashish, Kelly, Peter, Cindy and group
-- on 04/19/2002 at 14:30 

Create table odc_def_mapper (
	odc_def_id number(10) not null,
	parent_odc_def_id number(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table odc_def_mapper add constraint  odc_def_mapper_pk
	primary key (odc_def_id, parent_odc_def_id) 
	using index tablespace tsmsmall pctfree 20;


Alter table odc_def_mapper add constraint odc_def_mapper_fk1 
	foreign key (odc_def_id) references odc_def(id);

Alter table odc_def_mapper add constraint odc_def_mapper_fk2
	foreign key(parent_odc_def_id) references odc_def(id);


-- Then adjust data in this table manually
/*
column picas_code format a15

select id,PICAS_CODE,PROCEDURE_LEVEL from odc_def where picas_code in (
select picas_code from odc_def group by picas_code having count(*) > 1 )
order by 2;


Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (68,67 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (69,67 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (80,79 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (81,79 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (71,70 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (72,70 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (74,73 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (75,73 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (77,76 );
Insert into odc_def_mapper(odc_def_id,parent_odc_def_id) values (78,76 );

commit;

update odc_def set picas_code = 'V1110' where picas_code = '#1110' 
and procedure_level = 'Visit';

update odc_def set picas_code = 'V1111' where picas_code = '#1111' 
and procedure_level = 'Visit';

update odc_def set picas_code = 'V1113' where picas_code = '#1113' 
and procedure_level = 'Visit';

commit;
*/


-- Following changes are as per the meeting with Suzanne, Kelly, chick and Lori
-- on 04/19/2002 at 9:30 am
/*
delete from mapper where odc_def_id in (
SELECT ODC_DEF_ID FROM study_level_service_master);

delete from TSMCLIENT0.mapper where odc_def_id in (
SELECT ODC_DEF_ID FROM study_level_service_master);

delete from study_level_service_inst;

alter table study_level_service_master drop constraint
study_level_service_master_fk1;

-- ? delete from cost_item;
-- ? delete from custom_set_item;

delete from odc_def where id in (
SELECT ODC_DEF_ID FROM study_level_service_master);
*/


drop table study_level_service_inst;

DROP TABLE STUDY_LEVEL_SERVICE_MASTER;

drop sequence study_level_service_master_seq;

drop sequence study_level_service_inst_seq;

Create table add_study(
	id number(10),
	country_id number(10),
	odc_def_id number(10),
	payment_country_id number(10),
	pct25 number(5),
	pct50 number(5),
	pct75 number(5))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table add_study add constraint add_study_pk
	primary key (id) using index tablespace tsmsmall_indx
	pctfree 20;

create sequence add_study_seq;

Alter table add_study add constraint add_study_fk1 
	foreign key (country_id) references country(id);

Alter table add_study add constraint add_study_fk2 
	foreign key (odc_def_id) references odc_def(id);

Alter table add_study add constraint add_study_fk3 
	foreign key (payment_country_id) references country(id);


-- Then load the data into ad_study by running add_study scripts

-- Following changes are as per the request of Kelly on 04/24/2002 at 10:53am


Alter table rate_set add(default_flg number(1) default 0 not null);

Alter table rate_set add constraint rs_default_flg_check 
	check (default_flg in (0,1));


-- Following changes are as per the request of Kelly 

Alter table picase_trial add (publish_client_group_id number(10));

Alter table picase_trial add constraint
PICASE_TRIAL_FK5 foreign key (PUBLISH_CLIENT_GROUP_ID)
references client_group(id);

-- Following changes are as per the request of Nancy on 04/24/2002 at 11:40am
-- This is to fix bug18E

Alter table trial_budget add(ODC_PCT_USE_OH_FLG number(1) default 1 not null);

Alter table trial_budget add constraint tb_ODC_PCT_USE_OH_FLG_check
check (ODC_PCT_USE_OH_FLG in (0,1));


-- Following changes are for Colin on client schema 
conn tsmclient***/welcome@**

Alter table pap_overhead add (specificity number(10));

Alter table pap_overhead add constraint pap_overhead_fk4
	foreign key (specificity) references 
	tsm10.specificity(id);

-- Following data changes are as per the request of Kelly on 04/25/2002 at 10 am

conn tsm10/welcome

update odc_def set hide=0 where picas_code = '#2001';

commit;


--*******************************************************
--Chnages upto this has been implemented in prod and test3
--*******************************************************


-- Following changes are done by Debashish to track changes during a data load process on 04/30/2002 at 9 am

Create table data_load_history(
	table_name varchar2(30) not null,
	load_date date default sysdate not null,
	num_inserted number(10),
	num_updated number(10))
	tablespace tsmsmall
	pctused 70 pctfree 15;

Alter table data_load_history add constraint data_load_history_pk
	primary key (table_name,load_date) using index tablespace
	tsmsmall_indx pctfree 15;
	
-- Following changes are as per the request of Kelly on 05/01/2002 at 8:23 am

Alter table role_to_task_template drop column HOURS_PER_ROLE;

ALTER TABLE ROLE_INST_TO_TASK_INST drop column TASK_INST_ID;

-- Following changes are for Gary on 05/01/2002 at 13:43 

Create table audit_hist(
	id number(10),
	modify_date date not null,
	ftuser_id number(10) not null,
	comments varchar2(256),
	app_type varchar2(50) not null,
	action varchar2(50) not null,
	target_name varchar2(50),
	target_primary_table varchar2(50) not null,
	target_id number(10) not null,
	entity_type varchar2(50) not null,
	entity_id number(10) not null)
	tablespace tsmlarge pctused 60 pctfree 20;

Alter table audit_hist add constraint audit_hist_pk
	primary key (id) using index tablespace tsmlarge_indx
	pctfree 20;

create sequence audit_hist_seq;

Alter table audit_hist add constraint audit_hist_fk1 
	foreign key (ftuser_id) references ftuser(id);

-- Following changes are as per the request of Kelly on 05/02/2002 at 13:45

Alter table trace_estimate add(design_shells number(5));
Alter table trace_estimate drop column NOTIFY_REVIEWERS;


-- Following changes are as per the request of Kelly on 05/03/2002 at 9:16 

Alter table role_inst_to_task_inst modify (CALC_HOURS NUMBER(12,2), 
				  	   ADJ_HOURS NUMBER(12,2));

-- Following changes are as per the request of Allen on 05/03/2002 at 16:00

Create or replace trigger client_div_to_lic_indmap_trg1
after insert or update of INDMAP_ID on client_div_to_lic_indmap
referencing new as n old as o
for each row
declare
indmap_cnt number(10);
invalid_indmap exception;

begin

  Select count(*) into indmap_cnt from indmap where 
	id = :n.INDMAP_ID and parent_indmap_id is null;

  If indmap_cnt = 0 then
	raise invalid_indmap;
  end if;

exception

   when invalid_indmap then
	Raise_application_error(-20106,'Indmap_id is not a Therapeutic Area ');
end;
/
sho err

-- Following changes are as per the request of Colin on 05/06/2002 at 15:15 

conn tsmclient****/welcome

Alter table pap_odc_cost (specificity number(10));
Alter table pap_odc_cost add constraint pap_odc_cost_fk5 
	foreign key (specificity) references specificity(id);

-- Following changes are as per the request of Alan on 05/06/2002 at 15:30

create or replace procedure LicenseWarning as

  cursor c1 is select id from client_div where license_exp_date <= sysdate+5 and
	license_exp_date > sysdate+1 ;
  cursor c2 is select id from client_div where license_exp_date <= sysdate+1 and
	license_exp_date > sysdate ;

  p_contact_userid number(10);
  admin_userid number(10);
  message_exist number(10);
  msg_txt1 varchar2(100);
  msg_txt2 varchar2(100);
  msg_txt3 varchar2(100);
  lic_exp_dt varchar2(40);
  msg_hdr varchar2(40):= 'License Warning';
  msg_txt varchar2(256);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack'; 

  msg_txt1:='Your PICAS-e contract will expire on ';
  msg_txt2:='. You will not be able to access the system after this date. ';
  msg_txt3:='Please contact your Fast Track representative if needed.  Thank you.';

  for ix1 in c1 loop
 
    select principal_contact_id,to_char(license_exp_date,'YYYY-MM-DD') into 
    p_contact_userid,lic_exp_dt from client_div where id = ix1.id;

    If p_contact_userid is not null then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-6 and sysdate  and message_header = 'License Warning' and
      addressee_ftuser_id = p_contact_userid ; 
    
      If message_exist = 0 then 

        Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
        MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) values (tsm_message_seq.nextval,
        msg_txt,admin_userid,p_contact_userid,sysdate,0,0,msg_hdr) ;

      end if;
    end if;
  End loop;

  for ix2 in c2 loop

    select principal_contact_id,to_char(license_exp_date,'YYYY-MM-DD') into 
    p_contact_userid,lic_exp_dt from client_div where id = ix2.id;

    If p_contact_userid is not null then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-6 and sysdate  and message_header = 'License Warning' and
      addressee_ftuser_id = p_contact_userid and seen_flg = 0 ;    

      If message_exist = 0 then 

         Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
         MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) values (tsm_message_seq.nextval,
         msg_txt,admin_userid,p_contact_userid,sysdate,0,0,msg_hdr) ;

      End if;
    End if;

  End loop;

 commit;
end;
/
sho err



-- Following chnages are as per the request of Kelly on 05/08/2002 at 9:12 am

Alter table trace_estimate modify(trial_id not null);

-- Following changes are as per the request of Kelly on 05/08/2002 at 11:35

Alter table trace_estimate modify(QUERY_PAGE_PCT number(5));

Alter table trace_estimate modify(
	qual_visit_hours number(12,2),
	init_visit_hours number(12,2),
	closeout_visit_hours number(12,2),
	routine_visit_hours number(12,2),
	travel_hours_visit number(12,2),
	visit_prep_hours number(12,2));

-- Following changes are as per the request of Kelly on 05/08/2002 at 13:10 

Create table client_div_to_lic_app(
	id number(10),
	client_div_id number(10),
	app_name varchar2(50),
	license_exp_date date)
	tablespace tsmsmall pctused 65 pctfree 20;

create sequence client_div_to_lic_app_seq;

Alter table client_div_to_lic_app add constraint 
	client_div_to_lic_app_pk primary key (id)
	using index tablespace tsmsmall_indx pctfree 20;

Alter table client_div_to_lic_app add constraint 
	client_div_to_lic_app_fk1 foreign key (client_div_id)
	references client_div(id);
	
Alter table client_div_to_lic_app add constraint cdtla_app_name_check check(
	app_name in ('DASHBOARD', 'PICASE', 'TRACE'));

-- Following changes are as per the request of Kelly on 05/08/2002 at 13:33

create or replace procedure LicenseWarning as

  cursor c1 is select client_div_id from client_div_to_lic_app where 
        license_exp_date <= sysdate+6 and license_exp_date > sysdate+2 and
        app_name = 'PICASE' ;
  cursor c2 is select client_div_id from client_div_to_lic_app where 
	license_exp_date <= sysdate+2 and license_exp_date > sysdate+1 and
	app_name = 'PICASE' ;

  client_admin_users number(10);
  admin_userid number(10);
  message_exist number(10);
  msg_txt1 varchar2(100);
  msg_txt2 varchar2(100);
  msg_txt3 varchar2(100);
  lic_exp_dt varchar2(40);
  msg_hdr varchar2(40):= 'License Warning';
  msg_txt varchar2(256);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack'; 

  msg_txt1:='Your PICAS-e contract will expire on ';
  msg_txt2:='. You will not be able to access the system after this date. ';
  msg_txt3:='Please contact your Fast Track representative if needed.  Thank you.';

  for ix1 in c1 loop
 
    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
    c.name = 'Client Admin' ;

    select to_char(license_exp_date,'YYYY-MM-DD') into 
    lic_exp_dt from client_div where id = ix1.client_div_id;

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and
      addressee_ftuser_id in (select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
      c.name = 'Client Admin'); 
    
      If message_exist = 0 then 

        Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
        MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select tsm_message_seq.nextval,
        msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
        where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
        c.name = 'Client Admin' ;

      end if;
    end if;
  End loop;

  for ix2 in c2 loop

    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
    c.name = 'Client Admin' ;


    select to_char(license_exp_date,'YYYY-MM-DD') into 
    lic_exp_dt from client_div where id = ix2.client_div_id;

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and seen_flg = 0 and
      addressee_ftuser_id in ( select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
      c.name = 'Client Admin') ;    

      If message_exist = 0 then 

         Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
         MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select tsm_message_seq.nextval,
         msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
         where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
         c.name = 'Client Admin' ;

      End if;
    End if;

  End loop;

 commit;
end;
/
sho err



-- Following chnages are as per the request of Kelly on 05/08/2002 at 14:00

Alter table audit_hist add constraint audit_hist_app_type_check check(
	app_type in ('DASHBOARD', 'PICASE', 'TRACE'));

-- Following chnages are as per the request of Kelly on 05/08/2002 at 14:03

conn ft15/welcome@....

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('ExecSuite', 'PICAS-E', 'Trace','DASHBOARD', 'PICASE', 'TRACE'));

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by on trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 

end;
/

-- Following changes are as per the request of Kelly on 05/08/2002 at 14:20
conn tsm10/welcome@....

Alter table client_div_to_lic_app add (principal_contact_id  number(10));

Alter table client_div_to_lic_app add constraint 
	client_div_to_lic_app_fk2 foreign key (principal_contact_id)
	references ftuser(id);

Alter table client_div_to_lic_app add constraint 
	client_div_to_lic_app_uq1 unique (client_div_id, app_name)
	using index tablespace tsmsmall_indx pctfree 20;

-- Following changes are as per the request of Gary and Joel on 05/09/2002 at 10 am

Alter table client_currency_cnv modify (CONVERSION_RATE null);

Alter table client_currency_cnv add constraint ccc_CONVERSION_RATE_check
check (CONVERSION_RATE > 0);

-- Following changes are as per the request of Peter on 05/10/2002 at 11:10 am

Alter table country add(fte_hours_month number(4,1) default 160);

-- Following changes are as per the request of Kelly on 05/10/2002 at 11:20 am

Alter table client_div add (locale varchar2(10));

update client_div set locale = 'ENG';
commit;

-- Following chnages are as per the request of kelly on 05/10/2002 at 11:45

grant select,references on client_div to tsmclient0;
grant select,references on client_div_to_lic_country to tsmclient0;


conn tsmclient0/welcome@...

create synonym client_div for tsm10.client_div;
create synonym client_div_to_lic_country for tsm10.client_div_to_lic_country;

conn tsm10/welcome@...



-- Following changes are as per the request of Gary on 05/13/2002 

update ip_business_factors set short_desc =  'ClinResearchCenter' where
type='Sites' and short_desc = 'ClinicalResearchCenter';

-- Following chnages are as per Debashish on 05/13/2002 at 11:38 to fix a bug


create or replace procedure LicenseWarning as

  cursor c1 is select client_div_id from client_div_to_lic_app where 
        license_exp_date <= sysdate+6 and license_exp_date > sysdate+2 and
        app_name = 'PICASE' ;
  cursor c2 is select client_div_id from client_div_to_lic_app where 
	license_exp_date <= sysdate+2 and license_exp_date > sysdate+1 and
	app_name = 'PICASE' ;

  client_admin_users number(10);
  admin_userid number(10);
  message_exist number(10);
  msg_txt1 varchar2(100);
  msg_txt2 varchar2(100);
  msg_txt3 varchar2(100);
  lic_exp_dt varchar2(40);
  msg_hdr varchar2(40):= 'License Warning';
  msg_txt varchar2(256);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack'; 

  msg_txt1:='Your PICAS-e contract will expire on ';
  msg_txt2:='. You will not be able to access the system after this date. ';
  msg_txt3:='Please contact your Fast Track representative if needed.  Thank you.';

  for ix1 in c1 loop
 
    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
    c.name = 'Client Admin' ;

    select to_char(license_exp_date,'YYYY-MM-DD') into 
    lic_exp_dt from client_div_to_lic_app where client_div_id = ix1.client_div_id 
    and app_name = 'PICASE';

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and
      addressee_ftuser_id in (select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
      c.name = 'Client Admin'); 
    
      If message_exist = 0 then 

        Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
        MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select tsm_message_seq.nextval,
        msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
        where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
        c.name = 'Client Admin' ;

      end if;
    end if;
  End loop;

  for ix2 in c2 loop

    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
    c.name = 'Client Admin' ;


      select to_char(license_exp_date,'YYYY-MM-DD') into 
      lic_exp_dt from client_div_to_lic_app where client_div_id = ix2.client_div_id 
      and app_name = 'PICASE';

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and seen_flg = 0 and
      addressee_ftuser_id in ( select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
      c.name = 'Client Admin') ;    

      If message_exist = 0 then 

         Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
         MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select tsm_message_seq.nextval,
         msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
         where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
         c.name = 'Client Admin' ;

      End if;
    End if;

  End loop;

 commit;
end;
/
sho err



-- Following changes are as per the request of Joel on 05/13/2002 at 16:21


Alter table trial_budget add(OVERHEAD_PCT_RANGE varchar2(20));

Alter table trial_budget add constraint tb_ovhd_pct_range_check
	check(overhead_pct_range in ('Low','Med','High','Co_Med'));

-- Following chnages are as per the request of Kelly on 05/15/2002 at 9:30 am

update trial_budget a set a.OVERHEAD_PCT_RANGE = (select b.DEF_PRICE_RANGE
from client_div b, trial c where c.client_div_id = b.id and c.id = a.trial_id)
where a.OVERHEAD_PCT_RANGE is null;

Alter table trial_budget modify(OVERHEAD_PCT_RANGE not null);

-- Following changes are as per the request of Colin on 05/15/2002 at 15:00

conn tsmclient***/welcome@****

create or replace view pap_overhead_overhead as
select id, country_id, phase_id, indmap_id,
company_ovrhd_p50, ofc_ovrhd_p25,
ofc_ovrhd_p50, ofc_ovrhd_p75,
adj_ovrhd_p25, adj_ovrhd_p50, adj_ovrhd_p75, specificity
from pap_overhead
where adj_ovrhd_p50 is not null;

create or replace view pap_overhead_odc as
select id, country_id, phase_id, indmap_id,
company_odc_p50, odc_p50
from pap_overhead
where odc_p50 is not null;

create or replace view pap_overhead_pct_paid as
select id, country_id, phase_id, indmap_id,
company_pct_paid_p50,
pct_paid_p50
from pap_overhead
where pct_paid_p50 is not null;





--Following changes are as per the request of Joel on 05/17/2002 at 10:30 am


Alter table trial_budget drop column official_overhead_pct_range;
Alter table trial_budget drop column adjusted_overhead_pct_range;

-- Following chnages are as per the request of Kelly on 05/17/2002 at 11:05 am

Alter table client_div drop column LICENSE_EXP_DATE;
Alter table client_div drop column PRINCIPAL_CONTACT_ID;
Alter table client_div drop column PRINCIPAL_CONTACT;
Alter table client_div drop column PRINCIPAL_PHONE;
Alter table client_div drop column PRINCIPAL_EMAIL;

-- Following changes are as per the request of Kelly on 05/17/2002 at 11:51 am

Alter table trace_estimate add (inv_mtg_count number(5),
				inv_mtg_hours number(12,2));


--following chnages are as per the request of Jeff on 05/22/2002 at 11:59 am

conn ft15/welcome@...

update ftuser set DISPLAY_NAME = initcap(FIRST_NAME)||' '||initcap(LAST_NAME);
commit;

CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
        end if;


   end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;

 :n.display_name:=initcap(:n.first_name)||' '||initcap(:n.last_name);

Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');


end;
/
sho err


--***************************************************
-- Implemented in utest upto this point on 06/02/2002
--***************************************************

conn tsm10/welcome@......

-- Following changes are as per the request of Nancy on 05/23/2002 at 5pm

Alter table project add constraint project_uq1
	unique (client_id, name) using index tablespace
	tsmsmall_indx pctfree 20;



-- Following chnages were done at the build time as per the request of Joel

Alter table project drop constraint project_uq1;


-- Following changes are as per the request of kelly on 06/05/2002 at 12.15pm

create or replace function Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is

type TabSeqTyp is ref cursor;
tab_seq TabSeqTyp;

start_value number(10);
last_value number(10);
diff_value number(10);

begin

<<try_again>>

open tab_seq for 'select '||seq_name||'.nextval from dual';
fetch tab_seq into start_value ;
close tab_seq;

for i in 1..increment_by-1 loop 

open tab_seq for 'select '||seq_name||'.nextval from dual';
fetch tab_seq into last_value ;
close tab_seq;

end loop;

diff_value:=last_value-start_value+1;

If diff_value <> increment_by then 
   goto try_again;
end if; 

return(start_value);
end;
/


--******************************************************************
--Chnages upto this has been implemented in the build on 05/23/2002
--******************************************************************

--***************************************************************************
--Chnages upto this has been implemented in the production beta on 06/09/2002
--***************************************************************************


-- Following changes are as per the request of Kelly on 06/10/2002

alter table task_inst drop column task_group_inst_id;

create or replace procedure delete_trace_trial (trialid in number) as

begin

delete from role_inst_to_task_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from task_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from task_group_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from milestone_inst where
trace_estimate_id in (select id from trace_estimate 
where trial_id=trialid);

delete from trace_estimate where trial_id=trialid;

delete from trace_trial where trial_id=trialid;

delete from trial where id=trialid;
commit;

end;
/

sho err

-- Folowing changes are as per the request of Colin on 06/11/2002 at 9:15am


Alter table client_div modify (def_overhead_pct number(12,2));

Alter table picas_visit_to_cost_item modify (frequency number(12,2));

Alter table cost_item modify (frequency number(12,2));

Alter table cost_item modify (screening_quantity number(12,2));

-- Following changes are as per the request of kelly on 06/17/2002 at 8:28 am

Alter table role_to_task_template drop column sequence;

Alter table task_inst drop column recalc_flg;

Alter table trace_estimate drop column locked_by_ftuser_id;
Alter table trace_estimate drop column locked_date;
Alter table trace_estimate drop column spons_staff_invmtg_count;
Alter table trace_estimate drop column cro_staff_invmtg_count;
Alter table trace_estimate drop column joint_staff_invmtg_count;
Alter table trace_estimate drop column joint_meeting_dur;
Alter table trace_estimate drop column published_flg;

Alter table trace_trial drop column drug_code_id;

--Following chnages are as per the request of Joel on 06/16/2002 at 11am


update tsm10.country set name = 'Russia, Estonia, Latvia, Lithuania' 
where abbreviation='FSU';
commit;

-- Following changes are as per the request of Gary on 06/16/2002 at 11:11 am

Alter table client_div drop column locale;

Alter table client_div add(iso_lang varchar2(2));

Alter table country add(iso_country varchar2(2));

update country set iso_country = 'AU'
where abbreviation = 'AUS';

update country set iso_country = 'AT'
where abbreviation = 'ARI';

update country set iso_country = 'BE'
where abbreviation = 'BEL';

update country set iso_country = 'CA'
where abbreviation = 'CAN';

update country set iso_country = 'DK'
where abbreviation = 'DEN';

update country set iso_country = 'FI'
where abbreviation = 'FIN';

update country set iso_country = 'FR'
where abbreviation = 'FRA';

update country set iso_country = 'DE'
where abbreviation = 'DEU';

update country set iso_country = 'HU'
where abbreviation = 'HUN';

update country set iso_country = 'IE'
where abbreviation = 'IRL';

update country set iso_country = 'IL'
where abbreviation = 'ISR';

update country set iso_country = 'IT'
where abbreviation = 'ITA';

update country set iso_country = 'NL'
where abbreviation = 'NET';

update country set iso_country = 'NO'
where abbreviation = 'NOR';

update country set iso_country = 'PL'
where abbreviation = 'POL';

update country set iso_country = 'ZA'
where abbreviation = 'SAF';

update country set iso_country = 'ES'
where abbreviation = 'ESP';

update country set iso_country = 'SE'
where abbreviation = 'SWE';

update country set iso_country = 'CH'
where abbreviation = 'SWI';

update country set iso_country = 'GB'
where abbreviation = 'UK';

update country set iso_country = 'US'
where abbreviation = 'USA';

update country set iso_country = 'AR'
where abbreviation = 'ARG';

update country set iso_country = 'CL'
where abbreviation = 'CHI';

update country set iso_country = 'GR'
where abbreviation = 'GCE';

update country set iso_country = 'HK'
where abbreviation = 'HKG';

update country set iso_country = 'IS'
where abbreviation = 'ICE';

update country set iso_country = 'ID'
where abbreviation = 'INS';

update country set iso_country = 'JP'
where abbreviation = 'JAP';

update country set iso_country = 'LV'
where abbreviation = 'LAT';

update country set iso_country = 'LU'
where abbreviation = 'LUX';

update country set iso_country = 'MY'
where abbreviation = 'MIA';

update country set iso_country = 'MX'
where abbreviation = 'MEX';

update country set iso_country = 'MA'
where abbreviation = 'MOR';

update country set iso_country = 'PT'
where abbreviation = 'POR';

update country set iso_country = 'SG'
where abbreviation = 'SIN';

update country set iso_country = 'TW'
where abbreviation = 'TAI';

update country set iso_country = 'TH'
where abbreviation = 'THA';

update country set iso_country = 'TR'
where abbreviation = 'TUR';

update country set iso_country = 'HR'
where abbreviation = 'CRO';

update country set iso_country = 'CZ'
where abbreviation = 'CZE';

update country set iso_country = 'EE'
where abbreviation = 'EST';

update country set iso_country = 'LT'
where abbreviation = 'LIT';

update country set iso_country = 'NZ'
where abbreviation = 'NZE';

update country set iso_country = 'RO'
where abbreviation = 'RUM';

update country set iso_country = 'RU'
where abbreviation = 'RIA';

update country set iso_country = 'SK'
where abbreviation = 'SVK';

update country set iso_country = 'SI'
where abbreviation = 'SLO';

update country set iso_country = 'BA'
where abbreviation = 'BOS';

update country set iso_country = 'PH'
where abbreviation = 'PHI';

update country set iso_country = 'NG'
where abbreviation = 'NIG';

update country set iso_country = 'DZ'
where abbreviation = 'ALG';

update country set iso_country = 'BR'
where abbreviation = 'BRA';

update country set iso_country = 'BG'
where abbreviation = 'BLG';

update country set iso_country = 'CN'
where abbreviation = 'CHN';

update country set iso_country = 'CO'
where abbreviation = 'COL';

update country set iso_country = 'CR'
where abbreviation = 'CRA';

update country set iso_country = 'EG'
where abbreviation = 'EGY';

update country set iso_country = 'SV'
where abbreviation = 'ELS';

update country set iso_country = 'GT'
where abbreviation = 'GUA';

update country set iso_country = 'IN'
where abbreviation = 'IND';

update country set iso_country = 'KW'
where abbreviation = 'KUW';

update country set iso_country = 'LB'
where abbreviation = 'LEB';

update country set iso_country = 'LI'
where abbreviation = 'LIE';

update country set iso_country = 'MT'
where abbreviation = 'MAL';

update country set iso_country = 'MC'
where abbreviation = 'MON';

update country set iso_country = 'PK'
where abbreviation = 'PAK';

update country set iso_country = 'PA'
where abbreviation = 'PAN';

update country set iso_country = 'PR'
where abbreviation = 'PRT';

update country set iso_country = 'BY'
where abbreviation = 'RBL';

update country set iso_country = 'SA'
where abbreviation = 'SAU';

update country set iso_country = 'TN'
where abbreviation = 'TUN';

update country set iso_country = 'AE'
where abbreviation = 'UAE';

update country set iso_country = 'UY'
where abbreviation = 'UGY';

update country set iso_country = 'UA'
where abbreviation = 'UKR';

update country set iso_country = 'VE'
where abbreviation = 'VEN';

update country set iso_country = 'YU'
where abbreviation = 'YUG';

update country set iso_country = 'HN'
where abbreviation = 'HON';

update country set iso_country = 'CY'
where abbreviation = 'CYP';

commit;

-- Following changes are as per the request of Kelly on 06/25/2002 at 14:33

drop table TRACE_AUDIT_HISTORY;

-- Following changes are as per the request of Kelly on 06/25/2002 at 14:33

drop table budget_audit_hist;

-- Following chnages are as per the request of Kelly on 07/01/2002 at 13:40

Alter table role_inst add constraint role_inst_uq1 
unique (role_template_id,rate_set_id)
using index tablespace tsmsmall_indx pctfree 20;




create or replace procedure temp_role_inst_update as 

rs_exist number(10);
rs_maxid number(10);
ri_maxid number(10);
countryid number(10);
ratesetid number(10);

cursor c1 is select id from client_div;

begin

select nvl(max(id),0)+1 into rs_maxid from rate_set;
select nvl(max(id),0)+1 into ri_maxid from role_inst;

select id into countryid from country where abbreviation = 'USA';


for ix1 in c1 loop

 select count(*) into rs_exist from rate_set where client_div_id = ix1.id;

 if rs_exist = 0 then

   Insert into rate_set(ID,NAME,CLIENT_DIV_ID,COUNTRY_ID,DEFAULT_FLG)
   values(rs_maxid,'Industry Standards',ix1.id,countryid,1);
   
   ratesetid:=rs_maxid;
   rs_maxid:=rs_maxid+1;

   	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,1,152,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,2,250,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,3,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,4,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,5,152,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,6,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,7,152,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,8,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,10,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,11,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,12,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,13,84,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,14,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,15,70,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,16,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,17,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,18,88,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,19,76,120,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,20,48,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,21,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,22,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,23,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,24,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,25,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,26,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,27,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,28,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,29,60,120,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,30,50,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,47,120,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,32,94,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,33,72,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,34,56,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,35,48,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,36,72,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,37,46,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,38,68,120,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,39,58,100,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,40,78,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,41,50,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,42,92,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,43,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,46,186,150,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,44,42,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,45,186,250,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;

	Insert into role_inst (ID,ROLE_TEMPLATE_ID,SALARY_RATE,CRO_RATE,
	RATE_SET_ID,ALIAS) values (ri_maxid,48,100,60,ratesetid,null);
	
        ri_maxid:=ri_maxid+1;
 end if;

end loop;

commit;

end;
/

exec temp_role_inst_update

-- Implemented in test1 and test2 database upto this point


-- Following changes are done as per the request of Nancy on 07/09/2002 at 12:53
-- This is for Picase ECR35 deleting budget

Alter table trial_budget add(delete_flg number(1) default 0 not null);

Alter table trial_budget add constraint tb_delete_flg_check check(
delete_flg in (0,1));

conn ft15/welcome

-- Following changes are as as per te verbal request of Jeff on 07/09/2002 at 14:51

CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
        end if;


   end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;


 If trim(:n.display_name) is null then
   :n.display_name:=initcap(:n.first_name)||' '||initcap(:n.last_name);
 end if;

Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');


end;
/
sho err

-- Following changes are as per the request of Kelly on 07/10/2002 at 15:50

conn tsm10/welcome

update role_to_task_template set calculation_name = 'NO_OP'  
where id=9;

update role_to_task_template set calculation_name = 'PA_ADMIN_GRANT_ADMIN'  
where id=10;

commit;

-- Following changes are as per the request of Kelly on 07/10/2002 at 16:12

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (598,34, 2, 'MM_VP_INVESTIGATOR_MEET');

Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values (599,34, 29, 'DM_SDC_INVESTIGATOR_MEET');

update role_to_task_template set calculation_name='NO_OP' where id=161;

commit;


-- Implemented in test1(tsm10t) upto this on 07/12/2002
-- Implemented in test(tsm10t) upto this on 07/12/2002

-- Following changes are as per the request of Kelly on 07/12/2002 at 14:30 

Create table User_Pref(
	ID number(10),
	ftuser_id number(10),
	app_type varchar2(50),  
	name  varchar2(50),
	value varchar2(50))
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table User_Pref add constraint User_Pref_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table User_Pref add constraint up_app_type_check 
	check (app_type in ('DASHBOARD', 'PICASE', 'TRACE'));

Alter table User_Pref add constraint User_Pref_fk1
	foreign key (ftuser_id) references 
	ftuser(id);

create sequence user_pref_seq;



Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'tree_pane_state',tree_pane_state from user_preferences;

Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'sort_type',sort_type from user_preferences;

Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'ta_filter',ta_filter from user_preferences;

Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'phase_filter',phase_filter from user_preferences;

Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'trial_filter',trial_filter from user_preferences;

Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'budget_filter',budget_filter from user_preferences;

Insert into user_pref select user_pref_seq.nextval,ftuser_id,'PICASE',
'show_warning',reset_warning from user_preferences;

commit;

-- Following changes are per the discussions with Kelly on 07/12/2002 at 15:50

conn ft15/welcome

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('DASHBOARD', 'PICASE', 'TRACE'));


conn tsm10/welcome 

-- Following changes are per the discussions with Kelly on 07/12/2002 at 15:50

Alter table audit_hist modify (COMMENTS varchar2(4000));


-- Following changes are as per the request of mmeyer on 07/15/2002 at 13:31

Alter table trial_budget add(DROPOUT_RATE_PCT NUMBER(12,2) default 0 not null);

-- Following changes are as per the request of Kelly on 07/17/2002 at 12:30
-- This is not yet implemented in devl, but need to be implemented.

drop table user_preferences;

-- Implemented in test1(tsm10t) database upto this point on 07/19/2002


-- Implemented in test2(tsm10t) database upto this point on 07/18/2002



-- Following changes are as per the request of Kelly on 07/19/2002 at 15:30


Alter table trace_estimate add(ivr_flg number(1) default 1 not null);

Alter table trace_estimate add constraint te_ivr_flg_check
check(ivr_flg in (0,1));


-- Following changes are as per the request of Kelly on 07/22/2002 at 9:25

create table temp_trace_estimate as select id,QUERY_PAGE_PCT from trace_estimate;
update trace_estimate set query_PAGE_PCT = null;
Alter table trace_estimate modify(QUERY_PAGE_PCT number(5,2));
update trace_estimate a set a.QUERY_PAGE_PCT = (select b.QUERY_PAGE_PCT
from temp_trace_estimate b where b.id=a.id);
commit;
drop table temp_trace_estimate;


-- Following changes are as per the request of Kelly on 07/24/2002 at 9:11 

Alter table rate_set add (fte_hours_month number(4,1) default 160 not null);

-- Implemented in test1(tsm10t) upto this on 07/26/2002

-- Implemented in test(tsm10t) upto this on 07/25/2002



-- Following changes are as per the request of Peter on 08/07/2002

update role_to_task_template set calculation_name = 'NO_OP' where ID = 11;
update role_to_task_template set calculation_name = 'MM_MGR_MMON' where ID = 12;

update role_to_task_template set calculation_name = 'NO_OP' where ID = 15;
update role_to_task_template set calculation_name = 'MM_MGR_REV_LAB' where ID = 16;

update role_to_task_template set calculation_name = 'NO_OP' where ID = 22;
update role_to_task_template set calculation_name = 'MM_MGR_INTERP_TEST' where ID = 23;

update role_to_task_template set calculation_name = 'NO_OP' where ID = 18;
update role_to_task_template set calculation_name = 'MM_MGR_REV_OTHER_TEST' where ID = 19;
update role_to_task_template set calculation_name = 'STAT_STAT_PLAN' where ID = 248;
update role_to_task_template set calculation_name = 'STAT_SRSTAT_ANALYSIS' where ID = 257;

insert into task_template (ID, NAME, SEQUENCE, TASK_GROUP_TEMPLATE_ID, 
START_MILESTONE_TEMPLATE_ID, END_MILESTONE_TEMPLATE_ID) 
VALUES(122, 'QueryResolution', 12, 4, 2, 6);

insert into task_template (ID, NAME, SEQUENCE, TASK_GROUP_TEMPLATE_ID, 
START_MILESTONE_TEMPLATE_ID, END_MILESTONE_TEMPLATE_ID) 
VALUES(123, 'DocumentCollection', 3, 1, 1, 5);

update task_template set sequence = 13 where id = 38;
update task_template set sequence = 14 where id = 91;
update task_template set sequence = 15 where id = 92;
update task_template set sequence = 16 where id = 93;
update task_template set sequence = 17 where id = 94;
update task_template set sequence = 18 where id = 95;
update task_template set sequence = 19 where id = 96;
update task_template set sequence = 20 where id = 97;


update task_template set sequence = 4 where id = 71;
update task_template set sequence = 5 where id = 72;
update task_template set sequence = 6 where id = 73;
update task_template set sequence = 7 where id = 74;
update task_template set sequence = 8 where id = 75;
update task_template set sequence = 9 where id = 76;

insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (600, 122, 20, 'CO_CRA_QUERY_RES');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (601, 122, 4, 'NO_OP');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (602, 122, 12, 'NO_OP');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (603, 122, 43, 'NO_OP');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (604, 123, 1, 'NO_OP');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (605, 123, 11, 'NO_OP');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (606, 123, 19, 'NO_OP');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (607, 123, 20, 'PA_CRA_DOC_COLLECT');
insert into role_to_task_template (ID, TASK_TEMPLATE_ID, ROLE_TEMPLATE_ID, CALCULATION_NAME) 
values (608, 123, 21, 'NO_OP');


commit;

-- Implemented in test1(tsm10t) database upto this point on 08/08/2002

-- *******************************************************************
-- Implemented in test2(tsm10t) database upto this point on 08/08/2002

-- *******************************************************************

-- Followinf changes were done to the development database to support multiple schemas
-- and need to be done manually

create user tsm10t identified by welcome default tablespace
tsmsmall temporary tablespace temp;

create user ft15t identified by welcome default tablespace
ftsmall temporary tablespace temp;

create user ftcommon identified by welcome default tablespace
tsmsmall temporary tablespace temp;

grant connect,resource to tsm10t;

grant connect,resource to ft15t;

grant connect,resource to ftcommon;


-- Then copied the ft15,tsm10 schemas to ft15t,tsm10t schemas

conn ft15/welcome

grant select on ft15.ftuser to ftcommon;
grant select on ft15.ftgroup to ftcommon;
grant select on ft15.ftuser_to_ftgroup to ftcommon;

connft15t/welcome

grant select on ft15t.ftuser to ftcommon;
grant select on ft15t.ftgroup to ftcommon;
grant select on ft15t.ftuser_to_ftgroup to ftcommon;

conn ftcommon/welcome

create or replace view ftuser as select 
ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,'tsm10' environment from ft15.ftuser
union all select 
ID,NAME||'@tsm10t' name,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,'tsm10t' from ft15t.ftuser;

create or replace view ftgroup as select
id, name,'tsm10' environment from ft15.ftgroup
union all select 
id, name,'tsm10t' from ft15t.ftgroup;


create or replace view ftuser_to_ftgroup as select
id,ftuser_id,ftgroup_id,'tsm10' environment from 
ft15.ftuser_to_ftgroup 
union all select
id,ftuser_id,ftgroup_id,'tsm10t' from 
ft15t.ftuser_to_ftgroup ;


-- Following chnages are as per the request of Joel on 08/20/2002


Alter table picase_trial add(study_duration_id number(10),
			     inpatient_status_id number(10));

Alter table picase_trial add constraint PICASE_TRIAL_FK6 
	foreign key (study_duration_id) references ip_business_factors(id);
Alter table picase_trial add constraint PICASE_TRIAL_FK7 
	foreign key (inpatient_status_id) references ip_business_factors(id);

Alter table picase_trial drop constraint pt_budget_type_check;
Alter table picase_trial add constraint pt_budget_type_check
	check(budget_type in 
	('Industry Cost', 'Per Patient Budget','Per Visit Budget','Modeled Budget'));

Alter table trial_budget add(cpp_modeled  NUMBER(10),
			     use_modeled_price number(1) default 0 not null);
Alter table trial_budget add constraint tb_use_modeled_price_check
	check(use_modeled_price in (0,1));
			     

Alter table client_div drop constraint cd_def_budget_type_check;
Alter table client_div add constraint cd_def_budget_type_check
	check( def_budget_type in 
	('Industry Cost','Per Patient Budget','Per Visit Budget','Modeled Budget'));



-- Implemented in test(tsm10t and tsm10 both) upto this on 08/22/2002
-- Implemented in test1(tsm10,tsm10e) upto this on 08/22/2002
-- Implemented in prod(tsm10,tsm10d) upto this on 08/29/2002


-- *******************************************************************
-- Implemented in test1tsm10d,tsm10b) upto this on 08/22/2002
-- *******************************************************************



-- *******************************************************************
-- *******************************************************************
-- Implemented in prod(tsm10b,tsm10e) upto this on 08/29/2002
-- *******************************************************************
-- *******************************************************************

-- Following changes are as per the request of Phil on 08/29/2002 at 17:45

Alter table trial_budget add(
	modeled_odc_pct number(12,2),
	modeled_oh_pct number(12,2),
	modeled_odc_pct_range varchar2(40),   
	modeled_oh_type varchar2(40));

Alter table trial_budget add constraint tb_modeled_odc_pct_range_check
check (modeled_odc_pct_range in ('Modelled', 'Manual'));

Alter table trial_budget add constraint tb_modeled_oh_type_check
check (modeled_oh_type in ('Modelled', 'Manual'));

-- Following chnages are as per the request of Colin on 09/03/2002 at 12:45

create table modelled_coeff (
	id number (10),
	country_id number (10) not null,
	coeff_type varchar2(7) not null,
	coeff_value varchar2(20),
	cross_coeff_type varchar2(7),
	cross_coeff_value varchar2(20),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table modelled_coeff add constraint modelled_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

Alter table modelled_coeff add constraint modelled_coeff_FK1
	foreign key (COUNTRY_ID) references country(id);


create sequence modelled_coeff_seq;

-- Following chnages are as per the request of Colin on 09/04/2002 at 10:20 am

Create table md_odc_oh_pct
	(id number (10),
	country_id number (10) not null, 
	ta_id number(10) not null, 
	oh_pct number(7,2) ,
	odc_pct number(7,2))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_PK 
	primary key(ID) using index tablespace tsmsmall_indx 
	pctfree 20 ;

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table MD_ODC_OH_PCT add constraint MD_ODC_OH_PCT_FK2
	foreign key (TA_ID) references indmap(id);

create sequence md_odc_oh_pct_seq;

-- Following chnages are as per the request of Colin on 09/11/2002 at 10:30am

Update ip_business_factors set num_days = 14 where type = 'Ph2+dur' and 
	short_desc like '%1-3 weeks%';
Update ip_business_factors set num_days = 39 where type = 'Ph2+dur' and 
	short_desc like '%4-7 weeks%';
Update ip_business_factors set num_days = 67 where type = 'Ph2+dur' and 
	short_desc like '%8-11 weeks%';
Update ip_business_factors set num_days = 112 where type = 'Ph2+dur' and 
	short_desc like '%12-20 weeks%';
Update ip_business_factors set num_days = 161 where type = 'Ph2+dur' and 
	short_desc like '%21-25 weeks%';
Update ip_business_factors set num_days = 203 where type = 'Ph2+dur' and 
	short_desc like '%26-32 weeks%';
Update ip_business_factors set num_days = 256 where type = 'Ph2+dur' and 
	short_desc like '%33-40 weeks%';
Update ip_business_factors set num_days = 298 where type = 'Ph2+dur' and 
	short_desc like '%41-44 weeks%';
Update ip_business_factors set num_days = 340 where type = 'Ph2+dur' and 
	short_desc like '%45-52 weeks%';
Update ip_business_factors set num_days = 389 where type = 'Ph2+dur' and 
	short_desc like '%53-58 weeks%';
Update ip_business_factors set num_days = 548 where type = 'Ph2+dur' and 
	short_desc like '%1-2 years%';
Update ip_business_factors set num_days = 913 where type = 'Ph2+dur' and 
	short_desc like '%2-3 years%';
Update ip_business_factors set num_days = 1095 where type = 'Ph2+dur' and 
	short_desc like '%>3 years%';
commit;


-- Following chnages are as per the request of Kelly on 09/11/2002 at 4:09 pm


conn tsm10/welcome

grant select on client_div to ftcommon;
grant select on CLIENT_DIV_TO_LIC_APP to ftcommon;
grant select on ftuser_to_client_group to ftcommon;

conn tsm10t/welcome

grant select on client_div to ftcommon;
grant select on CLIENT_DIV_TO_LIC_APP to ftcommon;
grant select on ftuser_to_client_group to ftcommon;

conn tsm10k/welcome

grant select on client_div to ftcommon;
grant select on CLIENT_DIV_TO_LIC_APP to ftcommon;
grant select on ftuser_to_client_group to ftcommon;


conn ftcommon/welcome

create or replace view client_div as select
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,'tsm10' environment from tsm10.client_div
union all select 
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,'tsm10t' from tsm10t.client_div
union all select 
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,'tsm10k' from tsm10k.client_div;

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP
union all select 
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,'tsm10t' from tsm10t.CLIENT_DIV_TO_LIC_APP
union all select 
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,'tsm10k' from tsm10k.CLIENT_DIV_TO_LIC_APP;

create or replace view ftuser_to_client_group as select
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10' environment from tsm10.ftuser_to_client_group
union all select 
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10t' from tsm10t.ftuser_to_client_group
union all select 
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10k' from tsm10k.ftuser_to_client_group;


-- Implemented in test(tsm10e) upto this on 09/12/2002


-- Following chnages are as per the request of Kelly on 09/13/2002 at 11am


Alter table client_div_to_lic_app add(version varchar2(30));
update client_div_to_lic_app set version = 'v1';
Alter table client_div_to_lic_app modify (version not null);

-- Following chnages are as per the request of Kelly on 09/16/2002 at 11:45am

conn ftcommon/welcome@......

create table application(
	id number(10),
	app_name varchar2(50),
	external_name varchar2(80),
	short_desc varchar2(128))
	tablespace tsmsmall
	pctused 80 pctfree 10;

create sequence application_seq;

Alter table application add constraint application_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 10;

Alter table application add constraint application_app_name_check check(
	app_name in ('DASHBOARD', 'PICASE', 'TRACE'));

Insert into application values
(application_seq.nextval,'TRACE','TrialSpace Resource and Cost Estimator',null);
Insert into application values
(application_seq.nextval,'PICASE','TrialSpace Grants Manager',null);

commit;	

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP
union all select 
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,'tsm10t' from tsm10t.CLIENT_DIV_TO_LIC_APP
union all select 
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,'tsm10k' from tsm10k.CLIENT_DIV_TO_LIC_APP;


-- Following chnages are as per the request opf Kelly on 09/17/2002 at 8:30 am

update task_template set start_milestone_template_id=5 where 
start_milestone_template_id=4 and end_milestone_template_id=6;
commit;


-- Implemented in test(tsm10e) upto this on 09/19/2002
-- Implemented in prev(tsm10p,tsm10e) upto this on 09/20/2002



create table modelled_inclusion (
	id number (10),
 	coeff_type varchar2(7) not null,
	coeff_value varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table modelled_inclusion add constraint modelled_inclusion_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence modelled_inclusion_seq;

Create table modelled_upfence(
	id number(10),
	country_id number(10) not null,
	ta_id number(10) not null,
	upfence number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table modelled_upfence add constraint modelled_upfence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence modelled_upfence_seq;

Alter table modelled_upfence add constraint modelled_upfence_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table modelled_upfence add constraint modelled_upfence_FK2
	foreign key (TA_ID) references indmap(id);

Create table modelled_standardize(
	id number(10),
	country_id number(10), 
	type varchar2(10) not null,
	patient number(10) not null,
	duration number(20,12) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table modelled_standardize add constraint modelled_standardize_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence modelled_standardize_seq;

Alter table modelled_standardize add constraint modelled_standardize_FK1
	foreign key (COUNTRY_ID) references country(id);

Alter table modelled_standardize add constraint ms_type_check check(
	type in ('LOCATION','SCALE','ADD','MULT','N'));

-- Implemented in test(tsm10e) upto this on 09/26/2002
-- Implemented in prev(tsm10p,tsm10e) upto this on 09/27/2002
-- Implemented in prod(tsm10) upto this on 09/27/2002

-- *******************************************************************
-- *******************************************************************
-- Implemented in prod(tsm10d) upto this on 09/28/2002
-- *******************************************************************
-- *******************************************************************


-- Following chnages are as per the request of Kelly on 09/30/2002 at 2:20 pm

update task_template set start_milestone_template_id=5, end_milestone_template_id=6  
WHERE start_milestone_template_id=6 AND end_milestone_template_id=7;

-- (rows affected are 52,82,101,102,105,106,109,117)

commit;

-- Following chnages are as per the request of Kelly on 10/02/2002 at 10:00 am

update task_template set start_milestone_template_id=6, end_milestone_template_id=7 
where id in (82,102,106,109,117);
commit;

-- Following chnages are as per the request of Kelly on 10/02/2002 at 17:15 am

update task_template set end_milestone_template_id=7 where id=62;

commit;

update task_template set start_milestone_template_id=6, end_milestone_template_id=7 
where id in (52);
commit;

-- Following chnages are done by DB on 10/04/2002 at 8:30 am

create table id_control(
	table_owner varchar2(40),
	table_name varchar2(40),
	next_id number(10) not null)
	tablespace tsmsmall
	pctused 80 pctfree 10;

Alter table id_control add constraint id_control_pk
	primary key (table_owner,table_name) using index tablespace
	tsmsmall_indx pctfree 10;

Alter table id_control add constraint id_control_uq1
	unique (table_name) using index tablespace 
	tsmsmall_indx pctfree 10;


Insert into id_control select 'ft15', 'aclentries', nvl(max(id),0)+1 from ACLENTRIES ;
Insert into id_control select 'tsm10', 'add_study', nvl(max(id),0)+1 from ADD_STUDY ;
Insert into id_control select 'tsm10', 'affiliation_factor', nvl(max(id),0)+1 from AFFILIATION_FACTOR ;
Insert into id_control select 'tsm10', 'audit_hist', nvl(max(id),0)+1 from AUDIT_HIST ;
Insert into id_control select 'tsm10', 'budget_group_permission', nvl(max(id),0)+1 from BUDGET_GROUP_PERMISSION ;
Insert into id_control select 'tsm10', 'budget_user_permission', nvl(max(id),0)+1 from BUDGET_USER_PERMISSION ;
Insert into id_control select 'tsm10', 'build_code', nvl(max(id),0)+1 from BUILD_CODE ;
Insert into id_control select 'tsm10', 'build_tag', nvl(max(id),0)+1 from BUILD_TAG ;
Insert into id_control select 'tsm10', 'build_tag_to_client_div', nvl(max(id),0)+1 from BUILD_TAG_TO_CLIENT_DIV ;
Insert into id_control select 'ft15', 'client', nvl(max(id),0)+1 from CLIENT ;
Insert into id_control select 'tsm10', 'client_currency_cnv', nvl(max(id),0)+1 from CLIENT_CURRENCY_CNV ;
Insert into id_control select 'tsm10', 'client_div', nvl(max(id),0)+1 from CLIENT_DIV ;
Insert into id_control select 'tsm10', 'client_div_to_build_code', nvl(max(id),0)+1 from CLIENT_DIV_TO_BUILD_CODE ;
Insert into id_control select 'tsm10', 'client_div_to_lic_app', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_APP ;
Insert into id_control select 'tsm10', 'client_div_to_lic_country', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_COUNTRY ;
Insert into id_control select 'tsm10', 'client_div_to_lic_indmap', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_INDMAP ;
Insert into id_control select 'tsm10', 'client_div_to_lic_phase', nvl(max(id),0)+1 from CLIENT_DIV_TO_LIC_PHASE ;
Insert into id_control select 'tsm10', 'client_group', nvl(max(id),0)+1 from CLIENT_GROUP ;
Insert into id_control select 'tsm10', 'cost_item', nvl(max(id),0)+1 from COST_ITEM ;
Insert into id_control select 'tsm10', 'country', nvl(max(id),0)+1 from COUNTRY ;
Insert into id_control select 'tsm10', 'currency', nvl(max(id),0)+1 from CURRENCY ;
Insert into id_control select 'tsm10', 'custom_set', nvl(max(id),0)+1 from CUSTOM_SET ;
Insert into id_control select 'tsm10', 'custom_set_item', nvl(max(id),0)+1 from CUSTOM_SET_ITEM ;
Insert into id_control select 'tsm10', 'def_publish_groups', nvl(max(id),0)+1 from DEF_PUBLISH_GROUPS ;
Insert into id_control select 'tsm10', 'drug_class', nvl(max(id),0)+1 from DRUG_CLASS ;
Insert into id_control select 'tsm10', 'drug_code', nvl(max(id),0)+1 from DRUG_CODE ;
Insert into id_control select 'ft15', 'ftgroup', nvl(max(id),0)+1 from FTGROUP ;
Insert into id_control select 'ft15', 'ftgroup_to_aclentries', nvl(max(id),0)+1 from FTGROUP_TO_ACLENTRIES ;
Insert into id_control select 'ft15', 'ftuser', nvl(max(id),0)+1 from FTUSER ;
Insert into id_control select 'ft15', 'ftuser_to_aclentries', nvl(max(id),0)+1 from FTUSER_TO_ACLENTRIES ;
Insert into id_control select 'tsm10', 'ftuser_to_client_group', nvl(max(id),0)+1 from FTUSER_TO_CLIENT_GROUP ;
Insert into id_control select 'ft15', 'ftuser_to_ftgroup', nvl(max(id),0)+1 from FTUSER_TO_FTGROUP ;
Insert into id_control select 'ft15', 'ft_foreign_key_info', nvl(max(id),0)+1 from FT_FOREIGN_KEY_INFO ;
Insert into id_control select 'tsm10', 'indmap', nvl(max(id),0)+1 from INDMAP ;
Insert into id_control select 'tsm10', 'institution', nvl(max(id),0)+1 from INSTITUTION ;
Insert into id_control select 'tsm10', 'investig', nvl(max(id),0)+1 from INVESTIG ;
Insert into id_control select 'tsm10', 'ip_business_factors', nvl(max(id),0)+1 from IP_BUSINESS_FACTORS ;
Insert into id_control select 'tsm10', 'ip_cpp', nvl(max(id),0)+1 from IP_CPP ;
Insert into id_control select 'tsm10', 'ip_duration', nvl(max(id),0)+1 from IP_DURATION ;
Insert into id_control select 'tsm10', 'ip_duration_factor', nvl(max(id),0)+1 from IP_DURATION_FACTOR ;
Insert into id_control select 'tsm10', 'ip_session', nvl(max(id),0)+1 from IP_SESSION ;
Insert into id_control select 'tsm10', 'ip_weight', nvl(max(id),0)+1 from IP_WEIGHT ;
Insert into id_control select 'tsm10', 'local_to_euro', nvl(max(id),0)+1 from LOCAL_TO_EURO ;
Insert into id_control select 'tsm10', 'location_set', nvl(max(id),0)+1 from LOCATION_SET ;
Insert into id_control select 'tsm10', 'location_set_item', nvl(max(id),0)+1 from LOCATION_SET_ITEM ;
Insert into id_control select 'tsm10', 'mapper', nvl(max(id),0)+1 from MAPPER ;
Insert into id_control select 'tsm10', 'md_odc_oh_pct', nvl(max(id),0)+1 from MD_ODC_OH_PCT ;
Insert into id_control select 'tsm10', 'medicare', nvl(max(id),0)+1 from MEDICARE ;
Insert into id_control select 'tsm10', 'milestone_inst', nvl(max(id),0)+1 from MILESTONE_INST ;
Insert into id_control select 'tsm10', 'milestone_template', nvl(max(id),0)+1 from MILESTONE_TEMPLATE ;
Insert into id_control select 'tsm10', 'modelled_coeff', nvl(max(id),0)+1 from MODELLED_COEFF ;
Insert into id_control select 'tsm10', 'modelled_inclusion', nvl(max(id),0)+1 from MODELLED_INCLUSION ;
Insert into id_control select 'tsm10', 'modelled_standardize', nvl(max(id),0)+1 from MODELLED_STANDARDIZE ;
Insert into id_control select 'tsm10', 'modelled_upfence', nvl(max(id),0)+1 from MODELLED_UPFENCE ;
Insert into id_control select 'tsm10', 'odc_def', nvl(max(id),0)+1 from ODC_DEF ;
Insert into id_control select 'tsm10', 'pap_euro_overhead', nvl(max(id),0)+1 from PAP_EURO_OVERHEAD ;
Insert into id_control select 'tsm10', 'pap_odc_pct', nvl(max(id),0)+1 from PAP_ODC_PCT ;
Insert into id_control select 'tsm10', 'pap_odc_pct_to_indmap', nvl(max(id),0)+1 from PAP_ODC_PCT_TO_INDMAP ;
Insert into id_control select 'tsm10', 'payments', nvl(max(id),0)+1 from PAYMENTS ;
Insert into id_control select 'tsm10', 'phase', nvl(max(id),0)+1 from PHASE ;
Insert into id_control select 'tsm10', 'picas_visit', nvl(max(id),0)+1 from PICAS_VISIT ;
Insert into id_control select 'tsm10', 'picas_visit_set', nvl(max(id),0)+1 from PICAS_VISIT_SET ;
Insert into id_control select 'tsm10', 'picas_visit_set_item', nvl(max(id),0)+1 from PICAS_VISIT_SET_ITEM ;
Insert into id_control select 'tsm10', 'picas_visit_to_cost_item', nvl(max(id),0)+1 from PICAS_VISIT_TO_COST_ITEM ;
Insert into id_control select 'tsm10', 'price_level', nvl(max(id),0)+1 from PRICE_LEVEL ;
Insert into id_control select 'tsm10', 'procedure_def', nvl(max(id),0)+1 from PROCEDURE_DEF ;
Insert into id_control select 'tsm10', 'procedure_to_protocol', nvl(max(id),0)+1 from PROCEDURE_TO_PROTOCOL ;
Insert into id_control select 'tsm10', 'project', nvl(max(id),0)+1 from PROJECT ;
Insert into id_control select 'tsm10', 'project_area', nvl(max(id),0)+1 from PROJECT_AREA ;
Insert into id_control select 'tsm10', 'project_phase', nvl(max(id),0)+1 from PROJECT_PHASE ;
Insert into id_control select 'tsm10', 'protocol', nvl(max(id),0)+1 from PROTOCOL ;
Insert into id_control select 'tsm10', 'protocol_to_indmap', nvl(max(id),0)+1 from PROTOCOL_TO_INDMAP ;
Insert into id_control select 'ft15', 'protocol_version', nvl(max(id),0)+1 from PROTOCOL_VERSION ;
Insert into id_control select 'tsm10', 'rate_set', nvl(max(id),0)+1 from RATE_SET ;
Insert into id_control select 'tsm10', 'region', nvl(max(id),0)+1 from REGION ;
Insert into id_control select 'tsm10', 'report_template', nvl(max(id),0)+1 from REPORT_TEMPLATE ;
Insert into id_control select 'tsm10', 'role_inst', nvl(max(id),0)+1 from ROLE_INST ;
Insert into id_control select 'tsm10', 'role_inst_to_task_inst', nvl(max(id),0)+1 from ROLE_INST_TO_TASK_INST ;
Insert into id_control select 'tsm10', 'role_template', nvl(max(id),0)+1 from ROLE_TEMPLATE ;
Insert into id_control select 'tsm10', 'role_to_task_template', nvl(max(id),0)+1 from ROLE_TO_TASK_TEMPLATE ;
Insert into id_control select 'tsm10', 'specificity', nvl(max(id),0)+1 from SPECIFICITY ;
Insert into id_control select 'ft15', 'sponsor', nvl(max(id),0)+1 from SPONSOR ;
Insert into id_control select 'tsm10', 'task_group_inst', nvl(max(id),0)+1 from TASK_GROUP_INST ;
Insert into id_control select 'tsm10', 'task_group_template', nvl(max(id),0)+1 from TASK_GROUP_TEMPLATE ;
Insert into id_control select 'tsm10', 'task_inst', nvl(max(id),0)+1 from TASK_INST ;
Insert into id_control select 'tsm10', 'task_template', nvl(max(id),0)+1 from TASK_TEMPLATE ;
Insert into id_control select 'tsm10', 'temp_inst_to_company', nvl(max(id),0)+1 from TEMP_INST_TO_COMPANY ;
Insert into id_control select 'tsm10', 'temp_ip_study_price', nvl(max(id),0)+1 from TEMP_IP_STUDY_PRICE ;
Insert into id_control select 'tsm10', 'temp_odc', nvl(max(id),0)+1 from TEMP_ODC ;
Insert into id_control select 'tsm10', 'temp_overhead', nvl(max(id),0)+1 from TEMP_OVERHEAD ;
Insert into id_control select 'tsm10', 'temp_procedure', nvl(max(id),0)+1 from TEMP_PROCEDURE ;
Insert into id_control select 'tsm10', 'trace_estimate', nvl(max(id),0)+1 from TRACE_ESTIMATE ;
Insert into id_control select 'tsm10', 'trace_user_prefs', nvl(max(id),0)+1 from TRACE_USER_PREFS ;
Insert into id_control select 'ft15', 'trial', nvl(max(id),0)+1 from TRIAL ;
Insert into id_control select 'tsm10', 'trial_budget', nvl(max(id),0)+1 from TRIAL_BUDGET ;
Insert into id_control select 'ft15', 'trial_metrics_history', nvl(max(id),0)+1 from TRIAL_METRICS_HISTORY ;
Insert into id_control select 'tsm10', 'tsm_message', nvl(max(id),0)+1 from TSM_MESSAGE ;
Insert into id_control select 'tsm10', 'tsm_trial_rollup', nvl(max(id),0)+1 from TSM_TRIAL_ROLLUP ;
Insert into id_control select 'tsm10', 'umbrella_orgs', nvl(max(id),0)+1 from UMBRELLA_ORGS ;
Insert into id_control select 'tsm10', 'unlisted_procedure', nvl(max(id),0)+1 from UNLISTED_PROCEDURE ;
Insert into id_control select 'ft15', 'usage_history', nvl(max(id),0)+1 from USAGE_HISTORY ;
Insert into id_control select 'tsm10', 'user_pref', nvl(max(id),0)+1 from USER_PREF ;
Insert into id_control select 'tsm10', 'working_trial', nvl(max(id),0)+1 from WORKING_TRIAL ;

commit;



create or replace function Increment_sequence (seq_name in varchar2,
increment_by in number default 1)  return number is
pragma autonomous_transaction;

start_value number(10);

begin

select next_id into start_value from id_control where 
table_name = lower(substr(seq_name,1,length(seq_name)-4))
for update;

update id_control set next_id = next_id+increment_by where 
table_name = lower(substr(seq_name,1,length(seq_name)-4));

commit;
return(start_value);

end;
/

-- Following chnages are related to proc code changes on 10/04/2002 at 9:30 am

Insert into odc_def select odc_def_seq.nextval,CPT_CODE,LONG_DESC,
OBSOLETE_FLG,OBSOLETE_DATE,PROCEDURE_LEVEL,ADDED_IN_BUILD_ID,1
from procedure_def where cpt_code in ('#6002','#6003','#6004');

/* use a pl/sql cursor to do this and do it in all all mapper_tables. */

/* did the mapper_seq.currval from dual */

--Insert into mapper values (mapper_seq.nextval,86,null);
--Insert into mapper values (mapper_seq.nextval,87,null);
--Insert into mapper values (mapper_seq.nextval,88,null);




delete from mapper where procedure_def_id in (select id from procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));
delete from TSM10_PKD_2.MAPPER where procedure_def_id in (select id from procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));
delete from TSM10_PKD_1.MAPPER where procedure_def_id in (select id from procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));
delete from TSM10_CLIENT0.MAPPER where procedure_def_id in (select id from procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));
delete from TSMCLIENT_PKD_4.MAPPER where procedure_def_id in (select id from procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));
delete from TSM10_HMR_2.MAPPER where procedure_def_id in (select id from procedure_def 
	where cpt_code in ('#6002','#6003','#6004'));


delete from procedure_def where cpt_code = '#6002';
delete from procedure_def where cpt_code = '#6003';
delete from procedure_def where cpt_code = '#6004';


-- Implemented in prev(tsm10p,tsm10e) upto this on 10/04/2002

-- Implemented in test(tsm10e) upto this on 10/04/2002


-- Following chnages are as per the request of Phil on 10/08/2002 at 15:57

aLTER TABLE TRIAL_BUDGET DROP CONSTRAINT TB_OVHD_PCT_RANGE_CHECK;

aLTER TABLE TRIAL_BUDGET ADD CONSTRAINT TB_OVHD_PCT_RANGE_CHECK
CHECK (OVERHEAD_PCT_RANGE IN ('Low','Med','High','Co_Med','Custom'));

-- Following chnages are as per the request of Kelly on 10/10/2002 at 13:00 hrs

drop sequence currency_seq;
drop sequence odc_def_seq;
drop sequence Institution_seq;
drop sequence region_seq;
drop sequence procedure_def_seq;
drop sequence IP_Business_factors_seq;
drop sequence IP_cpp_seq;
drop sequence IP_weight_seq;
drop sequence IP_duration_seq;
drop sequence PAP_euro_overhead_seq;
drop sequence Affiliation_factor_seq;
drop sequence IP_duration_factor_seq;
drop sequence Phase_seq; 
drop sequence Country_seq;
drop sequence build_tag_seq;
drop sequence client_div_seq;
drop sequence client_group_seq;
drop sequence client_div_to_lic_country_seq;
drop sequence client_currency_cnv_seq;
drop sequence custom_set_seq;
drop sequence def_publish_groups_seq;
drop sequence location_set_seq;
drop sequence location_set_item_seq;
drop sequence project_area_seq;
drop sequence project_seq;
drop sequence trial_budget_seq;
drop sequence tsm_message_seq;
drop sequence umbrella_orgs_seq;
drop sequence unlisted_procedure_seq;
drop sequence ftuser_to_client_group_seq;
drop sequence budget_group_permission_seq;
drop sequence budget_user_permission_seq;
drop sequence custom_set_item_seq;
drop sequence picas_visit_seq;
drop sequence cost_item_seq;
drop sequence protocol_seq;
drop sequence protocol_to_indmap_seq;
drop sequence Investig_seq;
drop sequence medicare_seq;
drop sequence pap_odc_pct_seq;
drop sequence payments_seq;
drop sequence procedure_to_protocol_Seq;
drop sequence picas_visit_to_cost_item_seq;
drop sequence ip_session_seq;
drop sequence pap_odc_pct_to_indmap_seq;
drop sequence local_to_euro_seq;
drop sequence tsm_trial_rollup_seq;
drop sequence client_div_to_lic_phase_seq;
drop sequence client_div_to_lic_indmap_seq;
drop sequence client_div_to_build_code_seq;
drop sequence build_code_seq;
drop sequence picas_visit_set_seq;
drop sequence picas_visit_set_item_seq;
drop sequence working_trial_seq;
drop sequence specificity_seq;
drop sequence audit_hist_seq;
drop sequence client_div_to_lic_app_seq;
drop sequence user_pref_seq;
drop sequence report_template_seq;

drop sequence drug_class_seq;
drop sequence drug_code_seq;
drop sequence milestone_template_seq;
drop sequence milestone_inst_seq;
drop sequence project_phase_seq;
drop sequence rate_set_seq;
drop sequence role_template_seq;
drop sequence role_inst_seq;
drop sequence role_inst_to_task_inst_seq;
drop sequence task_group_template_seq;
drop sequence task_group_inst_seq;
drop sequence task_inst_seq;
drop sequence task_template_seq;
drop sequence role_to_task_template_seq;
drop sequence trace_estimate_seq;
drop sequence trace_audit_history_seq;
drop sequence trace_user_prefs_seq;

Drop synonym usage_history_seq;
Drop synonym trial_metrics_history_seq;
Drop synonym trial_seq;
Drop synonym ftuser_seq;
Drop synonym ftuser_to_ftgroup_seq;


conn ft15/welcome

revoke select on usage_history_seq from tsm10;
revoke select on trial_metrics_history_seq from tsm10;
revoke select on trial_seq from tsm10;
revoke select on ftuser_seq from tsm10;
revoke select on ftuser_to_ftgroup_seq from tsm10;

conn tsm10/welcome@...

-- Implemented in test(tsm10) upto this on 10/10/2002


-- Following chnages are done by debashish on 10/11/2002 at noon


create or replace procedure CreateTsmMessage(ClientDivId in number,
	msg_hdr in varchar2,msg_txt in varchar2) as

admin_userid number(10);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack';

  Insert into tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
  MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select increment_sequence('tsm_message_seq',1),
  msg_txt,admin_userid,id,sysdate,0,0,msg_hdr from ftuser where client_div_id = ClientDivId;

 commit;
end;
/
sho err


create or replace procedure LicenseWarning as

  cursor c1 is select client_div_id from client_div_to_lic_app where 
        license_exp_date <= sysdate+6 and license_exp_date > sysdate+2 and
        app_name = 'PICASE' ;
  cursor c2 is select client_div_id from client_div_to_lic_app where 
	license_exp_date <= sysdate+2 and license_exp_date > sysdate+1 and
	app_name = 'PICASE' ;

  client_admin_users number(10);
  admin_userid number(10);
  message_exist number(10);
  msg_txt1 varchar2(100);
  msg_txt2 varchar2(100);
  msg_txt3 varchar2(100);
  lic_exp_dt varchar2(40);
  msg_hdr varchar2(40):= 'License Warning';
  msg_txt varchar2(256);

begin

  select id into admin_userid from ftuser where name = 'ftadmin@fasttrack'; 

  msg_txt1:='Your PICAS-e contract will expire on ';
  msg_txt2:='. You will not be able to access the system after this date. ';
  msg_txt3:='Please contact your Fast Track representative if needed.  Thank you.';

  for ix1 in c1 loop
 
    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
    c.name = 'Client Admin' ;

    select to_char(license_exp_date,'YYYY-MM-DD') into 
    lic_exp_dt from client_div_to_lic_app where client_div_id = ix1.client_div_id 
    and app_name = 'PICASE';

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and
      addressee_ftuser_id in (select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
      c.name = 'Client Admin'); 
    
      If message_exist = 0 then 

        Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
        MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select increment_sequence('tsm_message_seq',1),
        msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
        where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix1.client_div_id and 
        c.name = 'Client Admin' ;

      end if;
    end if;
  End loop;

  for ix2 in c2 loop

    select count(*) into client_admin_users from ftuser a, ftuser_to_ftgroup b, ftgroup c
    where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
    c.name = 'Client Admin' ;


      select to_char(license_exp_date,'YYYY-MM-DD') into 
      lic_exp_dt from client_div_to_lic_app where client_div_id = ix2.client_div_id 
      and app_name = 'PICASE';

    If client_admin_users > 0  then

      msg_txt:=msg_txt1||lic_exp_dt||msg_txt2||msg_txt3;

      select count(*) into message_exist from tsm_message where message_date between
      sysdate-7 and sysdate  and message_header = 'License Warning' and seen_flg = 0 and
      addressee_ftuser_id in ( select a.id from ftuser a, ftuser_to_ftgroup b, ftgroup c
      where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
      c.name = 'Client Admin') ;    

      If message_exist = 0 then 

         Insert into  tsm_message (ID,MESSAGE_TEXT,CREATOR_FTUSER_ID,ADDRESSEE_FTUSER_ID,
         MESSAGE_DATE,DISMISSED_FLG,SEEN_FLG,MESSAGE_HEADER) select increment_sequence('tsm_message_seq',1),
         msg_txt,admin_userid,a.id,sysdate,0,0,msg_hdr from ftuser a, ftuser_to_ftgroup b, ftgroup c
         where a.id = b.ftuser_id and b.ftgroup_id = c.id and a.client_div_id =  ix2.client_div_id and 
         c.name = 'Client Admin' ;

      End if;
    End if;

  End loop;

 commit;
end;
/


-- Implemented in test(tsm10) upto this on 10/11/2002
-- Implemented in prev(tsm10p,tsm10e) upto this on 10/11/2002


-- Following changes are as per the request of Chik/Colin on 10/17/2002 at 10:30

create table modelled_cpp_fence (
	id number (10),
 	country_id number (10) not null,
	cpp_low number(20,12) not null,
	cpp_high number(20,12)not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table modelled_cpp_fence add constraint modelled_cpp_fence_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 20;

create sequence Modelled_cpp_fence_seq;

Alter table modelled_cpp_fence add constraint modelled_cpp_fence_FK1
	foreign key (COUNTRY_ID) references country(id);

-- Following changes are as per Debashish on 10/18/2002 at 14:30 

Alter table md_odc_oh_pct modify (oh_pct number(20,12), odc_pct number(20,12));


-- Implemented in test(tsm10) upto this on 10/21/2002
-- Implemented in prod(tsm10) upto this on 10/22/2002
-- Implemented in prev(tsm10p,tsm10e) upto this on 10/22/2002

-- Following chnages are as per the request of Phil on 10/23/2002 at 15:00

Insert into build_tag values (-1,sysdate,'Build tag for migrated archived and published trials');
commit;

-- Implemented in prod(tsm10d) upto this on 10/25/2002


-- Following chnages are as per the request of Phil on 11/04/2002 at 10:45 am

conn ft15?/??@????

Alter table ftuser add (CAN_MODEL_FLAG  number(1) default 0 not null);

Alter table ftuser add constraint ftuser_CAN_MODEL_FLAG_check 
check (CAN_MODEL_FLAG in (0,1));

conn tsm10?/??@????

-- *******************************************************************
-- *******************************************************************
-- Implemented in test(tsm10) upto this on 11/4/2002
-- Implemented in prod(tsm10,tsm10d) upto this on 11/4/2002
-- Implemented in prev(tsm10p,tsm10e) upto this on 11/4/2002
-- Implemented in test(tsm10e) upto this on 03/26/2003
-- *******************************************************************
-- *******************************************************************

-- Following chnages are as per the request of Kelly on 01/03/2003 at 16:45

Alter table client_div_to_lic_app drop constraint CDTLA_APP_NAME_CHECK;

Alter table client_div_to_lic_app add constraint CDTLA_APP_NAME_CHECK
	check ( app_name in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));

-- Following chnages are as per the request of Kelly on 01/06/2003 at 9:45


Alter table audit_hist drop constraint audit_hist_app_type_check;

Alter table audit_hist add constraint audit_hist_app_type_check check(
	app_type in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


Alter table User_Pref drop constraint up_app_type_check;

Alter table User_Pref add constraint up_app_type_check 
	check (app_type in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


conn ft15/??@??

Alter table trial drop constraint trial_created_by_check;

Alter table trial add constraint trial_created_by_check check(
	created_by in ('DASHBOARD', 'PICASE', 'TRACE', 'TSPD'));


-- Following chnages are as per the request of Kelly on 01/07/2003 at 8:10 am

alter table ftgroup drop constraint FTGROUP_NAME_CHECK;

Insert into ftgroup values (17,'TSPD Viewer');
Insert into ftgroup values (18,'TSPD Author');
Insert into ftgroup values (19,'TSPD Admin');
commit;


conn tsm10/??@??


-- Following changes are made to fix some bugs in GM client build as per Kelly on 01/20/2003

Alter table currency modify (cnv_rate number(12,4));

-- Following chnages are as per the request of Joel for 
-- the new exe file to replace webstart on 01/28/2003

Alter table client_div_to_lic_app add (frontend_version  varchar2(30));


conn ftcommon/****@????

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,'tsm10' environment 
from tsm10.CLIENT_DIV_TO_LIC_APP;

conn tsm10/*****@?????

-- Following chnages are as per the request of Joel for 
-- the new exe file to replace webstart on 02/06/2003

Alter table client_div add (using_webstart NUMBER(1) default 1 not null);

Alter table client_div_to_lic_app add (patch_available NUMBER(1) default 0 not null);

create or replace view client_div as select
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,'tsm10' environment from tsm10.client_div;

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,
'tsm10' environment 
from tsm10.CLIENT_DIV_TO_LIC_APP;

-- Following changes are made as per the request of Colin on 02/07/2003

conn ft15/******@?????

Grant select,insert,update,delete,references on ftuser_login_history to TSM10;

conn tsm10/******@?????

Drop synonym ftuser_login_history;
 
Create synonym ftuser_login_history for ft15.ftuser_login_history;

-- Following chnages are as per the request of Colin/Nadine on 02/04/2003 

conn dmishra/*****@?????

Create user ftadmin identified by welcome default tablespace tsmsmall
temporary tablespace temp;

Grant connect,resource to ftadmin;

grant connect,resource, alter any procedure, create any index, create any procedure, 
create any sequence,create any synonym, create any table, create any trigger, 
create any view, delete any table, drop any index, drop any procedure, 
drop any sequence, drop any synonym, drop any table, drop any trigger, drop any view, 
drop user, create user, execute any procedure, insert any table, select any sequence,
select any table, update any table,grant any privilege, grant any role to ftadmin;

--**Most important thing is after this, login to the oracle unix server
--**connect as / and execute "grant select on sys.v_$session to ftadmin 

conn tsm10/*****@??????

-- Following chnages are as per the request of Colin on 03/21/2003 at noon

create table client_build_progress (
	id number(10),
	client_div_id number(10) not null,
	build_start date,
	build_end date,
	error number(1) default 0 not null)
        tablespace tsmsmall
        pctused 70 pctfree 20;

Alter table client_build_progress add constraint client_build_progress_pk
	primary key (id) using index tablespace tsmsmall_indx pctfree 20;

Alter table client_build_progress add constraint client_build_progress_fk1
	foreign key(client_div_id) references client_div(id);

Insert into id_control values('tsm10','client_build_progress',1);
commit;

-- Following chnages are as per the request of Joel on 04/11/2003 at 11:15 

conn ft15/***@????

Alter table trial drop constraint TRIAL_STATUS_CHECK;
Alter table trial add constraint TRIAL_STATUS_CHECK
check (trial_status in ('CREATION', 'ACTIVE', 'CLOSED','TSM_PUB','DELETED'));

-- Following chnages are as per the request of kelly on 04/15/2003 at 10:56 am

conn tsm10/***@???

Alter table client_div add (
	g50_col_enabled 	number(1) default 0 not null,
	g50_hdng		varchar2(5),
	g50_spec_hdng		varchar2(5),
	g50_pcklst_desc	varchar2(10));

Alter table client_div add constraint cd_g50_col_enabled_check
	check(g50_col_enabled in (0,1));


-- Following chnages are as per the request of Kelly on 04/15/2003 at 4pm

Alter table cost_item drop constraint cost_item_price_range_check;

Alter table cost_item add constraint cost_item_price_range_check
	check(price_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table client_div drop constraint cd_def_price_range_check;

Alter table client_div add constraint cd_def_price_range_check
	check(def_price_range in ('Low','Med','High','Co_Med','Custom','G50'));

Alter table trial_budget drop constraint tb_ovhd_pct_range_check;

Alter table trial_budget add constraint tb_ovhd_pct_range_check
	check(overhead_pct_range in ('Low','Med','High','Co_Med','Custom','G50'));

-- Following changes are as per the request of Kelly on 04/16/2003 at 9:30 am

Alter table procedure_def add (		
	obsolete_build_tag_id  number(10),
	added_build_tag_id  number(10),
        hide number(1) default 0 not null);

Alter table procedure_def add constraint procedure_def_hide_check
	check ( hide in (0,1));

Alter table odc_def add (		
	obsolete_build_tag_id  number(10),
	added_build_tag_id  number(10));

Alter table procedure_def drop column obsolete_date;
Alter table procedure_def drop column added_in_build_id;
Alter table odc_def drop column obsolete_date;
Alter table odc_def drop column added_in_build_id;

Alter table procedure_def add constraint procedure_def_fk1
	foreign key (obsolete_build_tag_id) references build_tag (id);

Alter table procedure_def add constraint procedure_def_fk2
	foreign key (added_build_tag_id) references build_tag (id);

Alter table odc_def add constraint odc_def_fk1
	foreign key (obsolete_build_tag_id) references build_tag (id);

Alter table odc_def add constraint odc_def_fk2
	foreign key (added_build_tag_id) references build_tag (id);


update procedure_def set obsolete_build_tag_id = 1 where obsolete_flg = 1;
update procedure_def set added_build_tag_id = 1 ;
update odc_def set obsolete_build_tag_id = 1 where obsolete_flg = 1;
update odc_def set added_build_tag_id = 1 ;
commit;

-- Following changes are as per the request of Kelly on 04/16/2003 at 11 am

Alter table client_div_to_build_code add(
	primary_flg number(1) default 1 not null);

Alter table client_div_to_build_code add constraint cdtbc_primary_flg_check 
	check ( primary_flg in (0,1));


-- Following changes as as per the request of colin on 04/18/2003 at 3:15 pm

Alter table trial_budget add(avg_cpp_g50 number(10));

-- Following chnages are as per the request of Colin on 04/22/2003 at 3:50pm

Alter table cost_item add (
	required_g50_specificity VARCHAR2(10) default 'GSP' not null,
	priced_g50_specificity VARCHAR2(10));

-- Following changes are as per the request of Joel on 04/24/2003 at 10:15 am

Alter table TRIAL_BUDGET drop constraint TB_OVERHEAD_TYPE_CHECK;

Alter table TRIAL_BUDGET add constraint TB_OVERHEAD_TYPE_CHECK
check (overhead_type in ('Clientdef','PicasOfficialDef','PicasAdjustedDef','Manual','G50'));

-- Following changes are as per the request of Joel on 04/24/2003 at 10:30 am

Alter table TRIAL_BUDGET drop constraint TB_ODC_PCT_RANGE_CHECK;

Alter table TRIAL_BUDGET add constraint TB_ODC_PCT_RANGE_CHECK
check (odc_pct_range in ('Industry','Company','Custom','G50'));

-- Following changes are as per the request of Kelly on 05/01/2003 at 11:43 AM

Alter table client_div_to_lic_country add constraint
client_div_to_lic_country_uq1 unique 
(CLIENT_DIV_ID,COUNTRY_ID)
using index tablespace tsmsmall pctfree 10;


-- Following chnages are as per the request of Debashish on 03/06/2003 for IPT queries
-- This changes are actually posted here on 05/06/2003 at 9 AM
 
Alter table tsm10.investig add (facility varchar2(40));

Alter table investig add constraint investig_facility_check
   check(facility in ('Hospital','Unit','Other','No Confinement, Not Phase I','Unknown'));

-- Following changes are added by Debashish on 03/11/2003 at 4pm
-- This changes are actually posted here on 05/06/2003 at 9 AM

Insert into phase(ID,SHORT_DESC,SEQUENCE) values (21,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (22,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (23,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (24,'ph1 PK/Bioavailability and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (25,'Ph1 Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (26,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (27,'ph1 PK/Bioavailability and Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (28,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (29,'ph1 Safety/Tolerance/Dose Ranging and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (30,'ph1 Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (31,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (32,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (33,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Efficacy and Radiol',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (34,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (35,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (36,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (37,'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (38,'ph1 PK/Bioavailability and Specific Population and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (39,'Ph1 PK/Bioavailability and Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (40,'Ph1 PK/Bioavailability and Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (41,'ph1 PK/Bioavailability and Specific Population and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (42,'ph1 PK/Bioavailability and Food Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (43,'ph1 PK/Bioavailability and Food Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (44,'ph1 PK/Bioavailability and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (45,'Ph1 PK/Bioavailability and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (46,'ph1 PK/Bioavailability and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (47,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (48,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (49,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (50,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (51,'ph1 Safety/Tolerance/Dose Ranging and Specific Population and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (52,'ph1 Safety/Tolerance/Dose Ranging and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (53,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (54,'ph1 Safety/Tolerance/Dose Ranging and Drug Interaction and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (55,'ph1 Safety/Tolerance/Dose Ranging and Radiolabelled',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (56,'ph1 Specific Population and Food Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (57,'ph1 Specific Population and Food Interaction and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (58,'ph1 Specific Population and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (59,'ph1 Specific Population and Drug Interaction and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (60,'ph1 Specific Population and Efficacy',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (61,'ph1 Food Interaction and Drug Interaction',null);
Insert into phase(ID,SHORT_DESC,SEQUENCE) values (62,'ph1 Drug Interaction and Efficacy',null);

update phase set short_desc = 'ph1 PK/Bioavailability' where id=6;
update phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging' where id=7;
update phase set short_desc = 'ph1 Specific Population' where id=8;
update phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging' where id=9;
update phase set short_desc = 'ph1 PK/Bioavailability and Specific Population' where id=10;
update phase set short_desc = 'ph1 Safety/Tolerance/Dose Ranging and Specific Population' where id=11;
update phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Specific Population' where id=12;
update phase set short_desc = 'ph1 Food Interaction' where id=13;
update phase set short_desc = 'ph1 Drug Interaction' where id=14;
update phase set short_desc = 'ph1 Efficacy' where id=15;
update phase set short_desc = 'ph1 PK/Bioavailability and Food Interaction' where id=16;
update phase set short_desc = 'ph1 PK/Bioavailability and Drug Interaction' where id=17;
update phase set short_desc = 'ph1 PK/Bioavailability and Safety/Tolerance/Dose Ranging and Food Interaction' where id=18;

commit;



-- Following changes were done after receiving the mail of Michael Kahn on "shame on us" on 05/06/2003 at 10:07 AM

update indmap set code = 'OPHTHALMOLOGY' where code = 'OPTHALMOLOGY';
commit;

-- Following chnages are as per the GM1.1 hide procedures for certain procedures

update procedure_def set hide = 1 where cpt_code in ('#4000','#4001','#4002','#4003','#4004','#4005',
'#4006','#4007','#6001','#6005','#6006','#6007','#6008','#6009','#6010','#6011',
'#6012','#6013','#6014','#6015','#6016','#6017','#6018','#6019','#6020','#6021','#6022','cpp','cppv');

update odc_def set hide=1 where picas_code in ('#6002','#6003','#6004');

commit;

-- Following chnages are as per the request of Kelly on 05/08/2003 at 14:32

Insert into phase(ID,SHORT_DESC,SEQUENCE) values (-1,'Unknown',null);
commit;

-- Following chnages are as per the request of Kelly on 05/08/2003 at 2:50 pm

alter table protocol add (
	protocol_family_id varchar2(64),
	collection_country_id number(10),
	same_as_prot number(1),
	title varchar2(4000));

Alter table protocol add constraint protocol_same_as_prot_check
	check (same_as_prot in (0,1));

Alter table protocol add constraint protocol_fk5 
	foreign key (collection_country_id) references country(id);

-- Following chnages are as per the request of Kelly on 05/13/2003

conn ft15/*****@????


declare

 cursor c1 is select CREATED_BY,CLIENT_DIV_ID,PROTOCOL_IDENTIFIER from trial 
 group by CREATED_BY,CLIENT_DIV_ID,PROTOCOL_IDENTIFIER having count(*) > 1 ;
 suffix_num number(4);

begin
 
 for ix1 in c1 loop
  
 suffix_num:=1;

   declare

      cursor c2 is select id from trial where created_by = ix1.created_by and
      client_div_id = ix1.client_div_id and protocol_identifier = ix1.protocol_identifier;

   begin

      for ix2 in c2 loop

        update trial set protocol_identifier = protocol_identifier||'_'||suffix_num
        where id = ix2.id;

        suffix_num:=suffix_num+1;
      end loop;
   end;

 end loop;

end;
/



Alter table trial add constraint trial_uq2 
unique(CLIENT_DIV_ID,CREATED_BY,PROTOCOL_IDENTIFIER)
using index tablespace tsmsmall_indx pctfree 20;

-- Following changes are as per the request of Joel on 05/22/2003 at 2:50 PM

create table tspd_trial (
	trial_id	NUMBER(10),
	tspd_template_id	NUMBER(10)	NOT NULL,
	creator_ftuser_id	NUMBER(10)	NOT NULL,
	owner_ftuser_id	NUMBER(10)	NOT NULL,
	create_date	DATE	NOT NULL,
	short_title	VARCHAR2(256),	
	full_title	VARCHAR2(1024),	
	short_desc	VARCHAR2(256),	
	full_desc	VARCHAR2(1024),	
	indication_desc	VARCHAR2(1024),	
	study_type	VARCHAR2(80),	
	study_countries	VARCHAR2(1024),	
	planned_sites	NUMBER(5))
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table tspd_trial add constraint tspd_trial_pk
	primary key (trial_id) using index tablespace
	tsmsmall_indx pctfree 20;

create table tspd_template (
	id	NUMBER(10),
	client_div_id	NUMBER(10) NOT NULL,
	last_updated	DATE NOT NULL,
	name	VARCHAR2(80)	NOT NULL,
	data	BLOB)
	tablespace trialblob 
	pctused 65 pctfree 20;

Alter table tspd_template add constraint tspd_template_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table tspd_document (
	id	NUMBER(10),
	trial_id	NUMBER(10)	NOT NULL,
	document_type	VARCHAR2(80)	NOT NULL,
	document_name	VARCHAR2(256),
	author_ftuser_id	NUMBER(10)	NOT NULL,
	create_date	DATE	NOT NULL,
	last_updated	DATE	NOT NULL,
	version_timestamp	NUMBER(10)	NOT NULL,
	data	BLOB,	
	snapshot_type	VARCHAR2(80),	
	snapshot_name	VARCHAR2(256),	
	snapshot_notes	VARCHAR2(1024),	
	review_by_date	DATE,	
	review_by_time	VARCHAR2(80),	
	review_status	VARCHAR2(80),
	amend_to_tspd_document_id	NUMBER(10),	
	icp_instance_id	NUMBER(10)	NOT NULL)
	tablespace trialblob 
	pctused 65 pctfree 20;

Alter table tspd_document add constraint tspd_document_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table icp_instance (
	id	NUMBER(10),
	trial_id	NUMBER(10),
	last_updated	DATE,
	version_timestamp	NUMBER(10),
	data	BLOB)
	tablespace trialblob 
	pctused 65 pctfree 20;

Alter table icp_instance add constraint icp_instance_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table tspd_doc_reviewer(
	id	NUMBER(10),
	ftuser_id	NUMBER(10)	NOT NULL,
	tspd_document_id	NUMBER(10)	NOT NULL,
	review_status	VARCHAR2(80),	
	completion_status	VARCHAR2(80),	
	review_notes	VARCHAR2(1024),	
	user_status	VARCHAR2(80))	
	tablespace tsmsmall 
	pctused 65 pctfree 20;


Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table tspd_doc_comment(
	id	NUMBER(10),
	tspd_doc_reviewer_id	NUMBER(10)	NOT NULL,
	sequence	NUMBER(10),	
	comments	VARCHAR2(1024),
	word_range	VARCHAR2(128)	NOT NULL)
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table tspd_doc_comment add constraint tspd_doc_comment_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table tspd_doc_advisory(
	id	NUMBER(10),
	tspd_document_id	NUMBER(10)	NOT NULL,
	status	VARCHAR2(80)	NOT NULL,
	reason_for_close	VARCHAR2(1024),	
	advisory_rule	VARCHAR2(80)	NOT NULL,
	advisory_object	VARCHAR2(256)	NOT NULL)
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table tspd_doc_advisory add constraint tspd_doc_advisory_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table criteria(
	id	NUMBER(10),
	client_div_id	NUMBER(10)	NOT NULL,
	type	VARCHAR2(80)	NOT NULL,
	short_desc	VARCHAR2(256),	
	long_desc	VARCHAR2(2048),
	rationale	VARCHAR2(2048))	
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table criteria add constraint criteria_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;	

create table criteria_set(
	id	NUMBER(10),
	name	VARCHAR2(80)	NOT NULL,
	create_date	DATE	NOT NULL,
	client_div_id	NUMBER(10)	NOT NULL,
	ftuser_id	NUMBER(10)	NOT NULL)
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table criteria_set add constraint criteria_set_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;

create table criteria_set_item(
	id	NUMBER(10),
	criteria_set_id	NUMBER(10)	NOT NULL,
	criteria_id	NUMBER(10)	NOT NULL)
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table criteria_set_item add constraint criteria_set_item_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;

create table password_rule(
	id	NUMBER(10),
	client_div_id	NUMBER(10)	NOT NULL,
	username_min_chars	NUMBER(3) default 0	NOT NULL,
	username_max_chars	NUMBER(3) default 0	NOT NULL,
	password_min_chars	NUMBER(3) default 0	NOT NULL,
	password_max_chars	NUMBER(3) default 0	NOT NULL,
	password_has_numeric	NUMBER(1) default 0	NOT NULL,
	password_valid_days	NUMBER(5) default 0 	NOT NULL,
	password_ntfy_user_days 	NUMBER(5) default 0	NOT NULL,
	password_allow_reuse_days	NUMBER(5) default 0	NOT NULL)
	tablespace tsmsmall 
	pctused 65 pctfree 20;

Alter table password_rule add constraint password_rule_pk
	primary key (id) using index tablespace
	tsmsmall_indx pctfree 20;



Insert into id_control select 'tsm10', 'tspd_template', nvl(max(id),0)+1 from tspd_template ;
Insert into id_control select 'tsm10', 'tspd_document', nvl(max(id),0)+1 from tspd_document ;
Insert into id_control select 'tsm10', 'icp_instance', nvl(max(id),0)+1 from icp_instance ;
Insert into id_control select 'tsm10', 'tspd_doc_reviewer', nvl(max(id),0)+1 from tspd_doc_reviewer ;
Insert into id_control select 'tsm10', 'tspd_doc_comment', nvl(max(id),0)+1 from tspd_doc_comment ;
Insert into id_control select 'tsm10', 'tspd_doc_advisory', nvl(max(id),0)+1 from tspd_doc_advisory ;
Insert into id_control select 'tsm10', 'criteria', nvl(max(id),0)+1 from criteria ;
Insert into id_control select 'tsm10', 'criteria_set', nvl(max(id),0)+1 from criteria_set ;
Insert into id_control select 'tsm10', 'criteria_set_item', nvl(max(id),0)+1 from criteria_set_item;
Insert into id_control select 'tsm10', 'password_rule', nvl(max(id),0)+1 from password_rule ;
commit;

conn ft15/****@????

Insert into ftgroup values (20,'TSPD Library Admin');
commit;

Alter table ftuser add(old_password varchar2(255));

conn ftcommon/****@???
create or replace view FTUSER as
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,'tsm10' environment from ft15.ftuser
union all
select ID,NAME||'@tsm10e' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,null,'tsm10e' environment from ft15e.ftuser;

-- Following chnages were done on 05/28/2003 at 9:40 AM

Alter table ftuser add (active_tspd_user number(1) default 0 not null);

Alter table ftuser add constraint ftuser_active_tspd_user_check
check(active_tspd_user in (0,1));

-- Following chnages were done on 05/28/2003 at 12:40 PM

conn tsm10/****@???

Alter table tspd_trial add constraint tspd_trial_fk1
foreign key (TRIAL_ID) references trial(id);

-- Following changes are as per the request of Kelly on 05/28/2003 at 3:20 pm

conn ft15/****@???

create index ftuser_indx1 on ftuser(client_div_id) 
tablespace ftsmall pctfree 20;

-- Following chnages are as per the request of Kelly on 05/28/2003 at 3:50 PM

conn tsm10/****@????

Alter table audit_hist add(start_date date);

-- Following chnages are as per the request of Joel on 05/30/2003 at 5:36 PM

conn ft15/***@???

Alter table ftuser add(def_plan_currency_id number(10));
Alter table ftuser add constraint ftuser_fk5 foreign key (def_plan_currency_id)
references tsm10.currency(id);

conn tsm10/****@????

Alter table client_div add(allow_create_unlisted number (1) default 0 not null);
Alter table client_div add constraint cd_allow_create_unlisted_check
check(allow_create_unlisted in (0,1));

conn ftcommon/****@????

create or replace view CLIENT_DIV as
select ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,'tsm10' environment from tsm10.client_div;

create or replace view FTUSER as
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,'tsm10' environment 
from ft15.ftuser;

-- Following chnages are done on 05/30/2003 at 6:09 PM


Alter table tspd_template add constraint tspd_template_fk1
	foreign key (client_div_id) references client_div(id);

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err	

Alter table tspd_trial add constraint tspd_trial_fk1
foreign key (TRIAL_ID) references trial(id);

Alter table tspd_trial add constraint tspd_trial_fk2
foreign key (tspd_template_id) references tspd_template(id);

Alter table tspd_trial add constraint tspd_trial_fk3
foreign key (creator_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tspd_trial_fk4
foreign key (owner_ftuser_id) references ftuser(id);

Alter table tspd_trial add constraint tt_study_type_check 
check(study_type in ('MultipleCenters','SingleCenter','Other')); 

Alter table icp_instance add constraint icp_instance_fk1
	foreign key (TRIAL_ID) references tspd_trial(trial_id);

Create or replace trigger icp_instance_trg1
before insert or update on icp_instance
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err
	
Alter table tspd_document add constraint tspd_document_fk1
	foreign key (TRIAL_ID) references tspd_trial(trial_id);

Alter table tspd_document add constraint tspd_document_fk2
	foreign key (author_ftuser_id) references ftuser(id);

Alter table tspd_document add constraint tspd_document_fk3
	foreign key (icp_instance_id) references icp_instance(id);	

Alter table tspd_document add constraint tspd_document_fk4
	foreign key (amend_to_tspd_document_id) references tspd_document(id);

Alter table tspd_document add constraint td_document_type_check
	check(document_type in ('Protocol','StudyGuide'));

Alter table tspd_document add constraint td_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion'));

Alter table tspd_document add constraint td_review_status_check
	check(review_status in ('Open','Closed'));

Create or replace trigger tspd_document_trg1
before insert or update on tspd_document
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err	

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_fk1
	foreign key (tspd_document_id) references tspd_document(id);

Alter table tspd_doc_reviewer add constraint tdr_review_status_check
	check(review_status in ('Complete','Partial'));

Alter table tspd_doc_reviewer add constraint tdr_completion_status_check
	check(completion_status in ('Approved','ApprovedWithRevisions','NotApproved'));

Alter table tspd_doc_reviewer add constraint tdr_user_status_check
	check(user_status in ('Active','Removed'));

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk1
	foreign key (tspd_doc_reviewer_id) references tspd_doc_reviewer(id);	

Alter table tspd_doc_advisory add constraint tspd_doc_advisory_fk1
	foreign key (tspd_document_id) references tspd_document(id);

Alter table tspd_doc_advisory add constraint tda_status_check
	check(status in ('Open','Closed'));	

Alter table criteria add constraint criteria_fk1
	foreign key (client_div_id) references client_div(id);
	
Alter table criteria add constraint criteria_type_check
	check(type in ('Inclusion','Exclusion','NotDefined'));

Alter table criteria_set add constraint criteria_set_fk1
	foreign key (client_div_id) references client_div(id);
	
Alter table criteria_set add constraint criteria_set_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table criteria_set_item add constraint criteria_set_item_fk1
	foreign key (criteria_id) references criteria(id);
	
Alter table criteria_set_item add constraint criteria_set_item_fk2
	foreign key (criteria_set_id) references criteria_set(id);

Alter table password_rule add constraint password_rule_fk1
	foreign key (client_div_id) references client_div(id);


-- Following chnages are done on 6/3/2003 at 10:00 AM as per the request of Joel

Alter table client_div_to_lic_app add(patch_version VARCHAR2(30));

conn ftcommon/****@???

create or replace view CLIENT_DIV_TO_LIC_APP as
select ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,PATCH_AVAILABLE,
patch_version ,'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP
union all
select ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,PATCH_AVAILABLE,
null,'tsm10e' environment from tsm10e.CLIENT_DIV_TO_LIC_APP;

-- Following chnages are as per the request of Kelly on 06/11/2003 at 3:10 PM

Alter table tspd_document drop constraint TD_REVIEW_STATUS_CHECK;

Alter table tspd_document add constraint TD_REVIEW_STATUS_CHECK
check (review_status in ('Open','Closed','Final'));

-- Following chnages are as per the request of Kelly on 06/11/2003 at 4:30 PM

Alter table tspd_trial add (build_tag_id number(10));

Alter table tspd_trial add constraint tspd_trial_fk5
foreign key (build_tag_id) references build_tag(id);

update tspd_trial set build_tag_id = (select max(id) from build_tag);

commit;

Alter table tspd_trial modify (build_tag_id not null);

-- Following chnages are as per the request of Fiammetta on 06/19/2003 at 11:30 AM

Alter table password_rule add constraint password_rule_uq1
unique (client_div_id) using index tablespace tsmsmall_indx
pctfree 20;


-- Following chnages are as per the request of Tonya on 06/19/2003 at 3:25 PM

Alter table CUSTOM_SET drop constraint CUSTOM_SET_TYPE_CHECK;

Alter table CUSTOM_SET add constraint CUSTOM_SET_TYPE_CHECK
check(type in ('ODC','CLIN','TASK'));

Alter table unlisted_procedure drop constraint UP_PROC_TYPE_CHECK;

Alter table unlisted_procedure add constraint UP_PROC_TYPE_CHECK
check(type in ('ODC','CLIN','TASK'));

-- Following chnages are as per the request of Joel on 06/27/2003 at 11:02 AM

alter table icp_instance add(snapshot_type varchar2(80) default 'WorkingCopy' not null);

alter table icp_instance add constraint ii_snapshot_type_check
	check(snapshot_type in ('WorkingCopy', 'ReviewCopy', 'FinalVersion'));

Alter table tspd_document add(snapshot_status VARCHAR2(80));
update tspd_document set snapshot_status=REVIEW_STATUS;
Alter table tspd_document drop column REVIEW_STATUS;
Alter table tspd_document add constraint td_snapshot_status_check
 check(snapshot_status in ('Open','Closed','Final'));


Alter table tspd_doc_reviewer drop constraint tdr_review_status_check;
update tspd_doc_reviewer set review_status = 'Approved'
where review_status = 'Complete';
update tspd_doc_reviewer set review_status = 'ApprovedWithRevisions'
where review_status = 'Partial';
Alter table tspd_doc_reviewer add constraint tdr_review_status_check
 check(review_status in ('Approved','ApprovedWithRevisions','NotApproved'));

Alter table tspd_doc_reviewer drop constraint tdr_completion_status_check;
update tspd_doc_reviewer set completion_status = 'Complete' 
where completion_status = 'Approved';
update tspd_doc_reviewer set completion_status = 'Partial'
where completion_status = 'ApprovedWithRevisions';
Alter table tspd_doc_reviewer add constraint tdr_completion_status_check
 check(completion_status in ('Complete','Partial'));


-- Following chnages are as per the request of Kelly on 06/30/2003 at 8:49 AM


Alter table client_div add (tspd_build_tag_id NUMBER(10));
Alter table client_div add constraint CLIENT_DIV_FK7
foreign key(tspd_build_tag_id) references build_tag(id);

conn ftcommon/***@????


create or replace view client_div as
select ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,TSPD_BUILD_TAG_ID,
'tsm10' environment from tsm10.client_div
union all
select ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,null,null,null,null,null,null,
'tsm10e' environment from tsm10e.client_div;


-- Following changes are as per the request of Kelly on 06/30/2003 at 1:50PM

conn ft15/****@????

CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by on trial
referencing new as n old as o
for each row

begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' or 
    :n.created_by = 'TSPD' then 
	:n.guid := 'TSM_'||:n.id; 
 end if; 

end;
/

sho err


update trial set PROTOCOL_IDENTIFIER=GUID   where PROTOCOL_IDENTIFIER is null;
Alter table trial modify(PROTOCOL_IDENTIFIER not null);


conn tsm10/****@?????

-- Folowing chnages are as per the bugs found on 07/03 and added by debashish

Alter table odc_def add (foxpro_flg number(1) default 1 not null);

Alter table odc_def add constraint od_foxpro_flg_check
check(foxpro_flg in (0,1));

Alter table procedure_def add (foxpro_flg number(1) default 1 not null);

Alter table procedure_def add constraint pd_foxpro_flg_check
check(foxpro_flg in (0,1));

conn ft15/****@????

-- Following changes are as per the request of Kelly to allow access from TSPD dataset on 7/7/03 at 8:50 AM

Grant select,insert,update,delete,references on ft_foreign_key_info to tsm10 with grant option;


conn tsm10/*****@????

-- Following changes are as per the request of Kelly on 07/09/2003 at 11:28 AM

Alter table tspd_document add (document_notes  VARCHAR2(1024));

-- Following chnages are as per the request of Kelly on 07/09/2003 at 12 Noon

create or replace view tspd_template_noblob as
 select id,client_div_id,last_updated,name 
 from tspd_template;

create or replace view icp_instance_noblob as
 select id,trial_id,last_updated,
 version_timestamp,snapshot_type 
 from icp_instance;

create or replace view tspd_document_noblob as
 select id,trial_id,document_type,document_name,
 author_ftuser_id,create_date,last_updated,
 version_timestamp,snapshot_type,snapshot_name, 
 snapshot_notes, review_by_date,review_by_time, 
 amend_to_tspd_document_id,icp_instance_id,
 snapshot_status,document_notes 
 from tspd_document;

-- Following chnages are as per the request of Kelly on 07/09/2003 at 5PM

Alter table tspd_document add(snapshot_create_date date);

create or replace view tspd_document_noblob as
	select id,trial_id,document_type,document_name,
	author_ftuser_id,create_date,last_updated,
	version_timestamp,snapshot_type,snapshot_name,	
	snapshot_notes,	review_by_date,review_by_time,	
	amend_to_tspd_document_id,icp_instance_id,
	snapshot_status,document_notes,snapshot_create_date
	from tspd_document;

-- Following changes are as per the request of Kelly on 07/14/2003 at 11:00 AM

Alter table protocol add(earliest_grant_date date);

update protocol set earliest_grant_date = (
select min(grant_date) from investig where
investig.protocol_id =protocol.id);

Alter table tspd_doc_comment drop column sequence;

Alter table tspd_doc_comment drop column word_range;

Alter table tspd_doc_comment add(
	word_range_start number(10),
	word_range_end number(10),
	create_date date,
	tspd_document_id number(10));

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk2 foreign key
	(TSPD_DOCUMENT_ID) references TSPD_DOCUMENT(ID);



-- Following chnages are as per the request of Kelly on 07/14/2003 at 3:50 PM

Alter table tspd_document add(soa_tbl_format blob);
Alter table tspd_doc_comment add(ftuser_id number(10));

update tspd_doc_comment set FTUSER_ID=TSPD_DOC_REVIEWER_ID;
Alter table tspd_doc_comment modify (FTUSER_ID not null);
Alter table tspd_doc_comment drop column TSPD_DOC_REVIEWER_ID;

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_uq1
	unique (ftuser_id,tspd_document_id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_doc_reviewer add constraint tspd_doc_reviewer_fk2
	foreign key (ftuser_id) references ftuser(id);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk1
	foreign key (ftuser_id) references ftuser(id);

Alter table tspd_doc_comment add constraint tspd_doc_comment_fk3
	foreign key (ftuser_id,TSPD_DOCUMENT_ID) 
	references tspd_doc_reviewer(ftuser_id,TSPD_DOCUMENT_ID);

--**************************************************************
-- Implemented in tsm10e@test upto this on 07/14/2003 at 5:45 PM
--**************************************************************

-- Following chnages are as per the request of Tonya on 07/23/2003 at 3:25 PM

Alter table CUSTOM_SET drop constraint CUSTOM_SET_TYPE_CHECK;

Alter table CUSTOM_SET add constraint CUSTOM_SET_TYPE_CHECK
check(type in ('ODC','CLIN','TSPD_TASK'));

Alter table unlisted_procedure drop constraint UP_PROC_TYPE_CHECK;

Alter table unlisted_procedure add constraint UP_PROC_TYPE_CHECK
check(type in ('ODC','CLIN','TSPD_TASK'));

-- Following chnages are as per the request of Kelly on 07/24/2003 at 11 AM

Alter table tspd_doc_comment add(hide_flg number(1) default 1 not null);
Alter table tspd_doc_comment add constraint tdc_hide_flg_check check 
(hide_flg in (0,1));

-- Following chnages are as per the request of Kelly on 07/24/2003 at 3:30 PM

alter table tspd_doc_reviewer add (VERSION_TIMESTAMP NUMBER(10) default 1);
update tspd_doc_reviewer set VERSION_TIMESTAMP=1;
commit;


-- Following chnages are as per the request of Matt on 07/29/2003 at 10:18 AM

create table TSPD_TEMPLATE_EMAIL(
	id	NUMBER(10),
	client_div_id	NUMBER(10),
	TEMPLATE_NAME  	VARCHAR2(30) NOT NULL,
	SUBJECT	VARCHAR2(256) NOT NULL,	
	MESSAGE_TEXT 	VARCHAR2(4000))	
	tablespace tspdsmall 
	pctused 65 pctfree 20;


Alter table TSPD_TEMPLATE_EMAIL add constraint TSPD_TEMPLATE_EMAIL_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table TSPD_TEMPLATE_EMAIL add constraint TSPD_TEMPLATE_EMAIL_fk1
	foreign key (client_div_id) references client_div(id);

Insert into id_control select user, 'tspd_template_email', nvl(max(id),0)+1 from 
	tspd_template_email;

commit;

-- Following chnages are as per the request of Matt on 07/31/2003 at 5 pm

Alter table tspd_document add(review_reminder_days number(2) default 0 not null);

-- Following chnages are as per the request of Tonya on 08/11/2003 at 8:40 am

Alter table audit_hist add (tspd_role varchar2(50));

-- Following chnages are as per the request of Matt on 08/05/2003 

Alter table password_rule add(
	LOCKOUT_INACTIVITY_DAYS number(5) default 0 not null,
	LOCKOUT_LOGIN_ATTEMPTS number(5) default 0 not null);

-- Following chnages are as per the request of Joel on 08/05/2003 at 2:01 PM

alter table unlisted_procedure add (VERSION_TIMESTAMP NUMBER(10) default 1);
update unlisted_procedure set VERSION_TIMESTAMP=1;
commit;


-- Following chnages are as per the request of Matt on 08/14/2003 at 11:37 am

Alter table criteria_set  add constraint criteria_set_uq1
unique (CLIENT_DIV_ID,NAME) using index tablespace 
tsmsmall_indx pctfree 15;

alter table custom_set add (VERSION_TIMESTAMP NUMBER(10) default 1);
update custom_set set VERSION_TIMESTAMP=1;
commit;

alter table criteria_set add (VERSION_TIMESTAMP NUMBER(10) default 1);
update criteria_set set VERSION_TIMESTAMP=1;
commit;

conn ft15/***@???

-- Following chnages are as per the request of Colin on 08/14/2003 at 15:34 

Alter table ftuser add (locked number(1) default 0 not null);
Alter table ftuser add constraint ftuser_locked_check 
check (locked in (0,1));

conn tsm10/***@????

-- Following changes are as per the request of Joel on 08/25/2003 at 4:36 PM

Alter table tspd_doc_reviewer drop constraint tdr_review_status_check;

Alter table tspd_doc_reviewer add constraint tdr_review_status_check
	check(review_status in ('Approved','ApprovedWithRevisions','NotApproved','NotReviewed'));

Alter table tspd_doc_reviewer drop constraint tdr_completion_status_check;

Alter table tspd_doc_reviewer add constraint tdr_completion_status_check
	check(completion_status in ('Complete','Partial','Incomplete'));

-- Following changes are as per the request of Joel on 8/26 at 4pm

Alter table tspd_doc_reviewer modify (user_status default 'Active');
Alter table tspd_doc_reviewer modify (completion_status default 'Incomplete');
Alter table tspd_doc_reviewer modify (review_status default 'NotReviewed');

-- Following chnages are as per the request of Matt on 08/27/2003 at 11:26 AM

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE_AND_TIME', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
      'The <protocol id> / <snapshot name> protocol has been closed for further review.  The review was due <review due date> on <review due time>.  If you have not yet completed your review and have additional comments please notify me directly.'
      ); 
  
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
      'The <protocol id> / <snapshot name> protocol has been closed for further review.  The review was due <review due date>.  If you have not yet completed your review and have additional comments please notify me directly.'
      ); 

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
      'The <protocol id> / <snapshot name> protocol has been closed for further review.  If you have not yet completed your review and have additional comments please notify me directly.'
      ); 
commit;

-- Following changes are as per the request of Kelly on 09/05/2003 3:11 PM
-- Kelly asked on 09/08/2003 to remove this column 

-- alter table tspd_document add(soa_table_format varchar2(4000));

-- Following chnages are as per the request of Matt on 09/05/2003 3:30 PM

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
       increment_sequence('tspd_template_email_seq'),
      'REVIEW_NONFINAL_SNAPSHOT_DUE',
      'Protocol <protocol id> / <snapshot name> document posted for your review',
      'The <protocol id> / <snapshot name> protocol has been posted for your review.  Please log in to the TrialSpace Protocol Designer to review and add your comments.  Once your review is complete, please submit and sign your review.\n\nThe review is due <review due date> on <review due time>.  If you are unable to complete your review you may re-assign the review to another reviewer.');
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'),
      'SUBMIT_REVIEW',
      'Review submitted for trial <protocol id>, <doc or amendment name> / <snapshot name>',
      '<reviewer display name> has submitted a review for trial <protocol id> <doc or amendment name> / <snapshot name>Review Status: <completion status / review status> Notes: <review notes>');

commit;


-- Following chnages are as per the request of Tonya/Kelly on 09/08/2003 at 9:22AM

create table tspd_lib_bucket(
	ID	NUMBER(10),
	NAME	VARCHAR2(255) not null,
	CREATE_DATE	DATE not null,
	CLIENT_DIV_ID	NUMBER(10),
	LAST_UPDATED	DATE not null)
	tablespace tspdsmall 
	pctused 70 pctfree 20;

Alter table tspd_lib_bucket add constraint tspd_lib_bucket_pk
	primary key (id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table tspd_lib_bucket add constraint tspd_lib_bucket_fk1
	foreign key (client_div_id) references client_div(id);

Create or replace trigger tspd_lib_bucket_trg1
before insert or update on tspd_lib_bucket
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/

insert into id_control select 'tsm10','tspd_lib_bucket',
nvl(max(id),0) from tspd_lib_bucket;
commit;

create table tspd_lib_element(
	ID			NUMBER(10),
	TSPD_LIB_BUCKET_ID	NUMBER(10) NOT NULL,
	NAME			VARCHAR2(255),
	CREATE_DATE		DATE NOT NULL,
	CONTENT_TYPE		NUMBER(10),
	CREATOR_FTUSER_ID	NUMBER(10),
	CONTENT_SUBTYPE		NUMBER(10),
	FILENAME		VARCHAR2(255),
	DATA			BLOB)
	tablespace tspdblob
	pctused 70 pctfree 20;

Alter table tspd_lib_element add constraint tspd_lib_element_pk
	primary key (id) using index tablespace tspdsmall_indx
	pctfree 20;

Alter table tspd_lib_element add constraint tspd_lib_element_fk1
	foreign key (TSPD_LIB_BUCKET_ID) references TSPD_LIB_BUCKET(id);

Alter table tspd_lib_element add constraint tspd_lib_element_fk2
	foreign key (CREATOR_FTUSER_ID) references FTUSER(id);

insert into id_control select 'tsm10','tspd_lib_element',
nvl(max(id),0) from tspd_lib_element;
commit;

create or replace view tspd_lib_element_noblob as
select ID,TSPD_LIB_BUCKET_ID,NAME,CREATE_DATE,CONTENT_TYPE,
CREATOR_FTUSER_ID,CONTENT_SUBTYPE,FILENAME from tspd_lib_element;


-- Following changes are as per the request of Colin on 09/08/2003 at 3 pm

conn ft15/***@????

grant update (locked) on ftuser to ftcommon;

conn tsm10/****@????

grant select on password_rule to ftcommon;

conn ftcommon/****@????

create or replace view ftuser as
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,
LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,
locked,'tsm10' environment from ft15.ftuser
union all
select ID,NAME||'@tsm10e' name ,PASSWORD,SITE_ID,STARTING_SCREEN,
LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,null,null,null,null,
'tsm10e' environment from ft15e.ftuser;

create or replace view password_rule as
select ID,CLIENT_DIV_ID,USERNAME_MIN_CHARS,USERNAME_MAX_CHARS,
PASSWORD_MIN_CHARS,PASSWORD_MAX_CHARS,PASSWORD_HAS_NUMERIC,
PASSWORD_VALID_DAYS,PASSWORD_NTFY_USER_DAYS,PASSWORD_ALLOW_REUSE_DAYS,
LOCKOUT_INACTIVITY_DAYS,LOCKOUT_LOGIN_ATTEMPTS,
'tsm10' environment from tsm10.password_rule;

create or replace procedure lock_ftuser
(schemaname in varchar2, username in varchar2, lock_value in number)
as
mysql_stmt varchar2(200);
table_name varchar2(70);
begin
table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set locked=:1 where name=:2';
execute immediate mysql_stmt using lock_value, username;
commit;
end;
/
sho err

-- Following changes are as per the request of Nancy/Gary on 09/08/2003 at 3:35 PM

alter table tspd_doc_advisory add (advisoryid varchar2(512));

-- Following changes are as per the request of Tonya on 09/09/2003 at 10:40 AM

alter table tspd_lib_bucket add(VERSION_TIMESTAMP NUMBER(10));

-- Following chnages are as per the request of Tonya on 09/10/2003 at 7:30 AM

alter table criteria add(other_desc VARCHAR2(256));

-- Following chnages are as per the request of Matt on 09/11/2003 at 8am

Alter table tspd_trial add (client_support_access_allowed number(1) default 0 not null);

Alter table tspd_trial add constraint tt_clnt_sprt_allwd_check check(
client_support_access_allowed in (0,1));

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_ADDED',
  'Change in roles for trial <protocol id>',
  '<user being added> has been added as <user role> to trial <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_REPLACED',
  'Change in roles for trial <protocol id>',
  '<user being added> has been added as <user role> to trial <protocol id>.  <user being replaced> has been replaced as <user role>.');

commit;

-- Following changes are as per the request of Kelly on 09/15/2003 at 8:20 am

alter table tspd_document add(amend_name VARCHAR2(256));

-- Following changes are as per the request of Allen on 09/15/2003 at 9:45 pm

Insert into ftgroup values (21,'TSPD FTAdmin');
Insert into ftgroup values (22,'TSPD Super Dolly');
Insert into ftgroup values (23,'TSPD Dolly');
commit;


-- Implemented in tsm10@tonya upto this on 09/11/2003 at 8:07 AM


-- Following changes are as per the request of Gary on 09/15/2003 at 11:56 AM

alter table tspd_doc_advisory modify (ADVISORY_OBJECT varchar2(2048));


-- Following changes are as per the request of Kelly on 09/17/2003 at 10:50 pm

Alter table tspd_document drop constraint td_snapshot_type_check;

Alter table tspd_document add constraint td_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion'));

alter table icp_instance drop constraint ii_snapshot_type_check;

alter table icp_instance add constraint ii_snapshot_type_check
	check(snapshot_type in ('WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion'));


-- Following changes are done by debashish to keep the database uptodate on 09/19/2003 at 9:52 AM

create or replace view tspd_document_noblob as
	select id,trial_id,document_type,document_name,
	author_ftuser_id,create_date,last_updated,
	version_timestamp,snapshot_type,snapshot_name,	
	snapshot_notes,	review_by_date,review_by_time,	
	amend_to_tspd_document_id,icp_instance_id,
	snapshot_status,document_notes,snapshot_create_date,
	REVIEW_REMINDER_DAYS,AMEND_NAME             
	from tspd_document;

-- Following changes are as per the request of Kelly on 09/21/2003 at 3:24 pm

Alter table tspd_lib_element add (ct varchar2(20), cst varchar2(20));
update tspd_lib_element set ct = to_char(content_type);
update tspd_lib_element set cst = to_char(content_subtype);
commit;
update tspd_lib_element set content_type = null;
update tspd_lib_element set content_subtype = null;
commit;
Alter table tspd_lib_element modify(content_type varchar2(20),
				    content_subtype varchar2(20));
update tspd_lib_element set content_type = ct;
update tspd_lib_element set content_subtype = cst;
commit;

alter table tspd_lib_element drop column ct;
alter table tspd_lib_element drop column cst;

Alter table tspd_lib_element add constraint tle_content_type_check
check (content_type in ('Inline','Text','MSWord','Image','Binary'));

Alter table tspd_lib_element add constraint tle_content_subtype_check
check (content_subtype in ('PNG','JPG','BMP'));

-- Following chnages are as per the request of Kelly on 09/23/2003 at 12 noon

Alter table tspd_lib_element add(tooltip varchar2(256));

-- Following chnages are as per the request of Kelly on 09/23/2003 at 15:05

Alter table tspd_lib_element drop constraint tle_content_type_check;

Alter table tspd_lib_element add constraint tle_content_type_check
check (content_type in ('Inline','Text','MSWord','Image'));

Alter table tspd_lib_element drop constraint tle_content_subtype_check;

Alter table tspd_lib_element add constraint tle_content_subtype_check
check (content_subtype in ('PNG','JPG','BMP','GIF'));

-- Following chnages are as per the request of Henry on 09/23/2003 at 5pm

create or replace procedure delete_tspd_template(
templateid in number) 
is
begin
delete from tspd_doc_reviewer where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_doc_comment where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_doc_advisory where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_document where trial_id in
(select trial_id from tspd_trial where 
tspd_template_id=templateid);

delete from icp_instance where trial_id in
(select trial_id from tspd_trial where 
tspd_template_id=templateid);

delete from tspd_trial where tspd_template_id=templateid;

delete from tspd_template where id=templateid;

delete from trial where created_by = 'TSPD' and
not id in (select trial_id from tspd_trial);

commit;
end;
/

-- Following chnages are as per the request of Matt on 09/25/2003 at 7pm

alter table tspd_document add (last_cookie number(10));

-- Following chnages are as per the request of Kelly on 09/25/2003 at 7 pm

Alter table tspd_lib_element add (filepath varchar2(256));

-- Following changes are as per the request of Nancy on 10/2/2003 at 15:22

alter table tspd_doc_advisory drop column advisory_rule;

-- Following chnages are as per the request of Kelly on 10/03/03 at 15:15

alter table tspd_lib_element add(inline_data varchar2(2048));

create or replace view tspd_lib_element_noblob as
select ID,TSPD_LIB_BUCKET_ID,NAME,CREATE_DATE,CONTENT_TYPE,
CREATOR_FTUSER_ID,CONTENT_SUBTYPE,FILENAME,TOOLTIP,
FILEPATH,INLINE_DATA from tspd_lib_element;

-- Following changes are as per the request of Kelly on 10/05/2003 at 12:17

Alter table tspd_document drop constraint TD_SNAPSHOT_TYPE_CHECK;

Alter table tspd_document add constraint TD_SNAPSHOT_TYPE_CHECK 
	check (snapshot_type in (
	'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange'));


-- Following chnages are as per the request of Kelly on 10/15/2003 at 15:07 pm

Alter table icp_instance add (icp_type varchar2(80));

Alter table icp_instance add constraint icp_instance_icp_type_check
	check(icp_type in ('WorkingCopy','Frozen'));

update icp_instance set icp_type='WorkingCopy' where snapshot_type='WorkingCopy';
update icp_instance set icp_type='Frozen' where snapshot_type='FinalCopy';

commit;

create or replace view icp_instance_noblob as
	select id,trial_id,last_updated,
	version_timestamp,snapshot_type,icp_type 
	from icp_instance;

-- Following chnages are done by Kelly between 10/17/2003 and 10/24/2003


  delete tspd_template_email ;
  commit;
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE_AND_TIME', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.  
The review was due <review due date> at <review due time>.  If you have not yet
completed your review and have additional comments please notify me directly.'
      ); 
  
  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT_DATE', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.
The review was due <review due date>.  If you have not yet completed your 
review and have additional comments please notify me directly.'
      ); 

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'), 
      'CLOSE_SNAPSHOT', 
      'Protocol <protocol id> / <snapshot name> document closed for review',
'The <protocol id> / <snapshot name> protocol has been closed for further review.
If you have not yet completed your review and have additional comments please 
notify me directly.'
      ); 


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
       increment_sequence('tspd_template_email_seq'),
      'REVIEW_NONFINAL_SNAPSHOT',
      'Protocol <protocol id> / <snapshot name> document posted for your review',
'The <protocol id> / <snapshot name> protocol has been posted for your review.
Please log into TrialSpace Designer to review and add your comments.  
Once your review is complete, please submit and sign your review.  
If you are unable to complete your review you may re-assign the 
review to another reviewer.');

  INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES (
      increment_sequence('tspd_template_email_seq'),
      'SUBMIT_REVIEW',
      'Review submitted for protocol <protocol id> / <snapshot name>',
'<reviewer display name> has submitted a review for protocol <protocol id> / <snapshot name>
Review Status: <completion status> / <review status>
Notes: <review notes>');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_DELETED',
  'Change in roles for protocol <protocol id>',
  '<user being deleted> has been deleted as <user role> from protocol <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_ADDED',
  'Change in roles for protocol <protocol id>',
  '<user being added> has been added as <user role> to protocol <protocol id>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'USER_TRIAL_ROLE_REPLACED',
  'Change in roles for protocol <protocol id>',
  '<user being added> has been added as <user role> to protocol <protocol id>.  <user being replaced> has been replaced as <user role>.');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REASSIGN_AUTHOR',
  'Change in authorship for protocol <protocol id>',
  'Authorship of protocol <protocol id> has been reassigned to <new author>.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REASSIGN_REVIEWER',
  'Change in reviewer for protocol <protocol id> / <snapshot name>',
  '<reviewer being added> has been added as reviewer to protocol <protocol id> / <snapshot name>.  <reviewer being replaced> has been replaced as reviewer.');



INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REVIEW_CC',
  'Protocol <protocol id> / <snapshot name>',
'The <protocol id> / <snapshot name> protocol is available for your review.  
You will find it attached to this message in PDF format.');

INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'FINAL_SNAPSHOT',
  'Final protocol <protocol id> created', 
'The final <protocol id> protocol has been created.  You will find it attached 
to this message in PDF format.');


INSERT INTO tspd_template_email (id, template_name, subject, message_text) VALUES
( increment_sequence('tspd_template_email_seq'),
  'REVIEWER_REMINDER',
  'Protocol <protocol id> / <snapshot name> document will be closed for review in <# days> days',
'The <protocol id> / <snapshot name> protocol will be closed for your review in 
<# days> days.  Your review has not yet been completed.  Please log in to the 
TrialSpace Designer to review and add your comments.  Once your review is 
complete, please submit and sign your reivew.  If you are unable to complete 
your review you may re-assign the review to another reviewer.');

commit;

-- Following chnages are as per the request of Kelly/Fiammetta on 11/6/2003 at 11 am

update id_control set NEXT_ID=10000 where
lower(table_name) = 'tspd_template';

insert into id_control select 'tsm10','shared_tspd_template',
max(id)+1 from tspd_template;

commit;

-- Following chnages are as per the request of Kelly on 11/14/2003 at 10am

Alter table tspd_template add constraint
tspd_template_uq1 unique(CLIENT_DIV_ID, NAME)
using index tablespace TSPDSMALL_INDX
pctfree 10;


-- Following chnages are done by Debashish to implement IPT in production

Rename IPM_PH1_COEFF to OLDIPM_PH1_COEFF;
Rename IPM_PHASE2TO4 to OLDIPM_PHASE2TO4;
Rename IPM_PHASE2TO4_2000 to OLDIPM_PHASE2TO4_2000;
Rename IPM_PHASE2TO4_2000I to OLDIPM_PHASE2TO4_2000I;
Rename IPM_PHASE2TO4_G to OLDIPM_PHASE2TO4_G;
Rename IPM_PHASE2TO4_I to OLDIPM_PHASE2TO4_I;
Rename IPM_PHASE2TO4_REPORT to OLDIPM_PHASE2TO4_REPORT;
Rename IPM_PHASE2TO4_REPORTI to OLDIPM_PHASE2TO4_REPORTI;
Rename IPM_PHASE2TO4_REPORT_RANGE to OLDIPM_PHASE2TO4_REPORT_RANGE;
Rename IPM_PHASE2TO4_REPORT_RANGEI to OLDIPM_PHASE2TO4_REPORT_RANGEI;
Rename IPM_PHASE2TO4_VIEW to OLDIPM_PHASE2TO4_VIEW;
Rename IPT_GRANTS to OLDIPT_GRANTS;
Rename IPT_GRANTS_PH2 to OLDIPT_GRANTS_PH2;
Rename IPT_GRANTS_PH2_2000 to OLDIPT_GRANTS_PH2_2000;
Rename IPT_GRANTS_PH2_2000I to OLDIPT_GRANTS_PH2_2000I;
Rename ipm_inclusion to oldipm_inclusion;
Rename IPM_PH2TO4_ADJ_INDEX to OLDIPM_PH2TO4_ADJ_INDEX;
Alter table investig drop column GRANT_TOTAL_USD;

-- Implemented in tsm10@tonya upto this on 11/17/2003 at 11:00 AM

-- Following chnages are as per the request of Kelly on 11/24/2003 at 1:45PM

conn ftcommon/******@??????

Alter table application drop constraint APPLICATION_APP_NAME_CHECK;

Insert into ftcommon.application(ID,APP_NAME,EXTERNAL_NAME) 
values(3,'TSPD','TrialSpace Designer');

Alter table application add constraint APPLICATION_APP_NAME_CHECK
check (app_name in ('PICASE', 'TRACE','TSPD'));

commit;

-- Following changes are as per the request of Kelly on 12/03/2003 at 3:40 PM

Alter table tspd_template add(software_version varchar(20));
Alter table tspd_document add(software_version varchar(20));

-- Following chnages are as per the request of Kelly on 12/08/2003 at 13:15

Alter table tspd_template add (updated_by_ftuser_id number(10));

Alter table tspd_template add constraint
	tspd_template_fk2 foreign key (updated_by_ftuser_id)
	references ftuser(id);

-- Following chnages are as per the request of Kelly on 12/08/2003 at 16:25

create or replace view tspd_document_noblob as 
select id,trial_id,document_type,document_name,
author_ftuser_id,create_date,last_updated,
version_timestamp,snapshot_type,snapshot_name,
snapshot_notes, review_by_date,review_by_time,
amend_to_tspd_document_id,icp_instance_id,
snapshot_status,document_notes,snapshot_create_date,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
SOFTWARE_VERSION from tspd_document;

create or replace view tspd_template_noblob as 
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID
from tspd_template;

-- Folowing changes are for 2004Q1 import

Alter table payments add(outlier_cd number(1) default 0 not null);
Alter table payments add constraint payments_outlier_cd_check
	check(outlier_cd in (0,1,2)); 

-- Implemented in tsm10@tonya upto this on 1/20/2004 at 10:53 AM

-- Following chnages are as per the request of Kelly and venkata on 01-20-2004 at the meeting at 1:30PM

Alter table currency add (is_viewable number(1) default 0 not null);

Alter table currency add constraint currency_is_viewable_check
	check(is_viewable in (0,1));

update currency a set a.is_viewable = (select max(b.is_viewable) from country b
       where b.currency_id = a.id ) where exists (select c.id from country c
       where c.currency_id = a.id);

update currency set (name,symbol,is_viewable) = (select 'Yen','¥',1 from dual)
where id = (select currency_id from country where abbreviation='JAP');


commit;

--**************************************************************
-- Implemented in tsm10@tonya upto this on 1/21/2004 at 10:00 AM
--**************************************************************


create table tspd_template_history (
	id	NUMBER(10),
        history_date    date not null,
        tspd_template_id number(10) not null,
	client_div_id	NUMBER(10) NOT NULL,
	last_updated	DATE NOT NULL,
	name	VARCHAR2(80)	NOT NULL,
	data	BLOB,
	SOFTWARE_VERSION VARCHAR2(20),
	UPDATED_BY_FTUSER_ID NUMBER(10))
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table tspd_template_history add constraint tspd_template_history_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_template_history add constraint tspd_template_history_fk1
	foreign key (client_div_id) references client_div(id);

Insert into id_control values('tsm10','tspd_template_history',1);
commit;

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
If updating then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id from dual;  
end if;
 :n.last_updated:=sysdate;
end;
/
sho err	


create or replace view tspd_template_history_noblob 
as select ID,HISTORY_DATE,TSPD_TEMPLATE_ID ,CLIENT_DIV_ID,
LAST_UPDATED,NAME,SOFTWARE_VERSION,UPDATED_BY_FTUSER_ID
from tspd_template_history;



-- Following chnages were done to fix the data related bug in GM1.2

update ip_business_factors set(low,med,high) =
(select 0.031185,0.051518,0.071851 from dual) where type='Dosing';
update ip_business_factors set(low,med,high) =
(select 0.008403,0.011158,0.013912 from dual) where type='Country';
update ip_business_factors set(low,med,high) =
(select 0.014125,0.017147,0.020178 from dual) where type='Study';
update ip_business_factors set(low,med,high) =
(select 0.001391,0.009042,0.016693 from dual) where type='Populate';
update ip_business_factors set(low,med,high) =
(select 0.038149,0.042842,0.047535 from dual) where type='Ph1dur';
update ip_business_factors set(low,med,high) =
(select 0.041965,0.046714,0.051463 from dual) where type='Confine';

commit;

-- Following changes are as per the request of Tonya on 02-02-2004 at 8:10AM

Alter table trial_budget add(num_entered_patients number(6),
			     num_enrolled_patients number(6));

update trial_budget set num_entered_patients=num_patients;
commit;

Alter table client_div add(def_input_pref varchar2(40) default 'Entering');

alter table ftuser add (input_pref varchar2(40));

-- This procedure is as per the request of Henry on 02-03-2004 at 1:21pm
-- This proceudre will not go t production

create or replace procedure delete_tspd_trial(
trialid in number) 
is

begin

delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid); 
delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);
delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);
delete from tspd_document where trial_id=trialid;
delete from icp_instance where trial_id=trialid;
delete from tspd_trial where trial_id=trialid;
delete from trial where created_by = 'TSPD' and id=trialid;
 
commit;
end;
/

-- Following procedure was created by Debashish on 02-03-2003 at 15:45

Create or replace procedure oracle_sendmail(ftrecipient in varchar2, ftsubject in varchar2, 
ftmessage in varchar2)
is
  c utl_smtp.connection;
 
  PROCEDURE send_header(name IN VARCHAR2, header IN VARCHAR2) AS
  BEGIN
    utl_smtp.write_data(c, name || ': ' || header || utl_tcp.CRLF);
  END;
 
BEGIN
  c := utl_smtp.open_connection('localhost');
  utl_smtp.helo(c, 'fast-track.com');
  utl_smtp.mail(c, 'none@fast-track.com');
  utl_smtp.rcpt(c, ftrecipient);
  utl_smtp.open_data(c);
  send_header('From',    '"FT Alert" <none@fast-track.com>');
  send_header('To',      ftrecipient);
  send_header('Subject', ftsubject);
  utl_smtp.write_data(c, utl_tcp.CRLF || ftmessage);
  utl_smtp.close_data(c);
  utl_smtp.quit(c);
EXCEPTION
  WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
    BEGIN
      utl_smtp.quit(c);
    EXCEPTION
      WHEN utl_smtp.transient_error OR utl_smtp.permanent_error THEN
        NULL; -- When the SMTP server is down or unavailable, we don't have
              -- a connection to the server. The quit call will raise an
              -- exception that we can ignore.
    END;
    raise_application_error(-20107,
      'Oracle failed to send mail due to the following error: ' || sqlerrm);
END;
/


create table oracle_alert_config(
	id	number(10),
	alert_event	varchar2(128),
	email_recipient	varchar2(512),
	email_subject	varchar2(128),
	email_text	varchar2(1024))
	tablespace tspdsmall
	pctused 65 pctfree 20;

Alter table oracle_alert_config add constraint oracle_alert_config_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table oracle_alert_config add constraint oracle_alert_config_uq1
	unique (alert_event) using index tablespace
	tspdsmall_indx pctfree 20;

Insert into id_control values('tsm10','oracle_alert_config',1);
commit;

Insert into oracle_alert_config select increment_sequence('oracle_alert_config_seq'),
	'UserLocked','dmishra@fast-track.com',
	'Info- FastTrack application user has been locked',null from dual;
commit;

-- replace the word ft15xxxxxxx with appropriate user name

grant execute on oracle_sendmail to ft15xxxxxxxx;
grant select on oracle_alert_config to ft15xxxxxxxx;
grant execute on increment_sequence to ft15xxxxxxxx;
grant select,insert,update,delete on audit_hist to ft15xxxxxxx;

conn ft15xxxxxx/*****@?????

create synonym oracle_alert_config for tsm10xxxxxxxx.oracle_alert_config;
create synonym oracle_sendmail for tsm10xxxxxxxx.oracle_sendmail;
create synonym increment_sequence for tsm10xxxxxxxx.increment_sequence;
create synonym audit_hist for tsm10xxxxxxxx.audit_hist;


CREATE OR REPLACE
TRIGGER ftuser_trg4
after update of locked
ON ftuser
referencing new as n old as o
for each row
declare
 AlertMessage varchar2(128);
 AlertRecipient varchar2(512);
 AlertSubject varchar2(128);
begin
 If :n.locked = 1 and :o.locked <> 1 
   then
   select email_recipient,email_subject into AlertRecipient,AlertSubject from oracle_alert_config
   where alert_event = 'UserLocked';
   AlertMessage:='The user '||:o.name||' has been locked on '||to_char(sysdate,'mm/dd/yy')||' at '||to_char(sysdate,'HH24:MI:sS')||' hrs';
   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
end;
/

conn tsm10xxxxxxxxx/****@???

-- Following database changes are as per the request of Tonya on 02-10-2004 at 8:25am

alter table trial_budget add(local_currency_id number(10));
alter table client_div add(messaging_opt number(1) default 1 not null);

Alter table trial_budget add constraint TRIAL_BUDGET_FK11
foreign key (LOCAL_CURRENCY_ID) references currency(id);

Alter table client_div add constraint cd_messaging_opt_check 
check(messaging_opt in (0,1));


-- Following database changes are as per the request of Kelly on 02-16-2004 at 8 am

Alter table CRITERIA drop constraint CRITERIA_TYPE_CHECK;

Alter table CRITERIA add constraint CRITERIA_TYPE_CHECK check(
TYPE in ('Inclusion','Exclusion','NotDefined','Undifferentiated','Other'));

Alter table criteria add (classifier varchar2(128));

Alter table custom_set_item add(
short_desc varchar2(128),
long_desc varchar2(1024));

-- Following chnages are as per the request of Kelly on 02/17/2004 at 11:50 am

Alter table criteria add(other_classifier_desc VARCHAR2(256));

-- Following changes are as per the request of Kelly on 02-18-2004 at 8:53 am

Alter table CRITERIA drop constraint CRITERIA_TYPE_CHECK;

update criteria set type='other' where type='Other';

Alter table CRITERIA add constraint CRITERIA_TYPE_CHECK check(
TYPE in ('Inclusion','Exclusion','NotDefined','Undifferentiated','other'));

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


update country set IS_VIEWABLE=1 where
ABBREVIATION in ('ARG','BRA','CHI','MEX');

update currency set IS_VIEWABLE=1 where id in (
select CURRENCY_ID from country where
ABBREVIATION in ('ARG','BRA','CHI','MEX'));

commit;

-- Following changes are as per the request of Tonya on 02-20-2004 at 8:20 am

Update currency set name='Argenintinian Peso' where id in 
	(select currency_id from country where abbreviation='ARG'); 
Update currency set name='Brazilian Real' where id in 
	(select currency_id from country where abbreviation='BRA'); 
Update currency set name='Chilean Peso' where id in 
	(select currency_id from country where abbreviation='CHI');
Update currency set name='Mexican Peso' where id in 
	(select currency_id from country where abbreviation='MEX');

commit;

-- Following chnages are as per the request of Kelly for only in development database on 02-24-2004 at 8:13

create or replace procedure delete_my_tspd_trial(
myuserid in varchar2) 
is

begin

delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid)); 

delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));


delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

delete from tspd_document where trial_id in (select trial_id from
tspd_trial b, ftuser c where 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));
 

delete from icp_instance where trial_id in (select trial_id from
tspd_trial b, ftuser c where 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

delete from tspd_trial where CREATOR_FTUSER_ID in (select id from
ftuser where upper(name) = upper(myuserid));

delete from trial where created_by = 'TSPD' and
not id in (select trial_id from tspd_trial);

commit;
end;
/
sho err




-- Following chnages are as per the verbal discussion with Kelly on 03-03-2004

Alter table currency add (viewable_flg number(1) default 0 not null);
update currency set viewable_flg=is_viewable;
commit;
Alter table currency add constraint currency_viewable_flg_check
check(viewable_flg in (0,1));

-- Following changes were done on 03-08-2004 after talking to Kelly

Alter table currency drop column is_viewable;


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

conn ft15/***@????

-- Following chnages are as per the verbal discussion with Joel on 03-19-2004 at 10am

alter table ftuser add(failed_login_attempts number(10));

CREATE OR REPLACE
TRIGGER ftuser_trg4
after update of locked,failed_login_attempts
ON ftuser
referencing new as n old as o
for each row
declare
 AlertMessage varchar2(128);
 AlertRecipient varchar2(512);
 AlertSubject varchar2(128);
begin
 If :n.locked = 1 and :o.locked <> 1 
   then
   select email_recipient,email_subject into AlertRecipient,AlertSubject from oracle_alert_config
   where alert_event = 'UserLocked';
   AlertMessage:='The user '||:o.name||' has been locked on '||to_char(sysdate,'mm/dd/yy')||' at '||to_char(sysdate,'HH24:MI:sS')||' hrs';
   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
 If nvl(:n.failed_login_attempts,0) > nvl(:o.failed_login_attempts,0) then

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.login_failed','ftuser',:o.id,'system',205,sysdate from dual;
 end if; 
end;
/

grant update (failed_login_attempts) on ftuser to ftcommon;

conn ftcommon/****@?????

--++++++++++++++++++++++++++++++++++++++++++
---- ***ADJUST THE VIEW FOR ALL SCHEMAS****
--+++++++++++++++++++++++++++++++++++++++++++


create or replace view ftuser as 
select ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,
LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,
locked,failed_login_attempts,'tsm10' environment from ft15.ftuser;

create or replace procedure FailedLoginAttempts
(schemaname in varchar2, username in varchar2)
as
mysql_stmt varchar2(200);
table_name varchar2(70);

begin

table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set failed_login_attempts=nvl(failed_login_attempts,0)+1 where name=:1';
execute immediate mysql_stmt using username;

commit;
end;
/
sho err

conn tsm10/****@???

-- Following changes are as per the request of Kelly on 04-08-2004 at 15:53pm

create table tspd_document_history (
	ID				number(10),
	HISTORY_DATE	 		date NOT NULL,
	TSPD_DOCUMENT_ID		NUMBER(10) NOT NULL,
	TRIAL_ID                        NUMBER(10) NOT NULL,
	DOCUMENT_TYPE                   VARCHAR2(80) NOT NULL,
	DOCUMENT_NAME                   VARCHAR2(256),
	AUTHOR_FTUSER_ID                NUMBER(10) NOT NULL,
	CREATE_DATE                     DATE NOT NULL,
	LAST_UPDATED                    DATE NOT NULL,
	VERSION_TIMESTAMP               NUMBER(10) NOT NULL,
	DATA                            BLOB,
	SNAPSHOT_TYPE                   VARCHAR2(80),
	SNAPSHOT_NAME                   VARCHAR2(256),
	SNAPSHOT_NOTES                  VARCHAR2(1024),
	REVIEW_BY_DATE                  DATE,
	REVIEW_BY_TIME                  VARCHAR2(80),
	AMEND_TO_TSPD_DOCUMENT_ID       NUMBER(10),
	ICP_INSTANCE_ID                 NUMBER(10) NOT NULL,
	SNAPSHOT_STATUS                 VARCHAR2(80),
	DOCUMENT_NOTES                  VARCHAR2(1024),
	SNAPSHOT_CREATE_DATE            DATE,
	SOA_TBL_FORMAT                  BLOB,
	REVIEW_REMINDER_DAYS            NUMBER(2) NOT NULL,
	AMEND_NAME                      VARCHAR2(256),
	LAST_COOKIE                     NUMBER(10),
	SOFTWARE_VERSION                VARCHAR2(20))
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table tspd_document_history add constraint tspd_document_history_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Insert into id_control values('tsm10','tspd_document_history',1);
commit;

create index tspd_document_history_indx1 on tspd_document_history(TSPD_DOCUMENT_ID)
	tablespace tspdsmall_indx pctfree 20;

Create or replace trigger tspd_document_trg1
before insert or update or delete on tspd_document
referencing new as n old as o
for each row
begin
If updating or deleting then
   Insert into tspd_document_history select increment_sequence('tspd_document_history_seq'),
   	sysdate,:o.id,:o.TRIAL_ID,:o.DOCUMENT_TYPE,
	:o.DOCUMENT_NAME,:o.AUTHOR_FTUSER_ID,:o.CREATE_DATE,:o.LAST_UPDATED,
	:o.VERSION_TIMESTAMP,:o.DATA,:o.SNAPSHOT_TYPE,:o.SNAPSHOT_NAME,:o.SNAPSHOT_NOTES,
	:o.REVIEW_BY_DATE,:o.REVIEW_BY_TIME,:o.AMEND_TO_TSPD_DOCUMENT_ID,
	:o.ICP_INSTANCE_ID,:o.SNAPSHOT_STATUS,:o.DOCUMENT_NOTES,:o.SNAPSHOT_CREATE_DATE,
	:o.SOA_TBL_FORMAT,:o.REVIEW_REMINDER_DAYS,:o.AMEND_NAME,:o.LAST_COOKIE,
	:o.SOFTWARE_VERSION from dual;  

   delete from tspd_document_history where id in(
  	select id from (SELECT id,
   	RANK() OVER (PARTITION BY tspd_document_id
   	ORDER BY history_date DESC) rank
   	FROM tspd_document_history where tspd_document_id=:o.id)
   	where rank > 3);

end if;
If updating or inserting then
 :n.last_updated:=sysdate;
end if;
end;
/
sho err	


create or replace view tspd_document_history_noblob as select
	ID,HISTORY_DATE,TSPD_DOCUMENT_ID,TRIAL_ID,DOCUMENT_TYPE,
	DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE,LAST_UPDATED,
	VERSION_TIMESTAMP,SNAPSHOT_TYPE,SNAPSHOT_NAME,SNAPSHOT_NOTES,
	REVIEW_BY_DATE,REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,
	ICP_INSTANCE_ID,SNAPSHOT_STATUS,DOCUMENT_NOTES,SNAPSHOT_CREATE_DATE,
	REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
	SOFTWARE_VERSION from tspd_document_history;

-- Following charges are as per the request of Kelly on 04-12-2004

Alter table tspd_doc_comment modify (comments varchar2(4000));

-- Following chnages are as per the request of Kelly on 04/26/2004 at 4pm

alter table country add (parent_country_id number(10));

alter table country add constraint COUNTRY_FK3 
foreign key(parent_country_id) references country(id);

-- Following chnages are as per the request of Chris/Kelly on 04-26-2004 at 4pm

conn tsm10/welcome
grant select on password_rule to ft15;
grant select on client_div_to_lic_app to ft15;
conn ft15/welcome
create synonym password_rule for tsm10.password_rule;
create synonym client_div_to_lic_app for tsm10.client_div_to_lic_app;

CREATE OR REPLACE
TRIGGER ftuser_trg4
after update of locked,failed_login_attempts
ON ftuser
referencing new as n old as o
for each row
declare
 AlertMessage varchar2(4000);
 AlertRecipient varchar2(512);
 AlertSubject varchar2(128);
 Failed_login_time varchar2(1024);
 Num_failed_attempts number(5);
 password_rule_exists number(1);
 pcontactid number(10);
 
begin
 If nvl(:n.failed_login_attempts,0) > nvl(:o.failed_login_attempts,0) then

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.login_failed','ftuser',:o.id,'system',205,sysdate from dual;
 end if; 

 If :n.locked = 1 and :o.locked <> 1 
   then
    
    if :o.client_div_id is not null 
      then
         select count(*) into password_rule_exists from password_rule where
         client_div_id=:o.client_div_id;

         if password_rule_exists=1 
           then
            select lockout_login_attempts into num_failed_attempts from password_rule 
            where client_div_id=:o.client_div_id;
         else 
            num_failed_attempts:=1;
         end if;
    else
       num_failed_attempts:=1;
    end if;

    declare

     cursor c1 is SELECT rank,to_char(modify_date,'
Mon dd, yyyy hh24:mi:ss')||' hrs PST' mdate FROM
     	(SELECT MODIFY_DATE,
     	RANK() OVER (PARTITION BY ftuser_id,action
     	ORDER BY modify_date DESC) Rank
     	FROM audit_hist where ftuser_id=:o.id and action='auditAction.login_failed')
     	where to_number(to_char(rank)) <= to_number(to_char(num_failed_attempts));
      
    begin
      for ix1 in c1 loop
         Failed_login_time:=ix1.mdate||Failed_login_time;
      end loop;
    end;       
     
  AlertMessage:='From: Fast Track Data Center
Product: TrialSpace Designer
Auto alert: User lockout

The following user has been locked out of TrialSpace Designer:

'||:o.name||' with a user name of '||initcap(:o.first_name)||' '||initcap(:o.last_name)||'

Because of '||to_char(num_failed_attempts)||' consecutive failed attempts to login that occurred on:
'||Failed_login_time||'

Please ensure that this user is contacted and verifies the unsuccessful login attempts before unlocking this user.

For further details please contact client support on: 215-358-1400 opt 2

Thank you

Fast Track Systems Inc';

   select email_subject into AlertSubject from oracle_alert_config
   where alert_event = 'UserLocked';

/*  if :o.client_div_id is not null 
   then
     select principal_contact_id into pcontactid from client_div_to_lic_app
     where client_div_id=:o.client_div_id and app_name='TSPD';
       if pcontactid is null 
        then
    	  select email_recipient  into AlertRecipient from oracle_alert_config
    	  where alert_event = 'UserLocked';
       elsif pcontactid = :o.id 
         then
           AlertRecipient:=:n.email;        
       else  
           select email into AlertRecipient from ftuser where id=pcontactid;
       end if;
  else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserLocked';    
  end if; */

   	  select email_recipient  into AlertRecipient from oracle_alert_config
    	  where alert_event = 'UserLocked';


   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,      
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
end;
/


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

update currency a set (a.name,a.symbol)= (select 'Lev','Lw' from dual)
  where id in (select currency_id from country where abbreviation='BLG');
update currency a set (a.name,a.symbol)= (select 'Lei','L' from dual)
  where id in (select currency_id from country where abbreviation='RUM');
update currency a set (a.name,a.symbol)= (select 'Koruny','Kc' from dual)
  where id in (select currency_id from country where abbreviation='CZE');
update currency a set (a.name,a.symbol)= (select 'Koruny','Sk' from dual)
  where id in (select currency_id from country where abbreviation='SVK');
update currency a set (a.name,a.symbol)= (select 'Rouble','Rb' from dual)
  where id in (select currency_id from country where abbreviation='RIA');
update currency a set (a.name,a.symbol)= (select 'Krooni','KR' from dual)
  where id in (select currency_id from country where abbreviation='EST');
update currency a set (a.name,a.symbol)= (select 'Lati','Ls' from dual)
  where id in (select currency_id from country where abbreviation='LAT');
update currency a set (a.name,a.symbol)= (select 'Litai','L' from dual)
  where id in (select currency_id from country where abbreviation='LIT');
--update currency a set (a.name,a.symbol)= (select 'Dinar','Din' from dual)
--  where id in (select currency_id from country where abbreviation='YUG');
update currency a set (a.name,a.symbol)= (select 'Tolars','SIT' from dual)
  where id in (select currency_id from country where abbreviation='SLO');
update currency a set (a.name,a.symbol)= (select 'Kuna','HRK' from dual)
  where id in (select currency_id from country where abbreviation='CRO');
commit;


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


-- Following chnages are as per the request of Kelly on 05-04-2004

Alter table tspd_document add(
	locale varchar2(20),
	date_format varchar2(30));

Alter table tspd_template add(
	locale varchar2(20),
	date_format varchar2(30));

create or replace view TSPD_TEMPLATE_NOBLOB as
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID,VERSION,
STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,
RETIRED_DATE,locale,date_format from tspd_template;


create or replace view TSPD_DOCUMENT_NOBLOB as
select id,trial_id,document_type,document_name,
author_ftuser_id,create_date,last_updated,
version_timestamp,snapshot_type,snapshot_name,
snapshot_notes, review_by_date,review_by_time,
amend_to_tspd_document_id,icp_instance_id,
snapshot_status,document_notes,snapshot_create_date,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
SOFTWARE_VERSION,locale,date_format from tspd_document;

-- Following chnages are as per the request of Tonya on 05-06-2004 at 7pm

Insert into ftgroup values(24,'GM Client Data Admin');

Alter table unlisted_procedure add(
	low number(12,2),
	mid number(12,2),
	high number(12,2),
	delete_flg number(1));

Alter table unlisted_procedure add constraint
up_delete_flg_check check(delete_flg in (0,1));

-- added for kelly 5/13
Alter table picase_trial add(
   price_cmp_indmap_id number(10,0));

-- added for tonya 5/14:
Alter table ftuser add (
	messaging_flg number (1,0) default 1 not null);

Alter table ftuser add constraint ftuser_messaging_flg_check 
check(messaging_flg in (0,1));

--*******************************************************************************
-- Implemented upto this in tsm10e@TEST and tsm10t@PREV on 05-17-2004 at 4:00pm
--*******************************************************************************

-- this not needed after all, ok to drop, no code released using it
alter table ip_session drop column grp_local_currency_id;

-- not needed, we already had obsolete flag, ok to drop, no code ever used it
alter table unlisted_procedure drop column delete_flg;


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

alter table tspd_template add(
starteam_tag varchar(30));

create or replace view tspd_template_noblob as
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID,VERSION,
STATUS,CREATE_DATE,CREATOR_FTUSER_ID,RELEASED_DATE,
RETIRED_DATE,starteam_tag from tspd_template;

-- bug fix 44V.
--

CREATE OR REPLACE
TRIGGER client_div_to_lic_app_trg1
before insert or update of PRINCIPAL_CONTACT_ID 
ON client_div_to_lic_app
referencing new as n old as o
for each row
declare
new_principal_contact_email varchar2(100);
old_principal_contact_email varchar2(100);

begin

If :n.principal_contact_id is not null 
 then
    select email into  new_principal_contact_email from ftuser where
    id=:n.principal_contact_id;

    select email into  old_principal_contact_email from ftuser where
    id=:o.principal_contact_id;

    If :n.alert_email is null or :o.alert_email = old_principal_contact_email
     then
       :n.alert_email:=new_principal_contact_email;
    end if;
end if;
end;
/

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

Insert into application values (4,'FTADMIN','FTADMIN',null);
Commit;

conn tsm10/******@????????


-- Following was to fix the YUG problem by debashish on 6-7-04

update country set currency_id=null where
abbreviation='YUG';

commit;


-- Following changes are as per the request of Kelly on 06-10-2004

Alter table procedure_def add (short_desc varchar2(256));
Alter table odc_def add (short_desc varchar2(256));

--Following changes are made on 07-17-2004 at 7:40pm as per Kelly

alter table PICAS_VISIT_SET_ITEM drop constraint PVS_TRIAL_PHASE_CHECK

alter table PICAS_VISIT_SET_ITEM add constraint
PVS_TRIAL_PHASE_CHECK check(trial_phase in
('Screening','Treatment','Follow Up','Other','Withdrawal','Discontinuation'));

-- Following changes are as per the request of Kelly on 07-22-2004 at 13:20

Alter table ip_session modify (comments varchar2(4000));

-- Following changes are as per the request of Kelly on 07-27-2004 at 3:20am

alter table temp_procedure add(entry_date date);

-- Following changes are as per the request of Nancy on 07-30-2004 at 15:45 

update trial_budget set final=0 where final is null;
commit;
alter table trial_budget modify(final default 0 not null);

-- Following changes are ass per the request of Kelly on 07-30-2004 at 14:40

Alter table temp_procedure add (Primary_indication_flg number(1) default 1 not null);


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

Alter table ftuser modify (MESSAGING_FLG null);
ALTER TABLE FTUSER MODIFY (MESSAGING_FLG  DEFAULT NULL);

-- Following changes are as per the request of Kelly on 09-01-2004 at 16:18

Alter table ip_session_detail add(num_visits number(10));

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

--*********************************************
--*********************************************
--CHANGES AFTER GM1.30 STARTS HERE
--*********************************************
--*********************************************

-- This is as per the request of Kelly on 10-11-2004 at 9am

Alter table procedure_def add(usage_rank number(5));

create table client_div_to_top_proc ......

--Following changes are as per the request of Kelly on 10-14-2004at 7am

alter table cost_item add(LONG_DESC VARCHAR2(256));

-- Following changes are as per the request of Phil on 10-14-2004 at 7:18 am

alter table client_div add(alt_plan_currency_id number(10));

alter table  client_div add constraint CLIENT_DIV_FK8
foreign key (alt_plan_currency_id) references currency(id);

-- Following changes are as per the request of Phil on 10-15-2004 at 4:40pm

--****************************************************
--FOLLOWING MUST BE DONE CAREFULLY AND ft15xxxx MUST BE
--REPLACED WITH ACTUAL FT15?

grant select,references on currency to ft15xxxx;

conn ft15xxx/****@????????

create synonym currency for tsm10xxxx.currency

alter table ftuser add(alt_plan_currency_id number(10));

alter table  ftuser add constraint FTUSER_FK6
foreign key (alt_plan_currency_id) references currency(id)

--********************************************************

-- Following changes are as per the request of Kelly on 10-19-2004

alter table payments add (checked varchar2(20));


-- Following chnages are as suggested by debashish on 10-20-2004

create table temp13_procedure(
	id number(10),
	indmap_id number(10),
	country_id number(10),
	currency_id number(10),
	grant_date date,
	payment number(16,2),
	phase_id number(10),
	mapper_id number(10),
	institution_id number(10),
	build_code_id number(10) not null,
	primary_flg number(1) default 0 not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	active_flg number(1) default 0 not null,
	payments_id number(10),
	ENTRY_DATE DATE,
	PRIMARY_INDICATION_FLG NUMBER(1) default 1 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;	


Create table temp13_odc(
	id number(10),
	active_flg number(1) default 0 not null,
	indmap_id number(10),
	country_id number(10),
	protocol_id number(10),
	currency_id number(10),
	cpp number(16,2),
	cpv number(16,2),
	cpgv number(16,2),
	institution_id number(10),
	payment number(16,2),
	phase_id number(10),
	mapper_id number(10),
	build_code_id number(10) not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	payments_id number(10),
        GRANT_DATE date,            
	ENTRY_DATE date,            
	PRIMARY_INDICATION_FLG number(1) default 1 not null)
	tablespace tsmsmall
	pctused 60 pctfree 25;	

	
Create table temp13_overhead(
	id number(10),
	adj_other_pct number(16,2),
	adj_ovrhd_pct number(16,2),
	affiliation varchar2(20),
	indmap_id number(10),
	country_id number(10),
	protocol_id number(10),
	grant_date date,
	institution_id number(10),
	ovrhd_basis varchar2(80),
	ovrhd_pct number(16,2),
	pct_paid number(16,2),
	phase_id number(10),
	zip_code varchar2(20),
	build_code_id number(10) not null,
	adj18mo_flg number(1) default 0 not null,
	primary_flg number(1) default 0 not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	active_flg number(1) default 0 not null,
	investig_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

Create table temp13_inst_to_company(
	id number(10),
	institution_id number(10),
	build_code_id number(10) not null,
	phase_id number(10),
	ta_indmap_id number(10), 
	country_id number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;	

create table temp13_ip_study_price (
	id number(10),
	indmap_id number(10),
	country_id number(10),
	cpp number(16,2),
	cpv number(16,2),
	phase_id number(10),
	build_code_id number(10) not null,
	ta_indmap_id number(10),
	indgroup_indmap_id number(10),
	investig_id number(10),
	active_flg number(1) default 0 not null,
	phase1type_ID number(10))
	tablespace tsmsmall
	pctused 60 pctfree 25;

Insert into id_control select 'tsm10', 'temp13_inst_to_company', nvl(max(id),0)+1 from TEMP13_INST_TO_COMPANY ;
Insert into id_control select 'tsm10', 'temp13_ip_study_price', nvl(max(id),0)+1 from TEMP13_IP_STUDY_PRICE ;
Insert into id_control select 'tsm10', 'temp13_odc', nvl(max(id),0)+1 from TEMP13_ODC ;
Insert into id_control select 'tsm10', 'temp13_overhead', nvl(max(id),0)+1 from TEMP13_OVERHEAD ;
Insert into id_control select 'tsm10', 'temp13_procedure', nvl(max(id),0)+1 from TEMP13_PROCEDURE ;

drop sequence temp13_procedure_seq;
drop sequence temp13_odc_seq;
drop sequence temp13_overhead_seq;
drop sequence temp13_inst_to_company_seq;
drop sequence temp13_ip_study_price_seq;

create sequence temp13_procedure_seq;
create sequence temp13_odc_seq;
create sequence temp13_overhead_seq;
create sequence temp13_inst_to_company_seq;
create sequence temp13_ip_study_price_seq;

Alter table temp13_procedure add constraint temp13_procedure_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_procedure add constraint tp13_primary_flg_check 
	check(primary_flg in (0,1));

alter table temp13_procedure add constraint tp13_active_flg_check
check(active_flg in (0,1));

Alter table temp13_odc add constraint temp13_odc_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_odc add constraint temp3_odc_active_check 
	check (active_flg in (0,1));

Alter table temp13_overhead add constraint temp13_overhead_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_overhead add constraint temp13_ovrhd_affiliation_check
	check( affiliation in ('Affiliated','Unaffiliated','Both'));

Alter table temp13_overhead add constraint 
	temp13_ovrhd_adj18mo_flg_check
	check (adj18mo_flg in (0,1));

Alter table temp13_overhead add constraint to13_primary_flg_check
	check( primary_flg in(0,1));

alter table temp13_overhead add constraint to13_active_flg_check
check(active_flg in (0,1));

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_ip_study_price add constraint 
	temp13_ip_study_price_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table temp13_ip_study_price add constraint 
	tisp13_active_flg_check
	check (active_flg in (0,1));

drop index TEMP13_IP_STUDY_PRICE_indx1;
drop index TEMP13_ODC_indx1;
drop index TEMP13_OVERHEAD_indx1;
drop index TEMP13_PROCEDURE_indx1;
drop index TEMP13_PROCEDURE_indx2;


create index TEMP13_IP_STUDY_PRICE_indx1 on 
	TEMP13_IP_STUDY_PRICE(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_ODC_indx1 on 
	TEMP13_ODC(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_OVERHEAD_indx1 on 
	TEMP13_OVERHEAD(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_PROCEDURE_indx1 on 
	TEMP13_PROCEDURE(country_id)
	tablespace tsmlarge_indx pctfree 25;

create index TEMP13_PROCEDURE_indx2 on 
	TEMP13_PROCEDURE(mapper_id)
	tablespace tsmlarge_indx pctfree 25;

Alter table temp13_procedure add constraint temp13_procedure_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_procedure add constraint temp13_procedure_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_procedure add constraint temp13_procedure_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_procedure add constraint temp13_procedure_fk4
	foreign key (currency_id) references 
	country(id);

Alter table temp13_procedure add constraint temp13_procedure_fk5
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_procedure add constraint temp13_procedure_fk6
	foreign key (mapper_id) references 
	mapper(id);

Alter table temp13_procedure add constraint temp13_procedure_fk7
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_procedure add constraint temp13_procedure_fk8
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_procedure add constraint temp13_procedure_fk9
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_odc add constraint temp13_odc_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_odc add constraint temp13_odc_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_odc add constraint temp13_odc_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_odc add constraint temp13_odc_fk4
	foreign key (currency_id) references 
	country(id);

Alter table temp13_odc add constraint temp13_odc_fk5
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_odc add constraint temp13_odc_fk6
	foreign key (mapper_id) references 
	mapper(id);

Alter table temp13_odc add constraint temp13_odc_fk7
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_odc add constraint temp13_odc_fk8
	foreign key (protocol_ID) references 
	protocol(id);

Alter table temp13_odc add constraint temp13_odc_fk9
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_odc add constraint temp13_odc_fk10
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_overhead add constraint temp13_overhead_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_overhead add constraint temp13_overhead_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_overhead add constraint temp13_overhead_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_overhead add constraint temp13_overhead_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_overhead add constraint temp13_overhead_fk5
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_overhead add constraint temp13_overhead_fk6
	foreign key (protocol_ID) references 
	protocol(id);

Alter table temp13_overhead add constraint temp13_overhead_fk7
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_overhead add constraint temp13_overhead_fk8
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk1
	foreign key (institution_ID) references 
	institution(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk2
	foreign key (build_code_ID) references 
	build_code(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk3
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk4
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_inst_to_company add constraint 
	temp13_inst_to_company_fk5
	foreign key (country_id) references 
	country(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk1
	foreign key (indmap_id) references 
	indmap(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk2
	foreign key (country_id) references 
	country(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk3
	foreign key (build_code_id) references 
	build_code(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk5
	foreign key (ta_indmap_id) references 
	indmap(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk6
	foreign key (indgroup_indmap_id) references 
	indmap(id);

Alter table temp13_ip_study_price add constraint temp13_ip_study_price_fk7
	foreign key (phase1type_id) references 
	phase(id);

-- Following changes are as per the request of Kelly on 10-26-2004 at 7pm

Alter table temp_ip_study_price add(PRIMARY_INDICATION_FLG number(1) default 1 not null);

Alter table temp_overhead add(PRIMARY_INDICATION_FLG number(1) default 1 not null);

-- Following chnages are as per the request of Kelly on 10-26-2004 at 10:38 pm

alter table temp_odc add(
	grant_date date,
	entry_date date,
	Primary_indication_flg number(1) default 1 not null);


-- Following changes are as per the request of Phil on 01-23-2005

Create table derived_prices(
	ID			NUMBER(10),
	COUNTRY_ID		NUMBER(10),
	MAPPER_ID		NUMBER(10),
	LOW_PRICE		NUMBER(12,2),
	MED_PRICE		NUMBER(12,2),
	HIGH_PRICE		NUMBER(12,2),
	INDMAP_ID		NUMBER(10),
	PHASE_ID		NUMBER(10),
	SOURCE_COUNTRY_ID	NUMBER(10),
	TYPE			VARCHAR2(10))
	tablespace tsmsmall
	pctused 70 pctfree 15;


Alter table derived_prices add constraint derived_prices_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 25;

Alter table derived_prices add constraint derived_prices_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table derived_prices add constraint derived_prices_fk2
	foreign key (mapper_id) references 
	mapper(id);

Alter table derived_prices add constraint derived_prices_fk3
	foreign key (indmap_id) references 
	indmap(id);

Alter table derived_prices add constraint derived_prices_fk4
	foreign key (phase_id) references 
	phase(id);

Alter table derived_prices add constraint derived_prices_fk5
	foreign key (source_Country_id) references 
	Country(id);

insert into id_control values('tsm10','derived_prices',1);
commit;

-- Following changes are as per the request of Michael on 02-10-2005 at 6:25am

Create table tspd_document_authors(
	id NUMBER(10),
	tspd_document_id number(10) not null,
	ftuser_id number(10) not null,
	document_type varchar2(80) not null)
	tablespace tspdsmall 
	pctused 70 pctfree 20;

Alter table tspd_document_authors add constraint tspd_document_authors_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 25;

Alter table tspd_document_authors add constraint tspd_document_authors_fk1
	foreign key (tspd_document_id) references 
	tspd_document(id); 

Alter table tspd_document_authors add constraint tspd_document_authors_fk2
	foreign key (ftuser_id) references 
	ftuser(id);

Alter table tspd_document_authors add constraint tda_document_type_check
	check(document_type in ('Protocol','StudyGuide'));

Alter table tspd_document add(author_relinquished_dt date);

Alter table tspd_document add(author_model_type varchar2(24) default 'PUSH' not null);
Alter table tspd_document add constraint td_author_model_type_check
	check (author_model_type in ('PUSH','PULL'));

Alter table client_div add(author_model_type varchar2(24) default 'PUSH' not null);
Alter table client_div add constraint cd_author_model_type_check
	check (author_model_type in ('PUSH','PULL'));

insert into id_control values('tsm10','tspd_document_authors',1);

commit;


Alter table tspd_document add(public_visible_flg  number(1) default 0 not null);
Alter table tspd_document add constraint td_public_visible_flg_check
	check (public_visible_flg in (0,1));

Alter table client_div add(show_author_model_flg  number(1) default 0 not null);
Alter table client_div add constraint cd_show_author_model_flg_check
	check (show_author_model_flg in (0,1));


-- Following changes are per the request of Michael on 03-04-2005

create or replace procedure delete_my_tspd_trial(
myuserid in varchar2) 
is

begin

delete from tspd_document_authors where tspd_document_id in
(select a.id from tspd_document a, tspd_trial b, ftuser c where
a.trial_id=b.trial_id and
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));


delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid)); 

delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));


delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a, tspd_trial b, ftuser c where 
a.trial_id=b.trial_id and 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

delete from tspd_document where trial_id in (select trial_id from
tspd_trial b, ftuser c where 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));
 

delete from icp_instance where trial_id in (select trial_id from
tspd_trial b, ftuser c where 
b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

delete from tspd_trial where CREATOR_FTUSER_ID in (select id from
ftuser where upper(name) = upper(myuserid));

delete from trial where created_by = 'TSPD' and
not id in (select trial_id from tspd_trial);

commit;
end;
/
sho err

create or replace procedure delete_tspd_trial(
trialid in number) 
is

begin

delete from tspd_document_authors where tspd_document_id in
(select a.id from tspd_document a where a.trial_id=trialid); 


delete from tspd_doc_comment where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid); 

delete from tspd_doc_reviewer where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);


delete from tspd_doc_advisory where tspd_document_id in 
(select a.id from tspd_document a where a.trial_id=trialid);

delete from tspd_document where trial_id=trialid;
 

delete from icp_instance where trial_id=trialid;

delete from tspd_trial where trial_id=trialid;

delete from trial where created_by = 'TSPD' and id=trialid;
 
commit;
end;
/

create or replace procedure delete_tspd_template(
templateid in number)
is

begin

delete from tspd_document_authors where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_doc_comment where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_doc_reviewer where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);


delete from tspd_doc_advisory where
tspd_document_id in (select a.id from tspd_document a,
tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id=templateid);

delete from tspd_document where trial_id in
(select trial_id from tspd_trial where
tspd_template_id=templateid);

delete from icp_instance where trial_id in
(select trial_id from tspd_trial where
tspd_template_id=templateid);

delete from tspd_trial where tspd_template_id=templateid;

delete from tspd_template where id=templateid;

delete from trial where created_by = 'TSPD' and
not id in (select trial_id from tspd_trial);

commit;
end;
/

-- Following chnages are for ECR050 as per the request of Phil on 03-17

insert into currency values (76,'Vietnamese Dong','Dong',15795,1);
insert into country values (91,'Vietnam','VNM',2,76,null,0,1,160,'VN',null,null);

update id_control set next_id=77 where table_name='currency';
update id_control set next_id=92 where table_name='country';

commit;


Alter table country set name='South Korea' 
where name='Korea';

--Insert into currency values (
--increment_sequence('currency_seq'),
--'Vietnamese Dong','Dong',15795,1);

update country set currency_id=
(select id from currency where name='Vietnamese Dong')
where abbreviation='VNM';

Update Currency set name='Phillipino Peso'
where id =(select currency_id from 
country where abbreviation='PHI');

update country set currency_id=
(select id from currency where name='Phillipino Peso')
where abbreviation='PHI';

update Country set name='India, Pakistan' 
where name='India';

update Country set name='Australia, New Zealand' 
where name='Australia';

update country set currency_id=(select 
id from currency where upper(name)='EURO')
where abbreviation='GCE';

Uppdate country set is_viewable=1 where abbreviation in
('CHN','COL','CRA','EGY','GCE','HKG','IND',
'JAP','MIA','PER','PHI','POR','PRT','SIN',
'KOR','TAI','THA','TUR','VEN','VNM');

update currency set viewable_flg=1 where id in(
select currency_id from country where abbreviation in
('CHN','COL','CRA','EGY','GCE','HKG','IND',
'JAP','MIA','PER','PHI','POR','PRT','SIN',
'KOR','TAI','THA','TUR','VEN','VNM'));

commit;

-- Following chnages are as per the request of Tonya on 04-17-2005 at 9:25a

Alter table picase_trial add(comments varchar2(4000));

Alter table trial_budget drop constraint TB_OVERHEAD_TYPE_CHECK;


Alter table trial_budget add constraint TB_OVERHEAD_TYPE_CHECK check(
overhead_type in
('Clientdef','PicasOfficialDef','PicasAdjustedDef','Manual','G50','Clientent'));

-- Folloowing changes are as per request of Phil for derived_prices on 04-19 at 00:20am

Alter table derived_prices drop column mapper_id;
Alter table derived_prices add(procedure_def_id number(10), odc_def_id number(10));

Alter table derived_prices add constraint derived_prices_fk2
	foreign key (procedure_def_id) references 
	procedure_def(id);

Alter table derived_prices add constraint derived_prices_fk6
	foreign key (odc_def_id) references 
	odc_def(id);


Alter table derived_prices add constraint dp_proc_check check (
procedure_def_id is null or odc_def_id is null);

Alter table derived_prices modify(type not null);

Alter table derived_prices add constraint dp_type_check check (
type in ('ODC','PROC'));

Alter table derived_prices drop column INDMAP_ID;
Alter table derived_prices drop column PHASE_ID;
Alter table derived_prices drop column SOURCE_COUNTRY_ID;
Alter table derived_prices modify(country_id not null);

-- Following changes are as per request of Tonya on 04-27-2005 at 9:52pm

Alter table client_div add(ENTERED_OVERHEAD_PCT number(12,2)); 

--Following chnages are as per the request of Phil on 05-09-2005 at 8:20pm

Create table QPL_QUERY_SET(
	ID				NUMBER(10),
	CLIENT_DIV_ID			NUMBER(10) NOT NULL,
	CREATOR_FTUSER_ID		NUMBER(10) NOT NULL,
	CREATE_DT			DATE NOT NULL,
	NAME				VARCHAR2(80) NOT NULL,
	PROCEDURE_DEF_ID		NUMBER(10),
	TRIAL_ID			NUMBER(10),
	CUSTOM_SET_ID			NUMBER(10),
	ODC_NAME			VARCHAR2(256),
	PROC_TYPE			NUMBER(1) NOT NULL,
	COUNTRY_ID			NUMBER(10) NOT NULL,
	REGION_ID			NUMBER(10),
	AFFILIATION_ID			NUMBER(10) NOT NULL,
	PHASE_ID			NUMBER(10) NOT NULL,
	TA_ID				NUMBER(10) NOT NULL)
	tablespace tsmsmall
	pctused 65 pctfree 30;


Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 30;

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk1
	foreign key (CLIENT_DIV_id) references 
	CLIENT_DIV(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk2
	foreign key (CREATOR_ftuser_id) references 
	ftuser(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk3
	foreign key (PROCEDURE_DEF_id) references 
	PROCEDURE_DEF(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk4
	foreign key (TRIAL_id) references 
	TRIAL(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk5
	foreign key (CUSTOM_SET_id) references 
	CUSTOM_SET(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk6
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk7
	foreign key (REGION_ID) references 
	REGION(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk8
	foreign key (PHASE_id) references 
	PHASE(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk9
	foreign key (TA_id) references 
	INDMAP(id);

Alter table qpl_query_set add constraint qqs_proc_type_check
	check(proc_type between 0 and 4);

insert into id_control values('tsm10','qpl_query_set',1);
commit;

-- Following changes are as per the request of Phil on 05-10-2005 at 9:50pm

Create table QPL_QUERY_SET_ITEM(
	ID				NUMBER(10),
	QPL_QUERY_SET_ID		NUMBER(10) NOT NULL,
	PROCEDURE_DEF_ID		NUMBER(10),
	ODC_NAME			VARCHAR2(256),
	COUNTRY_ID			NUMBER(10))
	tablespace tsmsmall
	pctused 65 pctfree 30;


Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_pk 
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 30;

Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_fk1
	foreign key (QPL_QUERY_SET_id) references 
	QPL_QUERY_SET(id);

Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_fk2
	foreign key (PROCEDURE_DEF_id) references 
	PROCEDURE_DEF(id);

Alter table QPL_QUERY_SET_ITEM add constraint QPL_QUERY_SET_ITEM_fk3
	foreign key (COUNTRY_id) references 
	COUNTRY(id);

insert into id_control values('tsm10','qpl_query_set_item',1);
commit;

-- Following request is as per the request of Tonya on 05-17-2005 at 8:18pm

Alter table qpl_query_set add(
	odc_def_id number(10), 
	unlisted_procedure_id number(10));


Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk10
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table QPL_QUERY_SET add constraint QPL_QUERY_SET_fk11
	foreign key (unlisted_procedure_id) references 
	unlisted_procedure(id);


Alter table qpl_query_set_item add(
	unlisted_procedure_id	number(10),
	odc_def_id		number(10),
	proc_type 		NUMBER(1));

Alter table QPL_QUERY_SET_item add constraint QPL_QUERY_SET_item_fk4
	foreign key (odc_def_id) references 
	odc_def(id);

Alter table QPL_QUERY_SET_item add constraint QPL_QUERY_SET_item_fk5
	foreign key (unlisted_procedure_id) references 
	unlisted_procedure(id);


Alter table qpl_query_set_item drop column odc_name;

Alter table qpl_query_set_item add constraint qqsi_proc_type_check
	check(proc_type between 0 and 4);


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  171  DevTSM    1.170       2/27/2008 3:18:14 PM Debashish Mishra  
--  170  DevTSM    1.169       5/17/2005 8:23:42 PM Debashish Mishra Modified qpl*
--       tables
--  169  DevTSM    1.168       5/10/2005 10:02:08 PMDebashish Mishra  
--  168  DevTSM    1.167       5/9/2005 1:01:15 AM  Debashish Mishra  
--  167  DevTSM    1.166       4/19/2005 1:52:25 AM Debashish Mishra  
--  166  DevTSM    1.165       4/17/2005 9:34:31 AM Debashish Mishra  
--  165  DevTSM    1.164       3/18/2005 8:48:59 AM Debashish Mishra  
--  164  DevTSM    1.163       3/3/2005 6:35:51 AM  Debashish Mishra  
--  163  DevTSM    1.162       2/12/2005 7:02:50 PM Debashish Mishra  
--  162  DevTSM    1.161       2/12/2005 7:01:03 PM Debashish Mishra  
--  161  DevTSM    1.160       2/10/2005 10:55:44 PMDebashish Mishra  
--  160  DevTSM    1.159       2/10/2005 7:39:21 AM Debashish Mishra TSD
--       enhancements as requested by Michael on 02-09
--  159  DevTSM    1.158       1/26/2005 7:01:48 AM Debashish Mishra  
--  158  DevTSM    1.157       11/16/2004 12:39:07 AMDebashish Mishra  
--  157  DevTSM    1.156       10/19/2004 10:16:19 PMDebashish Mishra  
--  156  DevTSM    1.155       9/14/2004 7:01:06 AM Debashish Mishra  
--  155  DevTSM    1.154       9/12/2004 3:15:14 AM Debashish Mishra  
--  154  DevTSM    1.153       8/27/2004 3:50:40 PM Debashish Mishra modified
--       ftuser.messaging_flg
--  153  DevTSM    1.152       8/2/2004 1:29:44 PM  Debashish Mishra new column in
--       tremp_procedure table
--  152  DevTSM    1.151       7/27/2004 3:33:01 AM Debashish Mishra new column
--       level2_skip_flg in pap_clinical_proc_cost
--  151  DevTSM    1.150       7/22/2004 3:06:24 PM Debashish Mishra increased
--       column width for ip_session.comments
--  150  DevTSM    1.149       7/17/2004 7:47:03 PM Debashish Mishra modified
--       pvs_trial_phase_check
--  149  DevTSM    1.148       6/10/2004 11:32:03 AMDebashish Mishra  
--  148  DevTSM    1.147       6/10/2004 11:26:27 AMDebashish Mishra  
--  147  DevTSM    1.146       6/4/2004 11:16:11 AM Debashish Mishra Added ftadmin
--       to app_type 
--  146  DevTSM    1.145       6/1/2004 9:15:18 AM  Debashish Mishra  
--  145  DevTSM    1.144       5/27/2004 8:36:09 AM Debashish Mishra updated with
--       all schema changes in last two weeks
--  144  DevTSM    1.143       5/7/2004 10:39:17 AM Debashish Mishra  
--  143  DevTSM    1.142       5/6/2004 8:15:46 PM  Debashish Mishra  
--  142  DevTSM    1.141       4/12/2004 10:12:36 AMDebashish Mishra Increased
--       column width for tspd_doc_comment.comments from 1024 to 4000
--  141  DevTSM    1.140       4/8/2004 4:10:07 PM  Debashish Mishra  
--  140  DevTSM    1.139       3/19/2004 6:17:26 PM Debashish Mishra  
--  139  DevTSM    1.138       3/8/2004 10:37:25 AM Debashish Mishra  
--  138  DevTSM    1.137       3/3/2004 11:00:43 AM Debashish Mishra  
--  137  DevTSM    1.136       2/24/2004 12:27:26 PMDebashish Mishra  
--  136  DevTSM    1.135       2/20/2004 4:54:41 PM Debashish Mishra  
--  135  DevTSM    1.134       2/12/2004 10:41:54 AMDebashish Mishra  
--  134  DevTSM    1.133       2/2/2004 10:53:43 AM Debashish Mishra  
--  133  DevTSM    1.132       1/30/2004 3:29:42 PM Debashish Mishra  
--  132  DevTSM    1.131       12/8/2003 5:57:16 PM Debashish Mishra  
--  131  DevTSM    1.130       12/3/2003 3:23:06 PM Debashish Mishra  
--  130  DevTSM    1.129       11/25/2003 10:39:39 AMDebashish Mishra  
--  129  DevTSM    1.128       11/14/2003 11:49:49 AMDebashish Mishra Added unique
--       constraint to tspd_template
--  128  DevTSM    1.127       10/5/2003 12:21:02 PMDebashish Mishra Added new
--       constrasint value AuthorChange to tspd_document.snapshot_type
--  127  DevTSM    1.126       10/3/2003 3:28:58 PM Debashish Mishra Updated
--       tspd_lib_element_noblob
--  126  DevTSM    1.125       10/3/2003 3:15:25 PM Debashish Mishra new column
--       tspd_lib_element.inline_data
--  125  DevTSM    1.124       10/2/2003 3:24:52 PM Debashish Mishra Removed
--       tspd_doc_advisory.advisory.rule
--  124  DevTSM    1.123       9/26/2003 4:06:07 PM Debashish Mishra  
--  123  DevTSM    1.122       9/22/2003 7:46:35 AM Debashish Mishra modified
--       content_type and content_subtype in tspd_lib_element
--  122  DevTSM    1.121       9/19/2003 9:55:40 AM Debashish Mishra updated
--       tspd_document_noblob view
--  121  DevTSM    1.120       9/16/2003 8:28:47 PM Debashish Mishra  
--  120  DevTSM    1.119       9/9/2003 8:24:06 AM  Debashish Mishra  
--  119  DevTSM    1.118       8/26/2003 4:30:14 PM Debashish Mishra  
--  118  DevTSM    1.117       8/11/2003 12:00:41 PMDebashish Mishra  
--  117  DevTSM    1.116       7/30/2003 4:45:35 PM Debashish Mishra  
--  116  DevTSM    1.115       7/23/2003 2:13:13 PM Debashish Mishra removed
--       default value from tspd_template.last_updated
--  115  DevTSM    1.114       7/23/2003 12:30:38 PMDebashish Mishra Constraint
--       modified in custom_set and unlisted_procedure
--  114  DevTSM    1.113       7/16/2003 4:48:37 PM Debashish Mishra  
--  113  DevTSM    1.112       7/14/2003 5:10:12 PM Debashish Mishra  
--  112  DevTSM    1.111       7/9/2003 5:10:05 PM  Debashish Mishra  
--  111  DevTSM    1.110       7/3/2003 10:30:27 AM Debashish Mishra added
--       procedure_def.foxpro_flg
--  110  DevTSM    1.109       7/3/2003 10:27:08 AM Debashish Mishra Added
--       odc_def.foxpro_flg
--  109  DevTSM    1.108       7/2/2003 5:42:14 PM  Debashish Mishra  
--  108  DevTSM    1.107       6/30/2003 8:59:04 AM Debashish Mishra New column
--       client_div.build_tag_id
--  107  DevTSM    1.106       6/19/2003 3:26:41 PM Debashish Mishra Added
--       constraint values to custom_set.type and unlisted_procedure.type 
--  106  DevTSM    1.105       6/3/2003 10:38:25 AM Debashish Mishra Added new
--       column client_div_to_lic_app.patch_version 
--  105  DevTSM    1.104       5/30/2003 6:22:12 PM Debashish Mishra New columns to
--       ftuser and client_div table
--  104  DevTSM    1.103       5/29/2003 4:01:40 PM Debashish Mishra  
--  103  DevTSM    1.102       5/28/2003 3:48:09 PM Debashish Mishra  
--  102  DevTSM    1.101       5/28/2003 1:27:32 PM Debashish Mishra  
--  101  DevTSM    1.100       5/22/2003 2:51:57 PM Debashish Mishra new TSPD
--       tables
--  100  DevTSM    1.99        5/14/2003 3:33:55 PM Debashish Mishra  
--  99   DevTSM    1.98        5/13/2003 4:55:12 PM Debashish Mishra unique
--       constraint in trial table
--  98   DevTSM    1.97        5/8/2003 3:05:44 PM  Debashish Mishra  
--  97   DevTSM    1.96        5/2/2003 10:14:06 AM Debashish Mishra  
--  96   DevTSM    1.95        4/24/2003 12:17:44 PMDebashish Mishra Constraint
--       change in trial budget for Joel
--  95   DevTSM    1.94        4/23/2003 5:16:00 PM Debashish Mishra  
--  94   DevTSM    1.93        4/18/2003 8:09:48 PM Debashish Mishra  
--  93   DevTSM    1.92        4/15/2003 4:36:55 PM Debashish Mishra  
--  92   DevTSM    1.91        4/15/2003 11:06:13 AMDebashish Mishra New columns
--       added to client_div
--  91   DevTSM    1.90        4/11/2003 11:19:43 AMDebashish Mishra Added new
--       constraint value 'DELETED' to trial.trial_status
--  90   DevTSM    1.89        3/26/2003 10:04:52 AMDebashish Mishra  
--  89   DevTSM    1.88        2/19/2003 1:48:43 PM Debashish Mishra  
--  88   DevTSM    1.87        1/21/2003 1:20:40 PM Debashish Mishra  
--  87   DevTSM    1.86        11/4/2002 1:49:04 PM Debashish Mishra Updated after
--       updating qa,prev and prod databases
--  86   DevTSM    1.85        11/4/2002 12:02:50 PMDebashish Mishra added
--       ftuser.can_model_flag
--  85   DevTSM    1.84        10/29/2002 4:31:33 PMDebashish Mishra  
--  84   DevTSM    1.83        10/24/2002 3:40:53 PMDebashish Mishra  
--  83   DevTSM    1.82        10/21/2002 2:17:42 PMDebashish Mishra  
--  82   DevTSM    1.81        10/17/2002 4:10:21 PMDebashish Mishra  
--  81   DevTSM    1.80        10/10/2002 3:41:04 PMDebashish Mishra dropped
--       sequences
--  80   DevTSM    1.79        10/9/2002 4:50:46 PM Debashish Mishra constraint
--       change in trial_budget
--  79   DevTSM    1.78        10/7/2002 10:26:00 AMDebashish Mishra Migration of
--       #6002-4 codes
--  78   DevTSM    1.77        10/4/2002 9:30:36 AM Debashish Mishra changes
--       relatred to new id_control table and #600* proccode changes
--  77   DevTSM    1.76        10/2/2002 5:17:39 PM Debashish Mishra Updated
--       task_template set end milestone=7 where id=62
--  76   DevTSM    1.75        10/2/2002 10:06:57 AMDebashish Mishra updated start
--       and end milestone id to 6,7 for id's = 82,102,106,109,117 id's 52,101,105
--       remains unchanged.
--  75   DevTSM    1.74        9/30/2002 5:00:35 PM Debashish Mishra Updated 
--       task_template static data 
--  74   DevTSM    1.73        9/26/2002 4:09:26 PM Debashish Mishra  
--  73   DevTSM    1.72        9/25/2002 4:13:30 PM Debashish Mishra 3 new tables.
--       modelled_inclusion, modelled_standardize ad modelled_upfence
--  72   DevTSM    1.71        9/17/2002 9:17:13 AM Debashish Mishra Update to
--       task_template
--  71   DevTSM    1.70        9/16/2002 3:46:57 PM Debashish Mishra New table:
--       Application
--  70   DevTSM    1.69        9/13/2002 2:48:01 PM Debashish Mishra New column
--       client_div_to_lic_app.version
--  69   DevTSM    1.68        9/12/2002 11:45:16 AMDebashish Mishra  
--  68   DevTSM    1.67        9/12/2002 9:06:33 AM Debashish Mishra New views in
--       ftcommon
--  67   DevTSM    1.66        9/11/2002 10:35:00 AMDebashish Mishra chnages to
--       ip_business_factors for num_days for ph2+dur type
--  66   DevTSM    1.65        9/6/2002 11:19:50 AM Debashish Mishra new table
--       md_odc_oh_pct
--  65   DevTSM    1.64        9/3/2002 2:54:12 PM  Debashish Mishra modified
--       modelled_coeff.coeff
--  64   DevTSM    1.63        9/3/2002 2:30:24 PM  Debashish Mishra new table
--       modelled_coeff
--  63   DevTSM    1.62        8/30/2002 12:44:09 PMDebashish Mishra Phils'
--       requested changes for picas-eu
--  62   DevTSM    1.61        8/20/2002 3:04:41 PM Debashish Mishra Modified for
--       picas-eu
--  61   DevTSM    1.60        8/20/2002 12:48:19 PMDebashish Mishra Modified for
--       multiple schema support
--  60   DevTSM    1.59        8/16/2002 11:14:54 AMDebashish Mishra  
--  59   DevTSM    1.58        8/7/2002 12:13:12 PM Debashish Mishra  
--  58   DevTSM    1.57        8/7/2002 12:05:00 PM Debashish Mishra Implemented
--       changes in trace static data for Peter
--  57   DevTSM    1.56        7/24/2002 9:34:50 AM Debashish Mishra Added
--       rate_set.fte_hours_month
--  56   DevTSM    1.55        7/22/2002 11:33:20 AMDebashish Mishra
--       trace_estimate.ivr_flg modified to default 1 not null
--  55   DevTSM    1.54        7/22/2002 9:33:32 AM Debashish Mishra modified
--       trace_estimate.query_page_pct to number(5,2)
--  54   DevTSM    1.53        7/19/2002 3:40:13 PM Debashish Mishra added
--       trace-estimate.ivr_flg
--  53   DevTSM    1.52        7/19/2002 2:17:31 PM Debashish Mishra Implemented in
--       test2 and test1
--  52   DevTSM    1.51        7/17/2002 12:44:25 PMDebashish Mishra dropped table
--       user_preferences
--  51   DevTSM    1.50        7/15/2002 1:35:48 PM Debashish Mishra  
--  50   DevTSM    1.49        7/12/2002 4:13:36 PM Debashish Mishra Modified
--       audit_hist.comments to varchar2(4000)
--  49   DevTSM    1.48        7/12/2002 3:53:29 PM Debashish Mishra Modified
--       constraint in trial.created_by
--  48   DevTSM    1.47        7/12/2002 3:41:37 PM Debashish Mishra New table
--       user_pref
--  47   DevTSM    1.46        7/10/2002 4:16:50 PM Debashish Mishra
--       Updates/inserts into role_to_task_template
--  46   DevTSM    1.45        7/9/2002 3:05:44 PM  Debashish Mishra Modified the
--       trigger in ftuser to update the display name only when its null
--  45   DevTSM    1.44        7/9/2002 1:26:59 PM  Debashish Mishra added
--       trial_budget.delete_flg for picas-e ECR35 
--  44   DevTSM    1.43        7/2/2002 1:25:41 PM  Debashish Mishra Added one
--       constraint to role_inst and a temporary procedure to populate it
--  43   DevTSM    1.42        7/1/2002 11:32:16 AM Debashish Mishra Name change
--       for FSU
--  42   DevTSM    1.41        6/25/2002 2:48:49 PM Debashish Mishra dropped
--       trace_audit_history and budget_audit_hist tables
--  41   DevTSM    1.40        6/18/2002 9:39:06 AM Debashish Mishra updates for
--       country.iso_country
--  40   DevTSM    1.39        6/18/2002 8:47:15 AM Debashish Mishra Changes in
--       client_div and country for iso_lang and iso_country codes
--  39   DevTSM    1.38        6/17/2002 10:59:49 AMDebashish Mishra Name change
--       for FSU block
--  38   DevTSM    1.37        6/17/2002 9:16:57 AM Debashish Mishra dropped
--       columns from role_to_task_template, task_inst, trace_estimate and
--       trace_trial
--  37   DevTSM    1.36        6/13/2002 11:52:40 AMDebashish Mishra  
--  36   DevTSM    1.35        6/4/2002 10:04:21 AM Debashish Mishra Incremental
--       changes
--  35   DevTSM    1.34        5/23/2002 5:26:15 PM Debashish Mishra  
--  34   DevTSM    1.33        5/21/2002 1:01:43 PM Debashish Mishra  
--  33   DevTSM    1.32        5/16/2002 10:17:01 AMDebashish Mishra  
--  32   DevTSM    1.31        5/15/2002 9:46:02 AM Debashish Mishra  
--  31   DevTSM    1.30        5/10/2002 1:20:27 PM Debashish Mishra  
--  30   DevTSM    1.29        5/10/2002 10:23:44 AMDebashish Mishra  
--  29   DevTSM    1.28        5/8/2002 4:05:40 PM  Debashish Mishra  
--  28   DevTSM    1.27        5/3/2002 11:20:57 AM Debashish Mishra  
--  27   DevTSM    1.26        4/29/2002 9:39:58 AM Debashish Mishra  
--  26   DevTSM    1.25        4/25/2002 2:31:22 PM Debashish Mishra  
--  25   DevTSM    1.24        4/24/2002 3:17:08 PM Debashish Mishra  
--  24   DevTSM    1.23        4/22/2002 3:27:39 PM Debashish Mishra  
--  23   DevTSM    1.22        4/17/2002 3:48:08 PM Debashish Mishra  
--  22   DevTSM    1.21        4/9/2002 8:23:44 AM  Debashish Mishra  
--  21   DevTSM    1.20        4/4/2002 5:19:41 PM  Debashish Mishra  
--  20   DevTSM    1.19        4/3/2002 7:03:30 PM  Debashish Mishra  
--  19   DevTSM    1.18        3/28/2002 12:04:19 PMDebashish Mishra  
--  18   DevTSM    1.17        3/22/2002 12:52:50 PMDebashish Mishra  
--  17   DevTSM    1.16        3/18/2002 7:43:03 PM Debashish Mishra  
--  16   DevTSM    1.15        3/14/2002 4:04:49 PM Debashish Mishra  
--  15   DevTSM    1.14        3/14/2002 12:11:24 PMDebashish Mishra  
--  14   DevTSM    1.13        3/13/2002 1:04:04 PM Debashish Mishra  
--  13   DevTSM    1.12        3/12/2002 4:40:29 PM Debashish Mishra  
--  12   DevTSM    1.11        3/8/2002 10:53:54 AM Debashish Mishra  
--  11   DevTSM    1.10        3/6/2002 7:03:04 PM  Debashish Mishra  
--  10   DevTSM    1.9         2/27/2002 1:46:13 PM Debashish Mishra  
--  9    DevTSM    1.8         2/26/2002 3:43:18 PM Debashish Mishra  
--  8    DevTSM    1.7         2/22/2002 6:35:03 PM Debashish Mishra  
--  7    DevTSM    1.6         2/21/2002 3:32:07 PM Debashish Mishra  
--  6    DevTSM    1.5         2/18/2002 5:06:33 PM Debashish Mishra utest changes
--  5    DevTSM    1.4         2/12/2002 12:21:11 PMDebashish Mishra  
--  4    DevTSM    1.3         2/7/2002 3:12:20 PM  Debashish Mishra build_code
--       related stuff
--  3    DevTSM    1.2         2/5/2002 3:05:29 PM  Debashish Mishra  
--  2    DevTSM    1.1         2/4/2002 6:28:44 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/4/2002 6:17:12 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

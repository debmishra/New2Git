create table id_control(
 TABLE_OWNER        VARCHAR2(40),
 TABLE_NAME         VARCHAR2(40),
 NEXT_ID            NUMBER(10) not null)
tablespace tcsmall pctfree 20;

Alter table id_control add constraint id_control_pk 
primary key (table_owner,table_name) using index tablespace 
tcsmall_indx pctfree 30;

create table CRO_company(
Id			number(10),
Last_update		Date,
Name			varchar2(256) not null,
Addr1			varchar2(256) not null,
Addr2			varchar2(256),
City			varchar2(256) not null,
State			number(10),
Country_id		number(10) not null,
Zip			varchar2(20) not null,
Phone			varchar2(256),
Fax			varchar2(256),
Email			varchar2(256),
Home_page		Varchar2(256),
Contact			varchar2(256),
Date_formed		Date,
Co_type			varchar2(256),
Legal_form		varchar2(256),
Regoffice_name		varchar2(256),
Regoffice_addr1		varchar2(256),
Regoffice_addr2		varchar2(256),
Regoffice_city		varchar2(256),
Regoffice_state		number(10),
Regoffice_zip		varchar2(256),
Regoffice_cty		number(10),
Regoffice_email		varchar2(256),
Cro_type		varchar2(256),
long_Desc		varchar2(4000) not null,
Client_pct1		Number(10,2),
Client_pct2		Number(10,2),
Client_pct3		Number(10,2),
Total_staff		number(10),
Part_time_staff		number(10),
Full_time_staff		number(10),
Contract_staff		number(10),
Revenue_last_yr		number(10),
Projs_last_six_mos	number(10),
Clinical_staff		number(10),
Data_Mgmt_staff		number(10),
Lab_staff		number(10),
Med_writers_staff	number(10),
Regulatory_staff	number(10),
Qa_staff		number(10),
Dev_pack_staff		number(10),
Tox_staff		number(10),
Parent_co_name		varchar2(256),
other_staff		number(10))
tablespace tcsmall pctfree 20;

Alter table CRO_company add constraint CRO_company_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_company add constraint CRO_company_fk1
	foreign key (Country_id) references 
	Country(id);

insert into id_control values('tc10','cro_company',1);
commit;

create table CRO_ASSOC_COMPANY( 
ID			Number(10),
cro_company_id		Number(10) not null,
Name			Varchar2(256),
Address1		Varchar2(256),
Address2		Varchar2(256),
City			Varchar2(256),
State			Number(10,0),
Country			Number(10,0),
Zip			Varchar2(256),
Phone			Varchar2(256),
Email			Varchar2(256),
Fax			Varchar2(256),
Home_page		Varchar2(256),
Contact_name		Varchar2(256),
Assoc_type		Varchar2(256),
Last_updated		Date not null,
Ftuser_id		Number(10) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_ASSOC_company add constraint CRO_ASSOC_company_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_ASSOC_company add constraint CRO_ASSOC_company_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table CRO_ASSOC_company add constraint CRO_ASSOC_company_fk2
	foreign key (ftuser_id) references 
	ftuser(id);


insert into id_control values('tc10','cro_assoc_company',1);
commit;

create table CRO_COUNTRY_STAFFING ( 
ID		Number(10),
Cro_company_id	Number(10) not null,
Country_id	Number(10) not null,
Staff_count	Number(10),
Experience_area	Number(10),
Last_updated	Date not null,
Ftuser_id	Number(10) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_COUNTRY_STAFFING add constraint CRO_COUNTRY_STAFFING_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_COUNTRY_STAFFING add constraint CRO_COUNTRY_STAFFING_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table CRO_COUNTRY_STAFFING add constraint CRO_COUNTRY_STAFFING_fk2
	foreign key (country_id) references 
	country(id);

Alter table CRO_COUNTRY_STAFFING add constraint CRO_COUNTRY_STAFFING_fk3
	foreign key (ftuser_id) references 
	ftuser(id);


insert into id_control values('tc10','cro_country_staffing',1);
commit;

create table CRO_HW_SW_CODE ( 
ID		Number(10),
Hw_sw_type	Number(10) not null,
Crocas_key	Varchar2(256) not null,
Name		Varchar2(256) not null,
Is_viewable	Number(1) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_HW_SW_CODE add constraint CRO_HW_SW_CODE_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_HW_SW_CODE add constraint cshc_is_viewable_check
	check (is_viewable in (0,1));

Alter table CRO_HW_SW_CODE add constraint cshc_hw_sw_type_check
	check (hw_sw_type in (0,1,2));

insert into id_control values('tc10','cro_hw_sw_code',1);
commit;

create table CRO_EXP_AREA  ( 
ID		Number(10),
Name		Varchar2(256) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_EXP_AREA add constraint CRO_EXP_AREA_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

insert into id_control values('tc10','cro_exp_area',1);
commit;

create table CRO_service_type  ( 
ID		Number(10),
Name		Varchar2(256) not null,
Crocas_key	Varchar2(256) not null,
cro_exp_area_id	Number(10) not null,
Is_viewable	Number(1) not null,
Service_subtype	Varchar2(1))
tablespace tcsmall pctfree 30;

Alter table CRO_service_type add constraint CRO_service_type_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_service_type add constraint CRO_service_type_fk1
	foreign key (cro_exp_area_id) references 
	cro_exp_area(id);

Alter table CRO_service_type add constraint cst_is_viewable_check
	check (is_viewable in (0,1));

insert into id_control values('tc10','cro_service_type',1);
commit;

create table CRO_LANGUAGE  ( 
ID		Number(10),
Language_Name	Varchar2(256) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_LANGUAGE add constraint CRO_LANGUAGES_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

insert into id_control values('tc10','cro_languages',1);
commit;

create table CRO_MED_WRITING_TRANS ( 
ID		Number(10),
Cro_company_id	Number(10) not null,
Cro_language_id	Number(10) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_MED_WRITING_TRANS add constraint CRO_MED_WRITING_TRANS_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_med_writing_trans add constraint CRO_med_writing_trans_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table CRO_med_writing_trans add constraint CRO_med_writing_trans_fk2
	foreign key (Cro_language_id) references 
	Cro_language(id);

insert into id_control values('tc10','cro_med_writing_trans',1);
commit;

create table CRO_HW_SW_USED ( 
ID			Number(10),
Cro_company_id		Number(10) not null,
Cro_hw_sw_code_id	Number(10) not null)
tablespace tcsmall pctfree 30;

Alter table cro_hw_sw_used add constraint cro_hw_sw_used_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table cro_hw_sw_used add constraint cro_hw_sw_used_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table cro_hw_sw_used add constraint cro_hw_sw_used_fk2
	foreign key (Cro_hw_sw_code_id) references 
	Cro_hw_sw_code(id);

insert into id_control values('tc10','cro_hw_sw_used',1);
commit;

create table CRO_study  ( 
ID			Number(10),
Cro_company_id		Number(10) not null,
Project_name		Varchar2(256),
Indmap_id		Number(10),
Phase_id		Number(10),
Num_subjects		Number(10),
Num_sites		Number(10),
Start_date		Date,
Year_completed		Date,
Num_similar_studies	Number(10),
Cro_exp_area_id		Number(10) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_study add constraint CRO_study_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_study add constraint CRO_study_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table CRO_study add constraint CRO_study_fk2
	foreign key (indmap_id) references 
	indmap(id);

Alter table CRO_study add constraint CRO_study_fk3
	foreign key (phase_id) references 
	phase(id);

Alter table CRO_study add constraint CRO_study_fk4
	foreign key (cro_exp_area_id) references 
	cro_exp_area(id);

insert into id_control values('tc10','cro_study',1);
commit;

create table CRO_STUDY_COUNTRY( 
ID			Number(10),
Cro_company_id		Number(10) not null,
Cro_study_id		Number(10) not null,
Cro_exp_area_id		Number(10) ,
country_id			Number(10))
tablespace tcsmall pctfree 30;

Alter table CRO_study_country add constraint CRO_study_country_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_study_country add constraint CRO_study_country_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table CRO_study_country add constraint CRO_study_country_fk2
	foreign key (cro_study_id) references 
	cro_study(id);

Alter table CRO_study_country add constraint CRO_study_country_fk3
	foreign key (country_id) references 
	country(id);

Alter table CRO_study_country add constraint CRO_study_country_fk4
	foreign key (cro_exp_area_id) references 
	cro_exp_area(id);

insert into id_control values('tc10','cro_study_country',1);
commit;


create table CRO_STUDY_service( 
ID			Number(10),
Cro_company_id		Number(10) not null,
Cro_exp_area_id		Number(10) ,
cro_service_type_id	Number(10))
tablespace tcsmall pctfree 30;

Alter table CRO_study_service add constraint CRO_study_service_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_study_service add constraint CRO_study_service_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table CRO_study_service add constraint CRO_study_service_fk2
	foreign key (cro_exp_area_id) references 
	cro_exp_area(id);

Alter table CRO_study_service add constraint CRO_study_service_fk3
	foreign key (cro_service_type_id) references 
	cro_service_type(id);

insert into id_control values('tc10','cro_study_service',1);
commit;

create table CRO_HOURLY_WORK_TYPE  ( 
ID			Number(10),
work_type		Varchar2(256) not null,
parent_work_type_id	number(10))
tablespace tcsmall pctfree 30;

Alter table CRO_HOURLY_WORK_TYPE add constraint CRO_HOURLY_WORK_TYPE_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_HOURLY_WORK_TYPE add constraint CRO_HOURLY_WORK_TYPE_fk1
	foreign key (parent_work_type_id) references 
	CRO_HOURLY_WORK_TYPE(id);

insert into id_control values('tc10','cro_hourly_work_type',1);
commit;

create table CRO_HOURLY_WAGE ( 
ID			Number(10),
Cro_company_id		Number(10) not null,
Contract_name		Varchar2(256),
Cro_hourly_work_type_id	number(10) not null,
Hourly_rate		Number(10,2),
Country_id		Number(10),
Currency_id		Number(10),
Year_entered		Date,
category		Varchar2(256),
Num_hours		Number(10,2))
tablespace tcsmall pctfree 30;

Alter table cro_hourly_wage add constraint cro_hourly_wage_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table cro_hourly_wage add constraint cro_hourly_wage_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table cro_hourly_wage add constraint cro_hourly_wage_fk2
	foreign key (Cro_hourly_work_type_id) references 
	Cro_hourly_work_type(id);

Alter table cro_hourly_wage add constraint cro_hourly_wage_fk3
	foreign key (country_id) references 
	country(id);

Alter table cro_hourly_wage add constraint cro_hourly_wage_fk4
	foreign key (currency_id) references 
	currency(id);

insert into id_control values('tc10','cro_hourly_wage',1);
commit;

 
create table CRO_LOGIN ( 
id              NUMBER(7),
name            VARCHAR2(30) NOT NULL,
password        VARCHAR2(30) NOT NULL,
login_count     NUMBER(10) NULL,
last_updated    DATE DEFAULT sysdate NOT NULL,
cro_company_id      NUMBER(10,0) NOT NULL)
tablespace tcsmall pctfree 30;

Alter table cro_login add constraint cro_login_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table cro_login add constraint cro_login_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

insert into id_control values('tc10','cro_login',1);
commit;   


-- Following chnages have been done in devel & tonya on 06-24-05 at 7:10am

Alter table Cro_company add (
contact_title  		Varchar(256),
regoffice_contact	Varchar(256),
regoffice_contact_title Varchar(256),
regoffice_phone		Varchar(256),
regoffice_fax 		Varchar(256),
regoffice_country_id	number(10),
reg_is_same		number(1));

Alter table CRO_company add constraint CRO_company_fk2
	foreign key (regoffice_country_id) references 
	Country(id);
Alter table cro_company add constraint cc_reg_is_same_check
	check(reg_is_same in (0,1));

Alter table cro_assoc_company add (cro_login_id number(10));
Alter table cro_assoc_company drop column ftuser_id;
 
Alter table CRO_ASSOC_company add constraint CRO_ASSOC_company_fk2
	foreign key (cro_login_id) references 
	cro_login(id);

Alter table CRO_COUNTRY_STAFFING add (cro_login_id number(10));
Alter table CRO_COUNTRY_STAFFING drop column ftuser_id;

Alter table CRO_COUNTRY_STAFFING add constraint CRO_COUNTRY_STAFFING_fk3
	foreign key (cro_login_id) references 
	cro_login(id);

drop table ftuser;

-- Following chnages are as per the request of Debashish on 06-27-05 at 8am

alter table cro_company add(ma_id number(10));
alter table cro_assoc_company modify(country not null);
alter table cro_assoc_company add country_id number(10);
update cro_assoc_company set country_id=country;
commit;
alter table cro_assoc_company modify country_id not null;
alter table cro_assoc_company drop column country;


alter table tc10.cro_service_type modify IS_VIEWABLE null;

alter table tc10.cro_service_type modify CRO_EXP_AREA_ID null;

alter table tc10.cro_study modify cro_exp_area_id null;
alter table tc10.cro_study add (de_id number(10));
 
alter table tc10.cro_study_service
add(cro_study_id number(10));

alter table tc10.cro_study_service
add constraint cro_study_service_fk4 
foreign key (cro_study_id) references
tc10.cro_study(id);

alter table tc10.cro_hw_sw_code modify hw_sw_type null;

alter table tc10.cro_language add language_code
varchar2(10);

alter table tc10.cro_med_writing_trans drop column CRO_LANGUAGE_ID;

alter table tc10.cro_med_writing_trans add(
from_CRO_LANGUAGE_ID number(10) not null,
to_CRO_LANGUAGE_ID number(10) not null);

alter table tc10.cro_hourly_wage modify CRO_COMPANY_ID null;
alter table tc10.cro_hourly_wage add company_name varchar2(64);
alter table tc10.cro_hourly_wage modify CRO_COMPANY_ID null;

create table cro_country_phase(
ID			number(10),
Cro_company_id		number(10) not null,
country_id		number(10) not null,
Phase_id		number(10) not null,
De_study_count		number(10) not null,
Online_flag		number(1) not null)
tablespace tcsmall pctfree 20;

Alter table cro_country_phase add constraint cro_country_phase_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table cro_country_phase add constraint cro_country_phase_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table cro_country_phase add constraint cro_country_phase_fk2
	foreign key (country_id) references 
	country(id);

Alter table cro_country_phase add constraint cro_country_phase_fk3
	foreign key (Phase_id) references 
	Phase(id);

Alter table cro_country_phase add constraint ccp_online_flag_check
	check (online_flag in (0,1));

insert into id_control values('tc10','cro_country_phase',1);
commit;

create table cro_country_indication(
ID			number(10),
Cro_company_id		number(10) not null,
country_id		number(10) not null,
TA_id			number(10) not null,
Indication_group_id	number(10) not null,
De_study_count		number(10) not null,
Online_flag		number(1) not null)
tablespace tcsmall pctfree 20;

Alter table cro_country_indication add constraint cro_country_indication_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table cro_country_indication add constraint cro_country_indication_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table cro_country_indication add constraint cro_country_indication_fk2
	foreign key (country_id) references 
	country(id);

Alter table cro_country_indication add constraint cro_country_indication_fk3
	foreign key (ta_id) references 
	indmap(id);

Alter table cro_country_indication add constraint cro_country_indication_fk4
	foreign key (Indication_group_id) references 
	indmap(id);

Alter table cro_country_indication add constraint cci_online_flag_check
	check (online_flag in (0,1));

insert into id_control values('tc10','cro_country_indication',1);
commit;

create table cro_country_service(
ID			number(10),
Cro_company_id		number(10) not null,
country_id		number(10) not null,
cro_service_type_id	number(10) not null,
De_study_count		number(10) not null,
Online_flag		number(1) not null)
tablespace tcsmall pctfree 20;

Alter table cro_country_service add constraint cro_country_service_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table cro_country_service add constraint cro_country_service_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

Alter table cro_country_service add constraint cro_country_service_fk2
	foreign key (country_id) references 
	country(id);

Alter table cro_country_service add constraint cro_country_service_fk3
	foreign key (cro_service_type_id) references 
	cro_service_type(id);

Alter table cro_country_service add constraint ccs_online_flag_check
	check (online_flag in (0,1));

insert into id_control values('tc10','cro_country_service',1);
commit;

-- Following chnages are done on 08-03-2005 at 8:15am

alter table cro_country_staffing add(cro_exp_area_id number(10));

update cro_country_staffing set cro_exp_area_id=EXPERIENCE_AREA;

update cro_country_staffing set cro_exp_area_id=9 where cro_exp_area_id is null;

alter table cro_country_staffing add constraint CRO_COUNTRY_STAFFING_FK4
foreign key (cro_exp_area_id) references cro_exp_area(id);

-- Following changes are done on 08-04-2005 at 8am as per request of Tonya

alter table cro_country_phase modify(de_study_count null);
alter table cro_country_indication modify(de_study_count null);
alter table cro_country_service modify(de_study_count null);
alter table cro_country_indication add(indmap_id number(10) not null);
alter table cro_country_indication drop column TA_ID;
alter table cro_country_indication drop column INDICATION_GROUP_ID;
--alter table cro_language drop column LANGUAGE_CODE;

alter table cro_med_writing_trans add(CRO_LANGUAGE_ID number(10));
update cro_med_writing_trans set CRO_LANGUAGE_ID=TO_CRO_LANGUAGE_ID;
alter table cro_med_writing_trans modify(CRO_LANGUAGE_ID not null);
alter table cro_med_writing_trans drop column FROM_CRO_LANGUAGE_ID;
alter table cro_med_writing_trans drop column TO_CRO_LANGUAGE_ID;
alter table cro_med_writing_trans add constraint cro_med_writing_trans_fk2
foreign key (CRO_LANGUAGE_ID) references CRO_LANGUAGE(ID);

alter table cro_country_indication add constraint cro_country_indication_fk5
     foreign key(indmap_id) references indmap(id);

commit;

create table CRO_OTHER_HW_SW_CODE ( 
ID		Number(10),
Hw_sw_type	Number(10) not null,
short_desc	Varchar2(256) not null,
cro_company_id	number(10) not null)
tablespace tcsmall pctfree 30;

Alter table CRO_OTHER_HW_SW_CODE add constraint CRO_OTHER_HW_SW_CODE_pk 
	primary key (id) using index tablespace 
	tcsmall_indx pctfree 30;

Alter table CRO_OTHER_HW_SW_CODE add constraint cohsc_hw_sw_type_check
	check (hw_sw_type in (0,1,2));

Alter table CRO_OTHER_HW_SW_CODE add constraint CRO_OTHER_HW_SW_CODE_fk1
	foreign key (cro_company_id) references 
	cro_company(id);

insert into id_control values('tc10','cro_other_hw_sw_code',1);
commit;

-- Following changes are as per the request of Phil on 08-16 at 7:51am

alter table cro_study add (sub_phase_id number(10));

alter table cro_study add constraint CRO_STUDY_FK5 
foreign key(sub_phase_id) references phase(id);

-- Following changes are as per the request of Phil on 08-18

alter table cro_company add(edc_pct number(3),paper_pct number(3));

-- Following changes are as per the request of Phil on 08-23 at 5:30pm

alter table cro_hourly_work_type add(long_desc varchar2(1000));

-- Following chnages are as per Debashish on 08-30 at 1pm

alter table cro_study add (de_studyid number(10));

-- Following chnages are as per the email of Tonya on 08-31-2005 at 9am

alter table cro_country_staffing  drop column EXPERIENCE_AREA;

-- Following chnages are as per Debashish on 09-15-2005 at 10:30am

create index cro_hourly_wage_index1 on cro_hourly_wage(CRO_COMPANY_ID)
tablespace tcsmall_indx pctfree 20;

create index cro_hw_sw_used_index1 on cro_hw_sw_used(CRO_COMPANY_ID)
tablespace tcsmall_indx pctfree 20;

create index cro_hw_sw_used_index2 on cro_hw_sw_used(CRO_HW_SW_CODE_ID)
tablespace tcsmall_indx pctfree 20;





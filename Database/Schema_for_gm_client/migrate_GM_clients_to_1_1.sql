--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: migrate_GM_clients_to_1_1.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:43 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
drop sequence g50_PAP_clinical_proc_cost_seq;
drop sequence g50_pap_overhead_seq;
drop sequence g50_ip_study_price_seq;
drop sequence COMPANY_PAP_ODC_COST_seq;
drop sequence INDUSTRY_PAP_ODC_COST_seq;
drop sequence G50_COMPANY_PAP_ODC_COST_seq;

drop table G50_COMPANY_PAP_ODC_COST;
drop table g50_PAP_clinical_proc_cost;
drop table g50_pap_overhead;
drop table g50_ip_study_price;
drop table COMPANY_PAP_ODC_COST;
drop table INDUSTRY_PAP_ODC_COST;


Create table g50_PAP_clinical_proc_cost(
	id number(10),
	Country_id number(10),
	indmap_id number(10) not null,
	Phase_id number(10) not null,
	mapper_id number(10),
	pct25 number(16,2),
	pct50 number(16,2),
	pct75 number(16,2),
	company_pct50 number(16,2),
	de_price  number(1) default 0 not null,
	co_exp_cnt number(5),
	other_exp_cnt number(5),
	specificity number(10))
	tablespace tsmlarge 
	pctused 70 pctfree 20;

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;	

Alter table g50_PAP_clinical_proc_cost add constraint g50_PCPC_de_price_check 
	check (de_price in (0,1));

Alter table g50_pap_clinical_proc_cost add constraint
	g50_pap_clinical_proc_cost_uq1 
	unique(country_id,mapper_id,phase_id,indmap_id)
	using index tablespace tsmlarge_indx pctfree 20;

Create table g50_IP_study_price(
	id number(10),
	country_id number(10) not null,
	indmap_id number(10) not null,
	phase_id number(10) not null,
	pct25 number(16,2),
	pct50 number(16,2),
	pct75 number(16,2),
	company_pct50 number(16,2),
	de_price number(1) default 0 not null,
	cpp_flg number(1) default 0 not null,
	co_cpp_exp_cnt number(5),
	other_cpp_exp_cnt number(5))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Alter table g50_IP_study_price add constraint g50_IP_study_price_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table g50_IP_study_price add constraint g50_ISP_de_price_check 
	check (de_price in (0,1));

Alter table g50_IP_study_price add constraint g50_ISP_cpp_flg_check 
	check (cpp_flg in (0,1));

Alter table g50_ip_study_price add constraint
	g50_ip_study_price_uq1 
	unique(country_id,indmap_id,phase_id,cpp_flg)
	using index tablespace tsmlarge_indx pctfree 20;


Create table g50_pap_overhead(
	id number(10),
	Country_id number(10),
	phase_id number(10) not null,
        indmap_id number(10) not null,
        company_ovrhd_p50 number(16,2),
	company_odc_p50 number(16,2),
	ofc_ovrhd_p25 number(16,2),
	ofc_ovrhd_p50 number(16,2),
	ofc_ovrhd_p75 number(16,2),
	adj_ovrhd_p25 number(16,2),
	adj_ovrhd_p50 number(16,2),
	adj_ovrhd_p75 number(16,2),
	affiliation varchar2(20) not null,
	odc_p50 number(16,2),
	company_pct_paid_p50 number(16,2),
	pct_paid_p50 number(16,2),
        specificity number(10))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Alter table g50_pap_overhead add constraint g50_pap_overhead_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table g50_pap_overhead add constraint g50_po_affiliation_check 
	check (affiliation in ('Affiliated','Unaffiliated','Both','AllSites'));

Alter table g50_pap_overhead add constraint
	g50_pap_overhead_uq1 
	unique(country_id,affiliation,indmap_id,phase_id)
	using index tablespace tsmlarge_indx pctfree 20;


 
CREATE TABLE INDUSTRY_PAP_ODC_COST(
	ID NUMBER(10),
	COUNTRY_ID NUMBER(10),
	INDMAP_ID NUMBER(10) NOT NULL,
	PHASE_ID NUMBER(10) NOT NULL,
	MAPPER_ID NUMBER(10),
	PRICE_TYPE VARCHAR2(6) NOT NULL,
	PRICE_P25 NUMBER(16,2),
	PRICE_P50 NUMBER(16,2),
	PRICE_P75 NUMBER(16,2),
	SPECIFICITY NUMBER(10,0))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;

Alter table INDUSTRY_PAP_ODC_COST add constraint IPOC_price_type_check 
	check (PRICE_TYPE in ('CPP','VISIT','GLOBAL'));


CREATE TABLE COMPANY_PAP_ODC_COST(
	ID NUMBER(10,0) NOT NULL,
	COUNTRY_ID NUMBER(10,0),
	INDMAP_ID NUMBER(10,0) NOT NULL,
	PHASE_ID NUMBER(10,0) NOT NULL,
	MAPPER_ID NUMBER(10,0),
	PRICE_TYPE VARCHAR2(6) NOT NULL,
	PRICE_P50 NUMBER(16,2),
	SPECIFICITY NUMBER(10,0))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;


Alter table COMPANY_PAP_ODC_COST add constraint CPOC_price_type_check 
	check (PRICE_TYPE in ('CPP','VISIT','GLOBAL'));


Create sequence g50_PAP_clinical_proc_cost_seq;
Create sequence g50_pap_overhead_seq;
Create sequence g50_ip_study_price_seq;
Create sequence COMPANY_PAP_ODC_COST_seq;
Create sequence INDUSTRY_PAP_ODC_COST_seq;

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk3
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table g50_pap_overhead add constraint g50_pap_overhead_fk4
	foreign key (specificity) references 
	"&1".specificity(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table g50_PAP_clinical_proc_cost add constraint g50_PAP_clinical_proc_cost_fk5
	foreign key (specificity) references 
	"&1".specificity(id);

Alter table g50_IP_study_price add constraint g50_IP_study_price_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table g50_IP_study_price add constraint g50_IP_study_price_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table g50_IP_study_price add constraint g50_IP_study_price_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table INDUSTRY_PAP_ODC_COST add constraint INDUSTRY_PAP_ODC_COST_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table COMPANY_PAP_ODC_COST add constraint COMPANY_PAP_ODC_COST_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

Grant select,insert,update,delete on g50_pap_overhead to "&1";
Grant select,insert,update,delete on g50_PAP_clinical_proc_cost to "&1";
Grant select,insert,update,delete on g50_ip_study_price to "&1";
Grant select,insert,update,delete on COMPANY_PAP_ODC_COST to "&1";
Grant select,insert,update,delete on INDUSTRY_PAP_ODC_COST to "&1";


insert into industry_pap_odc_cost
select industry_pap_odc_cost_seq.nextval, country_id, indmap_id, phase_id, mapper_id, 'CPP', cpp_P25, cpp_p50, cpp_p75,
specificity
from pap_odc_cost where cpp_p25 is not null;

insert into industry_pap_odc_cost
select industry_pap_odc_cost_seq.nextval, country_id, indmap_id, phase_id, mapper_id, 'VISIT', visit_P25, visit_p50, visit_p75,
specificity
from pap_odc_cost where visit_p25 is not null;

insert into industry_pap_odc_cost
select industry_pap_odc_cost_seq.nextval, country_id, indmap_id, phase_id, mapper_id, 'GLOBAL', global_P25, global_p50, global_p75,
specificity
from pap_odc_cost where global_p25 is not null;

commit;

insert into company_pap_odc_cost
select company_pap_odc_cost_seq.nextval, country_id, indmap_id, phase_id, mapper_id, 'CPP', company_cpp_P50,
specificity
from pap_odc_cost where company_cpp_P50 is not null;

insert into company_pap_odc_cost
select company_pap_odc_cost_seq.nextval, country_id, indmap_id, phase_id, mapper_id, 'VISIT', company_visit_P50,
specificity
from pap_odc_cost where company_visit_P50 is not null;

insert into company_pap_odc_cost
select company_pap_odc_cost_seq.nextval, country_id, indmap_id, phase_id, mapper_id, 'GLOBAL', company_global_P50,
specificity
from pap_odc_cost where company_global_P50 is not null;

commit;

create index INDUSTRY_PAP_ODC_COST_index1 on
INDUSTRY_PAP_ODC_COST(country_id,mapper_id,phase_id,indmap_id)
tablespace tsmlarge_indx pctfree 20;

create index company_PAP_ODC_COST_index1 on
company_PAP_ODC_COST(country_id,mapper_id,phase_id,indmap_id)
tablespace tsmlarge_indx pctfree 20;


CREATE TABLE G50_COMPANY_PAP_ODC_COST(
	ID NUMBER(10,0) NOT NULL,
	COUNTRY_ID NUMBER(10,0),
	INDMAP_ID NUMBER(10,0) NOT NULL,
	PHASE_ID NUMBER(10,0) NOT NULL,
	MAPPER_ID NUMBER(10,0),
	PRICE_TYPE VARCHAR2(6) NOT NULL,
	PRICE_P50 NUMBER(16,2),
	SPECIFICITY NUMBER(10,0))
	tablespace tsmlarge 
	pctused 60 pctfree 25;

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_pk
	primary key (id) using index tablespace 
	tsmlarge_indx pctfree 25;


Alter table G50_COMPANY_PAP_ODC_COST add constraint GCPOC_price_type_check 
	check (PRICE_TYPE in ('CPP','VISIT','GLOBAL'));

Create sequence g50_COMPANY_PAP_ODC_COST_seq;

Grant select,insert,update,delete on G50_COMPANY_PAP_ODC_COST to "&1";

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk1
	foreign key (Country_id) references 
	"&1".Country(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk2
	foreign key (phase_id) references 
	"&1".phase(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk3
	foreign key (mapper_id) references 
	mapper(id);

Alter table G50_COMPANY_PAP_ODC_COST add constraint G50_COMPANY_PAP_ODC_COST_fk4
	foreign key (indmap_id) references 
	"&1".indmap(id);

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:43 PM Debashish Mishra  
--  5    DevTSM    1.4         9/19/2006 12:08:02 AMDebashish Mishra  removed
--       references to obsolete tables
--  4    DevTSM    1.3         3/3/2005 6:33:27 AM  Debashish Mishra   
--  3    DevTSM    1.2         3/3/2005 6:32:17 AM  Debashish Mishra  
--  2    DevTSM    1.1         7/2/2003 5:43:08 PM  Debashish Mishra  
--  1    DevTSM    1.0         6/24/2003 10:42:41 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

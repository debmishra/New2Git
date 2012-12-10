create table databld_run (
	id 	      	 NUMBER(10)  NOT NULL,
	run_date	 DATE          NOT NULL,
	tables   	 VARCHAR2(100) NOT NULL)
	tablespace tsmlarge
	pctused 60 pctfree 5;

Alter table databld_run add constraint databld_run_pk
  	primary key(id) using index tablespace
	tsmlarge_indx pctfree 5;


create table databld_run_prop (
 	id	  	     NUMBER(10)  NOT NULL,
	databld_run_id       NUMBER(10)  NOT NULL,
	prop_name 	     VARCHAR2(50)  NOT NULL,
	prop_val   	     VARCHAR2(100) NOT NULL)
	tablespace tsmlarge
	pctused 60 pctfree 5;

Alter table databld_run_prop add constraint databld_run_prop_pk
	primary key(id) using index tablespace 
	tsmlarge_indx pctfree 5;

Alter table databld_run_prop add constraint databld_run_prop_fk1
	foreign key (databld_run_id) references
	databld_run(id);


create table id_control (
 	table_owner                                VARCHAR2(40) NOT NULL,
	table_name                                 VARCHAR2(40) NOT NULL,
	next_id                                    NUMBER(10) NOT NULL)
	tablespace tsmlarge
	pctused 60 pctfree 5;

alter table id_control add constraint id_control_pk primary key table_name;

Grant select,insert,update,delete on databld_run  to "&1";
Grant select,insert,update,delete on databld_run_prop  to "&1";
Grant select,insert,update,delete on id_control to "&1";

insert into id_control values ('tsm10', 'mapper', 1);
commit;

insert into id_control values ('tsm10', 'pap_institution_proc_cost', 1);
commit;

insert into id_control values ('tsm10', 'pap_overhead', 1);
commit;

insert into id_control values ('tsm10', 'institution_overhead', 1);
commit;

insert into id_control values ('tsm10', 'pap_clinical_proc_cost', 1);
commit;

insert into id_control values ('tsm10', 'ip_study_price', 1);
commit;

insert into id_control values ('tsm10', 'g50_pap_clinical_proc_cost', 1);
commit;

insert into id_control values ('tsm10', 'g50_ip_study_price', 1);
commit;

insert into id_control values ('tsm10', 'g50_pap_overhead', 1);
commit;

insert into id_control values ('tsm10', 'industry_pap_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'company_pap_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'g50_company_pap_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'pap_institution_odc_cost', 1);
commit;

insert into id_control values ('tsm10', 'data_by_year', 1);
commit;

insert into id_control values ('tsm10', 'databld_run', 1);
commit;

insert into id_control values ('tsm10', 'databld_run_prop', 1);
commit;

alter table pap_overhead add adj_ovrhd_pct_ids varchar2(100);
alter table pap_overhead add ofc_ovrhd_pct_ids varchar2(100);
alter table pap_overhead add pct_paid_pct_ids varchar2(100);
alter table pap_overhead add odc_pct_ids varchar2(100);
alter table pap_overhead add company_ovrhd_pct_ids varchar2(100);
alter table pap_overhead add company_odc_pct_ids varchar2(100);
alter table pap_overhead add company_pct_paid_pct_ids varchar2(100);

alter table g50_pap_overhead add adj_ovrhd_pct_ids varchar2(100);
alter table g50_pap_overhead add ofc_ovrhd_pct_ids varchar2(100);
alter table g50_pap_overhead add pct_paid_pct_ids varchar2(100);
alter table g50_pap_overhead add odc_pct_ids varchar2(100);
alter table g50_pap_overhead add company_ovrhd_pct_ids varchar2(100);
alter table g50_pap_overhead add company_odc_pct_ids varchar2(100);
alter table g50_pap_overhead add company_pct_paid_ids varchar2(100);

alter table industry_pap_odc_cost add pct_ids varchar2(100);

alter table institution_overhead add ofc_ovrhd_pct_ids  varchar2(100);
alter table institution_overhead add adj_ovrhd_pct_ids  varchar2(100);
alter table institution_overhead add ovrhd_base_pct_ids varchar2(100);
alter table institution_overhead add pct_paid_pct_ids   varchar2(100);
alter table institution_overhead add ovrhd_18mo_pct_ids  varchar2(100);

alter table pap_Institution_odc_cost add pct_ids varchar2(100);

alter table pap_Institution_proc_cost add pct_ids varchar2(100);


alter table COMPANY_PAP_ODC_COST add pct_ids varchar2(100);
alter table G50_COMPANY_PAP_ODC_COST add pct_ids varchar2(100);

alter table pap_clinical_proc_cost add industry_pct_ids varchar2(100);
alter table pap_clinical_proc_cost add company_pct_ids  varchar2(100);

alter table g50_pap_clinical_proc_cost add industry_pct_ids varchar2(100);
alter table g50_pap_clinical_proc_cost add company_pct_ids  varchar2(100);

alter table  ip_study_price add industry_pct_ids varchar2(100);
alter table  ip_study_price add co_pct_ids varchar2(100);

alter table  g50_ip_study_price add industry_pct_ids varchar2(100);
alter table  g50_ip_study_price add co_pct_ids varchar2(100);


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
create table cro_rate_set(
  id                   NUMBER(10),
  name                 VARCHAR2(64) NOT NULL,
  effective_start_date DATE,
  effective_end_date   DATE,
  country_id           NUMBER(10),
  phase_id	       NUMBER(10),
  indmap_id	       NUMBER(10),
  default_flg          NUMBER(1)  DEFAULT 0 NOT NULL,
  fte_hours_month      NUMBER(4,1)  DEFAULT 160 NOT NULL)
  tablespace cropbt_data pctfree 20;

Alter table cro_rate_set add constraint cro_rate_set_pk
	primary key (id) using index tablespace cropbt_indx
	pctfree 20;

Alter table cro_rate_set add constraint crs_default_flg_check 
	check(default_flg in (0,1));

Alter table cro_rate_set add constraint cro_rate_set_fk1 
	foreign key(phase_id) references phase(id);

Alter table cro_rate_set add constraint cro_rate_set_fk2 
	foreign key(indmap_id) references indmap(id);

insert into id_control values ('tsm10','cro_rate_set',1);
commit;

Create table cro_plan_estimate(
  id                     NUMBER(10) ,
  cro_rate_set_id        NUMBER(10),
  country_id             NUMBER(10),
  site_count             NUMBER(5) ,
  patients_enrolled      NUMBER(5) ,
  patients_screened      NUMBER(5) ,
  patients_complete      NUMBER(5) ,
  qual_site_visits       NUMBER(5) ,
  init_site_visits       NUMBER(5) ,
  routine_site_visits    NUMBER(5) ,
  closeout_site_visits   NUMBER(5) ,
  qual_visit_hours       NUMBER(12,2),
  init_visit_hours       NUMBER(12,2),
  routine_visit_hours    NUMBER(12,2),
  closeout_visit_hours   NUMBER(12,2),
  travel_hours_visit     NUMBER(12,2),
  visit_prep_hours       NUMBER(12,2),
  patient_crf_pages      NUMBER(5) ,
  query_page_pct         NUMBER(5,2) ,
  unique_crf_pages       NUMBER(5) ,
  vendor_count           NUMBER(5) ,
  investig_payment_count NUMBER(5) ,
  lab_report_count       NUMBER(5) ,
  other_report_count     NUMBER(5) ,
  sae_count              NUMBER(5) ,
  total_adj_fte_hours    NUMBER(12,2),
  pct_complete           NUMBER(12,2),
  pct_pending            NUMBER(12,2),
  calc_version           NUMBER(6) ,
  design_shells          NUMBER(5) ,
  inv_mtg_count          NUMBER(5) ,
  inv_mtg_hours          NUMBER(12,2),
  ivr_flg                NUMBER(1)  DEFAULT 1 NOT NULL,
  phase_id 		 NUMBER(10) NOT NULL,
  indmap_id 		 NUMBER(10) NOT NULL,
  total_cost 		 NUMBER(12,2),
  total_cost_local 	 NUMBER(12,2),
  total_cost_alt 	 NUMBER(12,2),
  plan_currency_id 	 NUMBER(10) NOT NULL,
  alt_plan_currency_id 	 NUMBER(10),
  estimate_name 	 VARCHAR2(256) ,
  creator_ftuser_id 	 NUMBER(10) NOT null,
  local_currency_id 	 number(10) not null)
  tablespace cropbt_data pctfree 20;

Alter table cro_plan_estimate add constraint cro_plan_estimate_pk
	primary key (id) using index tablespace cropbt_indx
	pctfree 20;

Alter table cro_plan_estimate add constraint cpe_ivr_flg_check 
	check(ivr_flg in (0,1));

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk1 
	foreign key(country_id) references country(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk2 
	foreign key(cro_rate_set_id) references cro_rate_set(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk3 
	foreign key(phase_id) references phase(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk4 
	foreign key(indmap_id) references indmap(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk5 
	foreign key(plan_currency_id) references currency(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk6 
	foreign key(alt_plan_currency_id) references currency(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk7 
	foreign key(creator_ftuser_id) references ftuser(id);

Alter table cro_plan_estimate add constraint cro_plan_estimate_fk8 
	foreign key(local_currency_id) references currency(id);

insert into id_control values ('tsm10','cro_plan_estimate',1);
commit;

Create table cro_milestone_inst(
  id                    NUMBER(10),
  milestone_template_id NUMBER(10) NOT NULL,  
  milestone_date        DATE,
  cro_plan_estimate_id  NUMBER(10) NOT NULL)
  tablespace cropbt_data pctfree 20;  

Alter table cro_milestone_inst add constraint cro_milestone_inst_pk
	primary key (id) using index tablespace cropbt_indx
	pctfree 20;

Alter table cro_milestone_inst add constraint cro_milestone_inst_fk1 
	foreign key(milestone_template_id) references milestone_template(id);

Alter table cro_milestone_inst add constraint cro_milestone_inst_fk2 
	foreign key(cro_plan_estimate_id) references cro_plan_estimate(id);

insert into id_control values ('tsm10','cro_milestone_inst',1);
commit;

Create table cro_role_inst(
  id               NUMBER(10),
  role_template_id NUMBER(10),  
  salary_rate      NUMBER(12,2),
  cro_rate         NUMBER(12,2),
  cro_rate_set_id  NUMBER(10),   
  alias            VARCHAR2(64))
  tablespace cropbt_data pctfree 20; 

Alter table cro_role_inst add constraint cro_role_inst_pk
	primary key (id) using index tablespace cropbt_indx
	pctfree 20;

Alter table cro_role_inst add constraint cro_role_inst_fk1 
	foreign key(role_template_id) references role_template(id);

Alter table cro_role_inst add constraint cro_role_inst_fk2 
	foreign key(cro_rate_set_id) references cro_rate_set(id);

insert into id_control values ('tsm10','cro_role_inst',1);
commit;

Create table cro_roleinst_to_taskinst(
  id                       NUMBER(10),
  role_inst_id             NUMBER(10),	
  calc_hours               NUMBER(12,2),
  adj_hours                NUMBER(12,2),
  cro_plan_estimate_id        NUMBER(10), 
  role_to_task_template_id NUMBER(10))
  tablespace cropbt_data pctfree 20; 

Alter table cro_roleinst_to_taskinst add constraint cro_roleinst_to_taskinst_pk
	primary key (id) using index tablespace cropbt_indx
	pctfree 20;

Alter table cro_roleinst_to_taskinst add constraint cro_roleinst_to_taskinst_fk1 
	foreign key(role_inst_id) references role_inst(id);

Alter table cro_roleinst_to_taskinst add constraint cro_roleinst_to_taskinst_fk2 
	foreign key(cro_plan_estimate_id) references cro_plan_estimate(id);

Alter table cro_roleinst_to_taskinst add constraint cro_roleinst_to_taskinst_fk3 
	foreign key(role_to_task_template_id) references role_to_task_template(id);

insert into id_control values ('tsm10','cro_roleinst_to_taskinst',1);
commit;

Create table cro_task_inst(
  id                   NUMBER(10),
  task_template_id     NUMBER(10),  
  cro_plan_estimate_id NUMBER(10))
  tablespace cropbt_data pctfree 20; 

Alter table cro_task_inst add constraint cro_task_inst_pk
	primary key (id) using index tablespace cropbt_indx
	pctfree 20;

Alter table cro_task_inst add constraint cro_task_inst_fk1 
	foreign key(task_template_id) references task_template(id);

Alter table cro_task_inst add constraint cro_task_inst_fk2 
	foreign key(cro_plan_estimate_id) references cro_plan_estimate(id);

insert into id_control values ('tsm10','cro_task_inst',1);
commit;


Create table cro_task_group_inst(
 id                     NUMBER(10),
 task_group_template_id NUMBER(10) NOT NULL,
 cro_plan_estimate_id      NUMBER(10))
 tablespace cropbt_data pctfree 20; 

Alter table cro_task_group_inst add constraint cro_task_group_inst_pk
	primary key (id) using index tablespace cropbt_indx 
	pctfree 20;

Alter table cro_task_group_inst add constraint cro_task_group_inst_fk1 
	foreign key(task_group_template_id) references task_group_template(id);

Alter table cro_task_group_inst add constraint cro_task_group_inst_fk2 
	foreign key(cro_plan_estimate_id) references cro_plan_estimate(id);

insert into id_control values ('tsm10','cro_task_group_inst',1);
commit;


Alter table role_to_task_template add unit_cost number(10,2);

--Deployed upto this in TSM10E@TEST on 04/09/2006 at 1pm
--Deployed upto this in TSM10T@PREV on 04/09/2006 at 1pm

-- Following changes are as per request of Tonya on 04-12-2006 at 5pm

alter table cro_plan_estimate add(
client_id number(10),
client_div_id number(10));

alter table cro_plan_estimate add constraint CRO_PLAN_ESTIMATE_FK9
foreign key (client_id) references client(id);

alter table cro_plan_estimate add constraint CRO_PLAN_ESTIMATE_FK10
foreign key (client_div_id) references client_div(id);


-- Following changes are as per the request of Tonya on 04/21/2006 at 10:30am

Alter table cro_roleinst_to_taskinst drop constraint cro_roleinst_to_taskinst_fk1;

Alter table cro_roleinst_to_taskinst add constraint cro_roleinst_to_taskinst_fk1 
	foreign key(role_inst_id) references cro_role_inst(id);

--******************************************************
--Deployed upto this in TSM10E@TEST on 04/27/2006 at 7am 
--Deployed upto this in TSM10T@PREV on 04/27/2006 at 7am
--Deployed upto this in TSM10e@PREV on 06/11/2006 at 6:30pm
--Deployed upto this in TSM10G@PROD on 07/08/2006 at 5:30pm
--******************************************************

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_PBTOWN.sql$ 
--
-- $Revision: 15$        $Date: 2/22/2008 11:56:02 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
drop table cro_protocol;
drop table cro_search_set_item;
drop table cro_search_set;
drop table Cro_contract_to_country;
drop table Cro_cost_to_act_detail;
drop table Cro_activity_detail;
drop table Cro_cost_overlap;
drop table Cro_cost;
drop table Cro_contract;
drop table Cro_name_master;


create table Cro_name_master(
ID		NUMBER(10) NOT NULL,
Cro_code	VARCHAR2(20),
Cro_name	VARCHAR2(256),
Country_id	NUMBER(10) NOT NULL,
Cro_size	NUMBER(1) NOT NULL,
Address		VARCHAR2(256),
City		VARCHAR2(256),
region_id	NUMBER(10),
Zipcode		VARCHAR2(20),
Comments	VARCHAR2(100))                                --changed size from 20 to 100
tablespace cropbt_data pctfree 20;

Alter table Cro_name_master add constraint Cro_name_master_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table Cro_name_master add constraint Cro_name_master_fk1
	foreign key (country_id) references 
	country(id);

Alter table Cro_name_master add constraint Cro_name_master_fk2
	foreign key (region_id) references 
	region(id);
delete from id_control where table_name='cro_name_master';
insert into id_control values('tsm10','cro_name_master',1);
commit; 


create table Cro_contract(
ID		 	NUMBER(10) NOT NULL,
Cro_name_master_id	NUMBER(10),
Cro_size		NUMBER(3),
Contract		VARCHAR2(30),
client_div_id		NUMBER(10), 
build_code_id		NUMBER(10),                            
Comments		VARCHAR2(100),
Protocol_id		NUMBER(10),
indmap_id 		NUMBER(10),
country_id		NUMBER(10),
S_country_id		NUMBER(10),
project_id		NUMBER(10),
Phase_id		NUMBER(10),
Status			VARCHAR2(1),
Phase1type_id		NUMBER(10),
Penrollmn		Number(3),
Dayorweek		VARCHAR2(1),
Lab			VARCHAR2(1),
Totalvisit		Number(2),
Labvisit		Number(2),
Duration		Number(3),
indays			Number(2),
pscreen			Number(5),
Penrolled		Number(5),
Pcomplet		Number(5),
Pevaluab		Number(5),
Startdate		Date,
Enddate			Date,
Currency_id		NUMBER(10),
amount			Number(20,2),
Initial_val		Number(18,2),
Pctpaid			Number(4),
Overheadpct		Number(2),
overheadbas		VARCHAR2(1),
Entdate			Date,
Ovrheadamt		Number(10),
Overheadovl		Number(1),
Title			VARCHAR2(512),
Sitemon			Number(1),
Hrlyrates		Number(1) NOT NULL,
discount		Number(3),
Invfees			Number(18,2),
drug			varchar2(50))                       
tablespace cropbt_data pctfree 20;

Alter table Cro_contract add constraint Cro_contract_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;


Alter table Cro_contract add constraint Cro_contract_fk1
	foreign key (Cro_name_master_id) references 
	Cro_name_master(id);

Alter table cro_contract add constraint cro_contract_fk2
	foreign key (client_div_id) references                         
	client_div(id);

Alter table cro_contract add constraint cro_contract_fk3
	foreign key (Protocol_id) references 
	Protocol(id);

Alter table cro_contract add constraint cro_contract_fk4
	foreign key (indmap_id) references 
	indmap(id);

Alter table cro_contract add constraint cro_contract_fk5
	foreign key (country_id) references 
	country(id);

Alter table cro_contract add constraint cro_contract_fk6
	foreign key (S_country_id) references 
	country(id);


Alter table cro_contract add constraint cro_contract_fk7
	foreign key (project_id) references 
	project(id);

Alter table cro_contract add constraint cro_contract_fk8
	foreign key (Phase_id) references 
	Phase(id);

Alter table cro_contract add constraint cro_contract_fk9
	foreign key (Phase1type_id) references 
	Phase(id);

Alter table cro_contract add constraint cro_contract_fk10
	foreign key (Currency_id) references 
	Currency(id);

Alter table cro_contract add constraint cro_contract_fk11
	foreign key (build_code_id) references 
	build_code(id);



alter table cro_contract add constraint cro_contract_Overheadovl_CHECK
check (Overheadovl in(0,1));

alter table cro_contract add constraint cro_contract_Sitemon_CHECK
check (Sitemon in (0,1));

alter table cro_contract add constraint cro_contract_Hrlyrates_CHECK
check (Hrlyrates in (0,1));


delete from id_control where table_name='cro_contract';
insert into id_control values('tsm10','cro_contract',1);
commit; 

create table Cro_cost(
ID			NUMBER(10) NOT NULL,
cro_Contract_id		number(10) NOT NULL, 		-- contract_id                           
Cro_category_id		NUMBER(10) NOT NULL,
Cost			NUMBER(18,2) NOT NULL,
Overlap			NUMBER(1) NOT NULL)
tablespace cropbt_data pctfree 20;	


Alter table Cro_cost add constraint Cro_cost_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table Cro_cost add constraint Cro_cost_fk4
	foreign key (Cro_category_id) references 
	Cro_category(id);

Alter table Cro_cost add constraint Cro_cost_fk5
	foreign key (cro_Contract_id) references 
	cro_Contract(id);

alter table Cro_cost add constraint Cro_cost_Overlap_CHECK
check (Overlap in (0,1));

delete from id_control where table_name='cro_cost';
insert into id_control values('tsm10','cro_cost',1);
commit; 

create table Cro_cost_overlap(
ID			NUMBER(10) NOT NULL,
Cro_cost_id		NUMBER(10) NOT NULL,
Cro_category_id		NUMBER(10) ,
Other			VARCHAR2(256) )
tablespace cropbt_data pctfree 20;

Alter table Cro_cost_overlap add constraint Cro_cost_overlap_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;


Alter table Cro_cost_overlap add constraint Cro_cost_overlap_fk1
	foreign key (Cro_cost_id) references 
	Cro_cost(id);

Alter table Cro_cost_overlap add constraint Cro_cost_overlap_fk2
	foreign key (Cro_category_id) references 
	Cro_category(id);

delete from id_control where table_name='cro_cost_overlap';
insert into id_control values('tsm10','cro_cost_overlap',1);
commit; 

create table Cro_activity_detail(
ID			NUMBER(10) NOT NULL,
Cro_category_id		NUMBER(10) NOT NULL,
Sub_txt	   		Varchar2(128),
Choice_text		VARCHAR2(100) NOT NULL,
Decimals		NUMBER(1) NOT NULL,
Input			NUMbER(1) NOT NULL,
Use_data		NUMBER(1) NOT NULL,
Default_val		NUMBER(10),
sub_id			NUMBER(2),
choice_id 		NUMBER(2))
tablespace cropbt_data pctfree 20;

Alter table Cro_activity_detail add constraint Cro_activity_detail_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table Cro_activity_detail add constraint Cro_activity_detail_fk1
	foreign key (Cro_category_id) references 
	Cro_category(id);


delete from id_control where table_name='cro_activity_detail';
insert into id_control values('tsm10','cro_activity_detail',1);
commit; 

create table Cro_cost_to_act_detail(
ID			NUMBER(10) NOT NULL,
Cro_cost_id		NUMBER(10) NOT NULL,
Cro_activity_detail_id	NUMBER(10) ,
numeric_input 		NUMBER(10,2),
Item_seq		NUMBER(1) NOT NULL)
tablespace cropbt_data pctfree 20;

Alter table Cro_cost_to_act_detail add constraint Cro_cost_to_act_detail_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table Cro_cost_to_act_detail add constraint Cro_cost_to_act_detail_fk1
	foreign key (Cro_cost_id) references 
	Cro_cost(id);

Alter table Cro_cost_to_act_detail add constraint Cro_cost_to_act_detail_fk2
	foreign key (Cro_activity_detail_id) references 
	Cro_activity_detail(id);
delete from id_control where table_name='cro_cost_to_act_detail';
insert into id_control values('tsm10','cro_cost_to_act_detail',1);
commit; 


create table Cro_contract_to_country(
ID			NUMBER(10) NOT NULL,
cro_contract_id  	NUMBER(10) NOT NULL,
country_id		NUMBER(10) NOT NULL)
tablespace cropbt_data pctfree 20;

Alter table Cro_contract_to_country add constraint Cro_contract_to_country_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table Cro_contract_to_country add constraint Cro_contract_to_country_fk1
	foreign key (cro_contract_id) references 
	cro_contract(id);

Alter table Cro_contract_to_country add constraint Cro_contract_to_country_fk2
	foreign key (country_id) references 
	country(id);

delete from id_control where table_name='cro_contract_to_country';
insert into id_control values('tsm10','cro_contract_to_country',1);
commit; 


create table cro_search_set (
Id 			number(10) not null,
Name			varchar2(100) not null,
Creator_ftuser_id	number(10) not null,
Client_div_id		number(10) not null,
Create_date		date not null,
From_start_date		date,
To_start_date		date,
From_end_date		date,
To_end_date		date,
From_total		number(18, 2),
To_total		number(18,2),
currency_id		number(10))
tablespace cropbt_data pctfree 20;
 
Alter table cro_search_set add constraint cro_search_set_pk
	primary key(id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_search_set add constraint cro_search_set_fk1
	foreign key (Client_div_id) references 
	client_div(id);

Alter table cro_search_set add constraint cro_search_set_fk2
	foreign key (Creator_ftuser_id) references 
	ftuser(id);

Alter table cro_search_set add constraint cro_search_set_fk3
	foreign key (currency_id) references 
	currency(id);

Alter table cro_search_set add constraint
	cro_search_set_uq1 
	unique(client_div_id,name)
	using index tablespace cropbt_indx pctfree 5;

delete from id_control where table_name='cro_search_set';
insert into id_control values('tsm10','cro_search_set',1);
commit; 


create table cro_search_set_item (
Id 			number(10),
Cro_search_set_id	number(10) not null,
Cro_category_id		number(10),
Cro_name_master_id	number(10),
Protocol_id		number(10),
Country_id		number(10),
Phase_id		number(10),
Indmap_id		number(10))
tablespace cropbt_data pctfree 20;

Alter table cro_search_set_item add constraint cro_search_set_item_pk
	primary key(id) using index tablespace
	cropbt_indx pctfree 20;

Alter table cro_search_set_item add constraint cro_search_set_item_fk1
	foreign key(Cro_search_set_id) references
	Cro_search_set(id);
 
Alter table cro_search_set_item add constraint cro_search_set_item_fk2
	foreign key(Cro_category_id) references
	Cro_category(id);

 Alter table cro_search_set_item add constraint cro_search_set_item_fk3
	foreign key(Cro_name_master_id) references
	Cro_name_master(id);

 Alter table cro_search_set_item add constraint cro_search_set_item_fk4
	foreign key(Protocol_id) references
	Protocol(id);
 
Alter table cro_search_set_item add constraint cro_search_set_item_fk5
	foreign key(Country_id) references
	Country(id);
 
Alter table cro_search_set_item add constraint cro_search_set_item_fk6
	foreign key(Phase_id) references
	Phase(id);
 
Alter table cro_search_set_item add constraint cro_search_set_item_fk7
	foreign key(Indmap_id) references
	Indmap(id);
 
delete from id_control where table_name='cro_search_set_item';
insert into id_control values('tsm10','cro_search_set_item',1);
commit; 

-- according to phil's mail on 09/12/06 @ 11.10 am.

alter table cro_category add 
(is_pbtown_viewable number(1) default 0 not null);

alter table Cro_category add constraint Cro_category_viewable_CHECK
check (is_pbtown_viewable in (0,1))

 update cro_category set is_pbtown_viewable = 1  where
 id between 1 and 15;

 update cro_category set is_pbtown_viewable = 1  where
 id in ( 17, 18, 19,26,27);

insert into cro_category values 
(43,'Statistical Report', null, null, 'Statistical Report','Q',0,null,0,1); 

insert into cro_category values
(44,'Integrated Report', null, null, 'Integrated Report','R',0,null,0,1);


-- As per the request of Tonya on 09/06/06 @ 10:45 am.

alter table audit_hist drop constraint AUDIT_HIST_APP_TYPE_CHECK;

alter table audit_hist add constraint AUDIT_HIST_APP_TYPE_CHECK
check (app_type in('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN' ));



create table Cro_protocol(
ID		NUMBER(10) NOT NULL,
build_code_id   number(10),
Cro_protocol	VARCHAR2(50))                               
tablespace cropbt_data pctfree 20;

Alter table Cro_protocol add constraint Cro_protocol_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table cro_protocol add constraint cro_protocol_fk1 
foreign key(build_code_id) references build_code(id);

delete from id_control where table_name='cro_protocol';
insert into id_control values('tsm10','cro_protocol',1);
commit; 

truncate table Cro_contract_to_country;
truncate table Cro_cost_to_act_detail;
delete from Cro_activity_detail;
truncate table Cro_cost_overlap;
delete from Cro_cost;
delete from Cro_contract;
commit;

alter table cro_contract drop constraint CRO_CONTRACT_FK3;
alter table cro_contract add constraint CRO_CONTRACT_FK3 
foreign key (protocol_id) references cro_protocol(id);


-- Following changes are as per request of Phil on 03/27/2007 at 2pm

create table cro_contract_doc ( 
id 			  NUMBER(10),   
cro_contract_id         NUMBER(10)  NOT NULL,        
document                BLOB,
doc_type                VARCHAR2(50),
doc_name 		  varchar2(256),
client_div_id	  	  number(10))
tablespace cropbt_data pctfree 5;

Alter table cro_contract_doc add constraint cro_contract_doc_pk
	primary key (id) using index tablespace 
	cropbt_indx pctfree 5;

Alter table cro_contract_doc add constraint
	cro_contract_doc_fk1 foreign key (cro_contract_id) 
        references cro_contract(id) ;

alter table cro_contract_doc add constraint
cro_contract_doc_fk2 foreign key(client_div_id) references
client_div(id);

delete from id_control where table_name='cro_contract_doc';
insert into id_control values ('tsm10', 'cro_contract_doc', 1);
commit;


--******************************************************
--Deployed upto this in TSM10E@TEST on 4/2/2007 at 2:30 pm
--Deployed upto this in TSM10T@PREV on 4/2/2007 at 2:30 pm
--Deployed upto this in TSM10e@PREV on 4/5/2007 at 5:30 pm
--Deployed upto this in TSM10E@PROD on 4/7/2007 at 7:30 pm
--Deployed upto this in TSM10G@PROD on 4/7/2007 at 7:30 pm
--Deployed upto this in TSM10@PROD on 4/7/2007 at 7:30 pm

--****************************************************** 


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  15   DevTSM    1.14        2/22/2008 11:56:02 AMDebashish Mishra  
--  14   DevTSM    1.13        4/12/2007 9:11:19 AM Debashish Mishra  
--  13   DevTSM    1.12        4/3/2007 4:55:01 PM  Debashish Mishra  
--  12   DevTSM    1.11        3/29/2007 9:13:02 AM Debashish Mishra  
--  11   DevTSM    1.10        3/2/2007 7:26:15 PM  Debashish Mishra  
--  10   DevTSM    1.9         2/25/2007 9:13:01 PM Debashish Mishra  
--  9    DevTSM    1.8         11/10/2006 12:30:54 PMDebashish Mishra  
--  8    DevTSM    1.7         10/31/2006 11:27:46 AMDebashish Mishra  
--  7    DevTSM    1.6         10/24/2006 11:24:07 AMDebashish Mishra  
--  6    DevTSM    1.5         10/20/2006 1:43:19 PMDebashish Mishra  
--  5    DevTSM    1.4         10/16/2006 10:18:24 AMDebashish Mishra  
--  4    DevTSM    1.3         10/12/2006 9:19:27 AMDebashish Mishra  
--  3    DevTSM    1.2         10/9/2006 2:47:34 PM Debashish Mishra  
--  2    DevTSM    1.1         10/8/2006 12:47:47 AMDebashish Mishra  
--  1    DevTSM    1.0         9/19/2006 12:09:53 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

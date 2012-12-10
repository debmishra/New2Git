--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_GMOWN.sql$ 
--
-- $Revision: 16$        $Date: 2/22/2008 11:56:02 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

-- Following changes are as per request of Tonya on 03/05/2007

alter table protocol add drug varchar2(256);

alter table AUDIT_HIST drop constraint AUDIT_HIST_APP_TYPE_CHECK;

alter table AUDIT_HIST add constraint AUDIT_HIST_APP_TYPE_CHECK check (app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN'));

drop table own_document;
drop table own_search_set;
drop table own_search_set_item;
drop table own_procedure;
drop table own_odc;
drop table own_site;
drop table own_protocol;
drop table own_investig;

drop sequence own_procedure_seq;
drop sequence own_odc_seq;
drop sequence own_site_seq;
drop sequence own_protocol_seq;
drop sequence own_investig_seq;
drop sequence own_search_set_seq;
drop sequence own_search_set_item_seq;

create sequence own_procedure_seq;
create sequence own_odc_seq;
create sequence own_site_seq;
create sequence own_protocol_seq;
create sequence own_investig_seq;
create sequence own_search_set_seq;
create sequence own_search_set_item_seq;


create table own_investig(
ID		Number(10),
protocol_code	varchar2(50) not null,
Investig_code	varchar2(35) not null,
Country_Id	Number(10) not null,
Country_code	varchar2(3),
Country_name	varchar2(256),
Currency_id	Number(10) not null,
plan_Curr_id	Number(10),
institution_id	Number(10),
Phase		varchar2(30),
Phase_id	Number(10) not null,
Indmap_id	Number(10) not null,
Ind_desc	varchar2(256),
Ta_desc		varchar2(256),
Ta_indmap_id	Number(10) not null,
Drug		varchar2(50),
CPP		Number(16,2),
CPP_PLAN		Number(16,2),
CPV		Number(16,2),
CPV_PLAN		Number(16,2),
CppUS		Number(16,2),
CpvUS		Number(16,2),
Grant_date	Date,
Pct_paid	Number(6,2),
Build_code_id	Number(10) not null ,
adj_ovrhd_pct	Number(6,2),
Inst_name	varchar2(256),
Inst_zip_code	varchar2(32),
grant_total 	number(12),
state 		varchar2(30),
CITY 		varchar2(60), 
AFFILIATION 	varchar2(20))
tablespace tsmsmall pctfree 5;


Alter table Own_investig add constraint Own_investig_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;	

Alter table Own_investig add constraint
	Own_investig_fk1 foreign key (country_Id) 
        references country(id) ;

Alter table Own_investig add constraint
	Own_investig_fk2 foreign key (institution_Id) 
        references institution(id) ;

Alter table Own_investig add constraint
	Own_investig_fk3 foreign key (phase_Id) 
        references phase(id) ;

Alter table Own_investig add constraint
	Own_investig_fk4 foreign key (currency_Id) 
        references currency(id) ;

Alter table Own_investig add constraint
	Own_investig_fk5 foreign key (indmap_Id) 
        references indmap(id) ;

Alter table Own_investig add constraint
	Own_investig_fk6 foreign key (ta_indmap_Id) 
        references indmap(id) ;

--Alter table Own_investig add constraint
--	Own_investig_fk7 foreign key (Inst_country_id) 
--        references country(id) ;

Alter table Own_investig add constraint
	Own_investig_fk8 foreign key (build_code_id) 
        references build_code(id) ;

Alter table Own_investig add constraint
	Own_investig_fk9 foreign key (plan_curr_Id) 
        references currency(id) ;

delete from id_control where table_name='own_investig';
insert into id_control values ('tsm10', 'own_investig', 1);
commit;


create table 	own_protocol(
ID			Number(10),
Protocol_code		varchar2(50) not null,
Phase_id		Number(10) not null,
Phase			varchar2(35),
Ind_desc		varchar2(256),
Indmap_id		Number(10) not null,
Ta_indmap_id		Number(10) not null,
Ta_desc			varchar2(256),
Drug			varchar2(50),
overhead_pct		Number(4),
pct_paid		Number(4),
num_inv			Number(4),
CPPUS			Number(16,2),
CPVUS			Number(16,2),
CPP_PLAN			Number(16,2),
CPV_PLAN			Number(16,2),
plan_curr_id		Number(10),
Build_code_id		Number(10) not null)
tablespace tsmsmall pctfree 5;

Alter table Own_protocol add constraint Own_protocol_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_protocol add constraint
	Own_protocol_fk1 foreign key (Phase_Id) 
        references Phase(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk2 foreign key (indmap_Id) 
        references indmap(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk3 foreign key (ta_indmap_Id) 
        references indmap(id) ;

Alter table own_protocol add constraint
	Own_protocol_fk4 foreign key (build_code_id) 
        references build_code(id) ;

Alter table Own_protocol add constraint
	Own_protocol_fk5 foreign key (plan_curr_Id) 
        references currency(id) ;

delete from id_control where table_name='own_protocol';
insert into id_control values ('tsm10', 'own_protocol', 1);
commit;

create table 	own_site(
ID		Number(10),
institution_id	Number(10) NOT NULL,
name		varchar2(256),
Country_id	Number(10),
Country_name	varchar2(256),
Country_code	varchar2(10),
Zip_code	Character(32),
overhead_pct25  Number(4),
overhead_pct50  Number(4),
overhead_pct75  Number(4),
pct_paid	Number(4),
num_inv		Number(4),
CPPUS		Number(10,2),
CPvUS		Number(10,2),
CPP_plan		Number(10,2),
CPv_plan		Number(10,2),
plan_curr_id	Number(10),
latest_overhead		Number(4),
latest_ovrhead_date	Date,
Build_code_id	Number(10) not null,
state 		varchar2(30),
CITY 		varchar2(60), 
AFFILIATION 	varchar2(20))
tablespace tsmsmall pctfree 5;

Alter table own_site add constraint own_site_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_site add constraint
	own_site_fk1 foreign key (institution_Id) 
        references institution(id) ;

Alter table own_site add constraint
	own_site_fk2 foreign key (Country_Id) 
        references Country(id) ;

Alter table own_site add constraint
	own_site_fk3 foreign key (Build_code_Id) 
        references Build_code(id) ;

Alter table Own_site add constraint
	Own_site_fk4 foreign key (plan_curr_Id) 
        references currency(id) ;

delete from id_control where table_name='own_site';
insert into id_control values ('tsm10', 'own_site', 1);
commit;


create table 	own_procedure(
ID		Number(10),
currency_id	Number(10) not null,
mapper_id	Number(10) not null,
CPV		Number(16,2),
CpvUS		Number(16,2),
CPV_PLAN	Number(16,2),
protocol_CPV		Number(16,2),
protocol_CPV_US		Number(16,2),
Build_code_id	Number(10) not null,
Cpt_code	Character(80),
Long_desc	Character(256),
investig_code varchar2(35),
protocol_code varchar2(50),
plan_curr_id number(10))
tablespace tsmsmall pctfree 5;

Alter table own_procedure add constraint own_procedure_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_procedure add constraint
	own_procedure_fk1 foreign key (currency_Id) 
        references currency(id) ;

Alter table own_procedure add constraint
	own_procedure_fk2 foreign key (Build_code_Id) 
        references Build_code(id) ;

Alter table own_procedure add constraint
	own_procedure_fk3 foreign key (mapper_Id) 
        references mapper(id) ;

Alter table Own_procedure add constraint
	Own_procedure_fk4 foreign key (plan_curr_Id) 
        references currency(id) ;

delete from id_control where table_name='own_procedure';
insert into id_control values ('tsm10', 'own_procedure', 1);
commit;

create table 	own_odc(
ID		Number(10),
currency_id	Number(10) not null,
plan_curr_id	Number(10),
mapper_id	Number(10) not null,
CPP		Number(16,2),
CppUS		Number(16,2),
CPP_plan		Number(16,2),
protocol_CPP		Number(16,2),
protocol_CPP_US		Number(16,2),
CPV		Number(16,2),
CpvUS		Number(16,2),
CPV_plan		Number(16,2),
protocol_CPV		Number(16,2),
protocol_CPV_US		Number(16,2),
Build_code_id	Number(10) not null,
picas_code	varchar2(80),
Long_desc	varchar2(256),
investig_code varchar2(35),
protocol_code varchar2(50))
tablespace tsmsmall pctfree 5;

Alter table own_odc add constraint own_odc_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_odc add constraint
	own_odc_fk1 foreign key (currency_Id) 
        references currency(id) ;

Alter table own_odc add constraint
	own_odc_fk2 foreign key (Build_code_Id) 
        references Build_code(id) ;

Alter table own_odc add constraint
	own_odc_fk3 foreign key (mapper_Id) 
        references mapper(id) ;

Alter table Own_odc add constraint
	Own_odc_fk4 foreign key (plan_curr_Id) 
        references currency(id) ;

delete from id_control where table_name='own_odc';
insert into id_control values ('tsm10', 'own_odc', 1);
commit;


create table own_search_set(
ID			Number(10),
client_div_id		number(10) not null,
Name  			Varchar2(256) not null,
Creator_ftuser_id  	Number(10) not null,  
Creator_date  		Date,
from_grant_date  	Date,
to_grant_date  		Date,
currency_id  		Number(10) not null,  
is_search_ta  		Number(1),
from_grant_total 	number(12,2),
to_grant_total 		number(12,2))
tablespace tsmsmall pctfree 5;

Alter table own_search_set add constraint Own_search_set_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_search_set add constraint
	Own_search_set_fk1 foreign key (Creator_ftuser_id) 
        references ftuser(id) ;

Alter table own_search_set add constraint
	Own_search_set_fk2 foreign key (currency_id) 
        references currency(id) ;

Alter table own_search_set add constraint
	Own_search_set_fk3 foreign key (client_div_id) 
        references client_div(id) ;


delete from id_control where table_name='own_search_set';
insert into id_control values ('tsm10', 'own_search_set', 1);
commit;


create table own_search_set_item(
ID			Number(10),
Drug  			Varchar2(256),
Indmap_id  		Number(10), 
Indmap_ta_id  		Number(10), 
Phase_id  		Number(10), 
Country_id  		Number(10),
own_search_set_id 	number(10),
protocol_code 		varchar(50),
institution_id 		number(10),
state 			varchar2(30),
INVESTIG_CODE 		varchar2(35), 
CITY 			varchar2(60), 
AFFILIATION 		varchar2(20))
tablespace tsmsmall pctfree 5;

Alter table own_search_set_item add constraint Own_search_set_item_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_search_set_item add constraint
	Own_search_set_item_fk1 foreign key (Indmap_id) 
        references Indmap(id) ;

Alter table own_search_set_item add constraint
	Own_search_set_item_fk2 foreign key (Indmap_ta_id) 
        references Indmap(id) ;

Alter table own_search_set_item add constraint
	Own_search_set_item_fk3 foreign key (Phase_id) 
        references Phase(id) ;

Alter table own_search_set_item add constraint
	Own_search_set_item_fk4 foreign key (Country_id) 
        references Country(id) ;

alter table own_search_set_item add constraint
	OWN_SEARCH_SET_ITEM_FK5 foreign key (own_search_set_id)
	references own_search_set(id);

delete from id_control where table_name='own_search_set_item';
insert into id_control values ('tsm10', 'own_search_set_item', 1);
commit;


--Deployed upto this in tsm10e@test on 5/15/2007 at 12:50pm

-- Following changes are as per request of Tonya on 05/15/2007 at 12:30pm

alter table OWN_SEARCH_SET drop column IS_SEARCH_TA;

--Deployed upto this in tsm10e@test on 6/5/2007 at 7:25am

-- Following changes are as per request of Phil on 6/6/07 at 5pm

CREATE TABLE own_document (
  id  			NUMBER(10),
  own_protocol_id 	varchar2(256),
  own_site_id       	varchar2(256),
  document          	BLOB,
  doc_type          	NUMBER (1),
  doc_format       	VARCHAR2(50),
  doc_name        	VARCHAR2(256),
  client_div_id      	NUMBER(10),
  deleted 		number(1) default 0 not null)
tablespace trialblob pctfree 5;

Alter table own_document add constraint own_document_pk
	primary key (id) using index tablespace 
	tsmsmall_indx pctfree 5;

Alter table own_document add constraint
	own_document_fk1 foreign key (client_div_id) 
        references client_div(id) ; 
 
ALTER TABLE own_document add constraint od_doc_type_check CHECK (
    doc_type in (0,1,2,3,4,5));

delete from id_control where table_name='own_document';
insert into id_control values ('tsm10', 'own_document', 1);
commit;

--Deployed upto this in tsm10e@test on 6/22/2007 at 5pm

alter table audit_hist add (ip_address varchar2(30));

-- Following changes are as per request of Phil 0n 07/02/2007 at 1:34 pm

alter table own_document drop constraint od_doc_type_check ;
alter table own_document add constraint od_doc_type_check
check (doc_type between 1 and 7);

-- Following changes are as per request of Phil 0n 07/03/2007 at 9:03 am

alter table own_document add user_desc varchar2 (128);

--Deployed upto this in tsm10e@test on 7/5/2007 at 1:40pm
--Deployed upto this in tsm10t@prev on 7/6/2007 at noon

-- Following changes are as per request of Phil 0n 07/19/2007 at 6:00 pm

alter table own_document modify USER_DESC VARCHAR2(256);

--Deployed upto this in tsm10e@test on 7/24/2007 at 10:40pm
--Deployed upto this in tsm10t@prev on 7/24/2007 at 10:40pm
--Deployed upto this in tsm10e@prev on 7/24/2007 at 10:40pm

--Deployed upto this in tsm10g@prod on 7/24/2007 at 10:40pm
--Deployed upto this in tsm10@prod on 7/24/2007 at 10:40pm

--Following chnages are as per request of Phil on 09/14/2007 at 2:25pm

alter table own_document add (proto_name varchar2(256));

--*********************************************************
--Deployed upto this in tsm10e@test on 9/19/2007 at 3:02pm
--Deployed upto this in tsm10t@prev on 9/19/2007 at 3:02pm
--Deployed upto this in tsm10e@prev on 9/19/2007 at 3:02pm
--Deployed upto this in tsm10g@prod on 9/28/2007 at 10:40pm
--Deployed upto this in tsm10@prod on 9/2/2007 at 10:40pm


--*********************************************************

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  16   DevTSM    1.15        2/22/2008 11:56:02 AMDebashish Mishra  
--  15   DevTSM    1.14        10/10/2007 11:28:49 AMDebashish Mishra  
--  14   DevTSM    1.13        9/14/2007 2:29:32 PM Debashish Mishra  
--  13   DevTSM    1.12        9/11/2007 5:12:03 PM Debashish Mishra  
--  12   DevTSM    1.11        7/24/2007 9:32:22 AM Debashish Mishra  
--  11   DevTSM    1.10        7/9/2007 4:09:33 PM  Debashish Mishra  
--  10   DevTSM    1.9         6/28/2007 4:05:15 PM Debashish Mishra  
--  9    DevTSM    1.8         6/11/2007 7:24:37 PM Debashish Mishra  
--  8    DevTSM    1.7         6/6/2007 5:01:32 PM  Debashish Mishra  
--  7    DevTSM    1.6         5/15/2007 7:26:26 PM Debashish Mishra  
--  6    DevTSM    1.5         5/8/2007 5:57:18 PM  Debashish Mishra  
--  5    DevTSM    1.4         4/12/2007 9:11:18 AM Debashish Mishra  
--  4    DevTSM    1.3         4/3/2007 11:04:03 PM Debashish Mishra  
--  3    DevTSM    1.2         4/3/2007 4:55:01 PM  Debashish Mishra  
--  2    DevTSM    1.1         3/29/2007 9:16:32 AM Debashish Mishra  
--  1    DevTSM    1.0         3/5/2007 7:28:03 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

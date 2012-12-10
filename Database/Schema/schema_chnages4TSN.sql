
alter table ftuser add tsn_user_type number(1) default 0 not null;

alter table ftuser add constraint ftuser_tsn_user_type_check check
(tsn_user_type between 0 and 3);

insert into ftgroup values ('30','TSN Admin');	   
insert into ftgroup values ('31','TSN Negotiator');	   
insert into ftgroup values ('32','TSN Contact');	 
commit;

alter table trial drop constraint TRIAL_CREATED_BY_CHECK;

alter table trial add constraint TRIAL_CREATED_BY_CHECK check(
created_by in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN'));

alter table AUDIT_HIST drop constraint AUDIT_HIST_APP_TYPE_CHECK;

alter table AUDIT_HIST add constraint AUDIT_HIST_APP_TYPE_CHECK
check (app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN'));

alter table USER_PREF drop constraints UP_APP_TYPE_CHECK;

alter table USER_PREF add constraint UP_APP_TYPE_CHECK check(
app_type in ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN'));

alter table TSM_MESSAGE drop constraint TM_APP_TYPE_CHECK;

alter table TSM_MESSAGE add constraint TM_APP_TYPE_CHECK check(
app_type in ('PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN'));

drop table TSN_unl_institution;
drop table TSN_CLIENT_DEFAULTS;
drop table TSN_COMMENT;
drop table TSN_DOCUMENT;
drop table TSN_NEG_SITE_LEVEL_COST;
drop table TSN_NEG_TO_COST_ITEM;
drop table TSN_NEG_TO_VISIT;
drop table TSN_NEG_TO_INVESTIGATOR;
drop table TSN_UNLISTED_PROCEDURE;
drop table TSN_UNLISTED_VISIT;
drop table TSN_INVESTIGATOR;
drop table TSN_NEGOTIATE;
drop table TSN_TRIAL;


create table TSN_TRIAL(  
Trial_id        	NUMBER(10) NOT NULL,   
Creator_ftuser_id       NUMBER(10) NOT NULL,       
Create_date     	DATE,           
Plan_curr_id    	NUMBER(10) NOT NULL,   
Num_site        	NUMBER(6),
Num_patient     	NUMBER(6),
Avg_cpp 		NUMBER(16,2),
Avg_total       	NUMBER(16,2),
Total   		NUMBER(16,2))
tablespace tsnsmall pctfree 5;

Alter table TSN_TRIAL add constraint TSN_TRIAL_PK 
primary key (trial_id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table TSN_TRIAL add constraint TSN_TRIAL_fk1 
foreign key (trial_id) references trial(id);
 
Alter table TSN_TRIAL add constraint TSN_TRIAL_fk2 
foreign key (Creator_ftuser_id) references ftuser(id);

Alter table TSN_TRIAL add constraint TSN_TRIAL_fk3 
foreign key (Plan_curr_id) references currency(id);

delete from id_control where table_name='tsn_trial';
insert into id_control values ('tsm10','tsn_trial',1);
commit;

create table tsn_Negotiate( 
ID      		NUMBER(10),    
Tsn_trial_id    	NUMBER(10) not null,  
Trial_budget_id 	NUMBER(10),  
Creator_ftuser_id       NUMBER(10) not null, 
Create_date     	DATE,     
short_desc    		VARCHAR2 (256) NOT NULL,  
Date_due        	DATE NOT NULL,     
negotiation_type         NUMBER(1) NOT NULL,                
Start_price     	NUMBER(1)  NOT NULL,             
Price_modifier_type     NUMBER (1),   
Price_modifier_pct      NUMBER (4), 
Is_auto_accept  	NUMBER (1),
Contact_ftuser_ID       NUMBER(10)  NOT NULL,      
Send_email      	NUMBER (1),       
Export_negotiation      NUMBER (1),        
Status  		number(1),             
Arch_comment    	VARCHAR2 (2048),
Avg_cpp 		NUMBER(16,2),
Avg_total       	NUMBER(16,2),
Currency_id     	NUMBER(10),
Num_site        	NUMBER(6),       
Num_patient     	NUMBER(6),   
Archived_date   	DATE,               
Completion_date 	DATE,               
Wizard_page_number      NUMBER(4),              
Auto_accept_pct 	NUMBER(6,2),                 
Site_cost_note  	VARCHAR2(2000),
start_budget_price	NUMBER(16,2),
Proposed_price		NUMBER(16,2),
Actual_price		NUMBER(16,2),
GM_OH_PCT 		NUMBER(6,2),
GM_NUM_PATIENTS 	NUMBER(10),
GM_NUM_SCREEN_FAIL 	NUMBER(10))       
tablespace tsnsmall pctfree 5;

Alter table TSN_Negotiate add constraint TSN_negotiate_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table TSN_Negotiate add constraint TSN_negotiate_uq1 
unique (short_desc) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table TSN_Negotiate add constraint TSN_negotiate_fk1 
foreign key (tsn_trial_id) references tsn_trial(trial_id);

Alter table TSN_Negotiate add constraint TSN_negotiate_fk2 
foreign key (trial_budget_id) references trial_budget(id);
 
Alter table TSN_Negotiate add constraint TSN_negotiate_fk3 
foreign key (creator_ftuser_id) references ftuser(id);

Alter table TSN_Negotiate add constraint TSN_negotiate_fk4 
foreign key (Contact_ftuser_id) references ftuser(id);

Alter table TSN_Negotiate add constraint TSN_negotiate_fk5 
foreign key (currency_id) references currency(id);

alter table tsn_negotiate add constraint tn_price_modifier_type_check
check(price_modifier_type in (0,1));

alter table tsn_negotiate add constraint tn_price_modifier_pct_check
check(price_modifier_pct between 0 and 99);

alter table tsn_negotiate add constraint tn_is_auto_accept_check
check(is_auto_accept in (0,1));

alter table tsn_negotiate add constraint tn_status_check
check(status between 0 and 2);

delete from id_control where table_name='tsn_negotiate';
insert into id_control values ('tsm10','tsn_negotiate',1);
commit;


create table TSN_Investigator(
ID      	NUMBER(10), 
Client_div_id   NUMBER(10) NOT NULL,
Inst_name       VARCHAR2 (1000) NOT NULL,         
Last_name       VARCHAR2 (128) NOT NULL,         
First_name      VARCHAR2 (128) NOT NULL,           
Address_1       VARCHAR2 (256),             
Address_2       VARCHAR2 (256),            
city    	VARCHAR2 (256) NOT NULL,          
Region_id       NUMBER(10) NOT NULL,
Country_id      NUMBER(10) NOT NULL,
email   	VARCHAR2 (256) NOT NULL,          
Work_phone      VARCHAR2(50),                
Cell_phone      VARCHAR2(50),                
fax             VARCHAR2(50),        
userid 		VARCHAR2(256),                 
Password        VARCHAR2(256),         
Oh_pct  	NUMBER (6,2),         
Specialty       VARCHAR2 (256) NOT NULL,
Need_password   NUMBER(1)  NOT NULL,  
Obsolete_flg    NUMBER(1)  NOT NULL,
communication_type	Number(1) DEFAULT 1 NOT NULL,	 
is_negotiable		Number(1) DEFAULT 0 NOT NULL,
old_password 		varchar2(256),
LAST_PASSWORD_UPDATE 	date)
tablespace tsnsmall pctfree 5;

Alter table TSN_investigator add constraint TSN_investigator_pk 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table TSN_investigator add constraint TSN_investigator_fk1 
foreign key (Client_div_id) references Client_div(id);

Alter table TSN_investigator add constraint TSN_investigator_fk2 
foreign key (Region_id) references Region(id);

Alter table TSN_investigator add constraint TSN_investigator_fk3 
foreign key (Country_id) references Country(id);

alter table tsn_investigator add constraint ti_need_password_check
check(need_password in (0,1));

alter table tsn_investigator add constraint ti_obsolete_flg_check
check(obsolete_flg in (0,1));

delete from id_control where table_name='tsn_investigator';
insert into id_control values ('tsm10','tsn_investigator',1);
commit;

create table tsn_neg_to_investigator( 
ID      		NUMBER(10),
tsn_negotiate_id    	NUMBER(10)  NOT NULL,
tsn_investigator_id 	NUMBER(10)  NOT NULL,
Num_patients    	NUMBER(10),          
Screen_fail     	NUMBER(10),          
OH_type 		NUMBER (1),
Proposed_other_site_fee NUMBER(10),
Actual_other_site_fee   NUMBER(10),
Proposed_price  	NUMBER(16,2),
Actual_price    	NUMBER(16,2),
Communication_type      NUMBER(1) default 1 NOT NULL,
Email_status    	NUMBER(1) default 0 NOT NULL,
Delete_flg      	NUMBER(1) default 0  NOT NULL,   
country_id      	NUMBER(10)  NOT NULL,
Local_currency_id       NUMBER(10)  NOT NULL,
completion_date 	DATE,
Proposed_oh_pct 	NUMBER(6,2),
actual_oh_pct   	NUMBER(6,2),
Proposed_cpp    	NUMBER(16,2),
Actual_cpp      	NUMBER(16,2),
Proposed_total  	NUMBER(16,2),
Actual_total    	NUMBER(16,2),
Status  		number(1),
Inv_accept_flg		NUMBER (1),
Spn_accept_flg		NUMBER (1))
tablespace tsnsmall pctfree 5;

Alter table tsn_neg_to_investigator add constraint tsn_neg_to_investigator_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_neg_to_investigator add constraint tsn_neg_to_investigator_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_neg_to_investigator add constraint tsn_neg_to_investigator_fk2 
foreign key (tsn_investigator_id) references tsn_investigator(id);

Alter table tsn_neg_to_investigator add constraint tsn_neg_to_investigator_fk3 
foreign key (country_id) references country(id);

Alter table tsn_neg_to_investigator add constraint tsn_neg_to_investigator_fk4 
foreign key (local_currency_id) references currency(id);

alter table tsn_neg_to_investigator add constraint tnti_oh_type_check
check(oh_type in (0,1));

alter table tsn_neg_to_investigator add constraint tnti_communication_type_check
check(communication_type in (0,1));

alter table tsn_neg_to_investigator add constraint tnti_email_status_check
check(email_status in (0,1));

alter table tsn_neg_to_investigator add constraint tnti_status_check
check(status between 0 and 5);

alter table tsn_neg_to_investigator add constraint tnti_Inv_accept_flg_check
check(Inv_accept_flg in (0,1));

alter table tsn_neg_to_investigator add constraint tnti_Spn_accept_flg_check
check(Spn_accept_flg in (0,1));

delete from id_control where table_name='tsn_neg_to_investigator';
insert into id_control values ('tsm10','tsn_neg_to_investigator',1);
commit;

create table tsn_unlisted_procedure(
ID      		NUMBER(10),  
tsn_negotiate_id    	NUMBER(10)  NOT NULL,
procedure_type  	NUMBER(1)  NOT NULL,             
long_desc    		VARCHAR2(1000),          
price   		NUMBER(10,2)  NOT NULL,          
currency_id     	NUMBER(10)  NOT NULL)
tablespace tsnsmall pctfree 5;

Alter table tsn_unlisted_procedure add constraint tsn_unlisted_procedure_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_unlisted_procedure add constraint tsn_unlisted_procedure_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_unlisted_procedure add constraint tsn_unlisted_procedure_fk2 
foreign key (currency_id) references currency(id);

delete from id_control where table_name='tsn_unlisted_procedure';
insert into id_control values ('tsm10','tsn_unlisted_procedure',1);
commit;

create table tsn_neg_to_cost_item(
ID      			NUMBER(10),
tsn_Negotiate_id    		NUMBER(10)  NOT NULL,
tsn_Neg_to_investigator_id     	NUMBER(10),
Oh_applied      		NUMBER(1),
Currency_id     		NUMBER(10),
Proposed_price  		NUMBER(10,2),
Actual_price    		NUMBER(10,2),
Price_range     		NUMBER(1),
Start_price     		NUMBER(10,2), 
Inv_accept_flg  		NUMBER(1),
Spn_accept_flg  		NUMBER(1),
Procedure_def_id        	NUMBER(10),
Odc_def_id      		NUMBER(10),
Unlisted_procedure_id   	NUMBER(10),
tsn_Unlisted_procedure_id       NUMBER(10),
Qty     			NUMBER(4),
Display_order   		NUMBER(4))
tablespace tsnsmall pctfree 5;


Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk2 
foreign key (tsn_neg_to_investigator_id) references tsn_neg_to_investigator(id);

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk3 
foreign key (Currency_id) references Currency(id);

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk4 
foreign key (Procedure_def_id) references Procedure_def(id);

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk5 
foreign key (Odc_def_id) references Odc_def(id);

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk6 
foreign key (Unlisted_procedure_id) references Unlisted_procedure(id);

Alter table tsn_neg_to_cost_item add constraint tsn_neg_to_cost_item_fk7 
foreign key (tsn_Unlisted_procedure_id) references tsn_Unlisted_procedure(id);

delete from id_control where table_name='tsn_neg_to_cost_item';
insert into id_control values ('tsm10','tsn_neg_to_cost_item',1);
commit;


create table tsn_neg_site_level_cost(
ID      			NUMBER(10),
tsn_Negotiate_id    		NUMBER(10) NOT NULL,
tsn_Neg_to_investigator_id     	NUMBER(10),
Currency_id     		NUMBER(10),
Price_range     		NUMBER(1),
Start_price     		NUMBER(10,2),
Proposed_price  		NUMBER(10,2),      
Actual_price    		NUMBER(10,2),
Inv_accept_flg  		NUMBER(1),
Spn_accept_flg  		NUMBER(1),
Odc_def_id      		NUMBER(10),
Unlisted_procedure_id   	NUMBER(10),
tsn_unlisted_procedure_id       NUMBER(10),
Display_order   		NUMBER(4))
tablespace tsnsmall pctfree 5;

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_fk2 
foreign key (tsn_neg_to_investigator_id) references tsn_neg_to_investigator(id);

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_fk3 
foreign key (currency_id) references currency(id);

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_fk4 
foreign key (odc_def_id) references Odc_def(id);

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_fk5 
foreign key (unlisted_procedure_id) references unlisted_procedure(id);

Alter table tsn_neg_site_level_cost add constraint tsn_neg_site_level_cost_fk6 
foreign key (tsn_unlisted_procedure_id) references tsn_unlisted_procedure(id);

alter table tsn_neg_site_level_cost add constraint tnslc_price_range_check
check(price_range in (0,1));

delete from id_control where table_name='tsn_neg_site_level_cost';
insert into id_control values ('tsm10','tsn_neg_site_level_cost',1);
commit;

create table tsn_unlisted_visit(
ID      	NUMBER(10),       
tsn_negotiate_id    NUMBER(10)  NOT NULL,
short_desc    	VARCHAR(256) NOT NULL,
Currency_id     NUMBER(10),
price   	NUMBER(10))       
tablespace tsnsmall pctfree 5;

Alter table tsn_unlisted_visit add constraint tsn_unlisted_visit_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_unlisted_visit add constraint tsn_unlisted_visit_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_unlisted_visit add constraint tsn_unlisted_visit_fk2 
foreign key (currency_id) references currency(id);

delete from id_control where table_name='tsn_unlisted_visit';
insert into id_control values ('tsm10','tsn_unlisted_visit',1);
commit;

create table tsn_neg_to_visit (
ID      			NUMBER(10),      
tsn_negotiate_id    		NUMBER(10) NOT NULL,
tsn_neg_to_investigator_id     	NUMBER(10),
Currency_id     		NUMBER(10),
Price_range     		NUMBER(1),
Start_price     		NUMBER(10,2),
Proposed_price  		NUMBER(10,2), 
Actual_price    		NUMBER(10,2),       
Inv_accept_flg  		NUMBER(1),
Spn_accept_flg  		NUMBER(1),
visit_name      		varchar2(256),
tsn_unlisted_visit_id   	NUMBER(10),
Display_order   		NUMBER(4))
tablespace tsnsmall pctfree 5;

Alter table tsn_neg_to_visit add constraint tsn_neg_to_visit_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_neg_to_visit add constraint tsn_neg_to_visit_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_neg_to_visit add constraint tsn_neg_to_visit_fk2 
foreign key (tsn_neg_to_investigator_id) references tsn_neg_to_investigator(id);

Alter table tsn_neg_to_visit add constraint tsn_neg_to_visit_fk3 
foreign key (Currency_id) references Currency(id);

Alter table tsn_neg_to_visit add constraint tsn_neg_to_visit_fk4 
foreign key (tsn_unlisted_visit_id) references tsn_unlisted_visit(id);


alter table tsn_neg_to_visit add constraint tntv_price_range_check
check(price_range in (0,1));

alter table tsn_neg_to_visit add constraint tntv_inv_accept_flg_check
check(inv_accept_flg in (0,1));

alter table tsn_neg_to_visit add constraint tntv_spn_accept_flg_check
check(Spn_accept_flg in (0,1));

delete from id_control where table_name='tsn_neg_to_visit';
insert into id_control values ('tsm10','tsn_neg_to_visit',1);
commit;


create table tsn_comment(
ID      			NUMBER(10),   
tsn_negotiate_id    		NUMBER(10) NOT NULL,
tsn_neg_to_investigator_id     	NUMBER(10),
tsn_neg_to_cost_item_id       	NUMBER(10),
tsn_neg_site_level_cost_id 	NUMBER(10),
tsn_neg_to_visit_id   		NUMBER(10),
price   			NUMBER(10),       
currency_id     		NUMBER(10),
comments 			VARCHAR2(2000),          
comments_date    		DATE NOT NULL,   
sponsor_ftuser_id 		NUMBER(10),
tsn_investigator_id        	NUMBER(10))
tablespace tsnsmall pctfree 5;

Alter table tsn_comment add constraint tsn_comment_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_comment add constraint tsn_comment_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

Alter table tsn_comment add constraint tsn_comment_fk2 
foreign key (tsn_neg_to_investigator_id) references tsn_neg_to_investigator(id);

Alter table tsn_comment add constraint tsn_comment_fk3 
foreign key (tsn_neg_to_cost_item_id) references tsn_neg_to_cost_item(id);

Alter table tsn_comment add constraint tsn_comment_fk4 
foreign key (tsn_neg_site_level_cost_id) references tsn_neg_site_level_cost(id);

Alter table tsn_comment add constraint tsn_comment_fk5 
foreign key (tsn_neg_to_visit_id) references tsn_neg_to_visit(id);

Alter table tsn_comment add constraint tsn_comment_fk6 
foreign key (currency_id) references currency(id);

Alter table tsn_comment add constraint tsn_comment_fk7 
foreign key (sponsor_ftuser_id) references ftuser(id);

Alter table tsn_comment add constraint tsn_comment_fk8 
foreign key (tsn_investigator_id) references tsn_investigator(id);

delete from id_control where table_name='tsn_comment';
insert into id_control values ('tsm10','tsn_comment',1);
commit;

create table tsn_document(
ID      		NUMBER(10),   
tsn_negotiate_id    	NUMBER(10) NOT NULL,
document        	BLOB,            
doc_type        	NUMBER(1)  NOT NULL,
doc_name        	VARCHAR2(256) NOT NULL,          
doc_format      	VARCHAR2(50),
deleted_flg 		NUMBER(1) default 0)
tablespace tsnsmall pctfree 5;

Alter table tsn_document add constraint tsn_document_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table tsn_document add constraint tsn_document_fk1 
foreign key (tsn_negotiate_id) references tsn_negotiate(id);

alter table tsn_document add constraint td_doc_type_check
	check(doc_type in (0,1));

alter table tsn_document add constraint td_deleted_flg_check
	check(deleted_flg in (0,1));

alter table tsn_document add constraint td_doc_format_check
	check(doc_format in ('pdf','doc','xls'));

delete from id_control where table_name='tsn_document';
insert into id_control values ('tsm10','tsn_document',1);
commit;

create table TSN_CLIENT_DEFAULTS(
ID			NUMBER(10),	   
Client_div_id		NUMBER(10)  NOT NULL,
def_intro_msg		VARCHAR2(1000),	   
def_reminder_msg	VARCHAR2(1000),   
def_accept_msg		VARCHAR2(1000),
def_neg_type		NUMERIC(1),	   
show_CPT_flg		NUMERIC(1),	   
def_start_price		NUMERIC(1),	   
allow_user_edit_flg	NUMERIC(1),	   
def_plan_curr_id	NUMERIC(10) NOT NULL,
def_auto_accept_pct	NUMBER(4)  NOT NULL)
tablespace tsnsmall pctfree 5;		 

Alter table TSN_CLIENT_DEFAULTS add constraint TSN_CLIENT_DEFAULTS_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table TSN_CLIENT_DEFAULTS add constraint TSN_CLIENT_DEFAULTS_fk1 
foreign key (Client_div_id) references Client_div(id);
 
Alter table TSN_CLIENT_DEFAULTS add constraint TSN_CLIENT_DEFAULTS_fk2 
foreign key (def_plan_curr_id) references currency(id);


delete from id_control where table_name='tsn_client_defaults';
insert into id_control values ('tsm10','tsn_client_defaults',1);
commit;

-- updated upto this in tsm10e@test on 11/13/2007 at 12:55pm

-- Following changes are as per request of Tonya on 11/27/2007 at 4pm

alter table tsn_document drop constraint TD_DOC_FORMAT_CHECK;

-- Following changes are as per request of Tonya on 11/29/2007 at 4:21pm

alter table tsn_negotiate add(doc_str varchar2(2000));

-- Following changes are as per request of Tonya on 12/4/2007 at 11:21pm

alter table tsn_investigator modify REGION_ID null;

-- Following changes are as per request of Tonya on 12/10/2007 at 3pm

create table TSN_UNL_INSTITUTION( 
ID 		NUMBER(10),
Country_id  	NUMBER(10)   NOT NULL,
region_id  	NUMBER(10),  
Inst_name 	VARCHAR2(1000) NOT NULL,
Address1  	VARCHAR2(128),
Address2 	VARCHAR2(128),
City 		VARCHAR2(128))
tablespace tsnsmall pctfree 5;
 
Alter table TSN_UNL_INSTITUTION add constraint TSN_UNL_INSTITUTION_PK 
primary key (id) using index tablespace 
tsnsmall_indx pctfree 5;

Alter table TSN_UNL_INSTITUTION add constraint TSN_UNL_INSTITUTION_fk1 
foreign key (Country_id) references Country(id);
 
Alter table TSN_UNL_INSTITUTION add constraint TSN_UNL_INSTITUTION_fk2 
foreign key (region_id) references region(id);

delete from id_control where table_name='tsn_unl_institution';
insert into id_control values ('tsm10','tsn_unl_institution',1);
commit;

-- Following changes are as per request of Tonya on 12/20/2007 at 1:30pm

alter table tsn_negotiate add(email_intro_msg VARCHAR2(2000));

-- updated upto this in tsm10e@prev on ????
-- updated upto this in tsm10t@prev on ????

-- updated upto this in tsm10e@test on 1/2/2008 at 11:30 am

-- Following changes are as per request of Tonya on 1/3/2008 at 10:30pm

alter table TSN_CLIENT_DEFAULTS modify DEF_AUTO_ACCEPT_PCT  null;

-- Following changes are as per request of Tonya on 1/7/2008 at 10:45am

Alter table tsn_neg_to_investigator add remove_note Varchar2(2000);

alter table CLIENT_DIV_TO_LIC_APP drop constraint CDTLA_APP_NAME_CHECK;

alter table CLIENT_DIV_TO_LIC_APP add constraint CDTLA_APP_NAME_CHECK 
	check(app_name in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN')); 

-- Following change are as per request of Tonya on 1/9/2008 at 3pm

alter table tsn_neg_to_investigator  add price_range number(1);

alter table tsn_neg_to_investigator add constraint tnti_price_range_check
check ( price_range in (0,1));

Alter table TSN_Negotiate drop constraint TSN_negotiate_uq1;

-- Following change was as per request of TYonya on 10/30/2007 at 6:30pm

Alter table TSN_Negotiate add constraint TSN_negotiate_uq1 
unique (tsn_trial_id,short_desc) using index tablespace 
tsnsmall_indx pctfree 5;

-- updated upto this in tsm10e@test on 1/18/2008 at 1:30 pm

-- Following change was as per request of Tonya on 1/29/2008 at 3pm

Alter table ftuser drop column tsn_user_type;

-- Following change was as per request of Tonya on 2/19/2008 at 11:30am

alter table tsn_unlisted_procedure add proc_type number(1);
update tsn_unlisted_procedure set proc_type=procedure_type;
commit;
alter table tsn_unlisted_procedure modify proc_type not null;
alter table tsn_unlisted_procedure drop column PROCEDURE_TYPE;


-- updated upto this in tsm10e@test on 2/19/2008 at 1:30 pm

-- Following changes are as per request of Tonya on 3/4/2008 at 9:00am

alter table tsn_neg_to_investigator add TEMP_PRICE NUMBER(10,2);
alter table tsn_neg_to_cost_item add TEMP_PRICE NUMBER(10,2);
alter table tsn_neg_site_level_cost add TEMP_PRICE NUMBER(10,2);
alter table tsn_neg_to_visit add TEMP_PRICE NUMBER(10,2);

-- Following changes are as per request of Tonya on 3/19/2008 at 8:00am

delete from TSN_NEG_SITE_LEVEL_COST;
delete from  TSN_NEG_TO_VISIT;
delete from  TSN_NEG_TO_COST_ITEM;
delete from TSN_NEG_TO_INVESTIGATOR;
delete from TSN_UNLISTED_PROCEDURE;
delete from tsn_negotiate;
commit;

Alter table TSN_Negotiate add client_div_id number(10) not null;

Alter table TSN_Negotiate add constraint TSN_negotiate_fk6
foreign key (client_div_id) references client_div(id);

-- Following changes are as per request of Tonya on 3/24/2008 at 6:00am

alter table tsn_neg_to_investigator add(
proposed_oh_cost NUMBER(10,2), actual_oh_cost NUMBER(10,2));

insert into ftgroup values ('35','TSN Investigator');
commit;

alter table Tsn_neg_to_investigator add(
INV_OTHER_FEE_ACCEPT_FLG                           NUMBER(1),
SPN_OTHER_FEE_ACCEPT_FLG                           NUMBER(1),
OTHER_FEE_PRICE_RANGE                              NUMBER(1),
TEMP_OTHER_FEE                                     NUMBER(12));

alter table Tsn_neg_to_cost_item add actual_oh_applied	Number(1);
alter table Tsn_comment add is_other_fee Number(1) defaUlt 0;

-- updated upto this in tsm10e@test on 4/2/2008 at 12:30 pm

-- Following changes are as per request of Tonya on 4/14/2008 at 2:30pm

alter table Tsn_comment add(is_oh_pct Number(1) default 0 not null);

alter table tsn_neg_to_investigator add(
  proposed_proc_total 	number(12,2),
  actual_proc_total 	number(12,2),
  saved_oh_pct 		number(5,2),
  inv_oh_accept_flg 	number(1),
  spn_oh_accept_flg 	number(1));

-- Following changes are as per request of Tonya on 4/15/2008 at 10:30am

Alter table tsn_neg_to_investigator add oh_pct_range NUMBER(1);  


-- Following changes are as per request of Tonya on 4/22/2008 at 9am 

alter table tsn_comment modify price number(12,2);
-- updated upto this in tsm10e@test on 4/22/2008 at 4:30 pm

-- Following changes are as per request of Tonya on 4/25/2008 at 9:25 am

alter table tsn_neg_site_level_cost add QTY NUMBER(6,2);
alter table tsn_neg_to_cost_item  modify QTY    number(6,2);

-- updated upto this in tsm10e@test on 4/29/2008 at 4:30 pm

-- Following changes are as per request of Tonya on 4/30/2008 at 11:25 am

alter table tsn_negotiate  add gm_screen_fail_cost NUMBER(16,2);

-- updated upto this in tsm10e@test on 5/14/2008 at 5:50 pm

-- Following changes are as per request of Tonya on 5/15/2008 at 1:30pm

alter table tsn_neg_to_investigator add(
	proposed_scr_fail_cost 	NUMBER(16,2),
	actual_scr_fail_cost	NUMBER(16,2));

-- Following changes are as per request of Tonya on 5/16/2008 at 1:30pm

Alter table TSN_NEGOTIATE add use_oh_in_screen_faiures NUMBER(1) default 0 not null;



-- updated upto this in tsm10e@test on 5/20/2008 at 9:50 am


-- Following changes are as per request of Tonya on 5/23/2008 at 9:19 am

alter table TSN_COMMENT Add is_scr_cost NUMBER(1) DEFAULT 0 NOT NULL;

alter table TSN_NEG_TO_INVESTIGATOR Add(
		saved_scr_fail_cost 	NUMBER(10,2),
		scr_fail_range 		NUMBER(1),
		inv_scr_accept_flg 	NUMBER(1),
		spn_scr_accept_flg 	NUMBER(1));


-- updated upto this in tsm10e@test on 6/3/2008 at 1:20 pm

---- Following changes are as per request of Tonya on 6/3/2008 at 3 pm

alter table tsn_negotiate drop constraint tsn_negotiate_fk2;


-- updated upto this in tsm10e@test on 6/19/2008 at 3:20 pm
-- updated upto this in tsm10e@prev on 6/19/2008 at 3:20 pm
-- updated upto this in tsm10t@prev on 6/19/2008 at 3:20 pm
-- updated upto this in tsm10e@prod on 6/20/2008 at 6:20 pm
-- updated upto this in tsm10@prod on 6/20/2008 at 6:20 pm


-- Following changes are as per request of Tonya on 7/16/2008 at 1Pm

alter table tsn_unl_institution add (ftuser_id number(10), client_div_id number(10));

alter table tsn_unl_institution add constraint tsn_unl_institution_fk3 foreign key(ftuser_id)
references ftuser(id);

alter table tsn_unl_institution add constraint tsn_unl_institution_fk4 foreign key(client_div_id)
references client_div(id);

--Following changes are as per request of Tonya on 7/30/2008 at 4Pm
--Implemented in DEVL and D003.
alter table tsn_unl_institution modify(FTUSER_ID not null, CLIENT_DIV_ID not null);

--updated upto this in tsm10@devl  on 7/16/2008

-- updated upto this in tsm10e@test on 7/24/2008 at 10:30 am
-- updated upto this in tsm10t@prev on 7/24/2008 at 3:30 pm
-- updated upto this in tsm10e@prev on 7/24/2008 at 3:30 pm
-- Updated upto this in TSM10@PROD on 08/08/2008 at 5:10pm
-- Updated upto this in TSM10E@PROD on 08/08/2008 at 5:10pm
-- Updated upto this in TSM10@DEMO on 08/08/2008 at 5:10pm

--Following changes are as per request of Tonya on 7/30/2008 at 4Pm
--Implemented in DEVL and D003.
alter table tsn_unl_institution rename column FTUSER_ID to CREATOR_FTUSER_ID;


--updated upto this in tsm10@devl on 7/30/2008
-- updated upto this in tsm10@d003

-
--Following changes are as per Phil's request on 08/18/2008 at 10:45am
--Implemented in DEVL and D003
alter table tsn_client_defaults modify(def_intro_msg varchar2(4000),def_reminder_msg varchar2(4000), def_accept_msg varchar2(4000));

-- updated upto this in tsm10@devl on 8/18/2008 at 10:45am
-- updated upto this in tsm10@d003 on 8/18/2008 at 10:45am


--*********************************************************
-- updated upto this in tsm10e@test on 8/18/2008 at 10:45am
-- updated upto this in tsm10t@prev on 8/18/2008 at 10:45am
-- updated upto this in tsm10e@prev on 8/18/2008 at 10:45am
-- updated upto this in tsm10@prod on 8/18/2008 at 03:00pm
-- updated upto this in tsm10e@prod on 8/18/2008 at 03:00pm
-- updated upto this in tsm10@demo on 8/18/2008 at 03:00pm
--*********************************************************

--Following changes are as per Tonya's request on 08/30/2008
--Implemented in DEVL and D003
Alter table TSN_NEGOTIATE add alt_contact_ftuser_id NUMBER(10);
Alter table TSN_NEGOTIATE add constraint TSN_NEGOTIATE_FK7 foreign key(alt_contact_ftuser_id) references ftuser(id);
Alter table TSN_NEG_TO_INVESTIGATOR add (alt_contact_investigator_id NUMBER(10),negotiation_currency_id NUMBER(10)) ;
Alter table TSN_NEG_TO_INVESTIGATOR add constraint TSN_NEG_TO_INVESTIGATOR_FK5 foreign key (alt_contact_investigator_id) references  tsn_investigator(id);
Alter table TSN_NEG_TO_INVESTIGATOR add constraint TSN_NEG_TO_INVESTIGATOR_FK6 foreign key (negotiation_currency_id) references  currency(id);
Alter table TSN_document add tsn_neg_to_investigator_id number(10);
Alter table TSN_document add constraint TSN_document_FK2 foreign key (tsn_neg_to_investigator_id) references  tsn_neg_to_investigator(id);
alter table tsn_document modify tsn_negotiate_id null; 
update TSN_NEG_TO_INVESTIGATOR set negotiation_currency_id = local_currency_id; 
commit; 
alter table TSN_NEG_TO_INVESTIGATOR modify negotiation_currency_id not null;
-- updated upto this in tsm10@devl on 08/30/2008
-- updated upto this in tsm10@d003 on 08/30/2008

alter table TSN_NEG_SITE_LEVEL_COST add (is_invoicable Number(1) default 0 not null,
	is_cost_item NUMBER(1) default 1 not null ,
	invoice_qty Number(6,2),
	invoice_proposed_price number(10,2),
	invoice_actual_price number(10,2),
	invoice_temp_price number(10,2),
	invoice_spn_accept_flg number(1),
	invoice_inv_accept_flg number(1),
	invoice_price_range number(1));
alter table TSN_NEG_TO_COST_ITEM add (is_invoicable Number(1) default 0 not null,
	is_cost_item NUMBER(1) default 1 not null ,
	invoice_qty Number(6,2),
	invoice_proposed_price number(10,2),
	invoice_actual_price number(10,2),
	invoice_temp_price number(10,2),
	invoice_spn_accept_flg number(1),
	invoice_inv_accept_flg number(1),
	invoice_price_range number(1));
alter table TSN_NEG_TO_VISIT add (is_invoicable Number(1) default 0 not null,
	is_visit_item NUMBER(1) default 1 not null,
	invoice_proposed_price number(10,2),
	invoice_actual_price number(10,2),
	invoice_temp_price number(10,2),
	invoice_spn_accept_flg number(1),
	invoice_inv_accept_flg number(1),
	invoice_price_range number(1));


alter table TSN_COMMENT add (is_invoice_cost number(1) default 0 not null);
-- updated upto this in tsm10@devl on 09/15/2008
-- updated upto this in tsm10@d003 on 09/15/2008

--Following changes are as per Tonya's request on 10/06/2008
--Implemented in DEVL and D003
CREATE TABLE tsn_neg_to_inv_contact
(
  id NUMBER(10) NOT NULL,
  tsn_investigator_id NUMBER(10) NOT NULL,
  tsn_neg_to_investigator_id NUMBER(10) NOT NULL, 
  CONSTRAINT tsn_neg_to_inv_contact_PK PRIMARY KEY
  (
    ID
  )
  ENABLE
);

Alter table tsn_neg_to_inv_contact add constraint tsn_neg_to_inv_contact_fk1 foreign key (tsn_investigator_id) references tsn_investigator(id);
Alter table tsn_neg_to_inv_contact add constraint tsn_neg_to_inv_contact_fk2 foreign key (tsn_neg_to_investigator_id) references tsn_neg_to_investigator(id);
insert into id_control values('tsm10','tsn_neg_to_inv_contact',1);
commit;

-- updated upto this in tsm10@q002 on 12/3/2008 at 10:40am



--Following changes are as per Tonya's request on 12/16/2008
--Implemented in DEVL, D003 and D002

alter table tsn_client_defaults add (sys_email varchar2(100));

create table env_var 
(
  id NUMBER(10) NOT NULL,
  app_type varchar2(50),
  vaR_name varchar2(256),
  value varchar2(256), 
  CONSTRAINT env_var_PK PRIMARY KEY
  (
    ID
  )
  ENABLE
);

ALter table env_var add CONSTRAINT env_var_app_type_check CHECK (
app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN'));

insert into id_control values('tsm10','env_var',1);
commit;


--Following changes are as per Tonya's request on 12/19/2008
--Implemented in DEVL, D003 and D002
alter table tsn_client_defaults add(fromft_email_flg number(1) default 0 not null);



alter table client_div_to_lic_app drop constraint CDTLA_APP_NAME_CHECK;
alter table client_div_to_lic_app add constraint CDTLA_APP_NAME_CHECK CHECK(app_name in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN','GMOWN') );

alter table tsm_message drop constraint tm_app_type_check;
alter table tsm_message add constraint tm_app_type_check CHECK (app_type in ('PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN'));

alter table user_pref drop constraint up_app_type_check;
alter table user_pref add constraint up_app_type_check CHECK(app_type in ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN') );

--ONLY IN PROD changes
--insert into env_var select * from env_var@db_link;
--update env_var set VALUE='https://tps.mdsol.com/gmc/InvLogin.jsp' where id=1;

--insert into client_div_to_lic_app 
--SELECT increment_sequence('client_div_to_lic_app_seq'), client_div_to_lic_app.client_div_id,'GMOWN', license_exp_date,
--principal_contact_id,null,'2.1.0',0,null,alert_email,app_components 
--FROM client_div_to_lic_app
--WHERE app_name='PICASE' 
--AND client_div_id in (select id from client_div where client_div_identifier in ('ASP',
--'AZA',
--'BMS',
--'CSL',
--'FTM',
--'FTS',
--'KPI',
--'LIL',
--'MDT',
--'MED',
--'MGI',
--'ONX',
--'PRD',
--'PSW',
--'SFL',
--'SNI',
--'WAT') );

-- updated upto this in tsm10@devl on 12/19/2008
-- updated upto this in tsm10@d003 on 12/19/2008
-- updated upto this in tsm10@d002 on 12/19/2008
-- updated upto this in tsm10@q002 on 12/23/2008
-- updated upto this in tsm10@demo on 01/22/2009
-- updated upto this in tsm10e@prev on 01/22/2009
-- updated upto this in tsm10@prod on 01/30/2009
-- updated upto this in tsm10e@ltst on 03/03/2009


--To be implemented Manually in Prod.

--insert into env_var select * from env_var@dblink_q002;
--update id_control set next_id=3 where table_name='env_var';

--insert into client_div_to_lic_app 
--SELECT increment_sequence('client_div_to_lic_app_seq'), client_div_to_lic_app.client_div_id,'GMOWN', license_exp_date,
--principal_contact_id,null,'2.1.0',0,null,alert_email,app_components 
--FROM client_div_to_lic_app
--WHERE app_name='PICASE'	

--Implemented in Q002 on 03/12/2009
alter table tsn_unl_institution rename column FTUSER_ID to CREATOR_FTUSER_ID;


-- updated upto this in tsm10@devl on 12/19/2008
-- updated upto this in tsm10@d003 on 12/19/2008
-- updated upto this in tsm10@d002 on 12/19/2008
-- updated upto this in Q002 on 03/12/2009
-- updated upto this in demo on 03/12/2009
--*********************************************************
-- updated upto this in tsm10e@prev on 03/14/2009
-- updated upto this in prod on 03/14/2009
-- updated upto this in ltst on 03/14/2009
-- updated upto this in q003 on 03/14/2009
--*********************************************************

--As per Tonya's request on 04/14/09 in DEVL, d003, d002
ALTER TABLE tsn_neg_to_cost_item ADD(sqty NUMBER(6,2) );
ALTER TABLE tsn_neg_to_investigator ADD(is_fixed_sf_cost NUMBER(1) default 1 not null,
                                        use_oh_in_screen_failure NUMBER(1) default 0 not null );
--*********************************************************
-- updated upto this in tsm10@devl on 04/14/09
-- updated upto this in tsm10@d003 on 04/14/09
-- updated upto this in tsm10@d002 on 04/14/09
-- updated upto this in tsm10@q002 on 05/06/09
-- updated upto this in tsm10@demo on 05/18/2009
--*********************************************************

--Implemented in all databases devl, d002, d003, prev,q002,demo and prod
--On 04/26/2009
ALTER TABLE trial_budget modify(total_cost_local  number(15),total_cost_pvb_local number(15));

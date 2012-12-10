create table tspd_diagram  ( 
ID			Number(10),
icp_instance_id		Number(10) NOT NULL,
diagram			BLOB NOT NULL,
icp_object_id		Number(10) NOT NULL,
icp_object_type		Varchar2(80) NOT NULL,
version_timestamp	number(10) not null)
tablespace tspdblob pctfree 20;

Alter table tspd_diagram add constraint tspd_diagram_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_diagram add constraint tspd_diagram_fk1
	foreign key (icp_instance_id) references 
	icp_instance(id);

ALTER TABLE tspd_diagram ADD CONSTRAINT td_icp_object_type_check 
 CHECK (icp_object_type in ('SOA', 'ELEMENT', 'EVENT'));


insert into id_control values('tsm10','tspd_diagram',1);
commit;

create or replace view tspd_diagram_noblob as
select id, icP_instance_id, icp_object_id, 
icp_object_type, version_timestamp
from tspd_diagram;


create table tspd_coding_system(
id		Number(10),
short_desc	Varchar2(80) NOT NULL,
long_desc	Varchar2(160) NOT NULL,
version		Varchar2(80),
Sponsor		Varchar2(1024))
tablespace tspdsmall pctfree 20;

Alter table tspd_coding_system add constraint tspd_coding_system_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

insert into id_control values('tsm10','tspd_coding_system',1);
commit;

create table tspd_unit_of_measure(
id		Number(10),
short_desc	Varchar2(80) NOT NULL,
long_desc	Varchar2(160),
obsolete_flg	Number(1) default 0 NOT NULL,
locale		Varchar2(16) default 'en_US' NOT NULL,
parent_uom_id	number(10))
tablespace tspdsmall pctfree 20;

Alter table tspd_Unit_Of_Measure add constraint tspd_Unit_Of_Measure_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_unit_of_measure add constraint tspd_unit_of_measure_fk1
	foreign key (parent_uom_id) references 
	tspd_unit_of_measure(id);


insert into id_control values('tsm10','tspd_unit_of_measure',1);
commit;

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (1,'Temperature','Units of Temperature',0,'en_US',null );                                    

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (101,UNISTR('\00B0F'),'Degrees Fahrenheit',0,'en_US',1 );                                               

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (102,UNISTR('\00B0C'),'Degrees Celsius',0,'en_US',1 );                                                  
                                                                                                   

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (103,UNISTR('\00B0K'),'Degrees Kelvin',0,'en_US',1 );                                                   

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (2,'Weight','Units of static weight',0,'en_US',null );                                       

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (201,'kg','kilograms',0,'en_US',2 );                                                         

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (202,'g','grams',0,'en_US',2 );                                                              

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (203,'mg','milligrams',0,'en_US',2 );                                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (204,UNISTR('\00B5g'),'micrograms',0,'en_US',2 );                                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (205,'oz','ounces',0,'en_US',2 );                                                            

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (206,'lb','pounds',0,'en_US',2 );                                                            

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (3,'Dimensions','Units of Size and Area',0,'en_US',null );                                   

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (301,'nm','nanometers',0,'en_US',3 );                                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (302,UNISTR('nm\00B2'),'square nanometers',0,'en_US',3 );                                                

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (303,'mm','millimeters',0,'en_US',3 );                                                       

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (304,UNISTR('mm\00B2'),'square millimeters',0,'en_US',3 );                                               

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (305,'cm','centimeters',0,'en_US',3 );                                                       

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (306,UNISTR('cm\00B2'),'square centimeters',0,'en_US',3 );                                               

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (307,'m','meters',0,'en_US',3 );                                                             

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (308,UNISTR('m\00B2'),'square meters',0,'en_US',3 );                                                     

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (309,'inches','inches',0,'en_US',3 );                                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (310,UNISTR('inches\00B2'),'square inches',0,'en_US',3 );                                                

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (4,'Liquid and Flow','Measure of liquid volume and flow',0,'en_US',null );                   

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (401,UNISTR('\00B5l'),'microliters',0,'en_US',4 );                                                       

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (402,'ml','milliliters',0,'en_US',4 );                                                       

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (403,'dl','deciliters',0,'en_US',4 );                                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (404,'l','liters',0,'en_US',4 );                                                             

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (405,UNISTR('\00B5l/min'),'microliters per minute',0,'en_US',4 );                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (406,'ml/min','milliliters per minute',0,'en_US',4 );                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (407,'ml/hour','milliliters per hour',0,'en_US',4 );                                         

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (408,UNISTR('\00B5l/min/kg'),'microliters per minute per kg body weight',0,'en_US',4 );                  

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (409,'ml/min/kg','milliliters per minute per kg body weight',0,'en_US',4 );                  

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (410,'ml/hour/kg','milliliters per hour per kg body weight',0,'en_US',4 );                   

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (5,'Density','Units of Mass and Density',0,'en_US',null );                                                                                                                                     

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (501,UNISTR('kg/m\00B3'),'Density (Rho)',0,'en_US',5 );                                                  

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (502,UNISTR('(kg/m\00B3)/1000'),'Specific Gravity',0,'en_US',5 );                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (6,'Dilution and Concentration','Units of Dilution',0,'en_US',null );                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (601,'mg/ml','Milligrams per milliliter',6,'en_US',6 );                                      

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (602,'mg/l','Milligrams per liter',6,'en_US',6 );                                            

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (603,UNISTR('\00B5g/ml'),'Micrograms per milliliter',6,'en_US',6 );                                      

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (604,UNISTR('\00B5g/ml'),'Microgram per milliliter',6,'en_US',6 );                                       

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (605,'ppm','Parts per million',6,'en_US',6 );                                                

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (606,'ppb','Parts per billion',6,'en_US',6 );                                                

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (607,'M/l','Molarity',6,'en_US',6 );                                                         

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (608,'M/kg','Molality',6,'en_US',6 );                                                        

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (7,'Physical Dynamics','Physical Dynamics',0,'en_US',null );                                 

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (8,'Light','Light',0,'en_US',null );                                                         

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (9,'Motion','Velocity and Acceleration',0,'en_US',null );                                    

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (10,'Energy and Power','Energy and Power',0,'en_US',null );                                  

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (11,'Acoustics','Acoustics',0,'en_US',null );                                                

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (12,'Radiation','Radiation',0,'en_US',null );                                                

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (49,'None','Categorical Variables',0,'en_US',null );                                         

insert into tspd_unit_of_measure (ID,SHORT_DESC,LONG_DESC,OBSOLETE_FLG,LOCALE,PARENT_UOM_ID)           
values (50,'Other','Categorical Variables',0,'en_US',50 );
commit;

create table tspd_study_variable(
id			Number(10),
client_div_id		Number(10) NOT NULL,
short_desc		Varchar2(80) NOT NULL,
acronym			Varchar2(80),
long_desc		Varchar2(1024),
code1			Varchar2(80),
coding_System1_id	Number(10),
code2			Varchar2(80),
coding_System2_id	Number(10),
uom_id			Number(10),
uom_short_desc		Varchar2(80),
Min_valid		Number(10),
Max_valid		Number(10),
obsolete_flg		Number(1) default 0 NOT NULL,
code3 			VARCHAR2(80),
coding_system3_id 	NUMBER(10),
definition 		varchar2(256) NOT NULL,
low_normal 		number(10),
high_normal 		number(10))
tablespace tspdsmall pctfree 20;

Alter table tspd_study_variable add constraint tspd_study_variable_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_study_variable add constraint tspd_study_variable_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table tspd_study_variable add constraint tspd_study_variable_fk2
	foreign key (coding_System1_id) references 
	tspd_coding_System(id);

Alter table tspd_study_variable add constraint tspd_study_variable_fk3
	foreign key (coding_System2_id) references 
	tspd_coding_System(id);

Alter table tspd_study_variable add constraint tspd_study_variable_fk4
	foreign key (uom_id) references 
	tspd_Unit_Of_Measure(id);

Alter table tspd_study_variable add constraint tspd_study_variable_fk5
	foreign key (coding_System3_id) references 
	tspd_coding_System(id);

Alter table tspd_study_variable add constraint tsv_obsolete_flg_check
	check (obsolete_flg in (0,1));

insert into id_control values('tsm10','tspd_study_variable',1);
commit;

create table tspd_variable_mapping(
id			Number(10),
client_div_id		Number(10) NOT NULL,
procedure_def_id	Number(10),
custom_task_id		Number(10),
study_variable_id	Number(10) NOT NULL,
obsolete_flg		Number(1) default 0 NOT NULL, 
comments		Varchar2(160))
tablespace tspdsmall pctfree 20;

Alter table tspd_variable_mapping add constraint tspd_variable_mapping_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_variable_mapping add constraint tspd_variable_mapping_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table tspd_variable_mapping add constraint tspd_variable_mapping_fk2
	foreign key (procedure_def_id) references 
	procedure_def(id);

Alter table tspd_variable_mapping add constraint tspd_variable_mapping_fk3
	foreign key (custom_task_id) references 
	unlisted_procedure(id);

Alter table tspd_variable_mapping add constraint tspd_variable_mapping_fk4
	foreign key (study_variable_id) references 
	tspd_study_variable(id);

Alter table tspd_variable_mapping add constraint tvm_obsolete_flg_check
	check (obsolete_flg in (0,1));

insert into id_control values('tsm10','tspd_variable_mapping',1);
commit;

alter table client_div_to_lic_app add(app_components number(10));

CREATE OR REPLACE
procedure delete_my_tspd_trial(
myuserid in varchar2)
is

begin

delete from tspd_diagram where icp_instance_id in (select a.id
from icp_instance a,tspd_trial b, ftuser c where
a.trial_id=b.trial_id and b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

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

CREATE OR REPLACE
procedure delete_tspd_trial(
trialid in number)
is

begin

delete from tspd_diagram where icp_instance_id in (select id
from icp_instance where trial_id=trialid);

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

CREATE OR REPLACE
procedure delete_tspd_template(
templateid in number)
is

begin

delete from tspd_diagram where icp_instance_id in (select a.id
from icp_instance a,tspd_trial b where
a.trial_id=b.trial_id and b.tspd_template_id = templateid);

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

-- Implemented upto this in tsm10g@devl on 09/21/2005 at 1:35pm
-- Implemented upto this in tsm10e@test on 09/24/2005 at 3:45pm

LOAD DATA FOR UOM TABLE

-- Following chnages are as per request of Peter on 11/29/2005 at 10am

alter table tspd_variable_mapping modify(COMMENTS varchar2(2048));


-- Implemented upto this in tsm10g@devl on 12/12/2005 at 1:35pm
-- Implemented upto this in tsm10e@test on 12/12/2005 at 3:45pm

-- Following changes are as as per the request of Michael Meyer on 12/14/2005 at 9am

Alter table tspd_study_variable add(
data_type 		VARCHAR2(40),
dimension 		VARCHAR2(40),
origin 			VARCHAR2(40) default 'measurement' not null,
origination_method	 VARCHAR2(1024),
origination_func     	 VARCHAR2(1024));

alter table  tspd_study_variable add constraint tsv_origin_check 
	check(origin in ('measurement', 'derivation', 'recoded', 'analysis'));


 
 
create table tspd_stat_model(
id 		 NUMBER(10),
client_div_id	 NUMBER(10)  NOT NULL,
label		 VARCHAR2(80) NOT NULL,
model_type	 VARCHAR2(80) NOT NULL,
long_desc	 VARCHAR2(2048),
assumptions	 VARCHAR2(4000),
method_name	 VARCHAR2(40),
proc_signature	 VARCHAR2(1024),
method_mathml	 VARCHAR2(4000),
parent_id	 NUMBER(10),
obsolete_flg	 NUMBER(1) DEFAULT 0 NOT NULL)
tablespace tspdsmall pctfree 20;

Alter table tspd_stat_model add constraint tspd_stat_model_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_stat_model add constraint tspd_stat_model_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table tspd_stat_model add constraint tspd_stat_model_fk2
	foreign key (parent_id) references 
	tspd_stat_model(id);

Alter table tspd_stat_model add constraint tsm_obsolete_flg_check
	check (obsolete_flg in (0,1));

insert into id_control values('tsm10','tspd_stat_model',1);
commit;

  

create table tspd_analysis_var_mapping(
id				 NUMBER(10),
client_div_id			 NUMBER(10) NOT NULL,
tspd_stat_model_id 		 NUMBER(10) NOT NULL,
tspd_study_variable_id		 NUMBER(10) NOT NULL,
comments			 VARCHAR2(2048),
obsolete_flg			 NUMBER(1) DEFAULT 0 NOT NULL)
tablespace tspdsmall pctfree 20;

Alter table tspd_analysis_var_mapping add constraint tspd_analysis_var_mapping_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 30;

Alter table tspd_analysis_var_mapping add constraint tspd_analysis_var_mapping_fk1
	foreign key (client_div_id) references 
	client_div(id);

Alter table tspd_analysis_var_mapping add constraint tspd_analysis_var_mapping_fk2
	foreign key (tspd_stat_model_id) references 
	tspd_stat_model(id);

Alter table tspd_analysis_var_mapping add constraint tspd_analysis_var_mapping_fk3
	foreign key (tspd_study_variable_id) references 
	tspd_study_variable(id);

Alter table tspd_analysis_var_mapping add constraint tavm_obsolete_flg_check
	check (obsolete_flg in (0,1));

insert into id_control values('tsm10','tspd_analysis_var_mapping',1);
commit;

-- Implemented upto this in tsm10g@devl on 12/14/2005 at 10am


-- Following changes are as per the request of Peter on 12-22-05 at 3pm

alter table tspd_analysis_var_mapping add(
is_output number(1) default 0 not null);

alter table tspd_analysis_var_mapping add constraint tavm_is_output_check
check(is_output in (0,1));

load tspd_UOM table

-- Implemented upto this in tsm10e@test on 1/3/2006 at 2:34pm
-- Implemented upto this in tsm10g@devl on 1/3/2006 at 2:34pm

Alter table tspd_stat_model  add(method_mathml2  CLOB);

-- Following changes are as per the request of Michae on 02-08-2006 at 4:30pm

alter table client_div add(librarian_only number(1) default 0 not null);

Alter table client_div add constraint cd_librarian_only_check
check (librarian_only in (0,1));

Alter table project add(is_library number(1) default 0 not null);

Alter table project add constraint project_is_library_check
check (is_library in (0,1));

-- Following changes are as per request of Peter on 02/17/2006 at 9:50am

alter table tspd_study_variable drop constraint TSV_ORIGIN_CHECK;

alter table tspd_study_variable add constraint TSV_ORIGIN_CHECK
check(origin in ('measurement', 'derivation', 'recoded', 'analysis', 'imputed', 'parameter'));

-- Implemented upto this in tsm10e@test on 2/17/2006 at 10:00am
-- Implemented upto this in tsm10g@devl on 2/17/2006 at 10:00am
-- Implemented upto this in tsm10t@prev on 02/28/2006 at 1:16 pm

-- following chnages are as per request of Peter on 03-11-2006 at 11pm

 alter table tspd_study_variable modify(DIMENSION VARCHAR2(80));

-- Following chnages are as perrequest of Michael on 03/17/06 at 3 pm

alter table tspd_diagram modify (diagram null);

-- Implemented upto this in tsm10e@test on 3/26/2006 at 5 pm
-- Implemented upto this in tsm10g@devl on 3/26/2006 at 5 pm
-- Implemented upto this in tsm10t@prev on 3/26/2006 at 5 pm

-- Following changes are as per request of Peter on 03-23-2006 at 6:35pm

alter table tspd_study_variable add constraint tspd_study_variable_uq1
unique (acronym) using index tablespace tspdsmall_indx pctfree 10;

alter table tspd_study_variable add constraint tspd_study_variable_uq2
unique (short_desc) using index tablespace tspdsmall_indx pctfree 10;

-- Following changes are as per the request of Peter on 03/30/2006 at 5:33pm

insert into tspd_coding_system(ID,SHORT_DESC,LONG_DESC,VERSION,SPONSOR) values 
(0,'FAST-TRACK','FAST TRACK SYSTEMS','1.0','DR. CAUDLE');
insert into tspd_coding_system(ID,SHORT_DESC,LONG_DESC,VERSION,SPONSOR) values 
(1,'LOINC','LOINC','1.0','Administrator');
insert into tspd_coding_system(ID,SHORT_DESC,LONG_DESC,VERSION,SPONSOR) values 
(2,'SNOMED','SNOMED','1.0','Administrator'); 
update id_control set next_id=3 where table_name='tspd_coding_system';
commit;

-- Implemented upto this in tsm10e@test on 3/27/2006 at 5 pm
-- Implemented upto this in tsm10g@devl on 3/27/2006 at 5 pm
-- Implemented upto this in tsm10t@prev on 3/27/2006 at 5 pm

alter table TSPD_STUDY_VARIABLE disable constraint TSPD_STUDY_VARIABLE_FK5;
alter table TSPD_STUDY_VARIABLE disable constraint TSPD_STUDY_VARIABLE_FK3;
alter table TSPD_STUDY_VARIABLE disable constraint TSPD_STUDY_VARIABLE_FK2;

delete from tspd_coding_system where id between 0 and 2;
insert into tspd_coding_system(ID,SHORT_DESC,LONG_DESC,VERSION,SPONSOR) values 
(0,'FAST-TRACK','FAST TRACK SYSTEMS','1.0','Administrator');
insert into tspd_coding_system(ID,SHORT_DESC,LONG_DESC,VERSION,SPONSOR) values 
(1,'LOINC','Logical Observation Identifiers Names and Codes','1.0','National Library Of Medicine');
insert into tspd_coding_system(ID,SHORT_DESC,LONG_DESC,VERSION,SPONSOR) values 
(2,'SNOMED','Systematised Nomenclature of Medicine','1.0','The College of American Pathologists and The National Library Of Medicine'); 
update id_control set next_id=3 where table_name='tspd_coding_system';
commit;

alter table TSPD_STUDY_VARIABLE enable constraint TSPD_STUDY_VARIABLE_FK5;
alter table TSPD_STUDY_VARIABLE enable constraint TSPD_STUDY_VARIABLE_FK3;
alter table TSPD_STUDY_VARIABLE enable constraint TSPD_STUDY_VARIABLE_FK2;

-- Implemented upto this in tsm10e@test on 4/9/2006 at 1 pm
-- Implemented upto this in tsm10g@devl on 4/9/2006 at 1 pm
-- Implemented upto this in tsm10t@prev on 4/9/2006 at 1 pm

-- Following changes are as per request of Peter on 05/01/2006 at 9:50am

alter table tspd_stat_model modify METHOD_NAME VARCHAR2(80); 




alter table tspd_study_variable drop constraint TSPD_STUDY_VARIABLE_UQ1;

alter table tspd_study_variable  add constraint TSPD_STUDY_VARIABLE_UQ1
unique (client_div_id, acronym) using index tablespace tsmsmall_indx
pctfree 5;

alter table tspd_study_variable drop constraint TSPD_STUDY_VARIABLE_UQ2;

alter table tspd_study_variable  add constraint TSPD_STUDY_VARIABLE_UQ2
unique (client_div_id,SHORT_DESC) using index tablespace tsmsmall_indx
pctfree 5;


CREATE OR REPLACE procedure update_tspd_proc_pricing(BuildTag number) as

BuildTagExists   number(5);
GMBuildExists   number(5);
TSDBuildExists   number(5);
GMTableExists   number(5);
TSDTableExists   number(5);
curruser   varchar2(30);
stmt    varchar2(512);
max_price_num   number(10);


InvalidBuildTag   exception;
InvalidGMBuild   exception;
InvalidTSDBuild   exception;
InvalidGMTable   exception;
InvalidTSDTable   exception;

begin

select count(*) into BuildTagExists from build_tag where id=BuildTag;
   if BuildTagExists =0 then
      raise InvalidBuildTag;
   end if;

select user into currUser from dual;
select count(*) into GMBuildExists from all_users where username=CurrUser||'_'||BuildTag;
select count(*) into TSDBuildExists from all_users where username=CurrUser||'_TSPD_'||BuildTag;

If GMBuildExists=0 then
   raise InvalidGMBuild;
end if;

If TSDBuildExists=0 then
   raise InvalidTSDBuild;
end if;

select count(*) into GMTableExists from all_tables where owner=CurrUser||'_'||BuildTag and table_name='PAP_CLINICAL_PROC_COST';
select count(*) into TSDTableExists from all_tables where owner=CurrUser||'_TSPD_'||BuildTag and table_name='TSPD_PROC_PRICING';

If GMTableExists=0 then
   raise InvalidGMTable;
end if;

If TSDTableExists=0 then
   raise InvalidTSDTable;
end if;

stmt:='update '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing a set a.pct50=
(select pct50 from '||CurrUser||'_'||BuildTag||'.pap_clinical_proc_cost b, country c
where b.mapper_id=a.mapper_id and b.country_id=c.id and c.abbreviation='||''''||'USA'||''''||'
and b.phase_id=0 and b.indmap_id=0)';

execute immediate(stmt);

stmt:='insert into '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing
(ID,PHASE_ID,INDMAP_ID,MAPPER_ID,PCT50,CNT,YEARS_BACK)
select '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing_seq.nextval,
0,0,a.mapper_id,a.pct50,a.OTHER_EXP_CNT,
nvl(to_number(to_char(sysdate,''YYYY''))+1-a.IND_YEAR,0) from
'||CurrUser||'_'||BuildTag||'.pap_clinical_proc_cost a where not exists
(select 1 from '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing b
where b.mapper_id=a.mapper_id and  
b.phase_id=0 and b.indmap_id=0 and b.country_id=24) and
a.phase_id=0 and a.indmap_id=0 and a.country_id=24';

execute immediate(stmt);

commit;
exception

  when InvalidBuildTag then
      raise_application_error(-20111,'Invalid Build Tag');
  when InvalidGMBuild then
      raise_application_error(-20112,'GM Build phase-1 master client schema not found with build tag '||BuildTag);
  when InvalidTSDBuild then
      raise_application_error(-20113,'TSD build not found with build tag '||BuildTag);
  when InvalidGMTable then
      raise_application_error(-20114,'table PAP_CLINICAL_PROC_COST not found in the master-client build');
  when InvalidTSDTable then
      raise_application_error(-20115,'table TSPD_PROC_PRICING not found in TSD build');

end;
/

-- Implemented upto this in tsm10e@test on 5/1/2006 at 1 pm
-- Implemented upto this in tsm10g@devl on 5/1/2006 at 1 pm
-- Implemented upto this in tsm10t@prev on 5/1/2006 at 1 pm
-- Implemented upto this in tsm10e@prev on 5/1/2006 at 6:42 pm
-- Implemented upto this in tsm10g@prod on 7/8/2006 at 5:50 pm
-- Implemented upto this in tsm10@prod on 7/16/2006 at 10:55 am
-- Implemented upto this in tsm10e@prod on 7/16/2006 at 10:55 am

-- Following chnages are as per request of Peter on 08-31-2006 at 8pm

create or replace procedure deleteFullTSPDTrial (trialID in number, ftuserid in number)
 as
begin
INSERT INTO Audit_Hist(ID,FTUSER_ID,COMMENTS,APP_TYPE,ACTION,TARGET_NAME,
TARGET_PRIMARY_TABLE,TARGET_ID,ENTITY_TYPE,ENTITY_ID,START_DATE,
MODIFY_DATE,TSPD_ROLE) select increment_sequence('audit_hist_seq'), 
ftUserID, null,'TSPD','DELETE_TRIAL', protocol_identifier,
'tspd_trial', trialID, 'tspd_trial', trialID, sysdate,sysdate, null
 from trial where id=trialid;

DELETE FROM tspd_doc_advisory WHERE  tspd_document_id IN 
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_doc_comment WHERE  tspd_document_id IN 
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_doc_reviewer WHERE  tspd_document_id IN 
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_document_authors WHERE  tspd_document_id IN 
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_document_history WHERE  tspd_document_id IN 
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);

DELETE FROM tspd_diagram WHERE  icp_instance_id  IN 
(SELECT id FROM icp_instance WHERE icp_instance.trial_id = trialID);

DELETE FROM tspd_document WHERE trial_id = trialID;
DELETE FROM icp_instance WHERE trial_id = trialID;
DELETE FROM tspd_trial WHERE trial_id = trialID;
DELETE FROM trial WHERE id = trialID 
and not exists ( select 1 from picase_trial where picase_trial.trial_id = trialID)
and not exists (select 1 from cro_trial where cro_trial.trial_id = trialID);
commit;
end;
/

sho err

--Implemented upto this in tsm10e@test on 9/24/2006 at 9 pm
-- Implemented upto this in tsm10t@prev on 10/7/2006 at 1 pm
-- Implemented upto this in tsm10e@prev on 10/10/2006 at 10:42 pm
-- Implemented upto this in tsm10g@prod on 10/10/2006 at 10:50 pm
-- Implemented upto this in tsm10@prod on 10/10/2006 at 10:55 pm
-- Implemented upto this in tsm10e@prod on 10/10/2006 at 10:55 pm


--**************************************************************
-- Implemented upto this in tsm10g@devl on 10/7/2006 at 1 pm
--**************************************************************

-- Following code changes were done to fix TSD bug#f8P9HA0005LH 

insert into oracle_alert_config (ID,ALERT_EVENT,EMAIL_RECIPIENT,EMAIL_SUBJECT)
select increment_sequence('oracle_alert_config_seq'),'UserExpired',
'dmishra@fast-track.com','Info- FastTrack application user has been expired' 
from dual;

commit;

conn ft15/****@????

CREATE OR REPLACE TRIGGER ftuser_trg4
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
 num_INACTIVITY_DAYS number(5);
 UserExpiredFlg  number(1):=0;

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
  
            select LOCKOUT_INACTIVITY_DAYS into num_INACTIVITY_DAYS from password_rule
            where client_div_id=:o.client_div_id;
         else
            num_failed_attempts:=1;
            num_INACTIVITY_DAYS:=1;
         end if;
    else
       num_failed_attempts:=1;
       num_INACTIVITY_DAYS:=1;
    end if;

 if nvl(:o.LAST_LOGIN_DATE,sysdate)+num_INACTIVITY_DAYS < sysdate then 
     UserExpiredFlg:=1;
 end if;     

 if UserExpiredFlg <> 1 then 

    declare

     cursor c1 is SELECT rank,to_char(modify_date,'Mon dd, yyyy hh24:mi:ss')||' hrs PST' mdate FROM
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


  if :o.client_div_id is not null
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null
         then
        select email_recipient  into AlertRecipient from oracle_alert_config
        where alert_event = 'UserLocked';
       end if;
   else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserLocked';
   end if;

   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;


-- New code added here for User Expired logic

 if UserExpiredFlg = 1 then

 AlertMessage:='From: Fast Track Data Center
Product: TrialSpace Designer
Auto alert: User expired

The following user has been expired out of TrialSpace Designer:

'||:o.name||' with a user name of '||initcap(:o.first_name)||' '||initcap(:o.last_name)||'

Because of more than '||to_char(num_INACTIVITY_DAYS)||' days of inactivity.

Please ensure that this user is contacted and verifies the inactivity days before unlocking this user.

For further details please contact client support on: 215-358-1400 opt 2

Thank you

Fast Track Systems Inc';

   select email_subject into AlertSubject from oracle_alert_config
   where alert_event = 'UserExpired';


  if :o.client_div_id is not null
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null
         then
        select email_recipient  into AlertRecipient from oracle_alert_config
        where alert_event = 'UserExpired';
       end if;
   else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserExpired';
   end if;

   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
 end if;
end;
/
  
-- Following changes are as per request of Peter on 11/17/2006 at 16:30


alter table TSPD_DOCUMENT drop constraint TD_SNAPSHOT_TYPE_CHECK;

alter table TSPD_DOCUMENT add constraint TD_SNAPSHOT_TYPE_CHECK check (
snapshot_type in (
'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange'));


--Implemented upto this in tsm10e@test on 1/4/2007
-- Implemented upto this in tsm10t@prev on 1/10/2007 at 10:34 pm
-- Implemented upto this in tsm10e@prev on 1/10/2007 at 10:42 pm

-- Following changes are as per request of Fiammetta on 2/13/2007


Insert into tspd_template_email select increment_sequence('tspd_template_email_seq'),null,
'REASSIGN_AUTHOR_POOL',  'Change in authorship for <protocol id> ',  
'<old author> has relinquished authorship of protocol <protocol id> and it is now Available.'
from dual;


Insert into tspd_template_email select increment_sequence('tspd_template_email_seq'),null,
'REASSIGN_AUTHOR_PUSH',  'Change in authorship for <protocol id> ',  
'<old author> has reassigned protocol <protocol id> to <new author>.'
from dual;

commit;

--may not be required by the time of actual merge

--update tsm10.procedure_def a set a.short_desc=(select b.short_desc
--from tsm10g.procedure_def b where
--b.cpt_code=a.cpt_code);
--Implemented upto this in tsm10e@test on 2/3/2007
-- Implemented upto this in tsm10t@prev on 3/6/2007 at 4:34 pm

-- Implemented upto this in tsm10e@prev on 3/6/2007 at 4:42 pm
-- Implemented upto this in tsm10g@prod on 3/7/2007 at 7 pm
-- Implemented upto this in tsm10@prod on 3/7/2007 at 7 pm
-- Implemented upto this in tsm10e@prod on 3/7/2007 at 7 pm

-- Following changes are as per request of Peter on 3/27/07


Alter table tspd_template add(
locked_by_ftuser_id number(10),
configured_by_trial_id number(10),
template_tid number(10),
archive_seq number(10) default 1 not null);

update tspd_template set template_tid=id;
Alter table tspd_template modify template_tid not null;

alter table tspd_template add constraint TSPD_TEMPLATE_FK4
foreign key (locked_by_ftuser_id) references ftuser(id);

alter table tspd_template add constraint TSPD_TEMPLATE_FK5
foreign key (configured_by_trial_id) references trial(id);

alter table tspd_template add constraint TSPD_TEMPLATE_UQ2
unique (client_div_id, template_tid, status) using index tablespace 
tspdsmall_indx pctfree 5;

Alter table tspd_template_history add(
LOCALE   VARCHAR2(20),
DATE_FORMAT  VARCHAR2(30),
STARTEAM_TAG  VARCHAR2(30),
locked_by_ftuser_id number(10),
configured_by_trial_id number(10),
template_tid number(10),
archive_seq number(10) default 1 not null);

update tspd_template_history set template_tid=id;
Alter table tspd_template_history modify template_tid not null;

alter table tspd_template_history add constraint TSPD_TEMPLATE_history_FK2
foreign key (locked_by_ftuser_id) references ftuser(id);

alter table tspd_template_history add constraint TSPD_TEMPLATE_history_FK3
foreign key (configured_by_trial_id) references trial(id);

declare
 gname varchar2(100);
begin
 select * into gname from global_name;
 delete from id_control where table_name='tspd_template_universal_id';
  if global_name like 'DEVL%' then
	insert into id_control values ('tsm10','tspd_template_universal_id',1000);
  elsif global_name like 'TEST%' then
	insert into id_control values ('tsm10','tspd_template_universal_id',2000);
  elsif global_name like 'PREV%' then
	insert into id_control values ('tsm10','tspd_template_universal_id',3000);
  elsif global_name like 'PROD%' then
	insert into id_control values ('tsm10','tspd_template_universal_id',5000);
  end if;
 commit;
end;
/

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
declare
invalid_status exception;

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   :o.LOCKED_BY_FTUSER_ID,:o.CONFIGURED_BY_TRIAL_ID,
   :o.TEMPLATE_TID,:o.ARCHIVE_SEQ from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting AND :n.status='Retired' then
 raise invalid_status;
end if;

exception

 when invalid_status then
  raise_application_error(-20303,'Sorry, New template can not be inserted in retired status');

end;
/
sho err

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
invalid_status exception;
num_templates number(3);
invalid_retire exception;

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   :o.LOCKED_BY_FTUSER_ID,:o.CONFIGURED_BY_TRIAL_ID,
   :o.TEMPLATE_TID,:o.ARCHIVE_SEQ from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting AND :n.status='Retired' then
 raise invalid_status;
end if;


If updating and :n.status='Retired' then
  select count(*) into num_templates from tspd_template where client_div_id=:n.client_div_id
  and Template_tid=:n.template_tid;

  if num_templates <> 1 then
    raise invalid_retire;
  end if;
end if;

exception

 when invalid_status then
  raise_application_error(-20303,'Sorry, New template can not be inserted in retired status');
 when invalid_retire then
  raise_application_error(-20305,'Sorry, more than one template found with same template_tid');

end;
/
sho err

create or replace procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('tspd_template_universal_id_seq'),
    client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,'Released',create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    TEMPLATE_TID,1
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    TEMPLATE_TID,ARCHIVE_SEQ 
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

     
    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ) = (select last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing') 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';    

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

create or replace procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);

invalid_testing exception;
invalid_released exception;
invalid_template exception;
invalid_retired exception;


begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';

  if retired_exists=1 then
       raise invalid_retired;
  elsif testing_exists > 1 then
       raise invalid_testing;
  elsif released_exists > 1 then
       raise invalid_released;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
       update tspd_template set status='Retired' where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  elsif testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired' where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
  elsif testing_exists=1 and released_exists=1 then
 Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
     sysdate,id,client_div_id,last_updated,name,data,software_version,
     updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
     released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
     LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
     TEMPLATE_TID,ARCHIVE_SEQ
     from tspd_template
     where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        delete from tspd_template where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        update tspd_template set status='Retired' where
        client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  end if;
  commit;
exception

  when invalid_testing then
    raise_application_error(-20306,'More than one testing template found. Please fix this first');
  when invalid_released then
    raise_application_error(-20307,'More than one released template found. Please fix this first');
  when invalid_template then
    raise_application_error(-20308,'No template found to release');
  when invalid_retired then
    raise_application_error(-20309,'Template already in retire state');

end;
/
sho err

-- Following changes are as per request of Mike on 03/29/2007

Insert into ftgroup values (29,'TSPD Template Admin');
update id_control set next_id=30 where table_name='ftgroup';
commit;

--Implemented upto this in tsm10e@test on 6/4/2007

-- Following changes are as per request of Mike on 06/06/2007

alter table tspd_document add(macros_dirty number(1) default 0 not null);

alter table tspd_document add constraint td_macros_dirty_check
check (macros_dirty in (0,1));

-- Following chnage is as per the bug found and request of Mike/Peter on 06/19/2007

alter table tspd_template drop constraint TSPD_TEMPLATE_UQ1;
drop index TSPD_TEMPLATE_UQ1;

alter table tspd_template add constraint TSPD_TEMPLATE_UQ1
unique (CLIENT_DIV_ID,NAME,VERSION,STATUS)
using index tablespace tspdsmall_indx pctfree 5;

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
invalid_status exception;
num_templates number(3);

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   :o.LOCKED_BY_FTUSER_ID,:o.CONFIGURED_BY_TRIAL_ID,
   :o.TEMPLATE_TID,:o.ARCHIVE_SEQ from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting AND :n.status='Retired' then
 raise invalid_status;
end if;

exception

 when invalid_status then
  raise_application_error(-20303,'Sorry, New template can not be inserted in retired status');

end;
/
sho err

create or replace procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,'Released',create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    TEMPLATE_TID,1
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    TEMPLATE_TID,ARCHIVE_SEQ 
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

     
    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ) = (select last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing') 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';    

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

drop view ICP_INSTANCE_NOBLOB;
drop view TSPD_DIAGRAM_NOBLOB;
drop view TSPD_DOCUMENT_HISTORY_NOBLOB;
drop view TSPD_DOCUMENT_NOBLOB;
drop view TSPD_LIB_ELEMENT_NOBLOB;
drop view TSPD_TEMPLATE_HISTORY_NOBLOB;
drop view TSPD_TEMPLATE_NOBLOB;


--Implemented upto this in tsm10e@test on 6/20/2007
-- Implemented upto this in tsm10t@prev on 7/6/2007 at noon

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
invalid_status exception;
num_templates number(3);

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   null,null,:o.TEMPLATE_TID,:o.ARCHIVE_SEQ from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting AND :n.status='Retired' then
 raise invalid_status;
end if;

exception

 when invalid_status then
  raise_application_error(-20303,'Sorry, New template can not be inserted in retired status');

end;
/
sho err

create or replace procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,'Released',create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    TEMPLATE_TID,1
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,ARCHIVE_SEQ 
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

     
    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ) = (select last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing') 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';    

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

create or replace procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);

invalid_testing exception;
invalid_released exception;
invalid_template exception;
invalid_retired exception;


begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';

  if retired_exists=1 then
       raise invalid_retired;
  elsif testing_exists > 1 then
       raise invalid_testing;
  elsif released_exists > 1 then
       raise invalid_released;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
       update tspd_template set status='Retired' where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  elsif testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired' where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
  elsif testing_exists=1 and released_exists=1 then
 Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
     sysdate,id,client_div_id,last_updated,name,data,software_version,
     updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
     released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
     null,null,
     TEMPLATE_TID,ARCHIVE_SEQ
     from tspd_template
     where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        delete from tspd_template where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        update tspd_template set status='Retired' where
        client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  end if;
  commit;
exception

  when invalid_testing then
    raise_application_error(-20306,'More than one testing template found. Please fix this first');
  when invalid_released then
    raise_application_error(-20307,'More than one released template found. Please fix this first');
  when invalid_template then
    raise_application_error(-20308,'No template found to release');
  when invalid_retired then
    raise_application_error(-20309,'Template already in retire state');

end;
/
sho err

-- Following chnages are for defect# f8P9HA0061B on 07/18/2007 at 1pm as per Matt

update tspd_template_email set MESSAGE_TEXT=
'The <protocol id> / <snapshot name> protocol is available for your review.
You will find it attached to this message.' where template_name='REVIEW_CC';
commit;



--Implemented upto this in tsm10e@test on 7/11/2007
-- Implemented upto this in tsm10t@prev on 7/13/2007 at 7am

--Following changes are as per request of Fiametta on 08/08/2007 at 4:15pm


create or replace procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId 
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,'Released',create_date,creator_ftuser_id,
    sysdate,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,1
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,ARCHIVE_SEQ 
    from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';

     
    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ) = (select last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    sysdate,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    released_archiveseq from tspd_template 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Testing') 
    where client_div_id=ClientDivId 
    and template_tid=TemplateTid and status='Released';    

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

create or replace procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);

invalid_testing exception;
invalid_released exception;
invalid_template exception;
invalid_retired exception;


begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';

  if retired_exists=1 then
       raise invalid_retired;
  elsif testing_exists > 1 then
       raise invalid_testing;
  elsif released_exists > 1 then
       raise invalid_released;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  elsif testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
  elsif testing_exists=1 and released_exists=1 then
 Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
     sysdate,id,client_div_id,last_updated,name,data,software_version,
     updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
     released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
     null,null,
     TEMPLATE_TID,ARCHIVE_SEQ
     from tspd_template
     where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        delete from tspd_template where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        update tspd_template set status='Retired', retired_date=sysdate where
        client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  end if;
  commit;
exception

  when invalid_testing then
    raise_application_error(-20306,'More than one testing template found. Please fix this first');
  when invalid_released then
    raise_application_error(-20307,'More than one released template found. Please fix this first');
  when invalid_template then
    raise_application_error(-20308,'No template found to release');
  when invalid_retired then
    raise_application_error(-20309,'Template already in retire state');

end;
/
sho err


--Implemented upto this in tsm10e@test on 8/10/2007
-- Implemented upto this in tsm10t@prev on 8/10/2007 at 7am
-- Implemented upto this in tsm10e@prev on 9/28/2007 at 4:55 pm

-- Implemented upto this in tsm10@prod on 9/28/2007 at 4:55 pm
-- Implemented upto this in tsm10e@prod on 9/28/2007 at 4:55 pm


--************************************************
-- Implemented upto this in tsm10g@prod on 9/28/2007 at 4:55 pm
--************************************************

-- Following chnages are as per request of Fiammetta on 09/10/2007 at 1:09pm

alter table password_rule add(
password_has_odd	NUMBER(1) DEFAULT 0 NOT NULL,
password_min_valid_days	NUMBER(5) DEFAULT 0 NOT NULL);

-- Following chnages are as per request of Fiammetta on 09/11/2007 at 5:05pm

alter table tspd_doc_advisory add(user_status varchar2(80));
update tspd_doc_advisory set user_status=status;
commit;

-- Following chnages are as per request of Fiammetta on 09/18/2007 at 5:24pm

ALTER TABLE tspd_document drop CONSTRAINT td_snapshot_type_check ;
ALTER TABLE tspd_document ADD CONSTRAINT td_snapshot_type_check CHECK (
snapshot_type in (
'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange','Baseline'));

create or replace procedure copy_tspd_document(OldDocId in number)
as 
OldIcpId number(10);
NewIcpId number(10);
NewDocId number(10);

begin

select ICP_INSTANCE_ID into OldIcpId from tspd_document where id=OldDocId;
select increment_sequence('icp_instance_seq') into NewIcpId from dual;
select increment_sequence('tspd_document_seq') into NewDocId from dual;

Insert into icp_instance select NewIcpId,TRIAL_ID,LAST_UPDATED,
VERSION_TIMESTAMP,DATA,'Baseline','Frozen' from icp_instance 
where id=OldIcpId;

Insert into tspd_diagram select increment_sequence('tspd_diagram_seq'),NewIcpId,
DIAGRAM,ICP_OBJECT_ID,ICP_OBJECT_TYPE,VERSION_TIMESTAMP from tspd_diagram
where ICP_INSTANCE_ID=OldIcpId;

insert into tspd_document select NewDocId,TRIAL_ID,DOCUMENT_TYPE,
DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE,LAST_UPDATED,VERSION_TIMESTAMP,
DATA,'Baseline','Baseline',SNAPSHOT_NOTES,REVIEW_BY_DATE,
REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,NewIcpId,
'Final',DOCUMENT_NOTES,sysdate,SOA_TBL_FORMAT,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,
DATE_FORMAT,AUTHOR_RELINQUISHED_DT,AUTHOR_MODEL_TYPE,
PUBLIC_VISIBLE_FLG,MACROS_DIRTY  from tspd_document where id=OldDocId;

end;
/ 
sho err         


--Implemented upto this in tsm10e@test on 10/8/2007

create or replace procedure copy_tspd_document(OldDocId in number)
as 
OldIcpId number(10);
NewIcpId number(10);
NewDocId number(10);

begin

select ICP_INSTANCE_ID into OldIcpId from tspd_document where id=OldDocId;
select increment_sequence('icp_instance_seq') into NewIcpId from dual;
select increment_sequence('tspd_document_seq') into NewDocId from dual;

Insert into icp_instance select NewIcpId,TRIAL_ID,LAST_UPDATED,
VERSION_TIMESTAMP,DATA,'Baseline','Frozen' from icp_instance 
where id=OldIcpId;

Insert into tspd_diagram select increment_sequence('tspd_diagram_seq'),NewIcpId,
DIAGRAM,ICP_OBJECT_ID,ICP_OBJECT_TYPE,VERSION_TIMESTAMP from tspd_diagram
where ICP_INSTANCE_ID=OldIcpId;

insert into tspd_document select NewDocId,TRIAL_ID,DOCUMENT_TYPE,
DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE-(1/1440),LAST_UPDATED,VERSION_TIMESTAMP,
DATA,'Baseline','Baseline',SNAPSHOT_NOTES,REVIEW_BY_DATE,
REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,NewIcpId,
'Final',DOCUMENT_NOTES,sysdate,SOA_TBL_FORMAT,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,
DATE_FORMAT,AUTHOR_RELINQUISHED_DT,AUTHOR_MODEL_TYPE,
PUBLIC_VISIBLE_FLG,MACROS_DIRTY  from tspd_document where id=OldDocId;

Insert into TSPD_DOCUMENT_AUTHORS select 
increment_sequence('tspd_document_authors_seq'),NewDocId,ftuser_id,document_type
from TSPD_DOCUMENT_AUTHORS where tspd_document_id=OldDocId;

end;
/ 
sho err    

-- Following changes are as per request of Fiammetta on 10/17/2007 at 11:30am

Alter table TSPD_DOC_COMMENT add(
 context_text             VARCHAR2(256),
 docsection_path     VARCHAR(80),
 disposal_state      VARCHAR(40),
 disposal_ftuser_id  NUMBER(10));

ALTER TABLE tspd_doc_comment
  ADD CONSTRAINT tspd_doc_comment_fk4 
  FOREIGN KEY (disposal_ftuser_id)
  REFERENCES ftuser(id);

-- Following changes are as per request of Michael on 11/06/2007 at 11:40am


alter table tspd_document drop constraint TD_SNAPSHOT_TYPE_CHECK;

alter table tspd_document add constraint TD_SNAPSHOT_TYPE_CHECK
check (snapshot_type in (
'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange','Baseline','TrackChanges'));

-- Following changes are as per request of Fiammetta on 11/30/2007 at 6pm

alter table tspd_doc_comment
add Coupled_comment_id    NUMBER(10);

-- Following changes are as per request of Peter on 12/17/2007 at 10am

alter table tspd_document modify PUBLIC_VISIBLE_FLG default 0;
 

--Implemented upto this in tsm10e@test on 12/14/2007

-- Following changes are as per request of Fiammetta on 1/3/2008 at 3pm

alter table tspd_doc_comment add(
section_range_start NUMBER(10),
wide_context_start NUMBER(10));

-- Following changes are as per request of Mike on 1/16/2008 at 10am

alter table client_div add has_locking number(1) default 0 not null;

alter table client_div add constraint cd_has_locking_check 
check(has_locking in (0,1,2,3));

-- Following changes are as per the problem/bug reported by Dave and fixed by Debashish on 1/16/2008

CREATE OR REPLACE TRIGGER ftuser_trg4
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
 num_INACTIVITY_DAYS number(5);
 UserExpiredFlg  number(1):=0;

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
  
            select LOCKOUT_INACTIVITY_DAYS into num_INACTIVITY_DAYS from password_rule
            where client_div_id=:o.client_div_id;
         else
            num_failed_attempts:=1;
            num_INACTIVITY_DAYS:=1;
         end if;
    else
       num_failed_attempts:=1;
       num_INACTIVITY_DAYS:=1;
    end if;

 if nvl(:o.LAST_LOGIN_DATE,sysdate)+num_INACTIVITY_DAYS < sysdate and num_INACTIVITY_DAYS <> 0 then 
     UserExpiredFlg:=1;
 end if;     

 if UserExpiredFlg <> 1 then 

    declare

     cursor c1 is SELECT rank,to_char(modify_date,'Mon dd, yyyy hh24:mi:ss')||' hrs PST' mdate FROM
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


  if :o.client_div_id is not null
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null
         then
        select email_recipient  into AlertRecipient from oracle_alert_config
        where alert_event = 'UserLocked';
       end if;
   else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserLocked';
   end if;

   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;


-- New code added here for User Expired logic

 if UserExpiredFlg = 1 then

 AlertMessage:='From: Fast Track Data Center
Product: TrialSpace Designer
Auto alert: User expired

The following user has been expired out of TrialSpace Designer:

'||:o.name||' with a user name of '||initcap(:o.first_name)||' '||initcap(:o.last_name)||'

Because of more than '||to_char(num_INACTIVITY_DAYS)||' days of inactivity.

Please ensure that this user is contacted and verifies the inactivity days before unlocking this user.

For further details please contact client support on: 215-358-1400 opt 2

Thank you

Fast Track Systems Inc';

   select email_subject into AlertSubject from oracle_alert_config
   where alert_event = 'UserExpired';


  if :o.client_div_id is not null
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null
         then
        select email_recipient  into AlertRecipient from oracle_alert_config
        where alert_event = 'UserExpired';
       end if;
   else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserExpired';
   end if;

   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;

   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
 end if;
end;
/
 
-- Following changes are as per request of Mike on 01/16/2008 at 1:45 pm

alter table tspd_trial add(locking_status varchar2(4000),
locking_author_assign number(1) default 0 not null);

alter table tspd_trial add constraint tt_locking_author_assign_check
check(locking_author_assign in (0,1));

--Implemented upto this in tsm10e@test on 1/25/2008

-- Following changes are as per request of Mike on 01/25/2008 at 4:30pm

CREATE OR REPLACE procedure delete_my_tspd_trial(
myuserid in varchar2)
is

begin

delete from tspd_diagram where icp_instance_id in (select a.id
from icp_instance a,tspd_trial b, ftuser c where
a.trial_id=b.trial_id and b.CREATOR_FTUSER_ID=c.id and
upper(c.name) = upper(myuserid));

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

update tspd_template set CONFIGURED_BY_TRIAL_ID = null where
CONFIGURED_BY_TRIAL_ID in (select trial_id from
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

CREATE OR REPLACE procedure delete_tspd_trial(
trialid in number)
is

begin

delete from tspd_diagram where icp_instance_id in (select id
from icp_instance where trial_id=trialid);

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

update tspd_template set CONFIGURED_BY_TRIAL_ID = null where
CONFIGURED_BY_TRIAL_ID=trialid;

delete from tspd_trial where trial_id=trialid;

delete from trial where created_by = 'TSPD' and id=trialid;

commit;
end;
/

--Implemented upto this in tsm10e@test on 1/30/2008


-- Following changes are as per request of Michael on 02/20/2008 at 12:45pm

Alter table tspd_document add update_revision_doc_flg NUMBER(1) DEFAULT 0 NOT NULL;

-- Following changes are as per request of Mike on 02/21/2008 at 11:15am

CREATE OR REPLACE procedure copy_tspd_document(OldDocId in number)
as
OldIcpId number(10);
NewIcpId number(10);
NewDocId number(10);

begin

select ICP_INSTANCE_ID into OldIcpId from tspd_document where id=OldDocId;
select increment_sequence('icp_instance_seq') into NewIcpId from dual;
select increment_sequence('tspd_document_seq') into NewDocId from dual;

Insert into icp_instance select NewIcpId,TRIAL_ID,LAST_UPDATED,
VERSION_TIMESTAMP,DATA,'Baseline','Frozen' from icp_instance
where id=OldIcpId;

Insert into tspd_diagram select increment_sequence('tspd_diagram_seq'),NewIcpId,
DIAGRAM,ICP_OBJECT_ID,ICP_OBJECT_TYPE,VERSION_TIMESTAMP from tspd_diagram
where ICP_INSTANCE_ID=OldIcpId;

insert into tspd_document select NewDocId,TRIAL_ID,DOCUMENT_TYPE,
DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE-(1/1440),LAST_UPDATED,VERSION_TIMESTAMP,
DATA,'Baseline','Baseline',SNAPSHOT_NOTES,REVIEW_BY_DATE,
REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,NewIcpId,
'Final',DOCUMENT_NOTES,sysdate,SOA_TBL_FORMAT,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,
DATE_FORMAT,AUTHOR_RELINQUISHED_DT,AUTHOR_MODEL_TYPE,
PUBLIC_VISIBLE_FLG,MACROS_DIRTY,UPDATE_REVISION_DOC_FLG from tspd_document where id=OldDocId;

Insert into TSPD_DOCUMENT_AUTHORS select
increment_sequence('tspd_document_authors_seq'),NewDocId,ftuser_id,document_type
from TSPD_DOCUMENT_AUTHORS where tspd_document_id=OldDocId;

end;
/

sho err

-- Following changes are as per request of Fiammetta on 02/22/2008 at 10:52 AM

alter table TSPD_TEMPLATE_HISTORY add comments VARCHAR2(512) ;
alter table TSPD_TEMPLATE add comments VARCHAR2(512) ;

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
invalid_status exception;
num_templates number(3);

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   null,null,:o.TEMPLATE_TID,:o.ARCHIVE_SEQ,:o.comments from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting AND :n.status='Retired' then
 raise invalid_status;
end if;

exception

 when invalid_status then
  raise_application_error(-20303,'Sorry, New template can not be inserted in retired status');

end;
/

sho err

CREATE OR REPLACE procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,'Released',create_date,creator_ftuser_id,
    sysdate,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,1, comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,ARCHIVE_SEQ,comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';


    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ,comments) = (select last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    sysdate,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    released_archiveseq,comments from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing')
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

sho err

CREATE OR REPLACE procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);

invalid_testing exception;
invalid_released exception;
invalid_template exception;
invalid_retired exception;


begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';

  if retired_exists=1 then
       raise invalid_retired;
  elsif testing_exists > 1 then
       raise invalid_testing;
  elsif released_exists > 1 then
       raise invalid_released;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  elsif testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
  elsif testing_exists=1 and released_exists=1 then
 Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
     sysdate,id,client_div_id,last_updated,name,data,software_version,
     updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
     released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
     null,null,
     TEMPLATE_TID,ARCHIVE_SEQ,comments
     from tspd_template
     where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        delete from tspd_template where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';

        update tspd_template set status='Retired', retired_date=sysdate where
        client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  end if;
  commit;
exception

  when invalid_testing then
    raise_application_error(-20306,'More than one testing template found. Please fix this first');
  when invalid_released then
    raise_application_error(-20307,'More than one released template found. Please fix this first');
  when invalid_template then
    raise_application_error(-20308,'No template found to release');
  when invalid_retired then
    raise_application_error(-20309,'Template already in retire state');

end;
/

sho err

-- Following chnages are done by DB after an was reported by Dave on 03/10/2008 at 2pm

Alter table ICP_INSTANCE drop constraint II_SNAPSHOT_TYPE_CHECK;

-- Following procedure was as per request of Peter on 03/13/2008

CREATE OR REPLACE procedure tspd_25_upgrade (ClientDiv in varchar2)
as
ClientDivId number(10);
library_project_exists number(4);
libtest number(1);
too_many_library_projects exception;
Template_status varchar2(20);

cursor c1 is select template_tid from tspd_template WHERE client_div_id=ClientDivId 
group by template_tid having count(*)=1;

cursor c2 is select a.id from trial a, tspd_trial b, tspd_template c
  where a.id=b.trial_id and b.tspd_template_id=c.id and c.status='Testing'
  and a.created_by='TSPD' and a.client_div_id=ClientDivId;

begin

 select id into ClientDivId from client_div where client_div_identifier=ClientDiv;

 for ix1 in c1 loop
    select status into Template_status from tspd_template where template_tid=ix1.template_tid
    and client_div_id=ClientDivId;

    if initcap(template_status) = 'Released' then
        Insert into tspd_template
     select increment_sequence('shared_tspd_template_seq'),
      client_div_id,last_updated,name,data,software_version,
      updated_by_ftuser_id,version,'Testing',create_date-(1/24),creator_ftuser_id,
      released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
      LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,TEMPLATE_TID,archive_seq,comments
     from tspd_template where template_tid=ix1.template_tid;
    end if;
 end loop;

 select count(*) into library_project_exists from  project d, client_div e
 where  d.client_id=e.client_id AND e.id = ClientDivId and d.is_library=1;

 if library_project_exists=0 then
        insert into project (id,name,ARCHIVED_FLG,ARCHIVED_DATE,client_id,is_library)
        select increment_sequence('project_seq'), 'Library',0,null,client_id,1 from client_div
        where id=ClientDivId;
 elsif library_project_exists > 1 then
       raise too_many_library_projects;
 end if;

 for ix2 in c2 loop
   select is_library into libtest from project a, trial b where a.id=b.project_id and b.id=ix2.id;

   if libtest=0 then
      update trial a set a.project_id=(select b.id from project b, client_div c where b.client_id=c.client_id
      and c.id=ClientDivId and b.is_library=1) where a.id=ix2.id;
    end if;
 end loop;
exception

when too_many_library_projects then
   raise_application_error('-20401','More than One library project found ');

end;
/

--Implemented upto this in tsm10e@test on 3/2/2008

-- Implemented upto this in tsm10t@prev on 3/5/2008 at 7pm
-- Implemented upto this in tsm10e@prev on 3/5/2008 at 7pm

-- Following changes are as per request of Fiammetta on 03/18/2008 at 4:31pm

CREATE OR REPLACE procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);

invalid_testing exception;
invalid_released exception;
invalid_template exception;
invalid_retired exception;


begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';

  if retired_exists >= 1 then
       raise invalid_retired;
  elsif testing_exists > 1 then
       raise invalid_testing;
  elsif released_exists > 1 then
       raise invalid_released;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  elsif testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
  elsif testing_exists=1 and released_exists=1 then
 Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
     sysdate,id,client_div_id,last_updated,name,data,software_version,
     updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
     released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
     null,null,
     TEMPLATE_TID,ARCHIVE_SEQ,comments
     from tspd_template
     where client_div_id=ClientDivId
     and template_tid=TemplateTid and status='Testing';


        update tspd_template set status='Retired', retired_date=sysdate where
        client_div_id=ClientDivId and Template_tid=TemplateTid and status in ('Released','Testing');
  end if;
  commit;
exception

  when invalid_testing then
    raise_application_error(-20306,'More than one testing template found. Please fix this first');
  when invalid_released then
    raise_application_error(-20307,'More than one released template found. Please fix this first');
  when invalid_template then
    raise_application_error(-20308,'No template found to release');
  when invalid_retired then
    raise_application_error(-20309,'Template already in retire state');

end;
/

-- Following changes are as per request of Fiammetta on 03/18/2008 at 5pm

alter table tspd_template drop constraint tspd_template_uq2;
alter table tspd_template drop constraint tspd_template_uq1;
--Implemented upto this in tsm10e@test on 3/22/2008

-- Implemented upto this in tsm10t@prev on 3/28/2008 at 6pm
-- Implemented upto this in tsm10e@prev on 3/28/2008 at 6pm
 

CREATE OR REPLACE procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,sysdate,name,data,software_version,
    updated_by_ftuser_id,version,'Released',sysdate,creator_ftuser_id,
    sysdate,null,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,1, comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,ARCHIVE_SEQ,comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';


    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ,comments) = (select sysdate,name,data,software_version,
    updated_by_ftuser_id,version,create_date,creator_ftuser_id,
    sysdate,null,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    released_archiveseq,comments from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing')
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

sho err

CREATE OR REPLACE procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,sysdate,name,data,software_version,
    updated_by_ftuser_id,version,'Released',sysdate,creator_ftuser_id,
    sysdate,null,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,1, comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,ARCHIVE_SEQ,comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';


    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ,comments) = (select sysdate,name,data,software_version,
    updated_by_ftuser_id,version,creator_ftuser_id,
    sysdate,null,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    released_archiveseq,comments from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing')
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/
sho err

--Implemented upto this in tsm10e@test on 3/28/2008

-- Following changes are as per request of Peter & Fiammetta on 03/24/2008 at 5pm

ALTER TABLE tspd_template DROP CONSTRAINT tt_status_check;

ALTER TABLE tspd_template ADD CONSTRAINT tt_status_check CHECK (
status in ('Testing','Released','Retired','RetiredReleased'));


CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
invalid_status exception;
num_templates number(3);

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   null,null,:o.TEMPLATE_TID,:o.ARCHIVE_SEQ,:o.comments from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting AND (:n.status='Retired' or :n.status='RetiredReleased') then
 raise invalid_status;
end if;

exception

 when invalid_status then
  raise_application_error(-20303,'Sorry, New template can not be inserted in Retired or RetiredReleased status');

end;
/
sho err

CREATE OR REPLACE procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);
retiredreleased_exists number(2);

invalid_released exception;
invalid_template exception;
invalid_retired exception;


begin

  /* Find out how many templates in which status for a given TID */

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';
  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';
  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';
  select count(*) into retiredreleased_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='RetiredReleased';

  /* Raise errors if already a template found for the given TID in retired or released retired status
     Raise error if no template found in testing or released status to retire.
     Raise error if a released template found without testing. Run the 2.5 upgrade proc to fix it*/ 

  if retired_exists = 1 or retiredreleased_exists=1 then
       raise invalid_retired;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
        raise invalid_released;
  end if;
 
  /* Proceed with retiring templates if a testing template exists */ 

  if testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
  elsif testing_exists=1 and released_exists=1 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';
       update tspd_template set status='RetiredReleased', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';
  end if;
  commit;

exception

   when invalid_template then
    raise_application_error(-20308,'No template found to retire');
  when invalid_retired then
    raise_application_error(-20309,'Template already in Retire or RetireReleased state');
  when invalid_released then
    raise_application_error(-20307,'No testing template for a released template. Invalid released status');

end;
/
sho err


CREATE OR REPLACE procedure retire_template(ClientDivId in number, TemplateTid in number)
as
testing_exists number(2);
released_exists number(2);
retired_exists number(2);
retiredreleased_exists number(2);

invalid_released exception;
invalid_template exception;
invalid_retired exception;

released_trial_exists number(10);

begin

  /* Find out how many templates in which status for a given TID */

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';
  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';
  select count(*) into retired_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Retired';
  select count(*) into retiredreleased_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='RetiredReleased';

  /* Raise errors if already a template found for the given TID in retired or released retired status
     Raise error if no template found in testing or released status to retire.
     Raise error if a released template found without testing. Run the 2.5 upgrade proc to fix it*/ 

  if retired_exists = 1 or retiredreleased_exists=1 then
       raise invalid_retired;
  elsif testing_exists=0 and released_exists=0 then
       raise invalid_template;
  elsif testing_exists=0 and released_exists=1 then
        raise invalid_released;
  end if;
 
  /* Proceed with retiring templates if a testing template exists */ 

  if testing_exists=1 and released_exists=0 then
       update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';

  elsif testing_exists=1 and released_exists=1 then
 
 
      update tspd_template set status='Retired', retired_date=sysdate where
       client_div_id=ClientDivId and Template_tid=TemplateTid and status='Testing';

     /* check if trials are associated with the released template */

       select count(*) into released_trial_exists from tspd_trial where tspd_template_id in (
       select id from tspd_template where Template_tid=TemplateTid and status='Released'); 
        
       if released_trial_exists > 0 then 

         update tspd_template set status='RetiredReleased', retired_date=sysdate where
         client_div_id=ClientDivId and Template_tid=TemplateTid and status='Released';

       else
        /* if not, push it to history and delete it */

          Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
          sysdate,id,client_div_id,last_updated,name,data,software_version,
          updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
          released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
          LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
          TEMPLATE_TID,ARCHIVE_SEQ, comments
          from tspd_template
          where client_div_id=ClientDivId
          and template_tid=TemplateTid and status='Released';

          delete from tspd_template where client_div_id=ClientDivId
          and template_tid=TemplateTid and status='Released';


      end if;

  end if;
  commit;

exception

   when invalid_template then
    raise_application_error(-20308,'No template found to retire');
  when invalid_retired then
    raise_application_error(-20309,'Template already in Retire or RetireReleased state');
  when invalid_released then
    raise_application_error(-20307,'No testing template for a released template. Invalid released status');

end;
/


-- Following is a one timeprocedure t fix some gaps betwen 2.5.9 and 2.5.10 
-- 2.5.9 temporarily allowed duplicate retired templates 
-- and 2.5.10 doesn't

declare
cursor c1 is select template_tid from tspd_template where 
  client_div_id in (select client_div_id from client_div_to_lic_app
  where app_name='TSPD' and frontend_version like '2.5%') and status='Retired'
  group by template_tid having count(*) > 1;

Invalid_status1 exception;
Invalid_status2 exception;
num1 number(10);
num2 number(10);

begin
   
  for ix1 in c1 loop

    declare 

      cursor c2 is select id from tspd_template where template_tid=ix1.template_tid;
      lib_check number(10);
    begin
       for ix2 in c2 loop

         select count(*) into lib_check from project a, trial b, tspd_trial c
         where a.id=b.project_id and b.id=c.trial_id and c.tspd_template_id=ix2.id 
         and a.is_library=0;

         if lib_check > 1 then
           update tspd_template set status='RetiredReleased' where id=ix2.id;
         end if;
       end loop;
    end;
  end loop;

  select count(count(*)) into num1 from tspd_template where status='Retired'
  group by template_tid having count(*) > 1;
  select count(count(*)) into num1 from tspd_template where status='RetiredReleased'
  group by template_tid having count(*) > 1;

  if num1 > 0 then
     raise invalid_status1;
  elsif num2 > 0 then
     raise invalid_status2;
  else
     commit;
  end if;

exception

  when invalid_status1 then
   raise_application_error(-20306,'More than one in Retired status');
   rollback;
  when invalid_status2 then
   raise_application_error(-20305,'More than one in RetiredReleased status');
   rollback;
end;
/

ALTER TABLE tspd_template ADD CONSTRAINT tspd_template_uq2 
UNIQUE (client_div_id,template_tid,status) USING INDEX 
TABLESPACE tspdsmall_indx PCTFREE 5;


ALTER TABLE tspd_template   ADD CONSTRAINT tspd_template_uq1 
UNIQUE (client_div_id,NAME,version,status) USING INDEX
TABLESPACE tspdsmall_indx PCTFREE 5;  


CREATE OR REPLACE procedure tspd_25_upgrade (ClientDiv in varchar2)
as
ClientDivId number(10);
library_project_exists number(4);
libtest number(1);
too_many_library_projects exception;
Template_status varchar2(20);
non_library_project_exists number(10);

cursor c1 is select template_tid from tspd_template WHERE client_div_id=ClientDivId 
group by template_tid having count(*)=1;

cursor c2 is select a.id from trial a, tspd_trial b, tspd_template c
  where a.id=b.trial_id and b.tspd_template_id=c.id and c.status='Testing'
  and a.created_by='TSPD' and a.client_div_id=ClientDivId;

begin

 select id into ClientDivId from client_div where client_div_identifier=ClientDiv;

 for ix1 in c1 loop

    -- check the status of the template that has single occurence of template_tid 

    select status into Template_status from tspd_template where template_tid=ix1.template_tid 
    and client_div_id=ClientDivId;

    -- If it is released, insert a testing for it

    if initcap(template_status) = 'Released' then
        Insert into tspd_template
     select increment_sequence('shared_tspd_template_seq'),
      client_div_id,last_updated,name,data,software_version,
      updated_by_ftuser_id,version,'Testing',create_date-(1/24),creator_ftuser_id,
      released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
      LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,TEMPLATE_TID,archive_seq,comments
     from tspd_template where template_tid=ix1.template_tid;
    end if;
   -- if it is retired then further check if any non-library project associated with it

    if initcap(template_status) = 'Retired' then

       select count(*) into non_library_project_exists from tspd_trial a, trial b, project c
       where a.trial_id=b.id and b.project_id=c.id and c.is_library=0;

   -- if some non-library project found then update existing Retired to RetiredReleased 
   -- And also create a new retired  

      if non_library_project_exists > 0 then 

         update tspd_template set status='RetiredReleased' where template_tid=ix1.template_tid;
     
          Insert into tspd_template
          select increment_sequence('shared_tspd_template_seq'),
          client_div_id,last_updated,name,data,software_version,
          updated_by_ftuser_id,version,'Retired',create_date,creator_ftuser_id,
          released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
          LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,TEMPLATE_TID,archive_seq,comments
          from tspd_template where template_tid=ix1.template_tid;
      end if;

    end if;
 end loop;

-- check and see if libraryproject exists for all templates, if not, create one

 select count(*) into library_project_exists from  project d, client_div e
 where  d.client_id=e.client_id AND e.id = ClientDivId and d.is_library=1;

 if library_project_exists=0 then
        insert into project (id,name,ARCHIVED_FLG,ARCHIVED_DATE,client_id,is_library)
        select increment_sequence('project_seq'), 'Library',0,null,client_id,1 from client_div
        where id=ClientDivId;
 elsif library_project_exists > 1 then
       raise too_many_library_projects;
 end if;

 -- Make sure that all trials associated with testing templates are actually library pojects

 for ix2 in c2 loop
   select is_library into libtest from project a, trial b where a.id=b.project_id and b.id=ix2.id;

   if libtest=0 then
      update trial a set a.project_id=(select b.id from project b, client_div c where b.client_id=c.client_id
      and c.id=ClientDivId and b.is_library=1) where a.id=ix2.id;
    end if;
 end loop;
exception

when too_many_library_projects then
   raise_application_error('-20401','More than One library project found ');

end;
/
sho err

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
num_templates number(3);

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   null,null,:o.TEMPLATE_TID,:o.ARCHIVE_SEQ,:o.comments from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

end;
/
sho err


CREATE OR REPLACE procedure release_template(ClientDivId in number, TemplateTid in number)
as

testing_exists number(2);
released_exists number(2);
released_archiveseq number(10);
invalid_testing  exception;
invalid_released  exception;

begin

  select count(*) into testing_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Testing';

  if testing_exists <> 1 then
    Raise invalid_testing;
  end if;

  select count(*) into released_exists from tspd_template where client_div_id=ClientDivId
  and template_tid=TemplateTid and status='Released';

  if released_exists > 1 then
    Raise invalid_released;

  elsif released_exists = 0 then

    Insert into tspd_template select increment_sequence('shared_tspd_template_seq'),
    client_div_id,sysdate,name,data,software_version,
    updated_by_ftuser_id,version,'Released',sysdate,creator_ftuser_id,
    sysdate,null,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,1, comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing';

  elsif  released_exists = 1 then

    Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
    sysdate,id,client_div_id,last_updated,name,data,software_version,
    updated_by_ftuser_id,version,status,create_date,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    TEMPLATE_TID,ARCHIVE_SEQ,comments
    from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

    select archive_seq+1 into released_archiveseq from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';


    update tspd_template set (last_updated,name,data,software_version,
    updated_by_ftuser_id,version,creator_ftuser_id,
    released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,
    ARCHIVE_SEQ,comments) = (select sysdate,name,data,software_version,
    updated_by_ftuser_id,version,creator_ftuser_id,
    sysdate,null,LOCALE,DATE_FORMAT,STARTEAM_TAG,
    null,null,
    released_archiveseq,comments from tspd_template
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Testing')
    where client_div_id=ClientDivId
    and template_tid=TemplateTid and status='Released';

  end if;
commit;

exception

  when invalid_testing then
    raise_application_error(-20301,'One and only one testing template must be present before releasing a template');
  when invalid_released then
    raise_application_error(-20302,'More than one template found in released status');

end;
/

sho err

CREATE OR REPLACE TRIGGER tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row

declare
num_templates number(3);

begin

If updating AND :n.status='Testing' then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date,:o.LOCALE,:o.DATE_FORMAT,:o.STARTEAM_TAG,
   null,null,:o.TEMPLATE_TID,:o.ARCHIVE_SEQ,:o.comments from dual;
end if;

 :n.last_updated:=sysdate;
 :n.ARCHIVE_SEQ:=nvl(:o.ARCHIVE_SEQ,0)+1;

if inserting AND :n.template_tid IS NULL then
 :n.template_tid:=:n.id;
end if;

if inserting then
  :n.create_date:=sysdate;
end if;

if updating then
  :n.create_date:=:o.create_date;
end if;

end;
/
sho err

-- Deployed upto this in tsm10@devl
-- Implemented upto this in tsm10e@test on 3/31/2008
-- Implemented upto this in tsm10t@prev on 4/??/2008 
-- Implemented upto this in tsm10e@prev on 3/??/2008  
-- Implemented upto this in tsm10@prod on 4/5/2008 at 10 pm
-- Implemented upto this in tsm10e@prod on 4/5/2008 at 10 pm


CREATE OR REPLACE procedure tspd_25_upgrade (ClientDiv in varchar2)
as
ClientDivId number(10);
library_project_exists number(4);
libtest number(1);
too_many_library_projects exception;
Template_status varchar2(20);
non_library_project_exists number(10);

cursor c1 is select template_tid from tspd_template WHERE client_div_id=ClientDivId 
group by template_tid having count(*)=1;

cursor c2 is select a.id from trial a, tspd_trial b, tspd_template c
  where a.id=b.trial_id and b.tspd_template_id=c.id and c.status='Testing'
  and a.created_by='TSPD' and a.client_div_id=ClientDivId;

begin

 select id into ClientDivId from client_div where client_div_identifier=ClientDiv;

 for ix1 in c1 loop

    -- check the status of the template that has single occurence of template_tid 

    select status into Template_status from tspd_template where template_tid=ix1.template_tid 
    and client_div_id=ClientDivId;

    -- If it is released, insert a testing for it

    if initcap(template_status) = 'Released' then
        Insert into tspd_template
     select increment_sequence('shared_tspd_template_seq'),
      client_div_id,last_updated,name,data,software_version,
      updated_by_ftuser_id,version,'Testing',create_date-(1/24),creator_ftuser_id,
      released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
      LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,TEMPLATE_TID,archive_seq,comments
     from tspd_template where template_tid=ix1.template_tid and client_div_id=ClientDivId;
    end if;
   -- if it is retired then further check if any non-library project associated with it

    if initcap(template_status) = 'Retired' then

       select count(*) into non_library_project_exists from tspd_trial a, trial b, project c
       where a.trial_id=b.id and b.project_id=c.id and c.is_library=0;

   -- if some non-library project found then update existing Retired to RetiredReleased 
   -- And also create a new retired  

      if non_library_project_exists > 0 then 

         update tspd_template set status='RetiredReleased' where template_tid=ix1.template_tid 
         and client_div_id=ClientDivId;
     
          Insert into tspd_template
          select increment_sequence('shared_tspd_template_seq'),
          client_div_id,last_updated,name,data,software_version,
          updated_by_ftuser_id,version,'Retired',create_date,creator_ftuser_id,
          released_date,retired_date,LOCALE,DATE_FORMAT,STARTEAM_TAG,
          LOCKED_BY_FTUSER_ID,CONFIGURED_BY_TRIAL_ID,TEMPLATE_TID,archive_seq,comments
          from tspd_template where template_tid=ix1.template_tid and client_div_id=ClientDivId;
      end if;

    end if;
 end loop;

-- check and see if libraryproject exists for all templates, if not, create one

 select count(*) into library_project_exists from  project d, client_div e
 where  d.client_id=e.client_id AND e.id = ClientDivId and d.is_library=1;

 if library_project_exists=0 then
        insert into project (id,name,ARCHIVED_FLG,ARCHIVED_DATE,client_id,is_library)
        select increment_sequence('project_seq'), 'Library',0,null,client_id,1 from client_div
        where id=ClientDivId;
 elsif library_project_exists > 1 then
       raise too_many_library_projects;
 end if;

 -- Make sure that all trials associated with testing templates are actually library pojects

 for ix2 in c2 loop
   select is_library into libtest from project a, trial b where a.id=b.project_id and b.id=ix2.id;

   if libtest=0 then
      update trial a set a.project_id=(select b.id from project b, client_div c where b.client_id=c.client_id
      and c.id=ClientDivId and b.is_library=1) where a.id=ix2.id;
    end if;
 end loop;
exception

when too_many_library_projects then
   raise_application_error('-20401','More than One library project found ');

end;
/
sho err

-- Deployed upto this in tsm10@devl on 5/9/08 at 5:41pm
--Implemented upto this in tsm10e@test on 5/9/08 at 5:41pm
-- Implemented upto this in tsm10t@prev on 5/9/08 at 5:41pm
-- Implemented upto this in tsm10e@prev on 5/9/08 at 5:41pm
-- Implemented upto this in tsm10@prod on 5/9/08 at 5:41pm
-- Implemented upto this in tsm10e@prod on 5/9/08 at 5:41pm

--In devl and d003 as per Fiammetta Castaldi 07/21/2008
--Modify column sizes
--In TEST and PREV on 07/22/2008
--In PROD on 07/22/2008
alter table TSPD_STUDY_VARIABLE modify (MIN_VALID number(13,3), max_valid number(13,3),LOW_NORMAL number(13,3),HIGH_NORMAL number(13,3));



 
--Implemented upto this in tsm10e@test on 7/21/08 
-- Implemented upto this in tsm10t@prev on 7/22/08 
-- Implemented upto this in tsm10e@prev on 7/22/08 
-- Implemented upto this in tsm10@prod on 7/22/08 
-- Implemented upto this in tsm10e@prod on 7/22/08 


--In devl, d002 and d003 as per Fiammetta Castaldi 10/20/2008
--Modify check constraint

alter table tspd_document drop CONSTRAINT td_snapshot_type_check;
ALTER TABLE tspd_document
  ADD CONSTRAINT td_snapshot_type_check CHECK (
    snapshot_type in (
'WorkingCopy','ReviewCopy','FinalVersion','ConflictVersion','AuthorChange','DocTypeChange','Baseline','TrackChanges','Restored','Corrupted')
  );


--In devl, d002 and d003 as per Fiammetta Castaldi on 10/21/2008
create or replace procedure copy_tspd_document(OldDocId in number, SnapshotType in varchar2 default 'Baseline' )
as
OldIcpId number(10);
NewIcpId number(10);
NewDocId number(10);

begin

select ICP_INSTANCE_ID into OldIcpId from tspd_document where id=OldDocId;
select increment_sequence('icp_instance_seq') into NewIcpId from dual;
select increment_sequence('tspd_document_seq') into NewDocId from dual;

Insert into icp_instance select NewIcpId,TRIAL_ID,LAST_UPDATED,
VERSION_TIMESTAMP,DATA, SnapshotType ,'Frozen' from icp_instance
where id=OldIcpId;

Insert into tspd_diagram select increment_sequence('tspd_diagram_seq'),NewIcpId,
DIAGRAM,ICP_OBJECT_ID,ICP_OBJECT_TYPE,VERSION_TIMESTAMP from tspd_diagram
where ICP_INSTANCE_ID=OldIcpId;

insert into tspd_document select NewDocId,TRIAL_ID,DOCUMENT_TYPE,
DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE-(1/1440),LAST_UPDATED,VERSION_TIMESTAMP,
DATA,SnapshotType,SnapshotType,SNAPSHOT_NOTES,REVIEW_BY_DATE,
REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,NewIcpId,
'Final',DOCUMENT_NOTES,sysdate,SOA_TBL_FORMAT,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,
DATE_FORMAT,AUTHOR_RELINQUISHED_DT,AUTHOR_MODEL_TYPE,
PUBLIC_VISIBLE_FLG,MACROS_DIRTY,UPDATE_REVISION_DOC_FLG from tspd_document where id=OldDocId;

Insert into TSPD_DOCUMENT_AUTHORS select
increment_sequence('tspd_document_authors_seq'),NewDocId,ftuser_id,document_type
from TSPD_DOCUMENT_AUTHORS where tspd_document_id=OldDocId;

end;
/

--Following changes are as per request of Larry Peterson on 10/30/2008

CREATE OR REPLACE TRIGGER ftuser_trg4
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
 num_INACTIVITY_DAYS number(5);
 UserExpiredFlg  number(1):=0;
begin
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
            select LOCKOUT_INACTIVITY_DAYS into num_INACTIVITY_DAYS from password_rule
            where client_div_id=:o.client_div_id;
         else
            num_failed_attempts:=1;
            num_INACTIVITY_DAYS:=1;
         end if;
    else
       num_failed_attempts:=1;
       num_INACTIVITY_DAYS:=1;
    end if;
 if nvl(:o.LAST_LOGIN_DATE,sysdate)+num_INACTIVITY_DAYS < sysdate and num_INACTIVITY_DAYS <> 0 then
     UserExpiredFlg:=1;
 end if;
 if UserExpiredFlg <> 1 then
    declare
     cursor c1 is SELECT rank,to_char(modify_date,'Mon dd, yyyy hh24:mi:ss')||' hrs PST' mdate FROM
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
  if :o.client_div_id is not null
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null
         then
        select email_recipient  into AlertRecipient from oracle_alert_config
        where alert_event = 'UserLocked';
       end if;
   else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserLocked';
   end if;
   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;
   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
-- New code added here for User Expired logic
 if UserExpiredFlg = 1 then
 AlertMessage:='From: Fast Track Data Center
Product: TrialSpace Designer
Auto alert: User expired
The following user has been expired out of TrialSpace Designer:
'||:o.name||' with a user name of '||initcap(:o.first_name)||' '||initcap(:o.last_name)||'
Because of more than '||to_char(num_INACTIVITY_DAYS)||' days of inactivity.
Please ensure that this user is contacted and verifies the inactivity days before unlocking this user.
For further details please contact client support on: 215-358-1400 opt 2
Thank you
Fast Track Systems Inc';
   select email_subject into AlertSubject from oracle_alert_config
   where alert_event = 'UserExpired';
  if :o.client_div_id is not null
   then
     select alert_email into AlertRecipient from client_div_to_lic_app where
     client_div_id=:o.client_div_id and app_name='TSPD';
       if AlertRecipient is null
         then
        select email_recipient  into AlertRecipient from oracle_alert_config
        where alert_event = 'UserExpired';
       end if;
   else
      select email_recipient  into AlertRecipient from oracle_alert_config
      where alert_event = 'UserExpired';
   end if;
   oracle_sendmail(AlertRecipient, AlertSubject,AlertMessage) ;
   Insert into audit_hist(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select increment_sequence('audit_hist_seq'),:o.id,
   'TSPD','auditAction.user_lockout','ftuser',:o.id,'system',205,sysdate from dual;
 end if;
 end if;
end;
/

grant insert on audit_hist to ftcommon;
grant execute on increment_sequence to ftcommon;

alter table AUDIT_HIST drop constraint AUDIT_HIST_APP_TYPE_CHECK;

alter table AUDIT_HIST add constraint AUDIT_HIST_APP_TYPE_CHECK check(
app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','UNKNOWN'));

conn ftcommon/****@???

CREATE OR REPLACE procedure failedloginattempts
(schemaname in varchar2, username in varchar2, apptype in varchar2 default 'UNKNOWN')
as
mysql_stmt varchar2(200);
table_name varchar2(70);

mysql_stmt2 varchar2(300);
table_name2 varchar2(70);
incseq varchar2(70);
appname varchar2(50);

begin

table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set failed_login_attempts=nvl(failed_login_attempts,0)+1 where name=:1';
execute immediate mysql_stmt using username;


table_name2:=schemaname||'.audit_hist';
incseq:=schemaname||'.increment_sequence';
appname:=apptype;

mysql_stmt2:='Insert into '||table_name2||'(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE) select '||incseq||'('||''''||'audit_hist_seq'||''''||'),id,'||
   ''''||appname||''''||','||''''||'auditAction.login_failed'||''''||','||''''||'ftuser'||''''||','||'id,'||''''||'system'||''''||
   ',205,sysdate from '||table_name||' where name=:1' ;
execute immediate mysql_stmt2 using username;

commit;
end;
/


CREATE OR REPLACE procedure failedloginattempts
(schemaname in varchar2, username in varchar2, apptype in varchar2 default 'UNKNOWN', reason in varchar2 default null)
as
mysql_stmt varchar2(200);
table_name varchar2(70);

mysql_stmt2 varchar2(500);
table_name2 varchar2(70);
incseq varchar2(70);
appname varchar2(50);
fail_reason varchar2(250);

begin

table_name:=schemaname||'.ftuser';
mysql_stmt:='Update '||table_name||' set failed_login_attempts=nvl(failed_login_attempts,0)+1 where name=:1';
execute immediate mysql_stmt using username;


table_name2:=schemaname||'.audit_hist';
incseq:=schemaname||'.increment_sequence';
appname:=apptype;
fail_reason:=reason;

mysql_stmt2:='Insert into '||table_name2||'(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE,COMMENTS) select '||incseq||'('||''''||'audit_hist_seq'||''''||'),id,'||
   ''''||appname||''''||','||''''||'auditAction.login_failed'||''''||','||''''||'ftuser'||''''||','||'id,'||''''||'system'||''''||
   ',205,sysdate,'||''''||fail_reason||''''||' from '||table_name||' where name=:1' ;
execute immediate mysql_stmt2 using username;

commit;
end;
/

--Following changes are as per request of Larry Peterson on 11/5/2008

CREATE OR REPLACE procedure UnknownUserloginattempt 
(schemaname in varchar2, username in varchar2, apptype in varchar2 default 'UNKNOWN', reason in varchar2 default 'Unknown User')
as
mysql_stmt varchar2(500);
table_name varchar2(70);
incseq varchar2(70);
appname varchar2(50);
fail_reason varchar2(250);

begin

table_name:=schemaname||'.audit_hist';
incseq:=schemaname||'.increment_sequence';
appname:=apptype;
fail_reason:=reason||':'||username;

mysql_stmt:='Insert into '||table_name||'(ID,FTUSER_ID,APP_TYPE,ACTION,TARGET_PRIMARY_TABLE,TARGET_ID,
   ENTITY_TYPE,ENTITY_ID,MODIFY_DATE,COMMENTS) select '||incseq||'('||''''||'audit_hist_seq'||''''||'),-1,'||
   ''''||appname||''''||','||''''||'auditAction.login_failed'||''''||','||''''||'ftuser'||''''||','||'-1,'||''''||'system'||''''||
   ',205,sysdate,'||''''||fail_reason||''''||' from dual';
execute immediate mysql_stmt;

commit;
end;
/


conn tsm10/****@????

Insert into ftuser
(ID,FIRST_NAME,LAST_NAME,ACTIVE_TRACE_USER,ACTIVE_TSM_USER,
CAN_MODEL_FLAG,ACTIVE_TSPD_USER,LOCKED,ACTIVE_CROCAS_USER)
values (-1,'Unknown','Unknown',0,0,0,0,1,0);
commit;



--Following changes are as per request of Fiammetta on 11/3/2008

alter table tspd_variable_mapping add( 
form_oid             VARCHAR2(80),
proc_oid             VARCHAR2(80),
variable_oid         VARCHAR2(80),
form_sequence    NUMBER(10));

--Implemented upto this in tsm10@q002 on 11/12/08 at 5pm

CREATE TABLE tspd_client_div(
  id                  NUMBER(10,0)   NOT NULL,
  client_div_id       NUMBER(10,0)   NOT NULL,
  TRIAL_COPY_PERMISSION       VARCHAR2(20)  DEFAULT 'All' NULL
)
  TABLESPACE tspdsmall
  PCTFREE 20
/

ALTER TABLE tspd_client_div
  ADD CONSTRAINT tcd_copy_permission_check CHECK (
    TRIAL_COPY_PERMISSION in ('All','IcpOnly','NoTrial','None')
  )
/

ALTER TABLE tspd_client_div 
  ADD CONSTRAINT tspd_client_div_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tspdsmall_indx
    PCTFREE    20
/
 
ALTER TABLE tspd_client_div
  ADD CONSTRAINT tspd_client_div_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

GRANT SELECT ON TSPD_CLIENT_DIV to TPS_RO;

insert into id_control values('tsm10','tspd_client_div',1);

  CREATE OR REPLACE TRIGGER CLIENT_DIV_TRG1 
after insert on client_div
referencing new as n old as o
for each row
DECLARE
   TspdClientDivId number(10);

BEGIN
  SELECT increment_Sequence('tspd_client_div_seq') INTO TspdClientDivId
  FROM DUAL;
  insert into tspd_client_div (id,client_div_id) values(TspdClientDivId,:n.id);

END;
/
ALTER TRIGGER CLIENT_DIV_TRG1 ENABLE;



ALTER TABLE tspd_client_div DROP CONSTRAINT tspd_client_div_fk1;
ALTER TABLE tspd_client_div ADD CONSTRAINT tspd_client_div_fk1 
FOREIGN KEY (CLIENT_DIV_ID) REFERENCES client_div(id) on delete cascade;

INSERT INTO tspd_client_div (id,client_div_id) 
SELECT increment_sequence('tspd_client_div_seq'),id 
FROM client_div;

commit;

--*******************************************************
--Implemented upto this in tsm10@devl, tsm10@d003, tsm10@d002
-- on 12/03/08 at 12:10pm
--Implemented upto this in tsm10@q002
-- on 01/14/09 at 14:30pm
-- Implemented upto this in tsm10@demo on 01/23/09 4:00pm
-- Implemented upto this in tsm10e@prev on 01/23/09 4:40pm
-- Implemented upto this in tsm10@prod on 01/30/09 4:01pm
--*******************************************************

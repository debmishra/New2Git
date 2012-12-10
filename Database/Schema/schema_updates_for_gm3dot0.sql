CREATE TABLE complexity_hist (
  id          NUMBER(10,0) NOT NULL,
  phase_id NUMBER(10,0) NOT NULL,                
  indmap_id   NUMBER(10,0) NOT NULL,   
  complexity_val NUMBER(10,0) NOT NULL
)
TABLESPACE TSMLARGE pctfree 20
/

ALTER TABLE complexity_hist 
  ADD CONSTRAINT complexity_hist_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMLARGE_indx
    PCTFREE    20
/

ALTER TABLE complexity_hist
  ADD CONSTRAINT complexity_hist_fk1 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/

ALTER TABLE complexity_hist DROP CONSTRAINT complexity_hist_fk2;

ALTER TABLE complexity_hist
  ADD CONSTRAINT complexity_hist_fk2 FOREIGN KEY (
    indmap_id
  ) REFERENCES indmap (
    id
  )
/

insert into id_control values ('tsm10e','complexity_hist',1);
commit;

ALTER TABLE protocol add( complexity_val NUMBER(10,0) NULL)
/
 
ALTER TABLE procedure_def add( complexity_val NUMBER(10,0) NULL)
/

--As per Tonya's request on 03/05/2009
--In devl, d003 and d002.

ALTER TABLE trial_budget add( complexity_val NUMBER(10,0) NULL)
/

--As per Phil's request on 03/06/2009
--In devl, d003 and d002.
alter table complexity_hist modify(COMPLEXITY_VAL number(12,2));

alter table protocol modify(COMPLEXITY_VAL number(12,2));

alter table procedure_def modify(COMPLEXITY_VAL number(12,2));

ALTER TABLE trial_budget modify( complexity_val NUMBER(12,2) );

alter table tsm_trial_rollup add( hist_complexity_val NUMBER(12,2) );

--As per Tonya's's request on 03/16/2009
--In devl, d003 and d002.
alter table tsm_trial_rollup add( complexity_val NUMBER(12,2) NULL);


--As per Tonya's's request on 03/17/2009
--In devl, d003 and d002.
alter table cost_item add( trial_id NUMBER(10) );
ALTER TABLE cost_item
  ADD CONSTRAINT cost_item_fk5 FOREIGN KEY (
    trial_id
  ) REFERENCES trial (
    id
  )
/

alter table picas_visit add( trial_id NUMBER(10) );
ALTER TABLE picas_visit
  ADD CONSTRAINT picas_visit_fk2 FOREIGN KEY (
    trial_id
  ) REFERENCES trial (
    id
  )
/

--As per Tonya's's request on 03/18/2009
--In devl, d003 and d002.
alter table cost_item modify(TRIAL_BUDGET_ID null);
alter table picase_trial add(dropout_rate NUMBER(12,2) default 0 not null );
--Implemented in Q002 and Q003 on 03/23/09


--As per Tonya's's request on 03/19/2009
--In devl
--To be removed and commented. Not to be implemented.
--CREATE OR REPLACE TRIGGER trial_budget_trg1 after insert on trial_budget referencing new as n old as o for each row
--
--declare
--
--v_exist1 number(10);
--invalid_budget exception;
--
--begin
--
-- Select count(*) into v_exist1 from trial_budget where country_id=:n.country_id and trial_id=:n.trial_id and delete_flg=0 and --parent_trial_budget_id is null;  if v_exist1 > 1 then
--   raise invalid_budget;
-- end if;
--
--exception
--
-- when invalid_budget then
--     Raise_application_error(-20061,'Error while storing the budget. Please contact support'); 
--end ; 
--/


--As per Phil's request on 03/26/2009
--In devl, d003 and d002.
CREATE TABLE tsm_internal_cust (
  id            NUMBER(10,0) NOT NULL,
  client_div_id NUMBER(10,0) NOT NULL,                
  customer_name VARCHAR2(1000) NOT NULL,
  deleted       NUMBER(1,0)    DEFAULT 0 NOT NULL
)
TABLESPACE TSMSMALL pctfree 20
/

ALTER TABLE tsm_internal_cust 
  ADD CONSTRAINT tsm_internal_cust_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMSMALL_indx
    PCTFREE    20
/

ALTER TABLE tsm_internal_cust
  ADD CONSTRAINT tsm_internal_cust_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/

insert into id_control values ('tsm10e','tsm_internal_cust',1);
commit;

--to hold currency figures  
ALTER TABLE picase_trial add(expected_trial_cost NUMBER(12,2));

ALTER TABLE picase_trial add(num_subjects  NUMBER(6,0));
ALTER TABLE picase_trial add(num_visits    NUMBER(6,0));
ALTER TABLE picase_trial add(tsm_internal_cust_id  NUMBER(10,0));
ALTER TABLE picase_trial add(pediatric_flg   NUMBER(1,0) DEFAULT 0 NOT NULL);
ALTER TABLE picase_trial add(patient_type   NUMBER(1,0));
ALTER TABLE picase_trial add(patient_duration  NUMBER(6,0));
ALTER TABLE picase_trial add(patient_duration_unit NUMBER(1,0));

ALTER TABLE picase_trial ADD CONSTRAINT picase_trial_fk8 
FOREIGN KEY ( tsm_internal_cust_id ) 
REFERENCES tsm_internal_cust ( id );


--1 = inpatient, 2 = outpatient, 3 = Mixed
ALTER TABLE picase_trial 
ADD CONSTRAINT patient_type_check CHECK(patient_type    in   (1,  2, 3) ); 

--1=days, 2=weeks, 3=months, 4=years
ALTER TABLE picase_trial
ADD CONSTRAINT patient_duration_unit_check CHECK (
    patient_duration_unit    in   (1,  2, 3, 4) ); 
--Implemented upto this in DEVL, D002 and D003 on 03/27/2009

--As per Phil's request in devl, d003 and d002 on 04/15/09
ALTER TABLE picase_trial modify(patient_type  NUMBER(3,0));

ALTER TABLE picase_trial DROP CONSTRAINT patient_type_check;

--123=Inpatient,124=Outpatient,125=Mixed in the ip_business_factors table
ALTER TABLE picase_trial 
ADD CONSTRAINT patient_type_check CHECK(patient_type in (123,  124, 125));

--Implemented upto this in DEVL, D002 and D003 on 04/15/2009


--As per Tonya's request on 04/27/09
alter table picase_trial add(gm_version number(1));
alter table trial_budget add(gm_version number(1));
--Implemented upto this in DEVL, D002 and D003 on 04/27/2009

--As per Phil's request on 04/28/09

ALTER TABLE country add(country_group_id   NUMBER(10,0),
                        is_mdsol_viewable   NUMBER(1,0)   DEFAULT 0 NOT NULL);


--Implemented upto this in DEVL, D002 and D003 on 04/28/2009

alter table country rename column COUNTRY_GROUP_ID to group_country_id;

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Africa',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Central America',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Global',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Middle East',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'South America',1,2,0,0,0,0,1);

INSERT INTO country(id,NAME,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE) 
VALUES(increment_sequence('country_seq'),'Ghana',1,2,0,0,0,0,1);


alter table country drop constraint COUNTRY_FK4;

UPDATE country 
set GROUP_COUNTRY_ID=(select id FROM country 
                             WHERE name='Global')
where name<>'Global'
AND id in (122,123,125,126);

UPDATE country 
set GROUP_COUNTRY_ID=(select id FROM country 
                             WHERE name='Europe')
WHERE name in ('Western Europe','Eastern Europe');
update country set GROUP_COUNTRY_ID=null where name='Global';
commit;
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Africa';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Algeria';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Argentina';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Australia';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Austria';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Bangladesh';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Belarus';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Belgium';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Bosnia and Herzegovina';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Brazil';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Bulgaria';
UPDATE COUNTRY set group_country_id=115,is_mdsol_viewable=1 WHERE name='Canada';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Central America';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Chile';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='China';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Colombia';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Costa Rica';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Croatia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Cyprus';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Czech Republic';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Denmark';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Dominican Republic';
UPDATE COUNTRY set group_country_id=116,is_mdsol_viewable=1 WHERE name='Eastern Europe';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Ecuador';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Egypt';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='El Salvador';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Estonia';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Europe';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Finland';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='France';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Georgia';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Germany';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Ghana';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Global';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Greece';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Guatemala';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Honduras';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Hong Kong';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Hungary';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Iceland';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='India';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Indonesia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Iran';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Ireland';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Israel';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Italy';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Japan';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Kenya';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Latvia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Lebanon';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Lithuania';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Luxembourg';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Malawi';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Malaysia';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Malta';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Mexico';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Middle East';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Morocco';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Netherlands';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='New Zealand';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='North America';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Norway';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='Pacific Asia';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Pakistan';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Panama';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Peru';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Philippines';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Poland';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Portugal';
UPDATE COUNTRY set group_country_id=123,is_mdsol_viewable=1 WHERE name='Puerto Rico';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Romania';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Russia';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Serbia';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Singapore';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Slovakia';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Slovenia';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='South Africa';
UPDATE COUNTRY set group_country_id=124,is_mdsol_viewable=1 WHERE name='South America';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='South Korea';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Spain';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Sweden';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='Switzerland';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Taiwan';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Tanzania';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Thailand';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Tunisia';
UPDATE COUNTRY set group_country_id=125,is_mdsol_viewable=1 WHERE name='Turkey';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Uganda';
UPDATE COUNTRY set group_country_id=27,is_mdsol_viewable=1 WHERE name='Ukraine';
UPDATE COUNTRY set group_country_id=119,is_mdsol_viewable=1 WHERE name='United Kingdom';
UPDATE COUNTRY set group_country_id=115,is_mdsol_viewable=1 WHERE name='United States';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Uruguay';
UPDATE COUNTRY set group_country_id=126,is_mdsol_viewable=1 WHERE name='Venezuela';
UPDATE COUNTRY set group_country_id=120,is_mdsol_viewable=1 WHERE name='Vietnam';
UPDATE COUNTRY set group_country_id=116,is_mdsol_viewable=1 WHERE name='Western Europe';
UPDATE COUNTRY set group_country_id=122,is_mdsol_viewable=1 WHERE name='Zambia';
update country set GROUP_COUNTRY_ID=null where name='Global';
commit;

--Implemented upto this in Q002 on 05/04/2009


--As per Tonya's request on 05/01/2009
ALTER TABLE picase_trial ADD(target_enrolled_patients        NUMBER(6));
ALTER TABLE picase_trial ADD(target_screened_patients        NUMBER(6));
--Implemented upto this in DEVL, D002 and D003 on 05/01/2009


--As per Tonya's request on 05/20/2009
ALTER TABLE trial_budget ADD(TOTAL_COST_NO_OH  NUMBER(10), TOTAL_COST_NO_OH_LOCAL NUMBER(10));
--Implemented upto this in DEVL, D002 and D003 on 05/20/2009


--As per Tonya's request on 05/27/2009
ALTER TABLE trial_budget ADD(Fixed_scr_fail_cost NUMBER(10,2),
                             Is_fixed_scr_fail_cost  NUMBER(1) DEFAULT 0 NOT NULL); 

--Implemented upto this in DEVL, D002 and D003 on 05/27/2009
--Implemented upto this in q002 on 05/28/2009


--As per Tonya's request on 06/11/2009
ALTER TABLE trial_budget ADD(is_cost_add_to_trial NUMBER(1) DEFAULT 1 NOT NULL);

--Implemented upto this in DEVL, D002 and D003 on 06/11/2009
--Implemented upto this in q002 on 06/25/2009


--As per Tonya's request on 07/06/2009
ALTER TABLE cost_item ADD(temp_frequency NUMBER(12,2));

--Implemented upto this in DEVL, D002 and D003 on 07/06/2009

--As per Tonya's request on 07/10/2009
ALTER TABLE picase_trial MODIFY(GM_VERSION NUMBER(4,2));
ALTER TABLE trial_budget MODIFY(GM_VERSION NUMBER(4,2));

--In q002 on 07/13/2009
--In devl, d002, d003 on 07/14/2009
CREATE INDEX COST_ITEM_INDX2 ON COST_ITEM(TRIAL_ID) 
TABLESPACE TSMLARGE_INDX ;

--Implemented upto this in DEVL, D002 and D003 on 07/10/2009 
--Index created in development on 07/14/2009
--Implemented upto this in q002 on 07/13/2009

--Implemented upto this in prev on 07/14/2009

--As per Tonya's request on 07/17/2009
ALTER TABLE trial_budget ADD(total_cost_pvb_no_oh NUMBER(10),total_cost_pvb_no_oh_local NUMBER(10));

--Implemented upto this in DEVL, D002 and D003 on 07/20/2009 
--Implemented upto this in q002 on 07/23/2009

--As per Rogers request on 07/31/2009
update region set name='Metropolitan Area '||name WHERE type='Metro';
--Implemented upto this in DEVL, D002 and D003 on 08/05/2009 

--Implemented upto this in q002 on 08/05/2009


--As per Tonya's request on 08/05/2009
CREATE TABLE gm_budget_group(
  id            NUMBER(10) NOT NULL,
  TRIAL_ID      NUMBER(10) NOT NULL,                
  NAME          VARCHAR2(1000) NOT NULL,
  TYPE	        Varchar2(50) NOT null,
  CREATE_DATE                DATE NOT NULL,
  CREATOR_FTUSER_ID          NUMBER(10) NOT NULL,
  NUM_SITES                  NUMBER(4),
  NUM_ENTERED_PATIENTS       NUMBER(6),
  NUM_ENROLLED_PATIENTS      NUMBER(6),
  TOTAL_COST                 NUMBER(15),
  TOTAL_COST_PVB             NUMBER(10),
  TOTAL_COST_NO_OH           NUMBER(10),
  TOTAL_COST_PVB_NO_OH       NUMBER(10),
  COST_PER_PATIENT    NUMBER(12,2),
  COST_PER_VISIT      NUMBER(12,2),
  COMPLEXITY_VAL      NUMBER(12,2),
  IS_ORIGINAL         NUMBER(1)    DEFAULT 0 NOT NULL
)
TABLESPACE TSMSMALL pctfree 20
/

insert into id_control values ('tsm10e','gm_budget_group',1);
commit;

ALTER TABLE gm_budget_group 
  ADD CONSTRAINT gm_budget_group_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMSMALL_indx
    PCTFREE    5
/

ALTER TABLE gm_budget_group
  ADD CONSTRAINT gm_budget_group_fk1 FOREIGN KEY (
    TRIAL_ID
  ) REFERENCES trial (
    id
  )
/

ALTER TABLE gm_budget_group ADD CONSTRAINT gm_budget_group_uk1 UNIQUE (TRIAL_ID,NAME) USING INDEX
TABLESPACE tsmsmall_indx PCTFREE 5
/ 

ALTER TABLE trial_budget ADD (gm_budget_group_id NUMBER(10));

ALTER TABLE trial_budget ADD CONSTRAINT trial_budget_fk12 FOREIGN KEY(gm_budget_group_id)
REFERENCES gm_budget_group(id)
/
--Implemented upto this in DEVL, D002 and D003 on 08/05/2009 


--As per Tonya's request on 08/07/2009
ALTER TABLE gm_budget_group ADD(DELETE_FLG	NUMBER(1)  DEFAULT 0 NOT NULL, DELETE_DATE	DATE);

--Implemented upto this in DEVL, D002 and D003 on 08/07/2009 


--As per Tonya's request on 08/11/2009
ALTER TABLE trial_budget ADD(TOTAL_COST_LOW	NUMBER(10), TOTAL_COST_MED  NUMBER(10),
			     TOTAL_COST_HIGH	NUMBER(10), TOTAL_COST_CO   NUMBER(10),
			     TOTAL_COST_PVB_LOW	NUMBER(10),
			     TOTAL_COST_PVB_MED   NUMBER(10), TOTAL_COST_PVB_HIGH   NUMBER(10),
			     TOTAL_COST_PVB_CO	NUMBER(10) );

ALTER TABLE gm_budget_group  ADD(TOTAL_COST_LOW	NUMBER(10), TOTAL_COST_MED  NUMBER(10),
			     TOTAL_COST_HIGH	NUMBER(10), TOTAL_COST_CO   NUMBER(10),
			     TOTAL_COST_PVB_LOW	NUMBER(10),
			     TOTAL_COST_PVB_MED   NUMBER(10), TOTAL_COST_PVB_HIGH NUMBER(10),
			     TOTAL_COST_PVB_CO	NUMBER(10),NUM_COMPLETED_PATIENTS NUMBER(6));
--Implemented upto this in DEVL, D002 and D003 on 08/11/2009 
--Implemented upto this in q002 on 08/14/2009


--As per Phil's request on 08/12/2009
UPDATE country SET name='Australia' WHERE name='Australia, New Zealand';
UPDATE country SET name='India' WHERE name='India, Pakistan' and abbreviation='IND';
UPDATE country SET name='Serbia' WHERE name='Serbia and Montenegro';

update country set abbreviation='AB2' where id=122;
update country set abbreviation='AB3' where id=123;
update country set abbreviation='AB4' where id=124;
update country set abbreviation='AB5' where id=125;
update country set abbreviation='AB6' where id=126;
update country set abbreviation='AB7' where id=127;
--Implemented upto this in DEVL, D002 and D003 on 08/12/2009 

--As per Tonya's request on 08/17/2009
ALTER TABLE gm_budget_group RENAME column NAME to budget_group_name;
ALTER TABLE gm_budget_group RENAME column TYPE to budget_group_type;
--Implemented upto this in DEVL, D002 and D003 on 08/17/2009 


--As per Tonya's request on 08/18/2009
ALTER TABLE gm_budget_group  ADD(AVG_CPP_LOW 	NUMBER(12,2), AVG_CPP_MED	NUMBER(12,2),
			         AVG_CPP_HIGH	NUMBER(12,2), AVG_CPP_COMPANY	NUMBER(12,2));
--Implemented upto this in DEVL, D002 and D003 on 08/18/2009 
--Implemented upto this in q002 on 08/24/2009


--As per Tonya's request on 08/25/2009
ALTER TABLE client_div ADD(COMPLEXITY_ENABLED NUMBER(1)  DEFAULT 0 NOT NULL);
--Implemented upto this in DEVL, D002,D003 and q002 on 08/25/2009 


--As per Tonya's request on 08/28/2009
CREATE TABLE gm_client_defaults ( id                  NUMBER(10,0)   NOT NULL,
                                  client_div_id       NUMBER(10,0)   NOT NULL,
                                  complexity_enabled    NUMBER(1,0)   DEFAULT 0 NOT NULL );

insert into id_control values ('tsm10e','gm_client_defaults',1);
commit;

ALTER TABLE gm_client_defaults 
  ADD CONSTRAINT gm_client_defaults_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMSMALL_indx
    PCTFREE    5
/

ALTER TABLE gm_client_defaults
  ADD CONSTRAINT gm_client_defaults_fk1 FOREIGN KEY (
    client_div_id
  ) REFERENCES client_div (
    id
  )
/
--Implemented upto this in DEVL, D002,D003  on 08/28/2009 
--Implemented upto this in q002  on 08/31/2009 


--As per Tonya's request on 08/31/2009
ALTER TABLE picase_trial ADD(complexity_budget_id  NUMBER(10));

--Implemented upto this in DEVL, D002,D003  on 08/31/2009 
--Implemented upto this in q002  on 09/02/2009

--Implemented upto this DEMO and Q003
/***********************************************************/
--Implemented upto this in PREV on 10/07/2009
/***********************************************************/

--As per Phil's request on 09/18/2009
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Bangladesh','BGD',1,2,0,0,0,0,1,120);

UPDATE country SET is_mdsol_viewable=1, group_country_id=120 
WHERE id in (1,67);
UPDATE country SET is_mdsol_viewable=1, group_country_id=27 
WHERE id in (83);
UPDATE country SET abbreviation='GHA' where name='Ghana';

UPDATE country SET abbreviation='SA' WHERE name='South America';
UPDATE country SET abbreviation='ME' WHERE name='Middle East';
UPDATE country SET abbreviation='GBL' WHERE name='Global';
UPDATE country SET abbreviation='CA' WHERE name='Central America';
UPDATE country SET abbreviation='AFR' WHERE name='Africa';

/***********************************************************/
--Implemented upto this in PROD on 10/09/2009
/***********************************************************/

INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Ecuador','EDR',1,2,0,0,0,0,1,126);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Iran','IRN',1,2,0,0,0,0,1,125);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Kenya','KYA',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Tanzania','TNZ',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Uganda','UGN',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Zambia','ZMB',1,2,0,0,0,0,1,122);
INSERT INTO country(id,NAME,ABBREVIATION,currency_id,country_level,VIRTUAL_FLG,IS_VIEWABLE,IS_CRO_VIEWABLE,IS_PBT_VIEWABLE,IS_MDSOL_VIEWABLE,group_country_id) 
VALUES(increment_sequence('country_seq'),'Malawi','MWI',1,2,0,0,0,0,1,122);


--BELOW INSERT ONLY VALID FOR DEVL database.
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),31, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=31);

--BELOW INSERTS ONLY VALID FOR Q002 database.
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),91, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=91);
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),98, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=98);

--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),101, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=101);
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),103, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=103);
--INSERT INTO client_div_to_lic_country 
--SELECT increment_sequence('client_div_to_lic_country_seq'),104, id FROM country 
--WHERE is_mdsol_viewable=1 
--AND id not in (select country_id FROM client_div_to_lic_country WHERE client_div_id=104);


--Implemented upto this in DEVL,D002,D003  on 09/19/2009
--Implemented upto this in q002  on 09/19/2009


--As per Phil's request on 09/30/2009
ALTER TABLE trial_budget MODIFY  (avg_cpp_low  NUMBER(12,2),  avg_cpp_med        NUMBER(12,2),
  avg_cpp_high         NUMBER(12,2),  avg_cpp_company      NUMBER(12,2),
  avg_cpp_selected     NUMBER(12,2),  total_cost  NUMBER(17,2),
 total_cost_local     NUMBER(17,2), avg_cpp_selected_local     NUMBER(12,2),
  total_cost_pvb       NUMBER(12,2),
  total_cost_pvb_local       NUMBER(17,2),  total_cost_no_oh     NUMBER(12,2),
  total_cost_no_oh_local     NUMBER(12,2),  total_cost_pvb_no_oh       NUMBER(12,2),
  total_cost_pvb_no_oh_local NUMBER(12,2), total_cost_low       NUMBER(12,2),
  total_cost_med       NUMBER(12,2),  total_cost_high      NUMBER(12,2),
  total_cost_co        NUMBER(12,2), total_cost_pvb_low   NUMBER(12,2),
  total_cost_pvb_med   NUMBER(12,2),  total_cost_pvb_high  NUMBER(12,2),
  total_cost_pvb_co    NUMBER(12,2));

ALTER TABLE tsm_trial_rollup MODIFY (total_cost_pvb      NUMBER(17,2));

ALTER TABLE gm_budget_group MODIFY  ( total_cost             NUMBER(17,2),  total_cost_pvb         NUMBER(12,2),
  total_cost_no_oh       NUMBER(12,2),  total_cost_pvb_no_oh   NUMBER(12,2),
  total_cost_low         NUMBER(12,2),  total_cost_med         NUMBER(12,2),
  total_cost_high        NUMBER(12,2),  total_cost_co          NUMBER(12,2),
  total_cost_pvb_low     NUMBER(12,2),  total_cost_pvb_med     NUMBER(12,2),
  total_cost_pvb_high    NUMBER(12,2),  total_cost_pvb_co      NUMBER(12,2));

--Implemented upto this in DEVL,D002,D003  on 10/01/2009
--Implemented upto this in q002  on 10/06/2009



--As per Tonya's request on 10/20/2009
ALTER TABLE gm_budget_group ADD( specify_odc_flg NUMBER(1)  DEFAULT 1 NOT NULL);

--Implemented upto this in DEVL,D002,D003  on 10/20/2009
--Implemented upto this in q002  on 10/23/2009
--Implemented upto this in perf on 11/02/2009
/***********************************************************/
--Implemented upto this in demo on 11/03/2009
/***********************************************************/

--As per Phil's request on 11/13/2009
UPDATE region SET type='Metro', name='Metropolitan Area Washington DC' WHERE id=106;

--Implemented upto this in DEVL,D002,D003  on 11/13/2009
--Implemented upto this in q002  on 11/13/2009
--Implemented upto this in perf on 11/23/2009
--Implemented upto this in q003 on 11/25/2009

--As per Kelly's request on 12/15/2009
ALTER TABLE client_div_to_lic_app DROP CONSTRAINT cdtla_app_name_check;
ALTER TABLE client_div_to_lic_app ADD CONSTRAINT cdtla_app_name_check 
    CHECK (app_name in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN','GMOWN','GM30'));

--Implemented upto this in devl,d002,d003 on 12/15/2009
--Implemented upto this in q002  on 12/16/2009

create or replace procedure new_gm_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_gm30_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_gmc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_gma_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_cc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gm_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gm30_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gmc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_gma_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_cc_clientdiv (ClientDivId in number)
is
begin
null;
end;
/
--Implemented upto this in devl,d002,d003 on 12/16/2009
--Implemented upto this in q002  on 12/16/2009


alter table audit_hist drop constraint audit_hist_app_type_check;
ALTER TABLE audit_hist
  ADD CONSTRAINT audit_hist_app_type_check CHECK (
    app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','GM30','UNKNOWN')
  );

alter table TSM_MESSAGE drop constraint TM_APP_TYPE_CHECK;
ALTER TABLE TSM_MESSAGE
  ADD CONSTRAINT TM_APP_TYPE_CHECK CHECK (
    app_type in ('PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN','GM30')
  );

alter table user_pref drop constraint UP_APP_TYPE_CHECK;
alter table user_pref add constraint UP_APP_TYPE_CHECK 
CHECK (app_type IN ('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','TSN','GMOWN','DGW','GM30'));


alter table ENV_VAR drop constraint ENV_VAR_APP_TYPE_CHECK;
alter table ENV_VAR 
add constraint ENV_VAR_APP_TYPE_CHECK CHECK ( app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','GM30','UNKNOWN') );

alter table TRIAL drop constraint TRIAL_CREATED_BY_CHECK;
alter table TRIAL 
add constraint TRIAL_CREATED_BY_CHECK CHECK ( created_by in ('DASHBOARD','PICASE','TRACE','TSPD','CROCAS','TSN','GM30') );

---
---Connect as FTCOMMON 
---
conn ftcommon

ALTER TABLE application DROP CONSTRAINT APPLICATION_APP_NAME_CHECK;
ALTER TABLE application ADD CONSTRAINT APPLICATION_APP_NAME_CHECK 
CHECK (app_name in ('PICASE', 'TRACE','TSPD','FTADMIN','CROCAS','GM30'));
INSERT INTO application VALUES(6,'GM30','Grants Manager 3.0',null);
commit;

--Implemented upto this in devl,d002,d003 on 12/18/2009
--Implemented upto this in q002,perf on 12/28/2009

--As per DB's request on 12/29/2009
CREATE OR REPLACE TRIGGER trial_trg1
before insert or update of created_by
ON trial
referencing new as n old as o
for each row
begin

 If :n.created_by = 'PICAS-E' or :n.created_by = 'Trace' or
    :n.created_by = 'PICASE' or :n.created_by = 'TRACE' or
    :n.created_by = 'Crocas' or :n.created_by = 'CROCAS' or
    :n.created_by = 'TSPD' or  :n.created_by='GM30' then
  :n.guid := 'TSM_'||:n.id;
 end if;

end;
/

--Implemented upto this in devl,d002,d003 on 12/29/2009
--Implemented upto this in q002,perf on 12/29/2009


create or replace procedure new_tspd_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure upgrade_tspd_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

create or replace procedure new_clientdiv (ClientDivId in number)
is
begin
null;
end;
/

--Implemented upto this in devl,d002,d003 on 12/28/2009
--Implemented upto this in q002 on 12/30/2009
--Implemented upto this in perf on 12/31/2009

-- As per request on 01/12/2010 ---
CREATE OR REPLACE procedure new_gm30_clientdiv (ClientDivId in number)
is
 BEGIN
 UPDATE client_div SET allow_create_unlisted=1 WHERE id=ClientDivId;
 end;
/


CREATE OR REPLACE procedure new_tspd_clientdiv (ClientDivId in number)
is
BEGIN
 UPDATE client_div SET tspd_build_tag_id = (Select Max(tspd_build_tag_id) FROM client_div)
 WHERE id =   ClientDivId;
end;
/

--Implemented upto this in devl,d002,d003 on 01/12/2010
--Implemented upto this in q002 on 01/12/2010


-- As per Phil's request on 01/13/2010
CREATE OR REPLACE FUNCTION GM30_BUDGET_COUNTRY (TrialId in number) return VARCHAR2 as
BudgetCountry varchar2(2000):=null;
cursor C1 is select b.abbreviation, min(a.id) budgetid,
                    min(a.gm_budget_group_id) budgetgroupid, count(a.country_id) cnt
             from trial_budget a, country b
             WHERE a.trial_id=TrialId AND a.country_id=b.id
             AND a.region_id is null AND a.institution_id is null
             GROUP BY b.abbreviation order by 1;
begin
   FOR ix1 in c1 Loop
   --  if ix1.cnt > 0 then
         BudgetCountry := BudgetCountry||', '||ix1.abbreviation||'_|_'||ix1.budgetgroupid||'_|_'||ix1.budgetid||'_|_'||ix1.cnt;
   --  else
   --  BudgetCountry := BudgetCountry||', '||ix1.abbreviation;
   --  end if;
   end loop;
   RETURN (substr(budgetcountry,3));
end;
/
 

CREATE OR REPLACE FUNCTION GM30_BUDGET_GROUP (TrialId in number) return VARCHAR2 as
BudgetGroup varchar2(2000):=null;
cursor C1 is select budget_group_name from gm_budget_group
              where trial_id=TrialId AND budget_group_type='ARM' order by 1;
begin

   FOR ix1 in c1 Loop
     budgetgroup := budgetgroup||', '||ix1.budget_group_name;
   end loop;
    RETURN (substr(BudgetGroup,3));
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_BUDGET_REGION (TrialId in number) return VARCHAR2 as
BudgetRegion varchar2(2000):=null;
cursor C1 is select b.name,min(a.id) budgetid,
                    min(a.gm_budget_group_id) budgetgroupid, count(a.region_id) cnt
             from trial_budget a, country b
WHERE a.trial_id=TrialId AND a.region_id is not null AND a.region_id=b.id
group by b.name order by 1;
begin
   FOR ix1 in c1 Loop
       BudgetRegion := BudgetRegion||', '||ix1.name||'_|_'||ix1.budgetgroupid||'_|_'||ix1.budgetid||'_|_'||ix1.cnt;
   end loop;
   RETURN (substr(BudgetRegion,3));
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_BUDGET_SITE (TrialId in number) return VARCHAR2 as
BudgetSite varchar2(4000):=null;
cursor C1 is select b.name,  min(a.id) budgetid,
                    min(a.gm_budget_group_id) budgetgroupid, count(a.institution_id) cnt
             from trial_budget a, institution b
             WHERE a.trial_id=TrialId AND a.institution_id is not null AND a.institution_id=b.id
             group by b.name order by 1;
begin
   FOR ix1 in c1 Loop
      BudgetSite := BudgetSite||'#,,# '||ix1.name||'_|_'||ix1.budgetgroupid||'_|_'||ix1.budgetid||'_|_'||ix1.cnt;
   end loop;
   RETURN (substr(BudgetSite,6));
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_INDICATION_NAME (TrialId in number) return VARCHAR2 as
indtype varchar2(30);
tacode varchar2(256);
shortdesc varchar2(256);
indmapid number;
begin
   SELECT indmap_id INTO indmapid FROM trial where id=TrialId;
   SELECT type,code,short_desc INTO indtype,tacode,shortdesc FROM indmap WHERE id=indmapid;
   IF indtype='Therapeutic Area' THEN
     RETURN tacode;
   ELSE
     RETURN shortdesc;
   END IF;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_LATEST_BUILD (TrialId in number) return VARCHAR2 as
 builddate DATE;
begin
   SELECT max(bl.released_date) INTO builddate
   FROM  build_tag_to_client_div  bl, client_div d, trial t, trial_budget b
   WHERE b.trial_id=TrialId AND t.client_div_id=d.id
   AND bl.client_div_id=d.id AND b.build_tag_id=bl.build_tag_id;
   RETURN builddate;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_TA_NAME (TrialId in number) return VARCHAR2 as
indtype varchar2(30);
tacode varchar2(256);
shortdesc varchar2(256);
indmapid number;
begin
   SELECT indmap_id INTO indmapid FROM trial where id=TrialId;
   SELECT type,code INTO indtype,tacode FROM indmap WHERE id=indmapid;
   IF indtype='Indication' THEN
     SELECT code INTO tacode FROM indmap
     WHERE LEVEL=3 CONNECT BY id= PRIOR parent_indmap_id
                   START WITH id=indmapid;
   ELSIF indtype='Indication Group' THEN
     SELECT code INTO tacode FROM indmap
     WHERE LEVEL=2 CONNECT BY id= PRIOR parent_indmap_id
                   START WITH id=indmapid;
   END IF;
   RETURN tacode;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_TRIAL_AUTHOR (TrialId in number) return  VARCHAR2 AS
retname varchar2(256):=NULL;
lastname VARCHAR(128):=NULL; 
firstname VARCHAR(128):=null;
BEGIN
  SELECT f.last_name||', '||f.first_name INTO retname FROM ftuser f, picase_trial p, trial t
  WHERE p.trial_id=t.id AND f.id=p.creator_ftuser_id AND t.id=TrialId;
  RETURN retname;
end;
/
 

  CREATE OR REPLACE FUNCTION GM30_TRIAL_LOCK (TrialId in number, FtuserId in number) return VARCHAR2 as
cnt        number;
begin
   SELECT count(*) INTO cnt FROM trial_budget 
   WHERE trial_id=TrialId AND locking_ftuser_id IS NOT NULL
   AND locking_ftuser_id!=FtuserId;

   IF cnt > 0 THEN
     RETURN (2);
   END IF;

   SELECT count(*) INTO cnt FROM trial_budget 
   WHERE trial_id=TrialId AND locking_ftuser_id IS NOT NULL
   AND locking_ftuser_id=FtuserId;
   IF cnt > 0 THEN
     RETURN (1);
   END IF;
   
   SELECT count(*) INTO cnt FROM trial_budget 
   WHERE trial_id=TrialId AND locking_ftuser_id IS NOT NULL;
   IF cnt = 0 THEN
     RETURN (3);
   END IF;

end;
/
 

--Implemented upto this in devl,d002,d003 on 01/13/2010
--Implemented upto this in q002 on 01/13/2010
--Implemented upto this in perf on 01/13/2010

--As per Frank's request on 01/14/2010
CREATE OR REPLACE FUNCTION GM30_INDICATION_NAME (TrialId in number) return VARCHAR2 as
indtype varchar2(30);
tacode varchar2(256);
shortdesc varchar2(256);
indmapid number;
begin
   SELECT indmap_id INTO indmapid FROM trial where id=TrialId;
   SELECT type,code,short_desc INTO indtype,tacode,shortdesc FROM indmap WHERE id=indmapid;
   IF indtype='Therapeutic Area' THEN
     RETURN tacode;
   ELSE
     RETURN tacode||'-'||shortdesc;
   END IF;
end;
/

--Implemented upto this in devl,d002,d003 on 01/14/10


--As per DB's request on 01/15/10
Update currency set viewable_flg = 1 where id in (select currency_id from country where is_viewable=1 or is_mdsol_viewable=1);
Commit;


--Implemented upto this in devl,d002,d003 on 01/15/10
--Implemented upto this in q002 and perf on 01/15/10

--As per Frank's request on 01/18/2010
ALTER TABLE gm_budget_group  MODIFY(total_cost_pvb NUMBER(19,2),  total_cost_no_oh NUMBER(19,2), total_cost_pvb_no_oh NUMBER(19,2));  

--Implemented upto this in devl,d002,d003 on 01/15/10


--As per Frank's request on 01/18/2010

ALTER TABLE gm_budget_group  MODIFY(cost_per_patient       NUMBER(19,2),cost_per_visit         NUMBER(19,2),
                                    total_cost_low         NUMBER(19,2),total_cost_med         NUMBER(19,2),
                                    total_cost_high        NUMBER(19,2),total_cost_co          NUMBER(19,2),
                                    total_cost_pvb_low     NUMBER(19,2),total_cost_pvb_med     NUMBER(19,2),
                                    total_cost_pvb_high    NUMBER(19,2),total_cost_pvb_co      NUMBER(19,2),
                                    avg_cpp_low            NUMBER(19,2),avg_cpp_med            NUMBER(19,2),
                                    avg_cpp_high           NUMBER(19,2),avg_cpp_company        NUMBER(19,2));

ALTER TABLE tsm_trial_rollup  MODIFY(COST_PER_PATIENT  NUMBER(19,2),COST_PER_VISIT  NUMBER(19,2));


--Implemented upto this in devl,d002,d003 on 01/19/10
--Implemented upto this in q002 and perf on 01/19/10

--As per Frank's request on 01/19/2010
ALTER TABLE trial_budget MODIFY(AVG_CPP_LOW                  NUMBER(19,2),
AVG_CPP_MED                  NUMBER(19,2),
AVG_CPP_HIGH                 NUMBER(19,2),
AVG_CPP_COMPANY              NUMBER(19,2),
AVG_CPP_SELECTED             NUMBER(19,2),
AVG_CPP_SELECTED_LOCAL       NUMBER(19,2),
TOTAL_COST_PVB               NUMBER(19,2),
TOTAL_COST_NO_OH             NUMBER(19,2),
TOTAL_COST_NO_OH_LOCAL       NUMBER(19,2),
fixed_scr_fail_cost          NUMBER(19,2),
TOTAL_COST_PVB_NO_OH         NUMBER(19,2),
TOTAL_COST_PVB_NO_OH_LOCAL   NUMBER(19,2),
TOTAL_COST_LOW               NUMBER(19,2),
TOTAL_COST_MED               NUMBER(19,2),
TOTAL_COST_HIGH              NUMBER(19,2),
TOTAL_COST_CO                NUMBER(19,2),
TOTAL_COST_PVB_LOW           NUMBER(19,2),
TOTAL_COST_PVB_MED           NUMBER(19,2),
TOTAL_COST_PVB_HIGH          NUMBER(19,2),
TOTAL_COST_PVB_CO            NUMBER(19,2) );

ALTER TABLE trial_budget MODIFY(TOTAL_COST NUMBER(19,2), TOTAL_COST_LOCAL NUMBER(19,2), TOTAL_COST_PVB_LOCAL NUMBER(19,2));
ALTER TABLE gm_budget_group MODIFY(TOTAL_COST NUMBER(19,2));
ALTER TABLE tsm_trial_rollup  MODIFY(TOTAL_COST_PVB  NUMBER(19,2),TOTAL_COST  NUMBER(19,2));
--******************************************************
--Implemented upto this in devl,d002,d003 on 01/19/10
--Implemented upto this in q002 and perf on 01/20/10
--Modified to 19,2 on 01/21/2010
--Implemented upto this in q003 on 01/28/2010
--******************************************************
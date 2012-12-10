--As per Phil's request on 03/16/2011

ALTER TABLE gm_client_defaults ADD(qpl_enabled  NUMBER(1)  DEFAULT 0 NOT NULL);


--Implemented upto this in devl,d003,d004,d005,d007 on 03/16/2011
--Implemented upto this in q005 on 03/24/2011


create or replace
FUNCTION find_freq ( v_indmapid IN NUMBER, v_phaseid in NUMBER, v_buildtagid IN NUMBER, v_procid in NUMBER)
                                          RETURN NUMBER AS
table_name1 VARCHAR2(100);
table_name2 VARCHAR2(100);
v_result NUMBER(5,2);
v_mapperid NUMBER(10);
query1 varchar2(100);
query2 varchar2(200);
BEGIN
v_result:= NULL;
table_name1:='tsm10_'||v_buildtagid||'.mapper';
table_name2:='tsm10_'||v_buildtagid||'.gm_proc_freq';
query1 := 'SELECT id FROM '||table_name1||' WHERE procedure_def_id='||v_procid;
EXECUTE IMMEDIATE query1 INTO v_mapperid;
query2 := 'SELECT (proc_cnt/trial_cnt)*100 FROM '||table_name2||' WHERE mapper_id='||v_mapperid||' AND indmap_id='||v_indmapid||' AND phase_id='||v_phaseid;
EXECUTE IMMEDIATE query2 INTO v_result;
RETURN v_result;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
     RETURN v_result;
END;
/
sho err

--Implemented upto this in devl, q005
--Implemented upto this in d003,d004,d005,d007 on 04/07/2011

-- created as per request of Phil on 4/21/2011

CREATE OR REPLACE FUNCTION check_country_group ( v_countryid IN NUMBER)
                                          RETURN NUMBER AS

v_result NUMBER(1);

BEGIN
v_result:= 1;

SELECT 2 INTO v_result FROM dual
WHERE v_countryid IN (SELECT distinct group_country_id FROM country);

RETURN v_result;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
     RETURN v_result;
END;
/
sho err

--Implemented upto this in devl,d002,d003,d004,d005,d007,q002,q005 on 04/07/2011
-- Following as per request pf Phil on 4/22/2011 at 6:46 am

create or replace view v_qpl_indmap_search as
select a.id ta_id,a.code Ther_area, b.id indgrp_id, b.code ind_group, c.id indication_id, c.code indication,
      decode(c.short_desc,null,b.short_desc,c.short_desc) short_desc from
      (select id,code,short_desc from indmap where type='Therapeutic Area') a,
      (select id,parent_indmap_id,code,short_desc from indmap where type='Indication Group') b,
      (select id,parent_indmap_id,code,short_desc from indmap where type='Indication') c where
      c.parent_indmap_id(+) = b.id and
      b.parent_indmap_id = a.id and 
      (Lower(c.short_desc) like Lower('%migraine%')
      OR Lower(c.code) LIKE Lower('%migraine%'))
union all 
      select id ta_id,code Ther_area,null,null,null,NULL,null from indmap 
      where type='Therapeutic Area' and lower(code) like  lower('%migraine%')
union all
       select a.id,a.code, b.id, b.code, null,NULL,null from 
       (select id,code,short_desc from indmap where type='Therapeutic Area') a,
       (select id,parent_indmap_id,code,short_desc from indmap where type='Indication Group') b
       where b.parent_indmap_id = a.id and lower(b.code) like Lower('%migraine%')
order by 2,4,6;

create or replace view v_qpl_indmap_search as
select a.id ta_id,a.code Ther_area, b.id indgrp_id, b.code ind_group, c.id indication_id, c.code indication,
      decode(c.short_desc,null,b.short_desc,c.short_desc) short_desc from
      (select id,code,short_desc from indmap where type='Therapeutic Area') a,
      (select id,parent_indmap_id,code,short_desc from indmap where type='Indication Group') b,
      (select id,parent_indmap_id,code,short_desc from indmap where type='Indication') c where
      c.parent_indmap_id(+) = b.id and
      b.parent_indmap_id = a.id;

--Implemented upto this in devl,d002,d003,d004,d005,d007,q002,q005 on 04/22/2011

-- Following changes are as per request of Phil on 6/21/2011 at 11:30am

alter table audit_hist drop constraint audit_hist_app_type_check;
ALTER TABLE audit_hist   ADD CONSTRAINT audit_hist_app_type_check CHECK ( app_type in
('DASHBOARD','PICASE','TRACE','TSPD','FTADMIN','CROCAS','PBTOWN','GMOWN','TSN','DGW','GM30','UNKNOWN','DMS','QPL')
);


create table GM_ftuser_session(
id number(10),
ftuser_id number(10) not null,
session_id varchar2(256)) 
tablespace tsmsmall pctfree 5;

Alter table GM_ftuser_session add constraint GM_ftuser_session_pk 
	primary key (id) using index tablespace 
	tspdsmall_indx pctfree 5;

Alter table GM_ftuser_session add constraint GM_ftuser_session_fk1
	foreign key (ftuser_id) references 
	ftuser(id);

Alter table GM_ftuser_session add constraint GM_ftuser_session_uq1
        unique (ftuser_id) using index tablespace tsmsmall_indx pctfree 5;

insert into id_control values('tsm10','gm_ftuser_session',1);
commit;

--******************************************************************************
--Implemented upto this in devl,d002,d003,d005,d007,q002,q005 on 06/21/2011
--Implemented upto this in q003,demo on 06/24/2011
--Implemented upto this in prod on 07/05/2011
--******************************************************************************


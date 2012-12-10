--As per Phil request
--First request 01/24/12
alter table TSM10.PHASE add(uuid VARCHAR2(128) default 0);
alter table TSM10.indmap add(uuid VARCHAR2(128) default 0);
alter table TSM10.country add(uuid VARCHAR2(128) default 0);
alter table TSM10.procedure_def add(uuid VARCHAR2(128) default 0);
alter table TSM10.odc_def add(uuid VARCHAR2(128) default 0);
alter table tsm10.gm_client_defaults add (soc_enabled number(1) default 0);
--Phils request
--2nd request on 02/04/12
alter table TSM10.procedure_def_ext
add (procedure_def_uuid varchar2(128));

alter table TSM10.odc_def_ext
add (odc_def_uuid varchar2(128));

update TSM10.procedure_def_ext a
set procedure_def_uuid=(select uuid from
                           TSM10.procedure_def b where a.procedure_def_id=b.id);
                           
update TSM10.odc_def_ext a
set odc_def_uuid=(select uuid from
                           TSM10.odc_def b where a.odc_def_id=b.id);

commit;
 ---Below block watch out for error table or view does not exist .If you encounter this error
---please execute below block manually.
 declare
  v_id varchar2(10);
  v_sql1 VARCHAR2(500);
  v_sql2 VARCHAR2(500);
  v_sql3 VARCHAR2(500);
  v_update1 varchar2(500);
  v_update2 varchar2(500);
  v_update3 varchar2(500);
  begin
  select max(id) into v_id from tsm10.build_tag;
  
  v_sql1:=' alter table tsm10_'||v_id||'.gm_proc_freq add (uuid varchar2(128))';
  v_sql2:=' alter table tsm10_'||v_id||'.pap_clinical_proc_cost add (uuid varchar2(128))';
  v_sql3:=' alter table tsm10_'||v_id||'.industry_pap_odc_cost add (uuid varchar2(128))';

 v_update1:='update tsm10_'||v_id||'.gm_proc_freq a 
                                     set uuid=(select c.uuid from
                                         tsm10.mapper b,TSM10.procedure_def c
                                              where a.mapper_id=b.id 
                                                    and c.id=b.procedure_def_id)  ';

 v_update2:='update tsm10_'||v_id||'.pap_clinical_proc_cost a 
                                     set uuid=(select c.uuid from
                                         tsm10.mapper b,TSM10.procedure_def c
                                              where a.mapper_id=b.id 
                                                    and c.id=b.procedure_def_id)  ';


 v_update3:='update tsm10_'||v_id||'.industry_pap_odc_cost a 
                                     set uuid=(select c.uuid from
                                         tsm10.mapper b,TSM10.odc_def c
                                              where a.mapper_id=b.id 
                                                    and c.id=b.odc_def_id)  ';

                                                     execute immediate v_sql1; 
  						     execute immediate v_sql1; 
  						     execute immediate v_sql1; 
                                                    execute immediate v_update1;
                                                   execute immediate v_update2;
                                                    execute immediate v_update3;
                                                    commit;
                                                  
  end ;
/

--********************************************
--Implemented on DEVL,D003,D005,Q003 till here
--**********************************************                       
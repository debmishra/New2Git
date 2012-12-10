conn tsm10p/welcome@prev

drop database link mylink;

create database link mylink connect to 
tsm10t identified by kra8gpwl using 'prod';


declare

 lil_prod_id number(10);
 lil_prod_userid number(10);
 
 cursor c1 is select id from tspd_lib_bucket where
 client_div_id in (select id from client_div where
 client_div_identifier='NOV_TRAIN');

 prod_lib_bucket_max_id  number(10);
 prod_lib_element_max_id number(10);

begin

 select id into lil_prod_id from  client_div@mylink where client_div_identifier='NOV_TRAIN';
  select id into lil_prod_userid from  ftuser@mylink where name='pabramowitsch@NOV_TRAIN';
 select nvl(max(id),0)+1 into prod_lib_bucket_max_id from tspd_lib_bucket@mylink;
 select nvl(max(id),0)+1 into prod_lib_element_max_id from tspd_lib_element@mylink;

for ix1 in c1 loop

  insert into tspd_lib_bucket@mylink select prod_lib_bucket_max_id,name,create_date,
  lil_prod_id,last_updated,version_timestamp from tspd_lib_bucket where
  id=ix1.id;
  declare
    cursor c3 is select id from tspd_lib_element where
    tspd_lib_bucket_id=ix1.id;
  begin
    for ix3 in c3 loop
      insert into tspd_lib_element@mylink select prod_lib_element_max_id, 
       prod_lib_bucket_max_id,name,create_date,content_type,lil_prod_userid,
       content_subtype, filename, data, tooltip, filepath, inline_data from
       tspd_lib_element where id=ix3.id;
       prod_lib_element_max_id:=prod_lib_element_max_id+1;
    end loop;
  end;   
 prod_lib_bucket_max_id:=prod_lib_bucket_max_id+1;
end loop;


update id_control@mylink set next_id=prod_lib_bucket_max_id where
table_name='tspd_lib_bucket';
update id_control@mylink set next_id=prod_lib_element_max_id where
table_name='tspd_lib_element';

end;
/

declare
 clientdiv_id number(10);
 ftuserid number(10);
 ftuser_name varchar2(128):='pabramowitsch@NOV_TRAIN';
 criteria_set_maxid number(10);
 criteria_set_item_maxid number(10);
 criteria_maxid number(10);
 cursor c1 is select id from criteria_set where id in (211);
begin
 select id into clientdiv_id from client_div@mylink where client_div_identifier='NOV_TRAIN';
 select id into ftuserid from  ftuser@mylink where name=ftuser_name;
 select nvl(max(id),0)+1 into criteria_set_maxid from criteria_set@mylink;
 select nvl(max(id),0)+1 into criteria_set_item_maxid from criteria_set_item@mylink;
 select nvl(max(id),0)+1 into criteria_maxid from criteria@mylink;

 for ix1 in c1 loop
   Insert into criteria_set@mylink select criteria_set_maxid, name, create_date,
   clientdiv_id, ftuserid, version_timestamp from criteria_set where id=ix1.id;

   declare
    cursor c2 is select id, criteria_id from criteria_set_item where
    criteria_set_id=ix1.id;   
   begin
    for ix2 in c2 loop 
      insert into criteria@mylink select criteria_maxid,clientdiv_id,type,short_desc,
         long_desc, rationale, other_desc,CLASSIFIER,OTHER_CLASSIFIER_DESC
         from criteria where id=ix2.criteria_id;
      insert into criteria_set_item@mylink values(criteria_set_item_maxid,
         criteria_set_maxid,criteria_maxid);
      criteria_set_item_maxid:=criteria_set_item_maxid+1;
      criteria_maxid:=criteria_maxid+1;
    end loop;
   end;
 criteria_set_maxid:=criteria_set_maxid+1; 
 end loop;

 update id_control@mylink set next_id=criteria_set_maxid where 
 table_name='criteria_set';
 update id_control@mylink set next_id=criteria_set_item_maxid where 
 table_name='criteria_set_item';
 update id_control@mylink set next_id=criteria_maxid where 
 table_name='criteria';

end;
/

declare
 clientdiv_id number(10);
 ftuserid number(10);
 ftuser_name varchar2(128):='mmoore@LIL';
 criteria_set_maxid number(10);
 criteria_set_item_maxid number(10);
 criteria_maxid number(10);
 cursor c1 is select id from criteria_set where id in (171,173);
begin
 select id into clientdiv_id from client_div@mylink where client_div_identifier='LIL';
 select id into ftuserid from  ftuser@mylink where name=ftuser_name;
 select nvl(max(id),0)+1 into criteria_set_maxid from criteria_set@mylink;
 select nvl(max(id),0)+1 into criteria_set_item_maxid from criteria_set_item@mylink;
 select nvl(max(id),0)+1 into criteria_maxid from criteria@mylink;

 for ix1 in c1 loop
   Insert into criteria_set@mylink select criteria_set_maxid, name, create_date,
   clientdiv_id, ftuserid, version_timestamp from criteria_set where id=ix1.id;

   declare
    cursor c2 is select id, criteria_id from criteria_set_item where
    criteria_set_id=ix1.id;   
   begin
    for ix2 in c2 loop 
      insert into criteria@mylink select criteria_maxid,clientdiv_id,type,short_desc,
      long_desc, rationale, other_desc,CLASSIFIER,OTHER_CLASSIFIER_DESC 
      from criteria where id=ix2.criteria_id;
      insert into criteria_set_item@mylink values(criteria_set_item_maxid,
      criteria_set_maxid,criteria_maxid);
      criteria_set_item_maxid:=criteria_set_item_maxid+1;
      criteria_maxid:=criteria_maxid+1;
    end loop;
   end;
 criteria_set_maxid:=criteria_set_maxid+1; 
 end loop;

 update id_control@mylink set next_id=criteria_set_maxid where 
 table_name='criteria_set';
 update id_control@mylink set next_id=criteria_set_item_maxid where 
 table_name='criteria_set_item';
 update id_control@mylink set next_id=criteria_maxid where 
 table_name='criteria';

end;
/



drop database link mylink;

-- Following was done to move lib items back to test database as per
-- request of Henry on 01/13/2003

conn tsm10/welcome@test

create database link mylink connect to 
tsm10t identified by kra8gpwl using 'prod';


declare

 pkd_prev_id number(10);
 pkd_prev_userid number(10);
 pkd_username varchar2(128):='hkingdon';

 cursor c1 is select id from tspd_lib_bucket@mylink;

 prev_lib_bucket_max_id  number(10);
 prev_lib_element_max_id number(10);

begin

 select id into pkd_prev_id from  client_div where client_div_identifier='PKD';
 select id into pkd_prev_userid from  ftuser where name=pkd_username||'@PKD';



for ix1 in c1 loop
  select  increment_sequence('tspd_lib_bucket_seq') into prev_lib_bucket_max_id from dual;
  insert into tspd_lib_bucket select prev_lib_bucket_max_id,name,create_date,
  pkd_prev_id,last_updated,version_timestamp from tspd_lib_bucket@mylink where
  id=ix1.id;
  declare
    cursor c3 is select id from tspd_lib_element@mylink where
    tspd_lib_bucket_id=ix1.id;
  begin
    for ix3 in c3 loop

      select  increment_sequence('tspd_lib_element_seq') into prev_lib_element_max_id from dual;

      insert into tspd_lib_element select prev_lib_element_max_id, 
       prev_lib_bucket_max_id,name,create_date,content_type,pkd_prev_userid,
       content_subtype, filename, data, tooltip, filepath, inline_data from
       tspd_lib_element@mylink where id=ix3.id;
     end loop;
  end;   
end loop;


end;
/

drop database link mylink;

-- Following procedure was created on 02-02-2004 to copy custom_sets from preview to beta
declare

target_client_div varchar2(20):='NOV_TRAIN';
source_client_div varchar2(20):='NOV_TRAIN';
target_user varchar2(128):='pabramowitsch@NOV_TRAIN';

cursor c1 is select id from custom_set where client_div_id in
(select id from client_div where client_div_identifier=source_client_div);

target_custom_set_maxid number(10);
target_custom_set_item_maxid number(10);

target_client_div_id number(10);
target_userid number(10);

begin

select nvl(max(id),0)+1 into target_custom_set_maxid  from custom_set@mylink;
select nvl(max(id),0)+1 into target_custom_set_item_maxid  from custom_set_item@mylink;

select id into target_client_div_id from client_div@mylink 
	where client_div_identifier=target_client_div;
select id into target_userid from ftuser@mylink where name=target_user;


for ix1 in c1 loop

   Insert into custom_set@mylink select target_custom_set_maxid,name,create_dt,
      target_client_div_id, type, target_userid, version_timestamp from custom_set
      where id=ix1.id;

      declare
	cursor c2 is select id from custom_set_item where custom_set_id=ix1.id and
        unlisted_procedure_id is not null;
	cursor c3 is select id from custom_set_item where custom_set_id=ix1.id and
        procedure_def_id is not null; 
	cursor c4 is select id from custom_set_item where custom_set_id=ix1.id and
        odc_def_id is not null; 
        
        target_procedure_def_id number(10);
        target_odc_def_id number(10);
        target_unlisted_procedure_id number(10);

      begin

         for ix2 in c2 loop

            select id into target_unlisted_procedure_id from unlisted_procedure@mylink
            where name = (select name from unlisted_procedure where id = (select
            UNLISTED_PROCEDURE_ID from custom_set_item where id=ix2.id))
            and client_id = (select client_id from client_div@mylink where
            client_div_identifier=target_client_div);

            Insert into custom_set_item@mylink select target_custom_set_item_maxid,
	    target_custom_set_maxid,target_unlisted_procedure_id,null,null,price,short_desc,long_desc 
	    from custom_set_item where id = ix2.id;
            
	    target_custom_set_item_maxid:=target_custom_set_item_maxid+1;


         end loop;

         for ix3 in c3 loop

            select id into target_procedure_def_id from procedure_def@mylink
            where cpt_code = (select cpt_code from procedure_def where id = (select
            PROCEDURE_DEF_ID from custom_set_item where id=ix3.id));

            Insert into custom_set_item@mylink select target_custom_set_item_maxid,
	    target_custom_set_maxid,null,null,target_procedure_def_id,price,short_desc,long_desc 
	    from custom_set_item where id =ix3.id;

	    target_custom_set_item_maxid:=target_custom_set_item_maxid+1;

         end loop;

         for ix4 in c4 loop

            select id into target_odc_def_id from odc_def@mylink
            where picas_code = (select picas_code from odc_def where id = (select
            ODC_DEF_ID from custom_set_item where id=ix4.id));

            Insert into custom_set_item@mylink select target_custom_set_item_maxid,
	    target_custom_set_maxid,null,target_odc_def_id,null,price,short_desc,long_desc 
	    from custom_set_item where id =ix4.id;

	    target_custom_set_item_maxid:=target_custom_set_item_maxid+1;

         end loop;
      end;

 target_custom_set_maxid:=target_custom_set_maxid+1;

 end loop;

 update id_control@mylink set next_id=target_custom_set_maxid where 
 table_name='custom_set';
 update id_control@mylink set next_id=target_custom_set_item_maxid where 
 table_name='custom_set_item';

end;
/

 -- copy only study variable and variable mapping where there is no custom_task


declare

 source_client_div varchar2(80):='HLR_PHARM';
 target_client_div varchar2(80):='HLR_PHARM_PROD';

 cursor c1 is select id from tspd_study_variable where client_div_id=(select id from client_div where
                                                                      client_div_identifier=source_client_div);
 target_client_div_id number(10);
 tsv_id number(10);
 
begin
  select id into target_client_div_id from client_div where client_div_identifier=target_client_div;

  for ix1 in c1 loop

    select increment_sequence('tspd_study_variable_seq') into tsv_id from dual;

    Insert into tspd_study_variable(ID,CLIENT_DIV_ID,SHORT_DESC,ACRONYM,LONG_DESC,CODE1,CODING_SYSTEM1_ID,
				    CODE2,CODING_SYSTEM2_ID,UOM_ID,UOM_SHORT_DESC,MIN_VALID,MAX_VALID,
				    OBSOLETE_FLG,CODE3,CODING_SYSTEM3_ID,DEFINITION,LOW_NORMAL,
				    HIGH_NORMAL,DATA_TYPE,DIMENSION,ORIGIN,ORIGINATION_METHOD,ORIGINATION_FUNC)
    select tsv_id,target_client_div_id,SHORT_DESC,ACRONYM,LONG_DESC,CODE1,CODING_SYSTEM1_ID,
				    CODE2,CODING_SYSTEM2_ID,UOM_ID,UOM_SHORT_DESC,MIN_VALID,MAX_VALID,
				    OBSOLETE_FLG,CODE3,CODING_SYSTEM3_ID,DEFINITION,LOW_NORMAL,
				    HIGH_NORMAL,DATA_TYPE,DIMENSION,ORIGIN,ORIGINATION_METHOD,ORIGINATION_FUNC
    from tspd_study_variable where id=ix1.id;


       declare
         cursor c2 is select id from tspd_variable_mapping where study_variable_id=ix1.id 
			and client_div_id=(select id from client_div where
                        client_div_identifier=source_client_div);
       begin
          for ix2 in c2 loop

             insert into  tspd_variable_mapping(ID,CLIENT_DIV_ID,PROCEDURE_DEF_ID,CUSTOM_TASK_ID,
				STUDY_VARIABLE_ID,OBSOLETE_FLG,COMMENTS)
   	     select increment_sequence('tspd_variable_mapping_seq'),target_client_div_id,
				PROCEDURE_DEF_ID,CUSTOM_TASK_ID,tsv_id,OBSOLETE_FLG,COMMENTS
	     from tspd_variable_mapping where id=ix2.id;
          end loop;
       end;
    end loop;
end;
/


-- copy all study variable and variable mapping from prod to prev and set custom_task as null


drop database link mylink;

create database link mylink connect to tsm10 identified by 
kra8gpwl using 'prod';

declare

target_clientdivid	number(10);
source_clientdivid	number(10);
study_variable_nextid number(10);

cursor c1 is select id from tspd_study_variable@mylink where
client_div_id=source_clientdivid and upper(acronym)
not in (select upper(acronym) from tspd_study_variable 
where client_div_id=target_clientdivid);

begin

select id into source_clientdivid from client_div@mylink where 
client_div_identifier='FTD';

select id into target_clientdivid from client_div where 
client_div_identifier='FTD2';

for ix1 in c1 loop

select increment_sequence('tspd_study_variable_seq')
into study_variable_nextid from dual;

Insert into tspd_study_variable select study_variable_nextid,target_clientdivid,
SHORT_DESC,ACRONYM,LONG_DESC,CODE1,CODING_SYSTEM1_ID,
CODE2,CODING_SYSTEM2_ID,UOM_ID,UOM_SHORT_DESC,MIN_VALID,
MAX_VALID,OBSOLETE_FLG,CODE3,CODING_SYSTEM3_ID,DEFINITION,
LOW_NORMAL,HIGH_NORMAL,DATA_TYPE,DIMENSION,ORIGIN,
ORIGINATION_METHOD,ORIGINATION_FUNC from tspd_study_variable@mylink
where id=ix1.id;

Insert into tspd_variable_mapping select 
increment_sequence('tspd_variable_mapping_seq'),target_clientdivid,
c.id, null, study_variable_nextid,a.obsolete_flg, a.comments
from tspd_variable_mapping@mylink a, procedure_def@mylink b,
procedure_def c where a.procedure_def_id=b.id and
b.cpt_code=c.cpt_code and a.study_variable_id=ix1.id;

end loop; 

end;
/

drop database link mylink;

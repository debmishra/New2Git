DROP PROCEDURE IF EXISTS iir.load_activities;
CREATE PROCEDURE iir.`load_activities`()
BEGIN
declare exit_flag,v_count,inserted_rows int default 0;
declare v_uuid,v_cptcode,v_long_desc,v_proc_level,v_short_dec,v_type,v_value varchar(1001);
DECLARE c1 cursor for
select uuid, cpt_code, long_desc, procedure_level, short_desc, 'Procedure' 
from tsm10.procedure_def where obsolete_flg=0 and hide=0
union
select uuid, picas_code, long_desc, procedure_level, short_desc, 'ODC' 
from tsm10.odc_def where obsolete_flg=0 and hide=0;
DECLARE c2 cursor for
select procedure_def_uuid  uuid, value from tsm10.procedure_def_ext where client_div_id=-1 and procedure_ext_meta_oid like 'synonym%'
union
select odc_def_uuid  uuid, value from tsm10.odc_def_ext where client_div_id=-1 and procedure_ext_meta_oid like 'synonym%';
DECLARE CONTINUE HANDLER for SQLSTATE '02000' set exit_flag=1;
OPEN c1;
fetch_loop:loop
fetch c1 into v_uuid,v_cptcode,v_long_desc,v_proc_level,v_short_dec,v_type;
IF exit_flag then leave fetch_loop; END IF;
select count(*) into v_count from iir.activities
where uuid=v_uuid
and cpt_code=v_cptcode;

if v_count=0 then

insert into iir.activities(uuid,cpt_code,long_desc,level,short_desc,type) values
(v_uuid,v_cptcode,v_long_desc,v_proc_level,v_short_dec,v_type);

set inserted_rows=inserted_rows+1;

end if;
END LOOP;
INSERT into iir.data_load_history(tables_name,num_inserted,num_updated) values 
('Activities', inserted_rows,0);
CLOSE c1;
set inserted_rows=0;
set exit_flag=0;
OPEN c2;
fetch_loop:loop
fetch c2 into v_uuid,v_value;
IF exit_flag then leave fetch_loop; END IF;
select count(*) into v_count from iir.activities_synonyms
where activities_uuid=v_uuid;

if v_count=0 then

insert into iir.activities_synonyms(activities_uuid,value) values
(v_uuid,v_value);

set inserted_rows=inserted_rows+1;

end if;
END LOOP;
INSERT into iir.data_load_history(tables_name,num_inserted,num_updated) values 
('Activities_Synonyms', inserted_rows,0);
CLOSE c2;

 

END;

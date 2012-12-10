DROP PROCEDURE IF EXISTS iir.load_indications;
CREATE PROCEDURE iir.`load_indications`()
BEGIN
declare row_exists,v_id int;
declare inserted_rows,exit_flag int default 0;
declare v_code,v_short_desc,v_uuid,v_indgrp,v_ther_area varchar(1000);
declare c1 cursor for
select  a.id,a.code, a.short_desc, a.uuid, b.short_desc as indication_group, c.code as therapeutic_area 
from tsm10.indmap a, tsm10.indmap b, tsm10.indmap c 
where b.id=a.parent_indmap_id 
and c.id=b.parent_indmap_id;
DECLARE CONTINUE HANDLER for SQLSTATE '02000' SET exit_flag=1;
OPEN c1;
fetch_loop:loop
FETCH c1 into v_id,v_code,v_short_desc,v_uuid,v_indgrp,v_ther_area;
IF exit_flag then leave fetch_loop; END IF;

select count(*) into row_exists from iir.indications
where id=v_id;
IF row_exists=0 THEN
insert into iir.indications  (id,code,short_desc,uuid,
indication_group,therapeutic_area) values
(v_id,v_code,v_short_desc,v_uuid,v_indgrp,v_ther_area);
set inserted_rows=inserted_rows+1;
END IF;
END LOOP;
CLOSE c1;
INSERT into iir.data_load_history(tables_name,num_inserted,num_updated) values 
('Indications', inserted_rows,0);
 
END;
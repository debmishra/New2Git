drop procedure iir.load_countries;
CREATE PROCEDURE iir.load_countries()
begin
declare row_exists,v_id int;
 declare inserted_rows int default 0;
  declare v_name,v_abb,v_uuid,done text(1000);

declare c1 cursor  for
select id,uuid, name, iso_3166 as abbreviation  from tsm10.country where is_mdsol_viewable=1;
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
 open c1;
read_loop:loop
fetch c1 into v_id,v_uuid,v_name,v_abb;
select count(*)  into row_exists from iir.countries where name=v_name 
and abbreviation=v_abb
and id=v_id;

IF done THEN
      LEAVE read_loop;
      end if;
      
if row_exists=0 then
insert into iir.countries(id,uuid,name,abbreviation)  
values (v_id,v_uuid,v_name,v_abb);
set inserted_rows=inserted_rows+1;
end if;

end loop;
close c1;
Insert into iir.data_load_history(table_name,num_inserted,num_updated) values 
 ('Countries',inserted_rows,0);

end;

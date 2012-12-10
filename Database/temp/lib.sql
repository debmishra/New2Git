declare

 avtbeta_id number(10);
 avtbeta_userid number(10);
 avtusername varchar2(128):='mmoore';

 cursor c2 is select id from tspd_lib_bucket where
 client_div_id in (select id from client_div where
 client_div_identifier='AVT');

 beta_lib_bucket_max_id  number(10);
 beta_lib_element_max_id number(10);

begin

 select id into avtbeta_id from  client_div@mylink where client_div_identifier='AVT';
 select id into avtbeta_userid from  ftuser@mylink where name=avtusername||'@AVT';
 select nvl(max(id),0)+1 into beta_lib_bucket_max_id from tspd_lib_bucket@mylink;
 select nvl(max(id),0)+1 into beta_lib_element_max_id from tspd_lib_element@mylink;

for ix2 in c2 loop

  insert into tspd_lib_bucket@mylink select beta_lib_bucket_max_id,name,create_date,
  avtbeta_id,last_updated,version_timestamp from tspd_lib_bucket where
  id=ix2.id;
  declare
    cursor c4 is select id from tspd_lib_element where
    tspd_lib_bucket_id=ix2.id;
  begin
    for ix4 in c4 loop
      insert into tspd_lib_element@mylink select beta_lib_element_max_id, 
       beta_lib_bucket_max_id,name,create_date,content_type,avtbeta_userid,
       content_subtype, filename, data, tooltip, filepath, inline_data from
       tspd_lib_element where id=ix4.id;
       beta_lib_element_max_id:=beta_lib_element_max_id+1;
    end loop;
  end;   
 beta_lib_bucket_max_id:=beta_lib_bucket_max_id+1;
end loop;

update id_control@mylink set next_id=beta_lib_bucket_max_id where
table_name='tspd_lib_bucket';
update id_control@mylink set next_id=beta_lib_element_max_id where
table_name='tspd_lib_element';

end;

create table list_builds as select username from all_users
where username like user||'%' and length(username) >10;

set serveroutput on

declare

currbldtag number(3);
canbedeleted number(1);
clientdividentifier varchar2(10);
cursor c1 is select distinct client_div_id from build_tag_to_client_div;

begin

for ix1 in c1 loop

   select min(build_tag_id)-1 into currbldtag from build_tag_to_client_div
   where client_div_id=ix1.client_div_id;

   select client_div_identifier into clientdividentifier from client_div where
   id=ix1.client_div_id;

   loop 
    if  currbldtag=0 then 
      exit;
    end if;
      select count(*) into canbedeleted  from list_builds 
      where username=user||'_'||clientdividentifier||'_'||currbldtag ;
 
      if canbedeleted = 1 then
        dbms_output.put_line(user||'_'||clientdividentifier||'_'||currbldtag);
      end if;
    currbldtag:=currbldtag-1;
   end loop;
end loop;
end;
/
sho err
set serveroutput off

drop table list_builds;
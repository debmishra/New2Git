--*** Schema Changes for Designer GM3.1.1 ***--
--*** 01/10/2011                          ***--

--As per Phil's request on 01/10/2011

alter table ip_session add create_date date default sysdate;

Create or replace trigger ip_session_trg1
before insert on ip_session
for each row
begin
 :new.create_date:=sysdate;
end;
/
sho err;

--******************************************************
--Implemented upto this in devl on 01/11/2011
--Implemented upto this in d003 on 01/11/2011
--Implemented upto this in d005 on 01/11/2011
--Implemented upto this in d007 on 01/11/2011
--Implemented upto this in q002 on 01/11/2011
--Implemented upto this in q005 on 01/11/2011
--Implemented upto this in q004 on 05/18/2011
--******************************************************

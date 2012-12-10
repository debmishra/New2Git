-- Following changes are as per the email bug fix request by Lori on 11/08/2007 at 3pm

alter table client_div add fromft_email_flg NUMBER(1,0)  DEFAULT 0 NOT NULL;

--Deployed upto this in tsm10@devl
--Deployed upto this in tsm10e@test
--Deployed upto this in tsm10e@prev on 11/13 at 8:30am
--Deployed upto this in tsm10t@prev on 11/13 at 8:30am 

--Deployed upto this in tsm10e@prod on 11/17 at 8:30pm
--Deployed upto this in tsm10g@prod on 11/17 at 8:30pm
--Deployed upto this in tsm10@prod on 11/17 at 8:30pm
 

--Following changes are as per request of Tonya on 12-6-2007 at 10am
-- for CROCAS 1.02


Insert into ftgroup values (33,'CrocasOwn User');
Insert into ftgroup values (34,'GmOwn User');
commit;

update id_control set next_id=35 where table_name='ftgroup';
commit;

-- Following changes are to fix the very old bug on 12/14/2007 at 2:30pm

CREATE OR REPLACE TRIGGER client_div_to_lic_app_trg1
before insert or update of PRINCIPAL_CONTACT_ID
ON client_div_to_lic_app
referencing new as n old as o
for each row
declare
new_principal_contact_email varchar2(100);
old_principal_contact_email varchar2(100):=null;

begin

If :n.principal_contact_id is not null and :o.principal_contact_id is not null
 then
    select email into  new_principal_contact_email from ftuser where
    id=:n.principal_contact_id;

    select email into  old_principal_contact_email from ftuser where
    id=:o.principal_contact_id;

    If :n.alert_email is null or :o.alert_email = old_principal_contact_email
     then
       :n.alert_email:=new_principal_contact_email;
    end if;
end if;

If :n.principal_contact_id is not null and :o.principal_contact_id is null
 then
    select email into  new_principal_contact_email from ftuser where
    id=:n.principal_contact_id;

    If :n.alert_email is null   
     then
       :n.alert_email:=new_principal_contact_email;
    end if;
end if;
end;
/

--**************************************************** 
--Deployed upto this in tsm10@devl
--Deployed upto this in tsm10e@test
--Deployed upto this in tsm10e@prev on 12/8 at 8:30am
--Deployed upto this in tsm10t@prev on 12/8 at 8:30am 
--Deployed upto this in tsm10e@prod on 12/19/2007 at 5pm
--Deployed upto this in tsm10g@prod on 12/19/2007 at 5pm
--Deployed upto this in tsm10@prod on 12/19/2007 at 5pm

--**************************************************** 

alter table client_div add constraint CLIENT_DIV_FK9
foreign key (crocas_build_tag_id) references build_tag(id);


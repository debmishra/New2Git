--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: Copy_ft15_by_import.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:18:12 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table ftuser add constraint ftuser_fk4
	foreign key (client_div_id) references "&1".client_div(id);

Alter table trial add constraint trial_fk13 foreign key(client_div_id)
	references "&1".client_div(id);

Alter table trial add constraint trial_fk14 foreign key(project_area_id)
	references "&1".project_area(id);

Alter table trial add constraint trial_fk3
	foreign key (project_id) references "&1".project(id);

Alter table trial add constraint trial_fk4
	foreign key (indmap_id) references "&1".indmap(id);	

Alter table trial add constraint trial_fk5
	foreign key (phase_id) references "&1".phase(id);

Alter table trial add constraint trial_fk7
	foreign key (planning_currency_id) references "&1".currency(id);

CREATE OR REPLACE TRIGGER
ftuser_name_check_trg1
before insert or update on ftuser
referencing new as n old as o
for each row


declare
extension_v ftuser.name%type;
site_id_cnt  number(20);
client_id_cnt  number(20);
client_div_id_cnt number(10);
Invalid_site_id exception;
Invalid_client_id exception;
invalid_ftuser exception;
invalid_client_div_id exception;

begin

 If :n.name like '%@%' then

    extension_v:=substr(:n.name,instr(:n.name,'@')+1);

    If :n.site_id is not null then

        select count(*) into  site_id_cnt from site where site_identifier = extension_v;

        If site_id_cnt <1 then
           Raise Invalid_site_id;
        end if;
    elsif :n.client_id is not null and :n.client_div_id is null then

        select count(*) into client_id_cnt from client where client_identifier = extension_v;

        If client_id_cnt <1 then
           Raise Invalid_client_id;
        end if; 

    elsif :n.client_div_id is not null then

        select count(*) into client_div_id_cnt from "&1".client_div where client_div_identifier = extension_v;

        If client_div_id_cnt <1 then
           Raise Invalid_client_div_id;
        end if;


   end if;


 end if;

 If :n.site_id is not null and :n.client_id is not null then
    Raise invalid_ftuser;
 end if;


 If trim(:n.display_name) is null then
   :n.display_name:=initcap(:n.first_name)||' '||initcap(:n.last_name);
 end if;

Exception

  When Invalid_site_id then
       Raise_application_error(-20006,'Invalid site identifier attached with name');

  when Invalid_client_id then
       Raise_application_error(-20020,'Invalid client identifier attached with name');

  when Invalid_ftuser then
       Raise_application_error(-20042,'Both site_id and client_id can not exist together');

  when Invalid_client_div_id then
       Raise_application_error(-20102,'Invalid client division identifier attached with name');

end;
/
sho err




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:18:12 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:35:39 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:19:36 PM Debashish Mishra  
--  2    DevTSM    1.1         7/11/2002 4:32:04 PM Debashish Mishra  
--  1    DevTSM    1.0         6/4/2002 10:05:17 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

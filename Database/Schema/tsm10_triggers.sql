--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_triggers.sql$ 
--
-- $Revision: 15$        $Date: 2/22/2008 11:56:06 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


create or replace trigger custom_set_item_trg1
after insert or update of odc_def_id,procedure_def_id,unlisted_procedure_id  
on custom_set_item
referencing new as n old as o
for each row
declare

invalid_proc exception;
null_cnt number(2);

begin

   select decode(:n.odc_def_id,null,0,1)+decode(:n.procedure_def_id,null,0,1)+
	decode(:n.unlisted_procedure_id,null,0,1) into null_cnt from dual;

 
   If null_cnt > 1 then
	raise invalid_proc;
   end if;

exception

   when invalid_proc then
	
	Raise_application_error(-20102,'Can only refer to either odc_def or proc_def or unlisted_proc');
end;
/
sho err


create or replace trigger cost_item_trg2
after insert or update of odc_def_id,procedure_def_id,unlisted_procedure_id  
on cost_item
referencing new as n old as o
for each row
declare

invalid_proc exception;
null_cnt number(2);

begin

   select decode(:n.odc_def_id,null,0,1)+decode(:n.procedure_def_id,null,0,1)+
	decode(:n.unlisted_procedure_id,null,0,1) into null_cnt from dual;

 
   If null_cnt > 1 then
	raise invalid_proc;
   end if;

exception

   when invalid_proc then
	
	Raise_application_error(-20103,'Can only refer to either odc_def or proc_def or unlisted_proc');
end;
/
sho err



Create or replace trigger cost_item_trg3
before delete on cost_item
referencing new as n old as o
for each row
begin
delete from picas_visit_to_cost_item where cost_item_id = :o.id;
end;
/
sho err


Create or replace trigger unlisted_procedure_trg1
after insert or update of procedure_level on unlisted_procedure
referencing new as n old as o
for each row
declare
invalid_proclvl exception;

begin

  If :n.procedure_level is null and :n.type = 'ODC' then
	raise invalid_proclvl;
  end if;

exception

   when invalid_proclvl then
	Raise_application_error(-20104,'Procedure_level can not be null when type id ODC');
end;
/
sho err

Create or replace trigger def_publish_groups_trg1
after insert or update of PUBLISH_TO_CLIENT_GROUP_ID on def_publish_groups
referencing new as n old as o
for each row
declare
clntgrp_cnt number(10);
invalid_clntgrp exception;

begin

  Select count(*) into clntgrp_cnt from client_group where 
	id = :n.PUBLISH_TO_CLIENT_GROUP_ID;

  If clntgrp_cnt = 0 then
	raise invalid_clntgrp;
  end if;

exception

   when invalid_clntgrp then
	Raise_application_error(-20105,'PUBLISH_TO_CLIENT_GROUP_ID not in CLIENT_GROUP');
end;
/
sho err


Create or replace trigger client_div_to_lic_indmap_trg1
after insert or update of INDMAP_ID on client_div_to_lic_indmap
referencing new as n old as o
for each row
declare
indmap_cnt number(10);
invalid_indmap exception;

begin

  Select count(*) into indmap_cnt from indmap where 
	id = :n.INDMAP_ID and parent_indmap_id is null;

  If indmap_cnt = 0 then
	raise invalid_indmap;
  end if;

exception

   when invalid_indmap then
	Raise_application_error(-20106,'Indmap_id is not a Therapeutic Area ');
end;
/
sho err

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err	

Create or replace trigger icp_instance_trg1
before insert or update on icp_instance
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err


Create or replace trigger tspd_document_trg1
before insert or update on tspd_document
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err	

Create or replace trigger tspd_lib_bucket_trg1
before insert or update on tspd_lib_bucket
referencing new as n old as o
for each row
begin
 :n.last_updated:=sysdate;
end;
/
sho err


Create or replace trigger tspd_document_trg1
before insert or update or delete on tspd_document
referencing new as n old as o
for each row
begin
If updating or deleting then
   Insert into tspd_document_history select increment_sequence('tspd_document_history_seq'),
   	sysdate,:o.id,:o.TRIAL_ID,:o.DOCUMENT_TYPE,
	:o.DOCUMENT_NAME,:o.AUTHOR_FTUSER_ID,:o.CREATE_DATE,:o.LAST_UPDATED,
	:o.VERSION_TIMESTAMP,:o.DATA,:o.SNAPSHOT_TYPE,:o.SNAPSHOT_NAME,:o.SNAPSHOT_NOTES,
	:o.REVIEW_BY_DATE,:o.REVIEW_BY_TIME,:o.AMEND_TO_TSPD_DOCUMENT_ID,
	:o.ICP_INSTANCE_ID,:o.SNAPSHOT_STATUS,:o.DOCUMENT_NOTES,:o.SNAPSHOT_CREATE_DATE,
	:o.SOA_TBL_FORMAT,:o.REVIEW_REMINDER_DAYS,:o.AMEND_NAME,:o.LAST_COOKIE,
	:o.SOFTWARE_VERSION from dual;  

   delete from tspd_document_history where id in(
  	select id from (SELECT id,
   	RANK() OVER (PARTITION BY tspd_document_id
   	ORDER BY history_date DESC) rank
   	FROM tspd_document_history where tspd_document_id=:o.id)
   	where rank > 3);

end if;
If updating or inserting then
 :n.last_updated:=sysdate;
end if;
end;
/
sho err	

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
If updating then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id,:o.version,:o.status,:o.create_date,:o.creator_ftuser_id,
   :o.released_date,:o.retired_date from dual;  
end if;
 :n.last_updated:=sysdate;
end;
/
sho err	

CREATE OR REPLACE
TRIGGER client_div_to_lic_app_trg1
before insert or update of PRINCIPAL_CONTACT_ID 
ON client_div_to_lic_app
referencing new as n old as o
for each row
declare
new_principal_contact_email varchar2(100);
old_principal_contact_email varchar2(100);

begin

If :n.principal_contact_id is not null 
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
end;
/


exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  15   DevTSM    1.14        2/22/2008 11:56:06 AMDebashish Mishra  
--  14   DevTSM    1.13        9/19/2006 12:11:52 AMDebashish Mishra   
--  13   DevTSM    1.12        3/2/2005 10:51:19 PM Debashish Mishra  
--  12   DevTSM    1.11        11/16/2004 12:38:47 AMDebashish Mishra  
--  11   DevTSM    1.10        4/8/2004 4:09:38 PM  Debashish Mishra  
--  10   DevTSM    1.9         8/29/2003 5:17:53 PM Debashish Mishra  
--  9    DevTSM    1.8         5/6/2002 11:53:01 AM Debashish Mishra New trigger
--       for client_div_to_lic_indmap
--  8    DevTSM    1.7         3/13/2002 1:03:57 PM Debashish Mishra  
--  7    DevTSM    1.6         1/24/2002 4:16:46 PM Debashish Mishra modified for
--       exit problem
--  6    DevTSM    1.5         1/23/2002 6:18:42 PM Debashish Mishra Changes for
--       unlisted procedure
--  5    DevTSM    1.4         1/15/2002 12:30:00 PMDebashish Mishra  
--  4    DevTSM    1.3         1/4/2002 4:26:02 PM  Debashish Mishra  
--  3    DevTSM    1.2         12/19/2001 3:59:04 PMDebashish Mishra Added trigger
--       for custom set item
--  2    DevTSM    1.1         12/19/2001 10:50:38 AMDebashish Mishra  
--  1    DevTSM    1.0         12/4/2001 11:46:27 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

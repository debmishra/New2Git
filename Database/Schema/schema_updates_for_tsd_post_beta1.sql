--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_tsd_post_beta1.sql$ 
--
-- $Revision: 7$        $Date: 2/22/2008 11:56:03 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

-- Following changes are as per the request of Kelly on 12/03/2003 at 3:40 PM

Alter table tspd_template add(software_version varchar(20));
Alter table tspd_document add(software_version varchar(20));

-- Following chnages are as per the request of Kelly on 12/08/2003 at 13:15

Alter table tspd_template add (updated_by_ftuser_id number(10));

Alter table tspd_template add constraint
	tspd_template_fk2 foreign key (updated_by_ftuser_id)
	references ftuser(id);

-- Following chnages are as per the request of Kelly on 12/08/2003 at 16:25

create or replace view tspd_document_noblob as 
select id,trial_id,document_type,document_name,
author_ftuser_id,create_date,last_updated,
version_timestamp,snapshot_type,snapshot_name,
snapshot_notes, review_by_date,review_by_time,
amend_to_tspd_document_id,icp_instance_id,
snapshot_status,document_notes,snapshot_create_date,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,
SOFTWARE_VERSION from tspd_document;

create or replace view tspd_template_noblob as 
select id,client_div_id,last_updated,name,
SOFTWARE_VERSION, UPDATED_BY_FTUSER_ID
from tspd_template;



create table tspd_template_history (
	id	NUMBER(10),
        history_date    date not null,
        tspd_template_id number(10) not null,
	client_div_id	NUMBER(10) NOT NULL,
	last_updated	DATE NOT NULL,
	name	VARCHAR2(80)	NOT NULL,
	data	BLOB,
	SOFTWARE_VERSION VARCHAR2(20),
	UPDATED_BY_FTUSER_ID NUMBER(10))
	tablespace tspdblob 
	pctused 65 pctfree 20;

Alter table tspd_template_history add constraint tspd_template_history_pk
	primary key (id) using index tablespace
	tspdsmall_indx pctfree 20;

Alter table tspd_template_history add constraint tspd_template_history_fk1
	foreign key (client_div_id) references client_div(id);

Insert into id_control values('tsm10','tspd_template_history',1);
commit;

Create or replace trigger tspd_template_trg1
before insert or update on tspd_template
referencing new as n old as o
for each row
begin
If updating then
   Insert into tspd_template_history select increment_sequence('tspd_template_history_seq'),
   sysdate,:o.id,:o.client_div_id,:o.last_updated,:o.name,:o.data,:o.software_version,
   :o.updated_by_ftuser_id from dual;  
end if;
 :n.last_updated:=sysdate;
end;
/
sho err	


create or replace view tspd_template_history_noblob 
as select ID,HISTORY_DATE,TSPD_TEMPLATE_ID ,CLIENT_DIV_ID,
LAST_UPDATED,NAME,SOFTWARE_VERSION,UPDATED_BY_FTUSER_ID
from tspd_template_history;


--*******************************************************
--updated tsm10@TEST upto this on 12-16-2003 at 11:16
--updated tsm10e@TEST upto this on 12-19-2003 at 7:58
--updated tsm10p@PREV upto this on 12-19-2003 at 14:20
--updated tsm10t@PROD upto this on 12-29-2003 at 7:50
--updated tsm10e@PREV upto this on 11-05-2004 at 20:40
--updated tsm10e@PROD upto this on 11-06-2004 at 00:45
--updated tsm10@PROD upto this on 11-06-2004 at 00:45
--****************************************************

 
---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/22/2008 11:56:03 AMDebashish Mishra  
--  6    DevTSM    1.5         9/19/2006 12:11:36 AMDebashish Mishra   
--  5    DevTSM    1.4         3/2/2005 10:51:06 PM Debashish Mishra  
--  4    DevTSM    1.3         11/16/2004 12:38:34 AMDebashish Mishra  
--  3    DevTSM    1.2         3/8/2004 10:37:15 AM Debashish Mishra  
--  2    DevTSM    1.1         1/20/2004 6:17:19 PM Debashish Mishra  
--  1    DevTSM    1.0         12/26/2003 4:25:49 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

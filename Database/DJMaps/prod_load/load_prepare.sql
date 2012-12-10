--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: load_prepare.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
truncate table "&1".temp_procedure;
truncate table "&1".temp_odc;
truncate table "&1".temp_overhead;
truncate table "&1".temp_ip_study_price;
truncate table "&1".temp_inst_to_company;
truncate table "&1".add_study;
truncate table "&1".payments;
truncate table "&1".procedure_to_protocol;
truncate table "&1".protocol_to_indmap;
truncate table "&1".price_level;

Alter table "&1".payments drop constraint payments_fk1;
truncate table "&1".investig;
Alter table "&1".payments add constraint payments_fk1
	foreign key (investig_id) references 
	"&1".investig(id);

Delete from "&1".protocol;
commit;

drop sequence "&1".mapper_seq;
create sequence "&1".mapper_seq START WITH 857;
drop sequence "&1".add_study_seq;
create sequence "&1".add_study_seq;
drop sequence "&1".price_level_seq;
create sequence "&1".price_level_seq;


create index "&1".dl_indx1 on "&1".institution(abbreviation);
create index "&1".dl_indx2 on "&1".build_code(code);
create index "&1".dl_indx3 on "&1".protocol(build_code_id,picas_protocol);
create index "&1".dl_indx4 on "&1".procedure_def(cpt_code);
create index "&1".dl_indx5 on "&1".odc_def(picas_code);
create index "&1".dl_indx6 on 
 "&1".investig(investigator_code,protocol_id,build_code_id) tablespace tsmlarge;
create index "&1".dl_indx7 on "&1".indmap(code);
create index "&1".dl_indx8 on "&1".payments(payment_country_id);
create index "&1".dl_indx9 on "&1".investig(payment_country_id);

create or replace trigger "&1".price_level_trg1 
before insert on "&1".price_level
for each row
begin
select "&1".price_level_seq.nextval into :new.id from dual;
end;
/

--****part2 starts here


drop index "&1".dl_indx1;
drop index "&1".dl_indx2;
drop index "&1".dl_indx3;
drop index "&1".dl_indx4;
drop index "&1".dl_indx5;
drop index "&1".dl_indx6;
drop index "&1".dl_indx7;
drop index "&1".dl_indx8;
drop index "&1".dl_indx9;


drop trigger "&1".price_level_trg1 ;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:42 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:45 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:42 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:03 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

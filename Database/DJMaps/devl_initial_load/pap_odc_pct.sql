--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pap_odc_pct.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
Alter table otherpct add(country_id number(10));

update otherpct a set a.country_id = (select b.id 
	from country b where b.abbreviation = a.country);

commit;


drop sequence pap_odc_pct_to_indmap_seq;
create sequence pap_odc_pct_to_indmap_seq;


create or replace procedure temp_load_papodcpct
as
cursor c1 is select id from otherpct;
indmapid number(10);

begin 

for ix1 in  c1 loop

	Insert into pap_odc_pct select id, country_id, othpct, affi, unaffi,
	allaffi, ph1, ph23, ph4, phall from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'CARDIOVASCULAR' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, a from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'GASTROINTESTINAL' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, b from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'CENTRAL NERVOUS SYSTEM' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, c from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'ANTI-INFECTIVE' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, d from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'ONCOLOGY' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, e from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'IMMUNOMODULATION' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, f from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'DERMATOLOGY' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, h from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'ENDOCRINE' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, i from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'PHARMACOKINETIC' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, k from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'HEMATOLOGY' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, l from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'OPHTHALMOLOGY' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, m from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'GENITOURINARY SYSTEM' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, n from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'RESPIRATORY SYSTEM' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, o from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'PAIN AND ANESTHESIA' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, p from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'DEVICES AND DIAGNOSTICS' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, q from otherpct where id = ix1.id;

	select id into indmapid from indmap where trim(code) = 'UNKNOWN THERAPEUTIC AREA' and
	parent_indmap_id is null;

	Insert into pap_odc_pct_to_indmap select pap_odc_pct_to_indmap_seq.nextval,
	ix1.id, indmapid, x from otherpct where id = ix1.id;

end loop;

commit;

end;
/

exec temp_load_papodcpct

declare

 canntbenull exception;
 nullcnt  number(10);

begin

  select count(*) into nullcnt from  pap_odc_pct where
  BASE_PCT is null or AFFILIATED_PCT is null or UNAFFILIATED_PCT is null or
  AFF_UNAFF_PCT is null or PHASE_ONE_PCT is null or PHASE_TWOTHREE_PCT is null or
  PHASE_FOUR_PCT is null or PHASE_ALL_PCT is null;

  If nullcnt > 0 then
    Raise canntbenull;
  end if;

exception

  when canntbenull then
     Raise_application_error(-20206,'One of the *_PCT field is empty');
end;
/
sho err

update pap_odc_pct set BASE_PCT = null where  BASE_PCT =  -1;              
update pap_odc_pct set AFFILIATED_PCT  = null where  AFFILIATED_PCT =  -1;         
update pap_odc_pct set UNAFFILIATED_PCT  = null where  UNAFFILIATED_PCT =  -1;        
update pap_odc_pct set AFF_UNAFF_PCT  = null where  AFF_UNAFF_PCT =  -1;           
update pap_odc_pct set PHASE_ONE_PCT = null where  PHASE_ONE_PCT =  -1;            
update pap_odc_pct set PHASE_TWOTHREE_PCT = null where  PHASE_TWOTHREE_PCT =  -1;       
update pap_odc_pct set PHASE_FOUR_PCT = null where  PHASE_FOUR_PCT =  -1;           
update pap_odc_pct set PHASE_ALL_PCT = null where  PHASE_ALL_PCT =  -1;

commit;

            



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:42 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:12 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:11:58 PM Debashish Mishra  
--  4    DevTSM    1.3         5/6/2003 9:37:27 AM  Debashish Mishra Fixed the
--       spelling of ophthalmology
--  3    DevTSM    1.2         3/22/2002 4:40:18 PM Debashish Mishra  
--  2    DevTSM    1.1         3/18/2002 7:42:20 PM Debashish Mishra  
--  1    DevTSM    1.0         1/15/2002 12:30:31 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

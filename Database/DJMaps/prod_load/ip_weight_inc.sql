--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_weight_inc.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
declare

 iw_exist number(3);
 iw_maxid number(10);
 cursor c1 is select country, phase, ther_area,affiliation from tsm_stage.cppwt;
 indmapid number(10);
 countryid number(10);

begin

  select nvl(max(id),0)+1 into iw_maxid from "&1".ip_weight;

  for ix1 in c1 loop

    select id into indmapid from "&1".indmap where code = decode(ix1.ther_area,'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
    'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY',
    'I','ENDOCRINE','K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY',
    'N','GENITOURINARY SYSTEM','O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA',
    'Q','DEVICES AND DIAGNOSTICS','Z','UNKNOWN THERAPEUTIC AREA')
    and type = 'Therapeutic Area';

    select id into countryid from "&1".country where abbreviation= ix1.country;

    select count(*) into iw_exist from "&1".ip_weight where country_id = countryid and
    phase_id = ix1.phase and indmap_id = indmapid and affiliation = ix1.affiliation;

    If iw_exist=0 then 
       Insert into "&1".ip_weight select iw_maxid,countryid,phase,indmapid,affiliation,
       complex_minvalue,factor,minvalue from tsm_stage.cppwt where country = ix1.country and
       phase = ix1.phase and ther_area = ix1.ther_area and affiliation = ix1.affiliation;

       iw_maxid:=iw_maxid+1;
    Else
       update "&1".ip_weight set (COMPLEX_MINVALUE,FACTOR,MINVALUE) = (select 
       COMPLEX_MINVALUE,FACTOR,MINVALUE from tsm_stage.cppwt where country = ix1.country and
       phase = ix1.phase and ther_area = ix1.ther_area and affiliation = ix1.affiliation)
       where country_id = countryid and phase_id = ix1.phase and indmap_id = indmapid
       and affiliation = ix1.affiliation;               
    end if;
  end loop;
  commit;
end;
/

declare

 pol_countryid number(10);
 hun_countryid number(10);
 phc_countryid number(10);
 scy_countryid number(10);
 bul_countryid number(10);
 fsu_countryid number(10);

 pol_exist number(3);
 hun_exist number(3);
 phc_exist number(3);
 scy_exist number(3);
 bul_exist number(3);
 fsu_exist number(3);

 cursor c1 is select a.id,a.country_id, a.phase_id, a.indmap_id, a.affiliation 
 from "&1".ip_weight a,"&1".country b where a.country_id = b.id and b.abbreviation = 'EAE';

 iw_maxid number(10); 

begin

  select nvl(max(id),0)+1 into iw_maxid from "&1".ip_weight;

  select id into pol_countryid from "&1".country where abbreviation = 'POL';
  select id into hun_countryid from "&1".country where abbreviation = 'HUN';
  select id into phc_countryid from "&1".country where abbreviation = 'PHC';
  select id into scy_countryid from "&1".country where abbreviation = 'SCY';
  select id into bul_countryid from "&1".country where abbreviation = 'BUL';
  select id into fsu_countryid from "&1".country where abbreviation = 'FSU';

  for ix1 in c1 loop

    select count(*) into pol_exist from "&1".ip_weight where
    country_id=pol_countryid and phase_id = ix1.phase_id and
    indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;

    select count(*) into hun_exist from "&1".ip_weight where
    country_id=hun_countryid and phase_id = ix1.phase_id and
    indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
  
    select count(*) into phc_exist from "&1".ip_weight where
    country_id=phc_countryid and phase_id = ix1.phase_id and
    indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;   
    
    select count(*) into scy_exist from "&1".ip_weight where
    country_id=scy_countryid and phase_id = ix1.phase_id and
    indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;

    select count(*) into bul_exist from "&1".ip_weight where
    country_id=bul_countryid and phase_id = ix1.phase_id and
    indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;   
    
    select count(*) into fsu_exist from "&1".ip_weight where
    country_id=fsu_countryid and phase_id = ix1.phase_id and
    indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;


    If pol_exist = 0 then 
  	Insert into "&1".ip_weight select iw_maxid,pol_countryid,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from "&1".ip_weight where id=ix1.id;      

	iw_maxid:=iw_maxid+1;
    Else
        update "&1".ip_weight set (complex_minvalue, factor, minvalue) = (select
	complex_minvalue, factor, minvalue from "&1".ip_weight  where id = ix1.id)
	where country_id = pol_countryid and phase_id = ix1.phase_id and
	indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
    End if;

    If hun_exist = 0 then 
  	Insert into "&1".ip_weight select iw_maxid,hun_countryid,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from "&1".ip_weight where id=ix1.id;      

	iw_maxid:=iw_maxid+1;
    Else
        update "&1".ip_weight set (complex_minvalue, factor, minvalue) = (select
	complex_minvalue, factor, minvalue from "&1".ip_weight  where id = ix1.id)
	where country_id = hun_countryid and phase_id = ix1.phase_id and
	indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
    End if;

    If phc_exist = 0 then 
  	Insert into "&1".ip_weight select iw_maxid,phc_countryid,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from "&1".ip_weight where id=ix1.id;      

	iw_maxid:=iw_maxid+1;
    Else
        update "&1".ip_weight set (complex_minvalue, factor, minvalue) = (select
	complex_minvalue, factor, minvalue from "&1".ip_weight  where id = ix1.id)
	where country_id = phc_countryid and phase_id = ix1.phase_id and
	indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
    End if;

    If scy_exist = 0 then 
  	Insert into "&1".ip_weight select iw_maxid,scy_countryid,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from "&1".ip_weight where id=ix1.id;      

	iw_maxid:=iw_maxid+1;
    Else
        update "&1".ip_weight set (complex_minvalue, factor, minvalue) = (select
	complex_minvalue, factor, minvalue from "&1".ip_weight  where id = ix1.id)
	where country_id = scy_countryid and phase_id = ix1.phase_id and
	indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
    End if;

    If bul_exist = 0 then 
  	Insert into "&1".ip_weight select iw_maxid,bul_countryid,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from "&1".ip_weight where id=ix1.id;      

	iw_maxid:=iw_maxid+1;
    Else
        update "&1".ip_weight set (complex_minvalue, factor, minvalue) = (select
	complex_minvalue, factor, minvalue from "&1".ip_weight  where id = ix1.id)
	where country_id = bul_countryid and phase_id = ix1.phase_id and
	indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
    End if;

    If fsu_exist = 0 then 
  	Insert into "&1".ip_weight select iw_maxid,fsu_countryid,
	phase_id,indmap_id,affiliation, complex_minvalue, factor, minvalue
	from "&1".ip_weight where id=ix1.id;      

	iw_maxid:=iw_maxid+1;
    Else
        update "&1".ip_weight set (complex_minvalue, factor, minvalue) = (select
	complex_minvalue, factor, minvalue from "&1".ip_weight  where id = ix1.id)
	where country_id = fsu_countryid and phase_id = ix1.phase_id and
	indmap_id = ix1.indmap_id and affiliation = ix1.affiliation;
    End if;

  End loop;
  commit;
end;
/











---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:42 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:45 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:14:41 PM Debashish Mishra  
--  2    DevTSM    1.1         5/6/2003 9:37:09 AM  Debashish Mishra fixed the
--       spelling mistake in ophthalmology
--  1    DevTSM    1.0         2/19/2003 1:51:03 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

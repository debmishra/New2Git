--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pap_odc_pct_inc.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:42 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
declare

  pop_maxid number(10);
  popti_maxid number(10);
  countryid number(10);
  pop_exist number(3);
  popti_exist number(3);
  pop_id number(10);
  cursor c1 is select country from tsm_stage.otherpct;

  a_indmapid number(10);
  b_indmapid number(10);
  c_indmapid number(10);
  d_indmapid number(10);
  e_indmapid number(10);
  f_indmapid number(10);
  h_indmapid number(10);
  i_indmapid number(10);
  k_indmapid number(10);
  l_indmapid number(10);
  m_indmapid number(10);
  n_indmapid number(10);
  o_indmapid number(10);
  p_indmapid number(10);
  q_indmapid number(10);
  x_indmapid number(10);

begin

  select id into a_indmapid from  "&1".indmap where trim(code) = 'CARDIOVASCULAR' and
  parent_indmap_id is null;
  select id into b_indmapid from  "&1".indmap where trim(code) = 'GASTROINTESTINAL' and
  parent_indmap_id is null;
  select id into c_indmapid from  "&1".indmap where trim(code) = 'CENTRAL NERVOUS SYSTEM' and
  parent_indmap_id is null;
  select id into d_indmapid from  "&1".indmap where trim(code) = 'ANTI-INFECTIVE' and
  parent_indmap_id is null;   
  select id into e_indmapid from  "&1".indmap where trim(code) = 'ONCOLOGY' and
  parent_indmap_id is null;
  select id into f_indmapid from  "&1".indmap where trim(code) = 'IMMUNOMODULATION' and
  parent_indmap_id is null;
  select id into h_indmapid from  "&1".indmap where trim(code) = 'DERMATOLOGY' and
  parent_indmap_id is null;
  select id into i_indmapid from  "&1".indmap where trim(code) = 'ENDOCRINE' and
  parent_indmap_id is null;   
  select id into k_indmapid from  "&1".indmap where trim(code) = 'PHARMACOKINETIC' and
  parent_indmap_id is null;
  select id into l_indmapid from  "&1".indmap where trim(code) = 'HEMATOLOGY' and
  parent_indmap_id is null;
  select id into m_indmapid from  "&1".indmap where trim(code) = 'OPHTHALMOLOGY' and
  parent_indmap_id is null;
  select id into n_indmapid from  "&1".indmap where trim(code) = 'GENITOURINARY SYSTEM' and
  parent_indmap_id is null;   
  select id into o_indmapid from  "&1".indmap where trim(code) = 'RESPIRATORY SYSTEM' and
  parent_indmap_id is null;
  select id into p_indmapid from  "&1".indmap where trim(code) = 'PAIN AND ANESTHESIA' and
  parent_indmap_id is null;
  select id into q_indmapid from  "&1".indmap where trim(code) = 'DEVICES AND DIAGNOSTICS' and
  parent_indmap_id is null;
  select id into x_indmapid from  "&1".indmap where trim(code) = 'UNKNOWN THERAPEUTIC AREA' and
  parent_indmap_id is null;


  select nvl(max(id),0)+1 into pop_maxid from "&1".pap_odc_pct;
  select nvl(max(id),0)+1 into popti_maxid from "&1".pap_odc_pct_to_indmap;

  for ix1 in c1 loop

    select id into countryid from "&1".country where abbreviation = ix1.country;

    select count(*) into pop_exist from "&1".pap_odc_pct where country_id = countryid;
    
    If pop_exist = 0 then 

        Insert into "&1".pap_odc_pct select pop_maxid, countryid, othpct, affi, unaffi,
        allaffi, ph1, ph23, ph4, phall from tsm_stage.otherpct where country = ix1.country;

	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, a_indmapid, a from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, b_indmapid, b from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, c_indmapid, c from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, d_indmapid, d from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, e_indmapid, e from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, f_indmapid, f from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, h_indmapid, h from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, i_indmapid, i from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, k_indmapid, k from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, l_indmapid, l from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, m_indmapid, m from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, n_indmapid, n from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, o_indmapid, o from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, p_indmapid, p from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, q_indmapid, q from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;
	Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	pop_maxid, x_indmapid, x from tsm_stage.otherpct where country = ix1.country;
	popti_maxid:=popti_maxid+1;

        pop_maxid:=pop_maxid+1;

   Else

        Update "&1".pap_odc_pct set (BASE_PCT,AFFILIATED_PCT,UNAFFILIATED_PCT,       
        AFF_UNAFF_PCT,PHASE_ONE_PCT,PHASE_TWOTHREE_PCT,PHASE_FOUR_PCT,         
        PHASE_ALL_PCT) = (select  othpct, affi, unaffi,allaffi, ph1, ph23, ph4, 
        phall from tsm_stage.otherpct  where country = ix1.country) where country_id = countryid;

        select id into pop_id from "&1".pap_odc_pct where country_id = countryid;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = a_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, a_indmapid, a from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select a from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = a_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = b_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, b_indmapid, b from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select b from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = b_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = c_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, c_indmapid, c from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select c from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = c_indmapid;
        End if;    

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = d_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, d_indmapid, d from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select d from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = d_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = e_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, e_indmapid, e from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select e from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = e_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = f_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, f_indmapid, f from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select f from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = f_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = h_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, h_indmapid, h from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select h from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = h_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = i_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, i_indmapid, i from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select i from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = i_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = k_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, k_indmapid, k from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select k from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = k_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = l_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, l_indmapid, l from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select l from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = l_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = m_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, m_indmapid, m from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select m from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = m_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = n_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, n_indmapid, n from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select n from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = n_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = o_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, o_indmapid, o from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select o from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = o_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = p_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, p_indmapid, p from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select p from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = p_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = q_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, q_indmapid, q from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select q from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = q_indmapid;
        End if;

        select count(*) into popti_exist from "&1".pap_odc_pct_to_indmap where
        pap_odc_pct_id = pop_id and indmap_id = x_indmapid;
        If popti_exist = 0 then 
	   Insert into "&1".pap_odc_pct_to_indmap select popti_maxid,
	   pop_id, x_indmapid, x from tsm_stage.otherpct where country = ix1.country;
	   popti_maxid:=popti_maxid+1;
        Else
           update "&1".pap_odc_pct_to_indmap set indmap_pct = (select x from tsm_stage.otherpct
	   where country = ix1.country) where pap_odc_pct_id = pop_id and
           indmap_id = x_indmapid;
        End if;
   End if;
 End loop;
 commit;
end;
/  

declare

 canntbenull exception;
 nullcnt  number(10);

begin

  select count(*) into nullcnt from  "&1".pap_odc_pct where
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


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:42 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:41:48 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:14:43 PM Debashish Mishra  
--  2    DevTSM    1.1         5/6/2003 9:37:10 AM  Debashish Mishra fixed the
--       spelling mistake in ophthalmology
--  1    DevTSM    1.0         2/19/2003 1:51:05 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: modelled_coeff.sql$ 
--
-- $Revision: 10$        $Date: 2/27/2008 3:17:09 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create table tsm_stage.parm_tab (name varchar2(40),
short_desc varchar2(40),
coeff_char varchar2(20),
country_name varchar2(3),
country_id number (10) ,
coeff_type varchar2(7) ,
coeff_value varchar2(20),
cross_coeff_type varchar2(7),
cross_coeff_value varchar2(20),
coeff number(20,12));

truncate table tsm_stage.parm_tab;

Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'CAN' from tsm_stage.parm_can;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'DEU' from tsm_stage.parm_deu;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'FRA' from tsm_stage.parm_fra;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'NET' from tsm_stage.parm_net;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'UK' from tsm_stage.parm_uk1;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'USA' from tsm_stage.parm_usa;


Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'SWE' from tsm_stage.parm_scan;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'NOR' from tsm_stage.parm_scan;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'DEN' from tsm_stage.parm_scan;
Insert into tsm_stage.parm_tab(name,short_desc,coeff_char,country_name) 
select name,short_desc,coeff,'FIN' from tsm_stage.parm_scan;



delete from tsm_stage.parm_tab where trim(name) in ('_NAME_','_RMSE_','sqrty');

update tsm_stage.parm_tab set name = trim(name);
update tsm_stage.parm_tab set short_desc = trim(short_desc);
update tsm_stage.parm_tab set coeff_char = trim(coeff_char);

update tsm_stage.parm_tab a set a.country_id = (select b.id from "&1".country b where 
b.abbreviation=a.country_name);

update tsm_stage.parm_tab set COEFF = to_number(COEFF_CHAR);

commit;

declare

word1 varchar2(128);
word2 varchar2(128);
word3 varchar2(128);
word4 varchar2(128);

space1 number(3);
space2 number(3);
space3 number(3);
space4 number(3);

coefftype varchar2(20);
crosscoefftype varchar2(20);
coeffval varchar2(128);
crosscoeffval varchar2(128);

num_proc number(5);
isodc  number(1):=0;

probelm_with_proccode exception;



cursor c1 is select rowid,name,short_desc from tsm_stage.parm_tab where short_desc like '%*%';
cursor c2 is select rowid,name,short_desc from tsm_stage.parm_tab where not short_desc like '%*%' or short_desc is null;

begin

for ix1 in c1 loop



 select instr(ix1.short_desc,' ', 1,1) into space1 from dual;
 select instr(ix1.short_desc,' ', 1,2) into space2 from dual;
 select instr(ix1.short_desc,' ', 1,3) into space3 from dual;
 select instr(ix1.short_desc,' ', 1,4) into space4 from dual;

 select substr(ix1.short_desc,1,space1-1) into word1 from dual;
 select substr(ix1.short_desc,space1+1,space2-space1-1) into word2 from dual;
 select substr(ix1.short_desc,space3+1,space4-space3-1) into word3 from dual;
 select substr(ix1.short_desc,space4+1) into word4 from dual;
 If word1 = 'xcategory' and word2 like 'OTHR%' and length(word2)=6 then coefftype:='TA';
 elsif word1 = 'xcategory' and not word2 like 'OTHR%' then coefftype:='INDGRP';
 elsif word1 = 'xcompany' then coefftype:='COMPANY';
 elsif word1 = 'phase' then coefftype:='PHASE';
 elsif word1 = 'aff' then coefftype:='AFF';
 elsif word1 = 'status' then coefftype:='IOSTAT';
 elsif word1 = 'year' then coefftype:='YEAR';
 end if;

 If word3 = 'xcategory' and word4 like 'OTHR%' and length(word2)=6 then crosscoefftype:='TA';
 elsif word3 = 'xcategory' and not word4 like 'OTHR%' then crosscoefftype:='INDGRP';
 elsif word3 = 'xcompany' then crosscoefftype:='COMPANY';
 elsif word3 = 'phase' then crosscoefftype:='PHASE';
 elsif word3 = 'aff' then crosscoefftype:='AFF';
 elsif word3 = 'status' then crosscoefftype:='IOSTAT';
 elsif word3 = 'year' then crosscoefftype:='YEAR';
 end if;

 
 If coefftype='TA' then select id into coeffval from "&1".indmap where parent_indmap_id is null and
    	code= decode(substr(word2,6,1),'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
	'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE',
	'K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM',
	'O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA','Q','DEVICES AND DIAGNOSTICS',
	'Z','UNKNOWN THERAPEUTIC AREA');
 elsif coefftype='INDGRP' then 	select id into coeffval from "&1".indmap where type = 'Indication Group' and code=word2;
 elsif coefftype='COMPANY' then select id into coeffval from "&1".build_code where code=decode(word2,'OTHR','UNK',word2);
 elsif coefftype='PHASE' then select id into coeffval from "&1".phase where 
	short_desc=decode(word2,'A','phaseI','B','phaseII','C','PhaseIII');
 elsif coefftype='AFF' then select decode(word2,'A','Affiliated','U','Unaffiliated') into coeffval from dual ;
 elsif coefftype='YEAR' then coeffval:=word2;
 elsif coefftype='IOSTAT' then select decode(word2,'A','Outpatient','B','Inpatient','C','Mixed') 
	into coeffval from dual;
 end if;

 If crosscoefftype='TA' then select id into crosscoeffval from "&1".indmap where parent_indmap_id is null and
    	code= decode(substr(word4,6,1),'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
	'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE',
	'K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM',
	'O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA','Q','DEVICES AND DIAGNOSTICS',
	'Z','UNKNOWN THERAPEUTIC AREA');
 elsif crosscoefftype='INDGRP' then select id into crosscoeffval from "&1".indmap where type = 'Indication Group' and
	code=word4;
 elsif crosscoefftype='COMPANY' then select id into crosscoeffval from "&1".build_code where code=decode(word4,'OTHR','UNK',word4);
 elsif crosscoefftype='PHASE' then select id into crosscoeffval from "&1".phase where 
	short_desc=decode(word4,'A','phaseI','B','phaseII','C','PhaseIII');
 elsif crosscoefftype='AFF' then select decode(word4,'A','Affiliated','U','Unaffiliated') into crosscoeffval from dual;
 elsif crosscoefftype='YEAR' then crosscoeffval:=word4;
 elsif crosscoefftype='IOSTAT' then select decode(word4,'A','Outpatient','B','Inpatient','C','Mixed') 
	into crosscoeffval from dual;
 end if;


 update tsm_stage.parm_tab set (COEFF_TYPE,COEFF_VALUE,CROSS_COEFF_TYPE,CROSS_COEFF_VALUE)=
	(select coefftype,coeffval,crosscoefftype,crosscoeffval from dual) where rowid=ix1.rowid;

coefftype:=null;
coeffval:=null;
crosscoefftype:=null;
crosscoeffval:=null;

end loop;


for ix2 in c2 loop

  isodc:=0;

  If ix2.name = 'mcpatients2' then 
	coefftype:= 'PAT2';
   elsif ix2.name = 'mcpatients' then 
	coefftype := 'PAT';
   elsif ix2.name = 'mcduration2' then 
	coefftype := 'DUR2';
   elsif ix2.name = 'mcduration' then 
	coefftype := 'DUR';
   elsif substr(ix2.name,1,1) = '_' then 
	coefftype := 'PROC';
   elsif ix2.name like 'xcategory%' and substr(ix2.name,10) like 'OTHR%' and length(ix2.name)=15 then 
	coefftype:='TA';
   elsif ix2.name like 'xcategory%' and not substr(ix2.name,10) like 'OTHR%' then 
	coefftype:='INDGRP';
   elsif ix2.name like 'xcompany%' then 
	coefftype:='COMPANY';
   elsif ix2.name like 'phase%' then 
	coefftype:='PHASE';
   elsif ix2.name like 'aff%' then 
	coefftype:='AFF';
   elsif ix2.name like 'status%' then 
	coefftype:='IOSTAT';
   elsif ix2.name like 'year%' then 
	coefftype:='YEAR';
  end if;

 If coefftype='PAT' then coeffval:= 'mcpatients';
 elsif coefftype='PAT2' then coeffval:= 'mcpatients2';
 elsif coefftype='DUR' then coeffval:= 'mcduration';
 elsif coefftype='DUR2' then coeffval:= 'mcduration2';
 elsif coefftype='TA' then select id into coeffval from "&1".indmap where parent_indmap_id is null and
    	code= decode(substr(ix2.name,15,1),'A','CARDIOVASCULAR','B','GASTROINTESTINAL','C','CENTRAL NERVOUS SYSTEM',
	'D','ANTI-INFECTIVE','E','ONCOLOGY','F','IMMUNOMODULATION','H','DERMATOLOGY','I','ENDOCRINE',
	'K','PHARMACOKINETIC','L','HEMATOLOGY','M','OPHTHALMOLOGY','N','GENITOURINARY SYSTEM',
	'O','RESPIRATORY SYSTEM','P','PAIN AND ANESTHESIA','Q','DEVICES AND DIAGNOSTICS',
	'Z','UNKNOWN THERAPEUTIC AREA');
 elsif coefftype='INDGRP' then select id into coeffval from "&1".indmap where type = 'Indication Group' and
	code=substr(ix2.name,10);
 elsif coefftype='COMPANY' then select id into coeffval from "&1".build_code 
	where code=decode(substr(ix2.name,9),'OTHR','UNK',substr(ix2.name,9));
 elsif coefftype='PHASE' then select id into coeffval from "&1".phase where 
	short_desc=decode(substr(ix2.name,6),'A','phaseI','B','phaseII','C','PhaseIII');
 elsif coefftype='AFF' then select decode(substr(ix2.name,4),'A','Affiliated','U','Unaffiliated') into coeffval from dual;
 elsif coefftype='YEAR' then coeffval:=substr(ix2.name,5);
 elsif coefftype='IOSTAT' then select decode(substr(ix2.name,7),'A','Outpatient','B','Inpatient','C','Mixed') 
	into coeffval from dual;
 elsif coefftype='PROC' then
	select count(*) into num_proc from "&1".procedure_def where cpt_code=substr(ix2.name,2);
	  If num_proc <> 0 then
		select id into coeffval from "&1".procedure_def where cpt_code =substr(ix2.name,2);
	  else
		select count(*) into num_proc from "&1".procedure_def where cpt_code like '*'||substr(ix2.name,2)||'%';
		if num_proc > 1 then
			select count(*) into num_proc from "&1".procedure_def 
			where cpt_code = '*'||substr(ix2.name,2);
			if num_proc = 1 then
				select id into coeffval from "&1".procedure_def 
				where cpt_code = '*'||substr(ix2.name,2);
			else
				select count(*) into num_proc from "&1".procedure_def 
				where cpt_code = '*'||substr(ix2.name,2)||'*';
				if num_proc = 1 then
					select id into coeffval from "&1".procedure_def 
					where cpt_code = '*'||substr(ix2.name,2)||'*';
				else
					raise probelm_with_proccode;
				end if;
			end if;
		elsif num_proc = 1 then
			select id into coeffval from "&1".procedure_def where cpt_code like '*'||substr(ix2.name,2)||'%';
		else
	    		select count(*) into num_proc from "&1".odc_def where picas_code=substr(ix2.name,2);
	    		If num_proc <> 0 then
		  		select id into coeffval from "&1".odc_def where picas_code =substr(ix2.name,2);
		  		isodc:=1;
			end if;
		end if;
	  end if;
 end if;

    If isodc = 1 then 
	coefftype:='ODC';
    end if;

 update tsm_stage.parm_tab set (COEFF_TYPE,COEFF_VALUE)=
	(select coefftype,coeffval from dual) where rowid=ix2.rowid;

 coefftype:=null;
 coeffval:=null;
 num_proc:=null;

end loop;

commit;

exception

when probelm_with_proccode then
     Raise_application_error(-20207,'There are multiple procedure codes found when prefixed with a *');


end;
/


-- Then write the insert script here

drop sequence "&1".modelled_coeff_seq;
create sequence "&1".modelled_coeff_seq;

truncate table "&1".modelled_coeff;

Insert into "&1".modelled_coeff(ID,COUNTRY_ID,COEFF_TYPE,COEFF_VALUE,CROSS_COEFF_TYPE,CROSS_COEFF_VALUE,COEFF)
select "&1".modelled_coeff_seq.nextval,COUNTRY_ID,COEFF_TYPE,COEFF_VALUE,CROSS_COEFF_TYPE,CROSS_COEFF_VALUE,COEFF
from tsm_stage.parm_tab;

commit;

drop table tsm_stage.parm_tab;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  10   DevTSM    1.9         2/27/2008 3:17:09 PM Debashish Mishra  
--  9    DevTSM    1.8         2/7/2007 10:28:18 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:40:39 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:13:24 PM Debashish Mishra  
--  6    DevTSM    1.5         5/6/2003 9:36:33 AM  Debashish Mishra Fixed the
--       spelling mistake in ophthalmology
--  5    DevTSM    1.4         10/22/2002 12:11:25 PMDebashish Mishra Bugs fixed
--  4    DevTSM    1.3         10/17/2002 4:08:50 PMDebashish Mishra bugs fixed
--  3    DevTSM    1.2         9/13/2002 2:47:09 PM Debashish Mishra aff change
--  2    DevTSM    1.1         9/12/2002 11:45:07 AMDebashish Mishra  
--  1    DevTSM    1.0         9/6/2002 2:24:18 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

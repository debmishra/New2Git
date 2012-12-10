--******************************************************************
--******************************************************************
-- PROCEDURE ipt_ph2to4_parm_base_calc
--******************************************************************
--******************************************************************


create or replace procedure ipt_ph2to4_parm_base_calc (CountryId in number, 
PhaseId in number,IndmapId in number,StudyDuration in varchar2,
sst in varchar2, ps1 in varchar2,sd in number, cg in varchar2, 
gl in varchar2,IndmapType in varchar2,cpp_pred_value out number,
cpv_pred_value out number,dur_coeff1 out number,dur_coeff2 out number,
aff_coeff1 out number, aff_coeff2 out number ) as

indmap_coeff1 number(20,12);
cntry_coeff1 number(20,12);
affa_coeff1 number(20,12);
affu_coeff1 number(20,12);
phase_coeff1 number(20,12);
phaseaff_coeff1 number(20,12);
phaseaffa_coeff1 number(20,12);
phaseaffu_coeff1 number(20,12);

indmap_coeff2 number(20,12);
cntry_coeff2 number(20,12);
affa_coeff2 number(20,12);
affu_coeff2 number(20,12);
phase_coeff2 number(20,12);
phaseaff_coeff2 number(20,12);
phaseaffa_coeff2 number(20,12);
phaseaffu_coeff2 number(20,12);

indmap_exist number(4);
ta_exist  number(4);
cg_exist  number(4);
dur_exist number(4);
phase_exist number(4);
affa_exist number(4);
affu_exist number(4);
phaseaffa_exist number(4);
phaseaffu_exist number(4);

begin

    /* Indmap coeff calculation for cpp starts here */

     If IndmapType='Indication' 
       then
         
         select count(*) into indmap_exist from ipm_ph2to4_coeff a,indmap b where
	 a.coeff_value=to_char(b.parent_indmap_id) and
         a.geographical_location=gl and a.inpatient_status='Outpatient' and
         a.cpp_cpv='cpp' and a.coeff_type='INDGRP' and b.id=IndmapId ;
           
            if indmap_exist > 0 
              then 
                 select coeff into indmap_coeff1 from ipm_ph2to4_coeff a,indmap b where
	 	 a.coeff_value=to_char(b.parent_indmap_id) and
         	 a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 a.cpp_cpv='cpp' and a.coeff_type='INDGRP' and b.id=IndmapId ;
            else
                 
         	 select count(*) into ta_exist from ipm_ph2to4_coeff a,indmap b, indmap c where
	 	 a.coeff_value=to_char(c.parent_indmap_id) and b.parent_indmap_id=c.id and
         	 a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 a.cpp_cpv='cpp' and a.coeff_type='TA'and b.id=IndmapId ;
               
                 if ta_exist > 0 
                   then
 
         	 	select coeff into indmap_coeff1 from ipm_ph2to4_coeff a,indmap b, indmap c where
	 	 	a.coeff_value=to_char(c.parent_indmap_id) and b.parent_indmap_id=c.id and
         	 	a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 	a.cpp_cpv='cpp' and a.coeff_type='TA' and b.id=IndmapId ;
                 else
                       
			indmap_coeff1:=0;
                 end if;
            end if;

    elsif IndmapType='Indication Group' 
       then
         
         select count(*) into indmap_exist from ipm_ph2to4_coeff a
	 where a.geographical_location=gl and a.inpatient_status='Outpatient' and
         a.cpp_cpv='cpp' and a.coeff_type='INDGRP' and a.coeff_value=to_char(IndmapId) ;

            if indmap_exist > 0 
              then 
                 select coeff into indmap_coeff1 from ipm_ph2to4_coeff a
	 	 where a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 a.cpp_cpv='cpp' and a.coeff_type='INDGRP' and a.coeff_value=to_char(IndmapId) ;

            else

                select count(*) into ta_exist from ipm_ph2to4_coeff a, indmap b where
   		a.coeff_value=to_char(b.parent_indmap_id) and
		a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	a.cpp_cpv='cpp' and a.coeff_type='TA' and b.id=IndmapId ;
		
               
                if ta_exist > 0 
                  then
        	 	select coeff into indmap_coeff1 from ipm_ph2to4_coeff a, indmap b where
   			a.coeff_value=to_char(b.parent_indmap_id) and
			a.geographical_location=gl and a.inpatient_status='Outpatient' and
         		a.cpp_cpv='cpp' and a.coeff_type='TA' and b.id=IndmapId ;
		else
			indmap_coeff1:=0;
                end if;
	    end if;

    elsif IndmapType='Therapeutic Area' 

      then
         
         select count(*) into ta_exist from ipm_ph2to4_coeff a
 	 where a.geographical_location=gl and a.inpatient_status='Outpatient' and
       	 a.cpp_cpv='cpp' and a.coeff_type='TA' and a.coeff_value=to_char(IndmapId) ;

         if ta_exist > 0 
           then
             select coeff into indmap_coeff1 from ipm_ph2to4_coeff a 
 	     where a.geographical_location=gl and a.inpatient_status='Outpatient' and
       	     a.cpp_cpv='cpp' and a.coeff_type='TA' and a.coeff_value=to_char(IndmapId) ;
         else
            indmap_coeff1:=0;
         end if;

    end if;

    /* Indmap coeff calculation for cpv starts here */

     If IndmapType='Indication' 
       then
         
         select count(*) into indmap_exist from ipm_ph2to4_coeff a,indmap b where
	 a.coeff_value=to_char(b.parent_indmap_id) and
         a.geographical_location=gl and a.inpatient_status='Outpatient' and
         a.cpp_cpv='cpv' and a.coeff_type='INDGRP' and b.id=IndmapId ;
           
            if indmap_exist > 0 
              then 
                 select coeff into indmap_coeff2 from ipm_ph2to4_coeff a,indmap b where
	 	 a.coeff_value=to_char(b.parent_indmap_id) and
         	 a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 a.cpp_cpv='cpv' and a.coeff_type='INDGRP' and b.id=IndmapId ;
            else
                 
         	 select count(*) into ta_exist from ipm_ph2to4_coeff a,indmap b, indmap c where
	 	 a.coeff_value=to_char(c.parent_indmap_id) and b.parent_indmap_id=c.id and
         	 a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 a.cpp_cpv='cpv' and a.coeff_type='TA'and b.id=IndmapId ;
               
                 if ta_exist > 0 
                   then
 
         	 	select coeff into indmap_coeff2 from ipm_ph2to4_coeff a,indmap b, indmap c where
	 	 	a.coeff_value=to_char(c.parent_indmap_id) and b.parent_indmap_id=c.id and
         	 	a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 	a.cpp_cpv='cpv' and a.coeff_type='TA' and b.id=IndmapId ;
                 else
                       
			indmap_coeff2:=0;
                 end if;
            end if;

    elsif IndmapType='Indication Group' 
       then
         
         select count(*) into indmap_exist from ipm_ph2to4_coeff a
	 where a.geographical_location=gl and a.inpatient_status='Outpatient' and
         a.cpp_cpv='cpv' and a.coeff_type='INDGRP' and a.coeff_value=to_char(IndmapId);

            if indmap_exist > 0 
              then 
                 select coeff into indmap_coeff2 from ipm_ph2to4_coeff a
	 	 where a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	 a.cpp_cpv='cpv' and a.coeff_type='INDGRP' and a.coeff_value=to_char(IndmapId) ;

            else

                select count(*) into ta_exist from ipm_ph2to4_coeff a, indmap b where
   		a.coeff_value=to_char(b.parent_indmap_id) and
		a.geographical_location=gl and a.inpatient_status='Outpatient' and
         	a.cpp_cpv='cpv' and a.coeff_type='TA' and b.id=IndmapId ;
		
               
                if ta_exist > 0 
                  then
        	 	select coeff into indmap_coeff2 from ipm_ph2to4_coeff a, indmap b where
   			a.coeff_value=to_char(b.parent_indmap_id) and
			a.geographical_location=gl and a.inpatient_status='Outpatient' and
         		a.cpp_cpv='cpv' and a.coeff_type='TA' and b.id=IndmapId ;
		else
			indmap_coeff2:=0;
                end if;
	    end if;

    elsif IndmapType='Therapeutic Area' 

      then
         
         select count(*) into ta_exist from ipm_ph2to4_coeff a
 	 where a.geographical_location=gl and a.inpatient_status='Outpatient' and
       	 a.cpp_cpv='cpv' and a.coeff_type='TA' and a.coeff_value=to_char(IndmapId); 

         if ta_exist > 0 
           then
             select coeff into indmap_coeff2 from ipm_ph2to4_coeff a 
 	     where a.geographical_location=gl and a.inpatient_status='Outpatient' and
       	     a.cpp_cpv='cpv' and a.coeff_type='TA' and a.coeff_value=to_char(IndmapId);
         else
            indmap_coeff2:=0;
         end if;

    end if;

  /* coefficient for country group starts here */

  select count(*) into cg_exist from ipm_ph2to4_coeff a where 
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='COUNTRY GROUP' and a.coeff_value=cg;

  If cg_exist > 0
   then
     select coeff into cntry_coeff1 from ipm_ph2to4_coeff a where 
     a.geographical_location=gl and a.inpatient_status='Outpatient' and
     a.cpp_cpv='cpp' and a.coeff_type='COUNTRY GROUP' and a.coeff_value=cg;
  else
     cntry_coeff1:=0;
  end if;

  select count(*) into cg_exist from ipm_ph2to4_coeff a where 
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='COUNTRY GROUP' and a.coeff_value=cg;

  If cg_exist > 0
   then
     select coeff into cntry_coeff2 from ipm_ph2to4_coeff a where 
     a.geographical_location=gl and a.inpatient_status='Outpatient' and
     a.cpp_cpv='cpv' and a.coeff_type='COUNTRY GROUP' and a.coeff_value=cg;
  else
     cntry_coeff2:=0;
  end if;

  /* coefficient for duration starts here */

  select count(*) into dur_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='DURATION' ;
  
  If dur_exist > 0 
   then
     select coeff into dur_coeff1  from ipm_ph2to4_coeff a where
     a.geographical_location=gl and a.inpatient_status='Outpatient' and
     a.cpp_cpv='cpp' and a.coeff_type='DURATION' ;
  else
     dur_coeff1:=0;
  end if;

  select count(*) into dur_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='DURATION' ;
  
  If dur_exist > 0 
   then
     select coeff into dur_coeff2 from ipm_ph2to4_coeff a where
     a.geographical_location=gl and a.inpatient_status='Outpatient' and
     a.cpp_cpv='cpv' and a.coeff_type='DURATION' ;
  else
     dur_coeff2:=0;
  end if;

  /* coefficient for phase starts here */

  select count(*) into phase_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='PHASE' and a.cross_coeff_type is null and
  a.coeff_value= to_char(PhaseId) ;
 
  If phase_exist > 0 
   then
     select coeff into phase_coeff1 from ipm_ph2to4_coeff a where
     a.geographical_location=gl and a.inpatient_status='Outpatient' and
     a.cpp_cpv='cpp' and a.coeff_type='PHASE' and a.cross_coeff_type is null and
     a.coeff_value= to_char(PhaseId) ;
  else
     phase_coeff1:=0;
  end if;

  select count(*) into phase_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='PHASE' and a.cross_coeff_type is null and
  a.coeff_value= to_char(PhaseId) ;
 
  If phase_exist > 0 
   then
     select coeff into phase_coeff2 from ipm_ph2to4_coeff a where
     a.geographical_location=gl and a.inpatient_status='Outpatient' and
     a.cpp_cpv='cpv' and a.coeff_type='PHASE' and a.cross_coeff_type is null and
     a.coeff_value= to_char(PhaseId) ;
  else
     phase_coeff2:=0;
  end if;

  /* coefficient for affiliation starts here */

  select count(*) into affa_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='AFFILIATION' and a.coeff_value='Affiliated';

  If affa_exist > 0 then  
    select coeff into affa_coeff1 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpp' and a.coeff_type='AFFILIATION' and a.coeff_value='Affiliated';
  else
    affa_coeff1:=0;
  end if;

  select count(*) into affu_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='AFFILIATION' and a.coeff_value='Unaffiliated';
   
  If affu_exist > 0 then  
    select coeff into affu_coeff1 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpp' and a.coeff_type='AFFILIATION' and a.coeff_value='Unaffiliated';
  else
    affu_coeff1:=0;
  end if;

  If sst='Affiliated' 
    then
      aff_coeff1:=affa_coeff1;
  elsif sst='Unaffiliated'
    then
      aff_coeff1:=affu_coeff1;
  elsif sst='All'
    then
      aff_coeff1:=(affa_coeff1 + affu_coeff1)/2;
  end if;


  select count(*) into affa_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='AFFILIATION' and a.coeff_value='Affiliated';

  If affa_exist > 0 then  
    select coeff into affa_coeff2 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpv' and a.coeff_type='AFFILIATION' and a.coeff_value='Affiliated';
  else
    affa_coeff2:=0;
  end if;

  select count(*) into affu_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='AFFILIATION' and a.coeff_value='Unaffiliated';
   
  If affu_exist > 0 then  
    select coeff into affu_coeff2 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpv' and a.coeff_type='AFFILIATION' and a.coeff_value='Unaffiliated';
  else
    affu_coeff2:=0;
  end if;

  If sst='Affiliated' 
    then
      aff_coeff2:=affa_coeff2;
  elsif sst='Unaffiliated'
    then
      aff_coeff2:=affu_coeff2;
  elsif sst='All'
    then
      aff_coeff2:=(affa_coeff2 + affu_coeff2)/2;
  end if;

   /* coefficient for Phase * affiliation starts here */

  select count(*) into phaseaffa_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
  a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Affiliated';
  
  If phaseaffa_exist > 0 then
    select coeff into phaseaffa_coeff1 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpp' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
    a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Affiliated';
  else
    phaseaffa_coeff1:=0;
  end if;

  select count(*) into phaseaffu_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpp' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
  a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Unaffiliated';
  
  If phaseaffu_exist > 0 then
    select coeff into phaseaffu_coeff1 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpp' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
    a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Unaffiliated';
  else
    phaseaffu_coeff1:=0;
  end if;
  
  If sst='Affiliated' 
    then
      phaseaff_coeff1:=phaseaffa_coeff1;
  elsif sst='Unaffiliated'
    then
      phaseaff_coeff1:=phaseaffu_coeff1;
  elsif sst='All'
    then
      phaseaff_coeff1:=(phaseaffa_coeff1 + phaseaffu_coeff1)/2;
  end if;


  select count(*) into phaseaffa_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
  a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Affiliated';
  
  If phaseaffa_exist > 0 then
    select coeff into phaseaffa_coeff2 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpv' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
    a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Affiliated';
  else
    phaseaffa_coeff2:=0;
  end if;

  select count(*) into phaseaffu_exist from ipm_ph2to4_coeff a where
  a.geographical_location=gl and a.inpatient_status='Outpatient' and
  a.cpp_cpv='cpv' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
  a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Unaffiliated';
  
  If phaseaffu_exist > 0 then
    select coeff into phaseaffu_coeff2 from ipm_ph2to4_coeff a where
    a.geographical_location=gl and a.inpatient_status='Outpatient' and
    a.cpp_cpv='cpv' and a.coeff_type='PHASE' and a.coeff_value=to_char(PhaseId) and
    a.cross_coeff_type='AFFILIATION' and a.cross_coeff_value='Unaffiliated';
  else
    phaseaffu_coeff2:=0;
  end if;
  
  If sst='Affiliated' 
    then
      phaseaff_coeff2:=phaseaffa_coeff2;
  elsif sst='Unaffiliated'
    then
      phaseaff_coeff2:=phaseaffu_coeff2;
  elsif sst='All'
    then
      phaseaff_coeff2:=(phaseaffa_coeff2 + phaseaffu_coeff2)/2;
  end if;

/* dbms_output.put_line('indmap_coeff1: '||indmap_coeff1);
dbms_output.put_line('cntry_coeff1: '||cntry_coeff1);
dbms_output.put_line('aff_coeff1: '||aff_coeff1);
dbms_output.put_line('dur_coeff1: '||dur_coeff1);
dbms_output.put_line('phase_coeff1: '||phase_coeff1);
dbms_output.put_line('phaseaff_coeff1: '||phaseaff_coeff1); */


  cpp_pred_value:= power((indmap_coeff1+cntry_coeff1+aff_coeff1+(dur_coeff1*sd)+phase_coeff1+phaseaff_coeff1),2);
  cpv_pred_value:= power((indmap_coeff2+cntry_coeff2+aff_coeff2+(dur_coeff2*sd)+phase_coeff2+phaseaff_coeff2),2);

end;
/
sho err


--******************************************************************
--******************************************************************
-- PROCEDURE ipt_ph2to4_base_calc
--******************************************************************
--******************************************************************


create or replace procedure ipt_ph2to4_base_calc (CountryId in number, 
PhaseId in number,IndmapId in number,StudyDuration in varchar2,
sst in varchar2, ps1 in varchar2,sd in number, cg in varchar2, 
gl in varchar2,IndmapType in varchar2,cpp_pred_value out number,
cpv_pred_value out number,dur_coeff1 out number,dur_coeff2 out number,
aff_coeff1 out number, aff_coeff2 out number ) as

adj_exist	number(4);
adj_cg_exist	number(4);
adj_gl_exist	number(4);
adj_indgrp	number(10);
adj_coeff	number(20,12);


begin


ipt_ph2to4_parm_base_calc (CountryId,PhaseId,IndmapId,StudyDuration,sst,ps1,sd,cg,gl,
IndmapType,cpp_pred_value,cpv_pred_value,dur_coeff1,dur_coeff2,aff_coeff1,aff_coeff2);



 /* Calculations for adjustments starts here */
 /* changes done on 04/18/2003 after receiving the adjustment changes from Chik */


  If IndmapType='Indication' 
    then
        select parent_indmap_id into adj_indgrp from indmap where id=IndmapID;

  elsif IndmapType='Indication Group'
    then
        adj_indgrp:=IndmapID;
  else  
	adj_indgrp:=-100;
  end if;


  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where substr(geographical_location,1,3)=gl
  and inpatient_status='Outpatient' and cpp_cpv = 'cpp' and coeff_type='INDGRP' and
  coeff_value=to_char(adj_indgrp);

  If adj_exist > 0 then
  
      select coeff into adj_coeff from ipm_ph2to4_adj_coeff where substr(geographical_location,1,3)=gl
      and inpatient_status='Outpatient' and cpp_cpv = 'cpp' and coeff_type='INDGRP' and
      coeff_value=to_char(adj_indgrp);
  
      cpp_pred_value:=cpp_pred_value*adj_coeff;
  end if;

  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where substr(geographical_location,1,3)=gl
  and inpatient_status='Outpatient' and cpp_cpv = 'cpv' and coeff_type='INDGRP' and
  coeff_value=to_char(adj_indgrp);

  If adj_exist > 0 then
  
      select coeff into adj_coeff from ipm_ph2to4_adj_coeff where substr(geographical_location,1,3)=gl
      and inpatient_status='Outpatient' and cpp_cpv = 'cpv' and coeff_type='INDGRP' and
      coeff_value=to_char(adj_indgrp);

      cpv_pred_value:=cpv_pred_value*adj_coeff;
  end if;

  select count(*) into adj_exist from ipm_ph2to4_adj_country_ratio where country_id=CountryId;
  
  If adj_exist > 0 then

        If lower(trim(StudyDuration)) = '>3 years' then
              If PhaseId in (2,5) then
                   select y3p2 into adj_coeff from ipm_ph2to4_adj_country_ratio where 
                   country_id=CountryId;
              elsif PhaseId = 19 then
                   select y3p3 into adj_coeff from ipm_ph2to4_adj_country_ratio where 
                   country_id=CountryId;
              else 
                   adj_coeff:=1;
              end if;
        else
             If PhaseId in (2,5) then
                   select p2 into adj_coeff from ipm_ph2to4_adj_country_ratio where 
                   country_id=CountryId;
              elsif PhaseId = 19 then
                   select p3 into adj_coeff from ipm_ph2to4_adj_country_ratio where 
                   country_id=CountryId;
              else 
                   adj_coeff:=1;
              end if;
        end if;

        cpp_pred_value:=cpp_pred_value*adj_coeff;
	cpv_pred_value:=cpv_pred_value*adj_coeff;
 
  end if;  

  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where coeff_type = 'DURATION'
  and coeff_value = to_char(sd);

  If adj_exist > 0 then
  
      select coeff into adj_coeff from ipm_ph2to4_adj_coeff where coeff_type = 'DURATION'
      and coeff_value = to_char(sd);

      cpp_pred_value:=cpp_pred_value*adj_coeff;
      cpv_pred_value:=cpv_pred_value*adj_coeff;

  end if;

  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where coeff_type = 'PHASE'
  and coeff_value = to_char(PhaseId);

  If adj_exist > 0 then
  
      select coeff into adj_coeff from ipm_ph2to4_adj_coeff where coeff_type = 'PHASE'
      and coeff_value = to_char(PhaseId);

      cpp_pred_value:=cpp_pred_value*adj_coeff;
      cpv_pred_value:=cpv_pred_value*adj_coeff;

  end if;

end;
/
sho err


--******************************************************************
--******************************************************************
-- PROCEDURE ipt_ph2to4_model
--******************************************************************
--******************************************************************


create or replace procedure ipt_ph2to4_model (CountryId in number, PhaseId in number,
IndmapId in number, StudySiteType in varchar2, PatientStaus in varchar2,
StudyDuration in varchar2, low1 out number, mid1 out number, 
high1 out number, low2 out number, mid2 out number, 
high2 out number, cpp_sc out varchar2, cpv_sc out varchar2) as

sst investig.affiliation%type;
ps1  protocol.inpatient_status%type;
sd   number(10,2);
cg   ipm_geographical_location.country_group%type;
gl   ipm_geographical_location.geographical_location%type;
IndmapType indmap.type%type;

aff_coeff1 number(20,12);
dur_coeff1 number(20,12);
aff_coeff2 number(20,12);
dur_coeff2 number(20,12);

ipt_complex_coeff number(20,12);

ipm_cpp_exist number(4);
ipm_weight_exist number(4);
ipt_complex_exist number(4);
ipm_std_exist  number(4);
lkup_exist number(4);
compare_ipm_std_exist number(4);

cpp_pred_value number(20,12);
cpv_pred_value number(20,12);
cpp_complex_value number(20,12);


adj_exist	number(4);
adj_cg_exist	number(4);
adj_gl_exist	number(4);
adj_indgrp	number(10);
adj_coeff	number(20,12);

low_cpp1 number(20,12);
mid_cpp1 number(20,12);
high_cpp1 number(20,12);
low_cpp2 number(20,12);
mid_cpp2 number(20,12);
high_cpp2 number(20,12);
low_std1 number(20,12);
mid_std1 number(20,12);
high_std1 number(20,12);
low_std2 number(20,12);
mid_std2 number(20,12);
high_std2 number(20,12);
check_cpp_std number(20,12);
check_cpv_std number(20,12);
cpp_std varchar2(10);

dur_lkup_coeff number(20,12);
dur_lkup number(6,2);
i_low1 number(20,12);
i_mid1 number(20,12);
i_high1 number(20,12);
i_low2 number(20,12);
i_mid2 number(20,12);
i_high2 number(20,12);

ph_cpp_pred_value number(20,12);
ph_cpv_pred_value number(20,12);
ph_aff_coeff1 number(20,12);
ph_dur_coeff1 number(20,12);
ph_aff_coeff2 number(20,12);
ph_dur_coeff2 number(20,12);

usa_cpp_pred_value number(20,12);
usa_cpv_pred_value number(20,12);
usa_aff_coeff1 number(20,12);
usa_dur_coeff1 number(20,12);
usa_aff_coeff2 number(20,12);
usa_dur_coeff2 number(20,12);

compare_low_std1 number(20,12);
compare_high_std1 number(20,12);
compare_low_std2 number(20,12);
compare_high_std2 number(20,12);

iw_adj_exist  number(4);
iw_adj_coeff number(20,12);


begin

if lower(trim(StudySiteType))='allsites'
  then
    sst:='All';
 elsif lower(trim(StudySiteType))='affiliated' 
  then
    sst:='Affiliated';
 elsif lower(trim(StudySiteType))='unaffiliated' 
  then
    sst:='Unaffiliated';
end if;

if lower(trim(PatientStaus))='inpatient'
   then
      ps1:='Inpatient' ;
  elsif lower(trim(PatientStaus))='outpatient'
   then
      ps1:='Outpatient' ;
end if;


if lower(trim(StudyDuration))='1-3 weeks' 
  then
    sd:=14;
 elsif lower(trim(StudyDuration))='4-7 weeks' 
  then
    sd:=38.5;
 elsif lower(trim(StudyDuration))='8-11 weeks' 
  then
    sd:=66.5;
 elsif lower(trim(StudyDuration))='12-20 weeks' 
  then
    sd:=112;
 elsif lower(trim(StudyDuration))='21-25 weeks' 
  then
    sd:=161;
 elsif lower(trim(StudyDuration))='26-32 weeks' 
  then
    sd:=203;
 elsif lower(trim(StudyDuration))='33-40 weeks' 
  then
    sd:=255.5;
 elsif lower(trim(StudyDuration))='41-44 weeks' 
  then
    sd:=297.5;
 elsif lower(trim(StudyDuration))='45-52 weeks' 
  then
    sd:=339.5;
 elsif lower(trim(StudyDuration))='53-58 weeks' 
  then
    sd:=388.5;
 elsif lower(trim(StudyDuration))='1-2 years' 
  then
    sd:=547.5;
 elsif lower(trim(StudyDuration))='2-3 years' 
  then
    sd:=912.5;
 elsif lower(trim(StudyDuration))='>3 years' 
  then
    sd:=1277.5;
end if;


select country_group, substr(geographical_location,1,3) into cg,gl from 
ipm_geographical_location where country_id=CountryId;

select type into IndmapType from indmap where id=IndmapId;

-- ******* Call base procedures here *******

If PhaseId = 2 
  then
 
   ipt_ph2to4_base_calc (CountryId,19,IndmapId,StudyDuration,sst,ps1,sd,cg,gl,
   IndmapType,ph_cpp_pred_value,ph_cpv_pred_value,ph_dur_coeff1,ph_dur_coeff2,
   ph_aff_coeff1,ph_aff_coeff2);

elsif PhaseId = 19
   then

   ipt_ph2to4_base_calc (CountryId,2,IndmapId,StudyDuration,sst,ps1,sd,cg,gl,
   IndmapType,ph_cpp_pred_value,ph_cpv_pred_value,ph_dur_coeff1,ph_dur_coeff2,
   ph_aff_coeff1,ph_aff_coeff2);

end if;
     
ipt_ph2to4_base_calc (CountryId,PhaseId,IndmapId,StudyDuration,sst,ps1,sd,cg,gl,
IndmapType,cpp_pred_value,cpv_pred_value,dur_coeff1,dur_coeff2,aff_coeff1,aff_coeff2);

If PhaseId = 2 and cpp_pred_value < (ph_cpp_pred_value * 1.08) 
   then
      cpp_pred_value:=((cpp_pred_value+ph_cpp_pred_value)/2)*1.04;
elsif PhaseId = 19 and  ph_cpp_pred_value < (cpp_pred_value * 1.08) 
   then
      cpp_pred_value:=((cpp_pred_value+ph_cpp_pred_value)/2)*.95;
end if;

If PhaseId = 2 and cpv_pred_value < (ph_cpv_pred_value * 1.08) 
   then
      cpv_pred_value:=((cpv_pred_value+ph_cpv_pred_value)/2)*1.04;
elsif PhaseId = 19 and  ph_cpv_pred_value < (cpv_pred_value * 1.08) 
   then
      cpv_pred_value:=((cpv_pred_value+ph_cpv_pred_value)/2)*.95;
end if;

   /* calculations for low, mid and high starts here */


  select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
  and patient_status='Outpatient' and olow is not null and omid is not null and ohigh is not null ;

    If IndmapType='Indication' then

       select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Outpatient' and olow is not null and omid is not null and ohigh is not null ;

       if ipm_cpp_exist > 0  then

    	  select cpp_pred_value*olow,cpp_pred_value*omid,cpp_pred_value*ohigh, 
    	  cpv_pred_value*olow,cpv_pred_value*omid,cpv_pred_value*ohigh into 
    	  low_cpp1,mid_cpp1,high_cpp1,low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Outpatient';

          cpp_std:='cpp';

       else

          select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b where a.indmap_id=b.parent_indmap_id
	  and a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Outpatient' 
	  and a.olow is not null and a.omid is not null and a.ohigh is not null ;

          if ipm_cpp_exist > 0  then

    	    select cpp_pred_value*olow,cpp_pred_value*omid,cpp_pred_value*ohigh, 
    	    cpv_pred_value*olow,cpv_pred_value*omid,cpv_pred_value*ohigh into 
    	    low_cpp1,mid_cpp1,high_cpp1,low_cpp2,mid_cpp2,high_cpp2 from 
	    ipm_cpp a, indmap b where a.indmap_id=b.parent_indmap_id
    	    and a.phase_id=PhaseId and b.id=IndmapId and patient_status='Outpatient';
            
            cpp_std:='cpp';


          else
          
             select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b, indmap c 
	     where a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	     a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Outpatient' 
	     and a.olow is not null and a.omid is not null and a.ohigh is not null ;            

             if ipm_cpp_exist > 0  then

    	         select cpp_pred_value*olow,cpp_pred_value*omid,cpp_pred_value*ohigh, 
    	         cpv_pred_value*olow,cpv_pred_value*omid,cpv_pred_value*ohigh into 
    	         low_cpp1,mid_cpp1,high_cpp1,low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp a, indmap b, indmap c where 
		 a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
    	         a.phase_id=PhaseId and b.id=IndmapId and patient_status='Outpatient';

                 cpp_std:='cpp';

             else


   		 select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    		 phase_id=PhaseId;	

                 If ipm_std_exist > 0 then 

   		   select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2)),
    		   cpv_pred_value-(1.25*power(nvl(std_cpv,0),2)), cpv_pred_value, cpv_pred_value+(1.25*power(nvl(std_cpv,0),2)) into 
    		   low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and 
		   country_group=cg and phase_id=PhaseId;
     
                   cpp_std:='std';

                 else
                
                   select cpp_pred_value,cpp_pred_value,cpp_pred_value,cpv_pred_value,cpv_pred_value,cpv_pred_value into 
    		   low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from dual;

                   cpp_std:='std';

                 end if;

             end if;
           end if;
         end if;

    elsif IndmapType='Indication Group' then

       select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Outpatient' and olow is not null and omid is not null and ohigh is not null ;


       if ipm_cpp_exist > 0  then

    	  select cpp_pred_value*olow,cpp_pred_value*omid,cpp_pred_value*ohigh, 
    	  cpv_pred_value*olow,cpv_pred_value*omid,cpv_pred_value*ohigh into 
    	  low_cpp1,mid_cpp1,high_cpp1,low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Outpatient';

          cpp_std:='cpp';

       else

          select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b where a.indmap_id=b.parent_indmap_id
	  and a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Outpatient' 
	  and a.olow is not null and a.omid is not null and a.ohigh is not null ;

          if ipm_cpp_exist > 0  then

    	    select cpp_pred_value*olow,cpp_pred_value*omid,cpp_pred_value*ohigh, 
    	    cpv_pred_value*olow,cpv_pred_value*omid,cpv_pred_value*ohigh into 
    	    low_cpp1,mid_cpp1,high_cpp1,low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp a, indmap b where a.indmap_id=b.parent_indmap_id
    	    and a.phase_id=PhaseId and b.id=IndmapId and patient_status='Outpatient';

            cpp_std:='cpp';

          else

   	    select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	    phase_id=PhaseId;	

            If ipm_std_exist > 0 then  

      	      select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2)),
    	      cpv_pred_value-(1.25*power(nvl(std_cpv,0),2)), cpv_pred_value, cpv_pred_value+(1.25*power(nvl(std_cpv,0),2)) into 
    	      low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and 
	      country_group=cg and phase_id=PhaseId;

              cpp_std:='std';

           else
              
              select cpp_pred_value,cpp_pred_value,cpp_pred_value,cpv_pred_value,cpv_pred_value,cpv_pred_value into 
 	      low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from dual;

              cpp_std:='std';

           end if;
         
          end if;
        end if;

    elsif IndmapType='Therapeutic Area' then

      select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Outpatient' and olow is not null and omid is not null and ohigh is not null ;


       if ipm_cpp_exist > 0  then

    	  select cpp_pred_value*olow,cpp_pred_value*omid,cpp_pred_value*ohigh, 
    	  cpv_pred_value*olow,cpv_pred_value*omid,cpv_pred_value*ohigh into 
    	  low_cpp1,mid_cpp1,high_cpp1,low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Outpatient';

          cpp_std:='cpp';

       else

   	  select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	  phase_id=PhaseId;	

          If ipm_std_exist > 0 then

      	    select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2)),
    	    cpv_pred_value-(1.25*power(nvl(std_cpv,0),2)), cpv_pred_value, cpv_pred_value+(1.25*power(nvl(std_cpv,0),2)) into 
    	    low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and 
	    country_group=cg and phase_id=PhaseId;

            cpp_std:='std';

           else
              
              select cpp_pred_value,cpp_pred_value,cpp_pred_value,cpv_pred_value,cpv_pred_value,cpv_pred_value into 
 	      low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from dual;

              cpp_std:='std';

           end if;


       end if;

    end if;



      /* check whether to use factors or standard deviation for L,M,H calculation */

    if cpp_std = 'cpp' then
	
 	select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and 
	country_group=cg and phase_id=PhaseId;	

        If ipm_std_exist > 0 then 

   		select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2)),
    		cpv_pred_value-(1.25*power(nvl(std_cpv,0),2)), cpv_pred_value, cpv_pred_value+(1.25*power(nvl(std_cpv,0),2)) into 
    		low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and 
		country_group=cg and phase_id=PhaseId;

        else
                
                select cpp_pred_value,cpp_pred_value,cpp_pred_value,cpv_pred_value,cpv_pred_value,cpv_pred_value into 
    		low_std1,mid_std1,high_std1,low_std2,mid_std2,high_std2 from dual;


        end if;

       check_cpp_std:=(high_cpp1 - low_cpp1) - (high_std1 - low_std1);

       if check_cpp_std < 0 then

           	low1:=low_cpp1;
		mid1:=mid_cpp1;
                high1:=high_cpp1;
        else
                low1:=low_std1;
		mid1:=mid_std1;
		high1:=high_std1;
	end if;

       check_cpv_std:=(high_cpp2 - low_cpp2) - (high_std2 - low_std2);

       if check_cpv_std < 0 then

           	low2:=low_cpp2;
		mid2:=mid_cpp2;
                high2:=high_cpp2;
        else
                low2:=low_std2;
		mid2:=mid_std2;
		high2:=high_std2;
	end if;

   elsif    cpp_std = 'std' then

                low1:=low_std1;
		mid1:=mid_std1;
		high1:=high_std1;
                low2:=low_std2;
		mid2:=mid_std2;
		high2:=high_std2;

   end if;
              

   /* Adjustments for low against ipm_weight starts here */

select count(*) into iw_adj_exist from ipm_ph2to4_adj_coeff where coeff_type = 'DURATION'
and coeff_value = to_char(sd);

If iw_adj_exist > 0 then
  
   select coeff into iw_adj_coeff from ipm_ph2to4_adj_coeff where coeff_type = 'DURATION'
   and coeff_value = to_char(sd);

else

   iw_adj_coeff:=1;

end if;

    If IndmapType='Indication' then

       select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       if ipm_weight_exist > 0  then

     	  select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128)))
          into low1,mid1,high1 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;
        
       else

          select count(*) into ipm_weight_exist from ipm_weight a,indmap b where 
          a.indmap_id=b.parent_indmap_id and
	  country_id = CountryId and phase_id=PhaseId and 
          b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          if ipm_weight_exist > 0  then

    	    select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128)))
	    into low1,mid1,high1 from ipm_weight a,indmap b where 
            a.indmap_id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          else
          
            select count(*) into ipm_weight_exist from ipm_weight a,indmap b, indmap c where 
            a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;      

            if ipm_weight_exist > 0  then

     	    select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) into 
	    low1,mid1,high1 from ipm_weight a,indmap b, indmap c where 
            a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;    

             else

               select decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128)),
		decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128)),
		decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))
 	       into low1,mid1,high1 from dual;

             end if;
           end if;
         end if;

    elsif IndmapType='Indication Group' then

       select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		 decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		 decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) 
	  into low1,mid1,high1 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       else

          select count(*) into ipm_weight_exist from ipm_weight a,indmap b where 
          a.indmap_id=b.parent_indmap_id and
	  country_id = CountryId and phase_id=PhaseId and 
          b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          if ipm_weight_exist > 0  then

    	    select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) 
	    into low1,mid1,high1 from ipm_weight a,indmap b where 
            a.indmap_id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          else

               select decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128)),
		decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128)),
		decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))
 	       into low1,mid1,high1 from dual;

          end if;
        end if;
 
    elsif IndmapType='Therapeutic Area' then

      select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		 decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		 decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) 
	  into low1,mid1,high1 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       else

            select decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128)),
		decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128)),
		decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))
 	    into low1,mid1,high1 from dual;

       end if;
 

  end if;


 If low2 between 51 and 84 
  then
    low2:=low2*1.8*iw_adj_coeff;
    mid2:=mid2*1.8*iw_adj_coeff;
    high2:=high2*1.8*iw_adj_coeff;

 elsif low2 <= 50
  then
    while low2 < 85
     loop 

       low2:=low2+(40*iw_adj_coeff);
       mid2:=mid2+(40*iw_adj_coeff);
       high2:=high2+(40*iw_adj_coeff);

    end loop;
 end if;


  /* calculation for cpp using lookup table factors starts here on 04/29/2003 */

select count(*) into compare_ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
phase_id=PhaseId;	

If compare_ipm_std_exist > 0 then  
  select cpp_pred_value-(2*power(nvl(std_cpp,0),2)), cpp_pred_value+(2*power(nvl(std_cpp,0),2)),
  cpv_pred_value-(2*power(nvl(std_cpv,0),2)), cpv_pred_value+(2*power(nvl(std_cpv,0),2)) into 
  compare_low_std1,compare_high_std1,compare_low_std2,compare_high_std2 from ipm_std where geographical_location=gl and 
  country_group=cg and phase_id=PhaseId;
else
  select cpp_pred_value, cpp_pred_value,cpv_pred_value, cpv_pred_value into 
  compare_low_std1,compare_high_std1,compare_low_std2,compare_high_std2 from dual;
end if;
 

cpp_sc:='G' ;

select count(*) into lkup_exist from ipm_ph2to4_lkup_coeff where country_id=countryid and
phase_id = phaseid and indmap_id = indmapid and cpp_cpv = 'cpp';

If lkup_exist > 0 then

 select duration into dur_lkup from ipm_ph2to4_lkup_coeff 
 where country_id=countryid and phase_id = phaseid and indmap_id = indmapid and cpp_cpv = 'cpp';

 dur_lkup_coeff:= power(((sd-dur_lkup)*dur_coeff1),2)*sign(sd-dur_lkup);

  if lower(trim(StudySiteType))='affiliated' 
    then
        dur_lkup_coeff:= dur_lkup_coeff + power(aff_coeff1,2);
  end if;

 select pct25+dur_lkup_coeff,pct50+dur_lkup_coeff,pct75+dur_lkup_coeff into i_low1,i_mid1,i_high1
 from ipm_ph2to4_lkup_coeff where country_id=countryid and phase_id = phaseid and
 indmap_id = indmapid and cpp_cpv = 'cpp';


 If i_mid1 between compare_low_std1 and compare_high_std1 then
    cpp_sc:='I' ;
 end if;

 If cpp_sc = 'I' then
   low1:=i_low1;
   mid1:=i_mid1;
   high1:=i_high1;
 end if; 

end if;


  /* calculation for cpv using lookup table factors starts here on 04/29/2003 */

cpv_sc:='G' ;

select count(*) into lkup_exist from ipm_ph2to4_lkup_coeff where country_id=countryid and
phase_id = phaseid and indmap_id = indmapid and cpp_cpv = 'cpv';

If lkup_exist > 0 then

 select duration into dur_lkup from ipm_ph2to4_lkup_coeff 
 where country_id=countryid and phase_id = phaseid and indmap_id = indmapid and cpp_cpv = 'cpv';

 dur_lkup_coeff:= power(((sd-dur_lkup)*dur_coeff2),2)*sign(sd-dur_lkup);

  if lower(trim(StudySiteType))='affiliated' 
    then
        dur_lkup_coeff:= dur_lkup_coeff + power(aff_coeff2,2);
  end if;

 select pct25+dur_lkup_coeff,pct50+dur_lkup_coeff,pct75+dur_lkup_coeff into i_low2,i_mid2,i_high2
 from ipm_ph2to4_lkup_coeff where country_id=countryid and phase_id = phaseid and
 indmap_id = indmapid and cpp_cpv = 'cpv';


 If i_mid2 between compare_low_std2 and compare_high_std2 then
    cpv_sc:='I' ;
 end if;

 If cpv_sc = 'I' then
   low2:=i_low2;
   mid2:=i_mid2;
   high2:=i_high2;
 end if; 

end if;



/* *************End computation of outpatient cost ************************ */

/* *************Start computation of Inpatient cost *********************** */



If ps1 = 'Inpatient'
  then

cpp_pred_value:=mid1;

    /* Calculations for adjustments starts here */
    /* changes done on 04/18/2003 after receiving the adjustment changes from Chik */


  If IndmapType='Indication' 
    then
        select parent_indmap_id into adj_indgrp from indmap where id=IndmapID;

  elsif IndmapType='Indication Group'
    then
        adj_indgrp:=IndmapID;
  else  
	adj_indgrp:=-100;
  end if;


  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where geographical_location is null
  and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='INDGRP' and
  coeff_value=to_char(adj_indgrp);

  If adj_exist > 0 then
  
     select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
     and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='INDGRP' and
     coeff_value=to_char(adj_indgrp);
  
  else
    
    select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
    and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='INDGRP' and
    upper(coeff_value)='OTHER';

  end if;

  cpp_pred_value:=cpp_pred_value*adj_coeff;

  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where geographical_location is null
  and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='LOCATION' and
  coeff_value = (select abbreviation from country where id=CountryId);

  If adj_exist > 0 
    then 

     select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
     and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='LOCATION' and
     coeff_value = (select abbreviation from country where id=CountryId);

  else

     select count(*) into adj_cg_exist from ipm_ph2to4_adj_coeff where geographical_location is null
     and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='LOCATION' and
     coeff_value = cg;

     If adj_cg_exist > 0 
       then
           select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
           and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='LOCATION' and
           coeff_value = cg;
     else
           select count(*) into adj_gl_exist from ipm_ph2to4_adj_coeff where geographical_location is null
           and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='LOCATION' and
           lower(coeff_value) = lower(gl)||'x';           

           If adj_gl_exist > 0 
            then
               select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
               and inpatient_status='Inpatient' and cpp_cpv = 'cpp' and coeff_type='LOCATION' and
               lower(coeff_value) = lower(gl)||'x';
           else
               adj_coeff:=1;
           end if;
     end if;
   end if;

   cpp_pred_value:=cpp_pred_value*adj_coeff;



 /* calculation for adjusting the complex predicted value starts here */


  select count(*) into adj_exist from ipm_ph2to4_adj_coeff where geographical_location is null
  and inpatient_status='Inpatient' and cpp_cpv = 'complex' and coeff_type='INDGRP' and
  coeff_value=to_char(adj_indgrp);

  If adj_exist > 0 then
  
     select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
     and inpatient_status='Inpatient' and cpp_cpv = 'complex' and coeff_type='INDGRP' and
     coeff_value=to_char(adj_indgrp);
  
  else
    
    select coeff into adj_coeff from ipm_ph2to4_adj_coeff where geographical_location is null
    and inpatient_status='Inpatient' and cpp_cpv = 'complex' and coeff_type='INDGRP' and
    upper(coeff_value)='OTHER';

  end if;

  cpp_complex_value:=cpp_pred_value*adj_coeff;



    /* Calculation for simple inpatient low, mid and high starts here */


    If IndmapType='Indication' then

       select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Inpatient' and low is not null and mid is not null and high is not null ;

       if ipm_cpp_exist > 0  then

    	  select cpp_pred_value*low,cpp_pred_value*mid,cpp_pred_value*high 
    	  into low_cpp1,mid_cpp1,high_cpp1 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Inpatient';

          cpp_std:='cpp';

       else

          select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b where a.indmap_id=b.parent_indmap_id
	  and a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Inpatient' 
	  and a.low is not null and a.mid is not null and a.high is not null ;

          if ipm_cpp_exist > 0  then

    	    select cpp_pred_value*low,cpp_pred_value*mid,cpp_pred_value*high
	    into low_cpp1,mid_cpp1,high_cpp1 from ipm_cpp a, indmap b where a.indmap_id=b.parent_indmap_id
    	    and a.phase_id=PhaseId and b.id=IndmapId and patient_status='Inpatient';

            cpp_std:='cpp';

          else
          
             select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b, indmap c 
	     where a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	     a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Inpatient' 
	     and a.low is not null and a.mid is not null and a.high is not null ;            

             if ipm_cpp_exist > 0  then

    	         select cpp_pred_value*low,cpp_pred_value*mid,cpp_pred_value*high
		 into low_cpp1,mid_cpp1,high_cpp1 from ipm_cpp a, indmap b, indmap c where 
		 a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
    	         a.phase_id=PhaseId and b.id=IndmapId and patient_status='Inpatient';

                 cpp_std:='cpp';

             else

   	         select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	         phase_id=PhaseId;	

                 If ipm_std_exist > 0 then  

   		    select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2))
                    into low_std1,mid_std1,high_std1 from ipm_std where geographical_location=gl and country_group=cg and 
                    phase_id=PhaseId;

                    cpp_std:='std';

                 else
              
                   select cpp_pred_value,cpp_pred_value,cpp_pred_value into 
 	           low_std1,mid_std1,high_std1 from dual;

                   cpp_std:='std';

                 end if;            

             end if;
           end if;
         end if;

    elsif IndmapType='Indication Group' then

       select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Inpatient' and low is not null and mid is not null and high is not null ;


       if ipm_cpp_exist > 0  then

    	  select cpp_pred_value*low,cpp_pred_value*mid,cpp_pred_value*high
	  into low_cpp1,mid_cpp1,high_cpp1 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Inpatient';

          cpp_std:='cpp';

       else

          select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b where a.indmap_id=b.parent_indmap_id
	  and a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Inpatient' 
	  and a.low is not null and a.mid is not null and a.high is not null ;

          if ipm_cpp_exist > 0  then

    	    select cpp_pred_value*low,cpp_pred_value*mid,cpp_pred_value*high
	    into low_cpp1,mid_cpp1,high_cpp1 from ipm_cpp a, indmap b where a.indmap_id=b.parent_indmap_id
    	    and a.phase_id=PhaseId and b.id=IndmapId and patient_status='Inpatient';

            cpp_std:='cpp';

          else

   	    select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	    phase_id=PhaseId;	

            If ipm_std_exist > 0 then  

              select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2))
              into low_std1,mid_std1,high_std1 from ipm_std where geographical_location=gl and country_group=cg and 
              phase_id=PhaseId;

              cpp_std:='std';

            else
              
              select cpp_pred_value,cpp_pred_value,cpp_pred_value into 
 	      low_std1,mid_std1,high_std1 from dual;

              cpp_std:='std';

            end if;    

         
          end if;
        end if;

    elsif IndmapType='Therapeutic Area' then

      select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Inpatient' and low is not null and mid is not null and high is not null ;


       if ipm_cpp_exist > 0  then

    	  select cpp_pred_value*low,cpp_pred_value*mid,cpp_pred_value*high
	  into low_cpp1,mid_cpp1,high_cpp1 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Inpatient';

          cpp_std:='cpp';

       else

   	  select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	  phase_id=PhaseId;	

          If ipm_std_exist > 0 then  

            select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2))
            into low_std1,mid_std1,high_std1 from ipm_std where geographical_location=gl and country_group=cg and 
            phase_id=PhaseId;

            cpp_std:='std';

          else
              
            select cpp_pred_value,cpp_pred_value,cpp_pred_value into 
 	    low_std1,mid_std1,high_std1 from dual;

            cpp_std:='std';

          end if;  

       end if;

    end if;




      /* check whether to use factors or standard deviation for L,M,H calculation in simple inpatient value */

    if cpp_std = 'cpp' then
	
   	  select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	  phase_id=PhaseId;	

        If ipm_std_exist > 0 then 

            select cpp_pred_value-(1.25*power(nvl(std_cpp,0),2)), cpp_pred_value, cpp_pred_value+(1.25*power(nvl(std_cpp,0),2))
            into low_std1,mid_std1,high_std1 from ipm_std where geographical_location=gl and country_group=cg and 
            phase_id=PhaseId;

        else
                
            select cpp_pred_value,cpp_pred_value,cpp_pred_value into 
 	    low_std1,mid_std1,high_std1 from dual;


        end if;

       check_cpp_std:=(high_cpp1 - low_cpp1) - (high_std1 - low_std1);

       if check_cpp_std < 0 then

           	low1:=low_cpp1;
		mid1:=mid_cpp1;
                high1:=high_cpp1;
        else
                low1:=low_std1;
		mid1:=mid_std1;
		high1:=high_std1;
	end if;

   elsif    cpp_std = 'std' then

                low1:=low_std1;
		mid1:=mid_std1;
		high1:=high_std1;

   end if;

    /* Calculation for complex inpatient low, mid and high starts here */


    If IndmapType='Indication' then

       select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Inpatient' and clow is not null and cmid is not null and chigh is not null ;

       if ipm_cpp_exist > 0  then

    	  select cpp_complex_value*clow,cpp_complex_value*cmid,cpp_complex_value*chigh 
    	  into low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Inpatient';

          cpp_std:='cpp';

       else

          select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b where a.indmap_id=b.parent_indmap_id
	  and a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Inpatient' 
	  and a.clow is not null and a.cmid is not null and a.chigh is not null ;

          if ipm_cpp_exist > 0  then

    	    select cpp_complex_value*clow,cpp_complex_value*cmid,cpp_complex_value*chigh
	    into low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp a, indmap b where a.indmap_id=b.parent_indmap_id
    	    and a.phase_id=PhaseId and b.id=IndmapId and patient_status='Inpatient';

            cpp_std:='cpp';

          else
          
             select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b, indmap c 
	     where a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	     a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Inpatient' 
	     and a.clow is not null and a.cmid is not null and a.chigh is not null ;            

             if ipm_cpp_exist > 0  then

    	         select cpp_complex_value*clow,cpp_complex_value*cmid,cpp_complex_value*chigh
		 into low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp a, indmap b, indmap c where 
		 a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
    	         a.phase_id=PhaseId and b.id=IndmapId and patient_status='Inpatient';

                 cpp_std:='cpp';

             else

   	         select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	         phase_id=PhaseId;	

                 If ipm_std_exist > 0 then  

   		    select cpp_complex_value-(1.25*power(nvl(std_cpp,0),2)), cpp_complex_value, cpp_complex_value+(1.25*power(nvl(std_cpp,0),2))
                    into low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and country_group=cg and 
                    phase_id=PhaseId;

                    cpp_std:='std';

                 else
              
                   select cpp_complex_value,cpp_complex_value,cpp_complex_value into 
 	           low_std2,mid_std2,high_std2 from dual;

                   cpp_std:='std';

                 end if;            

             end if;
           end if;
         end if;

    elsif IndmapType='Indication Group' then

       select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Inpatient' and clow is not null and cmid is not null and chigh is not null ;


       if ipm_cpp_exist > 0  then

    	  select cpp_complex_value*clow,cpp_complex_value*cmid,cpp_complex_value*chigh
	  into low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Inpatient';

          cpp_std:='cpp';

       else

          select count(*) into ipm_cpp_exist from ipm_cpp a,indmap b where a.indmap_id=b.parent_indmap_id
	  and a.phase_id=PhaseId and b.id= IndmapId and a.patient_status='Inpatient' 
	  and a.clow is not null and a.cmid is not null and a.chigh is not null ;

          if ipm_cpp_exist > 0  then

    	    select cpp_complex_value*clow,cpp_complex_value*cmid,cpp_complex_value*chigh
	    into low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp a, indmap b where a.indmap_id=b.parent_indmap_id
    	    and a.phase_id=PhaseId and b.id=IndmapId and patient_status='Inpatient';

            cpp_std:='cpp';

          else

   	    select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	    phase_id=PhaseId;	

            If ipm_std_exist > 0 then  

              select cpp_complex_value-(1.25*power(nvl(std_cpp,0),2)), cpp_complex_value, cpp_complex_value+(1.25*power(nvl(std_cpp,0),2))
              into low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and country_group=cg and 
              phase_id=PhaseId;

              cpp_std:='std';

            else
              
              select cpp_complex_value,cpp_complex_value,cpp_complex_value into 
 	      low_std2,mid_std2,high_std2 from dual;

              cpp_std:='std';

            end if;    

         
          end if;
        end if;

    elsif IndmapType='Therapeutic Area' then

      select count(*) into ipm_cpp_exist from ipm_cpp where phase_id=PhaseId and indmap_id=IndmapId
       and patient_status='Inpatient' and clow is not null and cmid is not null and chigh is not null ;


       if ipm_cpp_exist > 0  then

    	  select cpp_complex_value*clow,cpp_complex_value*cmid,cpp_complex_value*chigh
	  into low_cpp2,mid_cpp2,high_cpp2 from ipm_cpp where 
    	  phase_id=PhaseId and indmap_id=IndmapId and patient_status='Inpatient';

          cpp_std:='cpp';

       else

   	  select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	  phase_id=PhaseId;	

          If ipm_std_exist > 0 then  

            select cpp_complex_value-(1.25*power(nvl(std_cpp,0),2)), cpp_complex_value, cpp_complex_value+(1.25*power(nvl(std_cpp,0),2))
            into low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and country_group=cg and 
            phase_id=PhaseId;

            cpp_std:='std';

          else
              
            select cpp_complex_value,cpp_complex_value,cpp_complex_value into 
 	    low_std2,mid_std2,high_std2 from dual;

            cpp_std:='std';

          end if;  

       end if;

    end if;




      /* check whether to use factors or standard deviation for L,M,H calculation in complex inpatient value */

    if cpp_std = 'cpp' then
	
   	  select count(*) into ipm_std_exist from ipm_std where geographical_location=gl and country_group=cg and 
    	  phase_id=PhaseId;	

        If ipm_std_exist > 0 then 

            select cpp_complex_value-(1.25*power(nvl(std_cpp,0),2)), cpp_complex_value, cpp_complex_value+(1.25*power(nvl(std_cpp,0),2))
            into low_std2,mid_std2,high_std2 from ipm_std where geographical_location=gl and country_group=cg and 
            phase_id=PhaseId;

        else
                
            select cpp_complex_value,cpp_complex_value,cpp_complex_value into 
 	    low_std2,mid_std2,high_std2 from dual;


        end if;

       check_cpp_std:=(high_cpp2 - low_cpp2) - (high_std2 - low_std2);

       if check_cpp_std < 0 then

           	low2:=low_cpp2;
		mid2:=mid_cpp2;
                high2:=high_cpp2;
        else
                low2:=low_std2;
		mid2:=mid_std2;
		high2:=high_std2;
	end if;

   elsif    cpp_std = 'std' then

                low2:=low_std2;
		mid2:=mid_std2;
		high2:=high_std2;

   end if;

    /* Comparing the low simple and complex costs against ipm_weight starts here */


  select count(*) into iw_adj_exist from ipm_ph2to4_adj_coeff where coeff_type = 'DURATION'
  and coeff_value = to_char(sd);

  If iw_adj_exist > 0 then
  
      select coeff into iw_adj_coeff from ipm_ph2to4_adj_coeff where coeff_type = 'DURATION'
      and coeff_value = to_char(sd);

  else

      iw_adj_coeff:=1;

  end if;





    If IndmapType='Indication' then

       select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		 decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		 decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) 
	  into low1,mid1,high1 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       else

          select count(*) into ipm_weight_exist from ipm_weight a,indmap b where 
          a.indmap_id=b.parent_indmap_id and
	  country_id = CountryId and phase_id=PhaseId and 
          b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          if ipm_weight_exist > 0  then

    	    select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) 
	    into low1,mid1,high1 from ipm_weight a,indmap b where 
            a.indmap_id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          else
          
            select count(*) into ipm_weight_exist from ipm_weight a,indmap b, indmap c where 
            a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;      

            if ipm_weight_exist > 0  then

     	    select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))) 
	    into low1,mid1,high1 from ipm_weight a,indmap b, indmap c where 
            a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;    

             else

               select decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128)),
		decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128)),
		decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))
 	       into low1,mid1,high1 from dual;

             end if;
           end if;
         end if;

    elsif IndmapType='Indication Group' then

       select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128)))
	  into low1,mid1,high1 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       else

          select count(*) into ipm_weight_exist from ipm_weight a,indmap b where 
          a.indmap_id=b.parent_indmap_id and
	  country_id = CountryId and phase_id=PhaseId and 
          b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          if ipm_weight_exist > 0  then

    	    select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		   decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		   decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128)))
	    into low1,mid1,high1 from ipm_weight a,indmap b where 
            a.indmap_id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

          else

               select decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128)),
		decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128)),
		decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))
 	       into low1,mid1,high1 from dual;

          end if;
        end if;
 
    elsif IndmapType='Therapeutic Area' then

      select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128))),
		 decode(sign(mid1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128))),
		 decode(sign(high1-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128)))
	  into low1,mid1,high1 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and minvalue is not null;

       else

          select decode(greatest(low1,128),128,128*iw_adj_coeff,greatest(low1,128)),
		decode(greatest(mid1,128),128,128*iw_adj_coeff,greatest(mid1,128)),
		decode(greatest(high1,128),128,128*iw_adj_coeff,greatest(high1,128))
 	  into low1,mid1,high1 from dual;

       end if;
 

 end if;



    If IndmapType='Indication' then

       select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128))),
		 decode(sign(mid2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128))),
		 decode(sign(high2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128)))
	  into low2,mid2,high2 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

       else

          select count(*) into ipm_weight_exist from ipm_weight a,indmap b where 
          a.indmap_id=b.parent_indmap_id and
	  country_id = CountryId and phase_id=PhaseId and 
          b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

          if ipm_weight_exist > 0  then

    	    select decode(sign(low2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128))),
		 decode(sign(mid2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128))),
		 decode(sign(high2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128)))
	    into low2,mid2,high2 from ipm_weight a,indmap b where 
            a.indmap_id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

          else
          
            select count(*) into ipm_weight_exist from ipm_weight a,indmap b, indmap c where 
            a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;      

            if ipm_weight_exist > 0  then

     	        select decode(sign(low2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128))),
		   decode(sign(mid2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128))),
		   decode(sign(high2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128)))
	        into low2,mid2,high2 from ipm_weight a,indmap b, indmap c where 
                a.indmap_id=c.parent_indmap_id and c.id=b.parent_indmap_id and
	        country_id = CountryId and phase_id=PhaseId and 
                b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;    

             else

               select decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128)),
		decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128)),
		decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128))
 	       into low2,mid2,high2 from dual;

             end if;
           end if;
         end if;

    elsif IndmapType='Indication Group' then

       select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128))),
		 decode(sign(mid2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128))),
		 decode(sign(high2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128)))
	  into low2,mid2,high2 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

       else

          select count(*) into ipm_weight_exist from ipm_weight a,indmap b where 
          a.indmap_id=b.parent_indmap_id and
	  country_id = CountryId and phase_id=PhaseId and 
          b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

          if ipm_weight_exist > 0  then

    	    select decode(sign(low2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128))),
		 decode(sign(mid2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128))),
		 decode(sign(high2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128)))
	    into low2,mid2,high2 from ipm_weight a,indmap b where 
            a.indmap_id=b.parent_indmap_id and
	    country_id = CountryId and phase_id=PhaseId and 
            b.id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

          else

               select decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128)),
		decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128)),
		decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128))
 	       into low2,mid2,high2 from dual;

          end if;
        end if;
 
    elsif IndmapType='Therapeutic Area' then

      select count(*) into ipm_weight_exist from ipm_weight where country_id = CountryId and phase_id=PhaseId and 
       indmap_id=IndmapId and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

       if ipm_weight_exist > 0  then

    	  select decode(sign(low2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128))),
		 decode(sign(mid2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128))),
		 decode(sign(high2-minvalue),-1,
			decode(greatest(minvalue*iw_adj_coeff,128),128,128*iw_adj_coeff,greatest(minvalue*iw_adj_coeff,128)),
			decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128)))
	  into low2,mid2,high2 from ipm_weight where  
	  country_id = CountryId and phase_id=PhaseId and indmap_id=IndmapId 
	  and affiliation=decode(sst,'All','AllSites',sst) and complex_minvalue is not null;

       else

          select decode(greatest(low2,128),128,128*iw_adj_coeff,greatest(low2,128)),
		decode(greatest(mid2,128),128,128*iw_adj_coeff,greatest(mid2,128)),
		decode(greatest(high2,128),128,128*iw_adj_coeff,greatest(high2,128))
 	  into low2,mid2,high2 from dual;

       end if;
 

 end if;

end if;
end;
/
sho err

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_business_factors_inc.sql$ 
--
-- $Revision: 4$        $Date: 2/27/2008 3:19:41 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
Insert into tsm_stage.ip_business_factors1 values(110, 
'Ph2+dur',  1,  2.0,   '1-3 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(111,
'Ph2+dur',  2,  5.5,   '4-7 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(112,
'Ph2+dur',  3,  9.5,  '8-11 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(113,
'Ph2+dur',  4, 16.0, '12-20 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(114,
'Ph2+dur',  5, 23.0, '21-25 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(115,
'Ph2+dur',  6, 29.0, '26-32 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(116,
'Ph2+dur',  7, 36.5, '33-40 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(117,
'Ph2+dur',  8, 42.5, '41-44 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(118,
'Ph2+dur',  9, 48.5, '45-52 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(119,
'Ph2+dur', 10, 55.5, '53-58 weeks', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(120,
'Ph2+dur', 11, -1.0,   '1-2 years', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(121,
'Ph2+dur', 12, -2.0,   '2-3 years', null, null, null);
Insert into tsm_stage.ip_business_factors1 values(122,
'Ph2+dur', 13, -3.0,    '>3 years', null, null, null);
Insert into tsm_stage.ip_business_factors1 values (123,'IOStatus',
1,1,'Inpatient',null,null,null);
Insert into tsm_stage.ip_business_factors1 values (124,'IOStatus',
2,-1,'Outpatient',null,null,null);
Insert into tsm_stage.ip_business_factors1 values (125,'IOStatus',
3,0,'Mixed',null,null,null);

commit;



update tsm_stage.ip_business_factors1 set short_desc = 'AllSites' 
	where type = 'Sites' and short_desc = 'All sites';

update tsm_stage.ip_business_factors1 set short_desc = 'ClinResearchCenter' 
	where type = 'Sites' and short_desc = 'Clinical Research Center';

update tsm_stage.ip_business_factors1 set short_desc = 'PhysClinic' 
	where type = 'Sites' and short_desc = 'Physician''s clinic/outpatient';

commit;

 
declare

 ibf_maxid number(10);
 ibf_exist number(3);
 seqno number(3);

 cursor c1 is select short_desc from tsm_stage.ip_business_factors1 where type = 'Study'
 and short_desc not in ('All studies') order by short_desc;

 cursor c2 is select short_desc from tsm_stage.ip_business_factors1 where type = 'Populate'
 and short_desc not in ('Healthy subjects','All special populations')
 order by short_desc;

 cursor c3 is select type from tsm_stage.ip_business_factors1 where type not in 
 ('Study','Populate','Confine','Ph2+dur','IOStatus');

 cursor c5 is select type,short_desc from tsm_stage.ip_business_factors1 where
 type in ('Ph2+dur','IOStatus');

begin
 

 select decode(nvl(max(id),0),0,nvl(max(id),0)+201,nvl(max(id),0)+1) into 
 ibf_maxid from "&1".ip_business_factors;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Study' and short_desc = 'All studies';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Study',1,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Study' and short_desc = 'All studies';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   1,factor from tsm_stage.ip_business_factors1 where type = 'Study' and 
   short_desc = 'All studies') where type = 'Study' and
   short_desc = 'All studies';
 end if;

 seqno:=2;

 for ix1 in c1 loop 

   select count(*) into ibf_exist from "&1".ip_business_factors where
   type = 'Study' and short_desc = ix1.short_desc ; 
  
   If ibf_exist = 0 then

     Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Study',seqno,factor,
     short_desc, null, null, null from tsm_stage.ip_business_factors1 where
     type = 'Study' and short_desc = ix1.short_desc ;

     ibf_maxid:=ibf_maxid+1;
   else

     update "&1".ip_business_factors set (ibf_order,factor) = (select
     seqno,factor from tsm_stage.ip_business_factors1 where type = 'Study' and 
     short_desc = ix1.short_desc) where type = 'Study' and
     short_desc = ix1.short_desc;

    end if;
    seqno:=seqno+1;
  end loop;   

  


 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Populate' and short_desc = 'Healthy subjects';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Populate',1,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Populate' and short_desc = 'Healthy subjects';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   1,factor from tsm_stage.ip_business_factors1 where type = 'Populate' and 
   short_desc = 'Healthy subjects') where type = 'Populate' and
   short_desc = 'Healthy subjects';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Populate' and short_desc = 'All special populations';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Populate',2,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Populate' and short_desc = 'All special populations';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   2,factor from tsm_stage.ip_business_factors1 where type = 'Populate' and 
   short_desc = 'All special populations') where type = 'Populate' and
   short_desc = 'All special populations';
 end if;

 seqno:=3;

 for ix2 in c2 loop 

   select count(*) into ibf_exist from "&1".ip_business_factors where
   type = 'Populate' and short_desc = ix2.short_desc ; 
  
   If ibf_exist = 0 then

     Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Populate',seqno,factor,
     short_desc, null, null, null from tsm_stage.ip_business_factors1 where
     type = 'Populate' and short_desc = ix2.short_desc ;

     ibf_maxid:=ibf_maxid+1;
   else

     update "&1".ip_business_factors set (ibf_order,factor) = (select
     seqno,factor from tsm_stage.ip_business_factors1 where type = 'Populate' and 
     short_desc = ix2.short_desc) where type = 'Populate' and
     short_desc = ix2.short_desc;

    end if;
    seqno:=seqno+1;
  end loop;  


        
 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = 'All patients';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',1,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = 'All patients';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   1,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = 'All patients') where type = 'Confine' and
   short_desc = 'All patients';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = 'No confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',2,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = 'No confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   2,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = 'No confinement') where type = 'Confine' and
   short_desc = 'No confinement';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc like '%24 hours confinement%';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',3,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc like '%24 hours confinement%';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   3,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc like '%24 hours confinement%') where type = 'Confine' and
   short_desc like '%24 hours confinement%';
 end if; 
        
 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = '24 to 48 hours confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',4,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = '24 to 48 hours confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   4,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = '24 to 48 hours confinement') where type = 'Confine' and
   short_desc = '24 to 48 hours confinement';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = '3 to 4 days confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',5,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = '3 to 4 days confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   5,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = '3 to 4 days confinement') where type = 'Confine' and
   short_desc = '3 to 4 days confinement';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = '5 to 6 days confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',6,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = '5 to 6 days confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   6,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = '5 to 6 days confinement') where type = 'Confine' and
   short_desc = '5 to 6 days confinement';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = '7 to 13 days confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',7,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = '7 to 13 days confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   7,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = '7 to 13 days confinement') where type = 'Confine' and
   short_desc = '7 to 13 days confinement';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = '14 to 28 days confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',8,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = '14 to 28 days confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   8,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = '14 to 28 days confinement') where type = 'Confine' and
   short_desc = '14 to 28 days confinement';
 end if;

 select count(*) into ibf_exist from "&1".ip_business_factors where
 type = 'Confine' and short_desc = 'over 28 days confinement';

 If ibf_exist = 0 then
  Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,'Confine',9,factor,
  short_desc, null, null, null from tsm_stage.ip_business_factors1 where
  type = 'Confine' and short_desc = 'over 28 days confinement';

  ibf_maxid:=ibf_maxid+1;
 else
   update "&1".ip_business_factors set (ibf_order,factor) = (select
   9,factor from tsm_stage.ip_business_factors1 where type = 'Confine' and 
   short_desc = 'over 28 days confinement') where type = 'Confine' and
   short_desc = 'over 28 days confinement';
 end if;



 for ix3 in c3 loop


    declare

      cursor c4 is select id,short_desc from tsm_stage.ip_business_factors1 
      where type = ix3.type order by id;

    begin
      seqno:=1;
      for ix4 in c4 loop

         select count(*) into ibf_exist from "&1".ip_business_factors where
         type = ix3.type and short_desc = ix4.short_desc;    
        
         If ibf_exist = 0 then
         
             Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select ibf_maxid,ix3.type,seqno,factor,
             short_desc, null, null, null from tsm_stage.ip_business_factors1 where
             type = ix3.type and short_desc = ix4.short_desc;        
         
             ibf_maxid:=ibf_maxid+1;

          else     

                update "&1".ip_business_factors set (ibf_order,factor) = (select
                seqno,factor from tsm_stage.ip_business_factors1 where type = ix3.type and 
                short_desc = ix4.short_desc) where type = ix3.type and
                short_desc = ix4.short_desc;     
       
          end if;

           seqno:=seqno+1;
        end loop;

     end;

 end loop;

  for ix5 in c5 loop

     select count(*) into ibf_exist from "&1".ip_business_factors where type=ix5.type
     and short_desc = ix5.short_desc;

     if ibf_exist = 0 then

        Insert into "&1".ip_business_factors(ID,TYPE,IBF_ORDER,FACTOR,SHORT_DESC,LOW,MED,HIGH) select id,ix5.type,ibf_order,factor,
        short_desc, null, null, null from tsm_stage.ip_business_factors1 where
        type = ix5.type and short_desc = ix5.short_desc;     

     else

        update "&1".ip_business_factors set (id,ibf_order,factor) = (select
        id,ibf_order,factor from tsm_stage.ip_business_factors1 where type = ix5.type and 
        short_desc = ix5.short_desc) where type = ix5.type and
        short_desc = ix5.short_desc; 
        
      end if;
  end loop;
  commit;
end;
/


update "&1".ip_business_factors set(low,med,high) =
(select .026373,.046042,.065712 from dual) where type='Dosing';

update "&1".ip_business_factors set(low,med,high) =
(select .016043,.019149,.022254 from dual) where type='Country';

update "&1".ip_business_factors set(low,med,high) =
(select .017566,.020437,.023308 from dual) where type='Study';

update "&1".ip_business_factors set(low,med,high) =
(select .003696,.007527,.011359 from dual) where type='Populate';

update "&1".ip_business_factors set(low,med,high) =
(select .028426,.03379,.039155 from dual) where type='Ph1dur';

update "&1".ip_business_factors set(low,med,high) =
(select .073457,.078195,.082932 from dual) where type='Confine';

commit;

update "&1".ip_business_factors set num_days=6  where type = 'Ph1dur' and
	short_desc like '%<one week%';
update "&1".ip_business_factors set num_days=14  where type = 'Ph1dur' and
	short_desc like '%1 to 2 weeks%';
update "&1".ip_business_factors set num_days=28  where type = 'Ph1dur' and
	short_desc like '%3 to 4 weeks%';
update "&1".ip_business_factors set num_days=42  where type = 'Ph1dur' and
	short_desc like '%5 to 6 weeks%';
update "&1".ip_business_factors set num_days=56  where type = 'Ph1dur' and
	short_desc like '%7 to 8 weeks%';
update "&1".ip_business_factors set num_days=84  where type = 'Ph1dur' and
	short_desc like '%9 to 12 weeks%';
update "&1".ip_business_factors set num_days=140  where type = 'Ph1dur' and
	short_desc like '%13 to 20 weeks%';
update "&1".ip_business_factors set num_days=175  where type = 'Ph1dur' and
	short_desc like '%21 to 25 weeks%';
update "&1".ip_business_factors set num_days=364  where type = 'Ph1dur' and
	short_desc like '%26 to 52 weeks%';
update "&1".ip_business_factors set num_days=365  where type = 'Ph1dur' and
	short_desc like '%over 52 weeks%';

update "&1".ip_business_factors set num_days=-1  where type = 'Confine' and
	short_desc like '%No confinement%';
update "&1".ip_business_factors set num_days=0  where type = 'Confine' and
	short_desc like '%<24 hours confinement%';
update "&1".ip_business_factors set num_days=1  where type = 'Confine' and
	short_desc like '%24 to 48 hours confinement%';
update "&1".ip_business_factors set num_days=3  where type = 'Confine' and
	short_desc like '%3 to 4 days confinement%';
update "&1".ip_business_factors set num_days=5  where type = 'Confine' and
	short_desc like '%5 to 6 days confinement%';
update "&1".ip_business_factors set num_days=7  where type = 'Confine' and
	short_desc like '%7 to 13 days confinement%';
update "&1".ip_business_factors set num_days=14  where type = 'Confine' and
	short_desc like '%14 to 28 days confinement%';
update "&1".ip_business_factors set num_days=29  where type = 'Confine' and
	short_desc like '%over 28 days confinement%';

update "&1".ip_business_factors set num_days=0  where type = 'Treatment' and
	short_desc like '%1 to 7 days%';
update "&1".ip_business_factors set num_days=8  where type = 'Treatment' and
	short_desc like '%8 to 14 days%';
update "&1".ip_business_factors set num_days=15  where type = 'Treatment' and
	short_desc like '%15 to 21 days%';
update "&1".ip_business_factors set num_days=22  where type = 'Treatment' and
	short_desc like '%22 to 28 days%';
update "&1".ip_business_factors set num_days=29  where type = 'Treatment' and
	short_desc like '%over 28 days%';

Update "&1".ip_business_factors set num_days = 14 where type = 'Ph2+dur' and 
	short_desc like '%1-3 weeks%';
Update "&1".ip_business_factors set num_days = 39 where type = 'Ph2+dur' and 
	short_desc like '%4-7 weeks%';
Update "&1".ip_business_factors set num_days = 67 where type = 'Ph2+dur' and 
	short_desc like '%8-11 weeks%';
Update "&1".ip_business_factors set num_days = 112 where type = 'Ph2+dur' and 
	short_desc like '%12-20 weeks%';
Update "&1".ip_business_factors set num_days = 161 where type = 'Ph2+dur' and 
	short_desc like '%21-25 weeks%';
Update "&1".ip_business_factors set num_days = 203 where type = 'Ph2+dur' and 
	short_desc like '%26-32 weeks%';
Update "&1".ip_business_factors set num_days = 256 where type = 'Ph2+dur' and 
	short_desc like '%33-40 weeks%';
Update "&1".ip_business_factors set num_days = 298 where type = 'Ph2+dur' and 
	short_desc like '%41-44 weeks%';
Update "&1".ip_business_factors set num_days = 340 where type = 'Ph2+dur' and 
	short_desc like '%45-52 weeks%';
Update "&1".ip_business_factors set num_days = 389 where type = 'Ph2+dur' and 
	short_desc like '%53-58 weeks%';
Update "&1".ip_business_factors set num_days = 548 where type = 'Ph2+dur' and 
	short_desc like '%1-2 years%';
Update "&1".ip_business_factors set num_days = 913 where type = 'Ph2+dur' and 
	short_desc like '%2-3 years%';
Update "&1".ip_business_factors set num_days = 1095 where type = 'Ph2+dur' and 
	short_desc like '%>3 years%';

commit;



















     

        

       
  

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  4    DevTSM    1.3         2/27/2008 3:19:41 PM Debashish Mishra  
--  3    DevTSM    1.2         3/3/2005 6:41:42 AM  Debashish Mishra  
--  2    DevTSM    1.1         8/29/2003 5:14:39 PM Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:51:01 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

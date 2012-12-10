--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ip_business_factors.sql$ 
--
-- $Revision: 11$        $Date: 2/27/2008 3:16:40 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
drop table ip_business_factors;
create table ip_business_factors as select * from 
ip_business_factors1;
 
declare

cursor c1 is select distinct type from ip_business_factors;

begin

for ix1 in c1 loop

declare

cursor c2 is select id from ip_business_factors where 
type = ix1.type;
num1 number(5):=1;

begin

for ix2 in c2 loop

update ip_business_factors set ibf_order = num1 where
id=ix2.id;
num1:=num1+1;

end loop;

end ;

end loop;

end;
/

commit;

Insert into ip_business_factors values(110, 
'Ph2+dur',  1,  2.0,   '1-3 weeks', null, null, null);
Insert into ip_business_factors values(111,
'Ph2+dur',  2,  5.5,   '4-7 weeks', null, null, null);
Insert into ip_business_factors values(112,
'Ph2+dur',  3,  9.5,  '8-11 weeks', null, null, null);
Insert into ip_business_factors values(113,
'Ph2+dur',  4, 16.0, '12-20 weeks', null, null, null);
Insert into ip_business_factors values(114,
'Ph2+dur',  5, 23.0, '21-25 weeks', null, null, null);
Insert into ip_business_factors values(115,
'Ph2+dur',  6, 29.0, '26-32 weeks', null, null, null);
Insert into ip_business_factors values(116,
'Ph2+dur',  7, 36.5, '33-40 weeks', null, null, null);
Insert into ip_business_factors values(117,
'Ph2+dur',  8, 42.5, '41-44 weeks', null, null, null);
Insert into ip_business_factors values(118,
'Ph2+dur',  9, 48.5, '45-52 weeks', null, null, null);
Insert into ip_business_factors values(119,
'Ph2+dur', 10, 55.5, '53-58 weeks', null, null, null);
Insert into ip_business_factors values(120,
'Ph2+dur', 11, -1.0,   '1-2 years', null, null, null);
Insert into ip_business_factors values(121,
'Ph2+dur', 12, -2.0,   '2-3 years', null, null, null);
Insert into ip_business_factors values(122,
'Ph2+dur', 13, -3.0,    '>3 years', null, null, null);
Insert into ip_business_factors values (123,'IOStatus',
1,1,'Inpatient',null,null,null);
Insert into ip_business_factors values (124,'IOStatus',
2,-1,'Outpatient',null,null,null);
Insert into ip_business_factors values (125,'IOStatus',
3,0,'Mixed',null,null,null);

commit;

update ip_business_factors set(low,med,high) =
(select .026373,.046042,.065712 from dual) where type='Dosing';

update ip_business_factors set(low,med,high) =
(select .016043,.019149,.022254 from dual) where type='Country';

update ip_business_factors set(low,med,high) =
(select .017566,.020437,.023308 from dual) where type='Study';

update ip_business_factors set(low,med,high) =
(select .003696,.007527,.011359 from dual) where type='Populate';

update ip_business_factors set(low,med,high) =
(select .028426,.03379,.039155 from dual) where type='Ph1dur';

update ip_business_factors set(low,med,high) =
(select .073457,.078195,.082932 from dual) where type='Confine';

commit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/27/2008 3:16:40 PM Debashish Mishra  
--  10   DevTSM    1.9         3/3/2005 6:38:58 AM  Debashish Mishra  
--  9    DevTSM    1.8         8/29/2003 5:11:46 PM Debashish Mishra  
--  8    DevTSM    1.7         3/18/2002 7:42:17 PM Debashish Mishra  
--  7    DevTSM    1.6         3/14/2002 4:04:39 PM Debashish Mishra  
--  6    DevTSM    1.5         3/12/2002 4:40:11 PM Debashish Mishra  
--  5    DevTSM    1.4         1/24/2002 5:20:34 PM Debashish Mishra Added
--       hardcoded values for low,med and high
--  4    DevTSM    1.3         1/21/2002 2:29:35 PM Debashish Mishra Modified for
--       the required data in ip_session
--  3    DevTSM    1.2         1/17/2002 5:31:34 PM Debashish Mishra  
--  2    DevTSM    1.1         1/17/2002 12:18:37 PMDebashish Mishra  
--  1    DevTSM    1.0         1/8/2002 6:37:15 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_client_inc.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:13 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into "&1".client(id,name,main_contact_id,
--client_identifier,client_acronym,de_acronym) values
--('||id||','''||name||''','||decode(main_contact_id,null,'null',main_contact_id)||',
--'''||client_identifier||''','''||client_acronym||''','''||de_acronym||''');'
--from "&1".client order by id

drop table client_temp;
create table client_temp (id number(10), name varchar2(255));

set define off

Insert into client_temp values (55,'Merck & Co., Inc.');
Insert into client_temp values (67,'Procter & Gamble Pharmaceuticals');
Insert into client_temp values (91,'Johnson & Johnson');

set define on

commit;
                                                        
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(2,'Abbott Laboratories',null,                                                  
'ABB','ABB','ABB');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(3,'Amgen Inc.',null,                                                           
'Amgen','AMG','AMG');

--Update "&1".client set de_acronym = 'AMG' where upper(name) like '%AMGEN%';   

Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(9,'Alza Corporation',null,                                                     
'ALZ','ALZ','ALZ');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(12,'Astra Zeneca Pharmaceuticals, Inc.',null,                                  
'AZP','AZP','AZP');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(13,'Aventis Pharmaceuticals',null,                                             
'AVT','AVT','AVT');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(15,'Bayer Corporation',null,                                                   
'BAY','BAY','BAY');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(17,'Biogen, Inc.',null,                                                        
'BIO','BIO','BIO');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(18,'Boehringer Ingelheim Pharmaceuticals, Inc.',null,                          
'BIH','BIH','BIH');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(19,'Bristol-Myers Squibb',null,                                                
'BMS','BMS','BMS');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(22,'Cephalon, Inc.',null,                                                      
'CEP','CEP','CEP');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(23,'Chiron Corporation',null,                                                  
'CHI','CHI','CHI');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(28,'Eisai Inc.',null,                                                          
'ESI','ESI','ESI');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(29,'Eli Lilly Corporation',null,                                               
'LIL','LIL','LIL');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(31,'F. Hoffmann-La Roche, Inc.',null,                                          
'HLR','HLR','HLR');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(35,'Genentech, Inc.',null,                                                     
'GEN','GEN','GEN');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(38,'Genzyme Corporation',null,                                                 
'GZY','GZY','GZY');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(42,'Immunex Corporation',null,                                                 
'IMU','IMU','IMU');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(55,'Merck and Co., Inc.',null,                                                   
'MRK','MRK','MRK');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(57,'Novartis Pharmaceuticals',null,                                            
'NVT','NVT','NVT');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(59,'Organon, Inc.',null,                                                       
'ORG','ORG','ORG');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(63,'Otsuka America Pharmaceutical, Inc.',null,                                 
'OTS','OTS','OTS');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(65,'Pharmacia Corporation',null,                                               
'UPJ','UPJ','UPJ');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(67,'Procter and Gamble Pharmaceuticals',null,                                    
'PGP','PGP','PGP');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(68,'Purdue Pharaceuticals',null,                                               
'PUR','PUR','PUR');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(72,'Sanofi-Synthelabo',null,                                                   
'SSL','SSL','SSL');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(79,'Takeda Pharmaceutical America, Inc.',null,                                 
'TAK','TAK','TAK');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(80,'Tap Pharmaceutical',null,                                                  
'TAP','TAP','TAP');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(83,'UCB Pharma, Inc.',null,                                                    
'UCB','UCB','UCB');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(86,'Wyeth-Ayerst Laboratories',null,                                           
'WAT','WAT','WAT');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(87,'Yamanouchi Europe, B.V.',null,                                             
'YAM','YAM','YAM');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(91,'Johnson and Johnson',null,                                                   
'JNJ','JNJ','JNJ');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(92,'Pfizer, Inc',null,                                                         
'PKD','PNY','PNY');                                                             
                                                                                
Insert into "&1".client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(93,'Pharmacyclics',null,                                                       
'PHC','PHC','PHC');                                                             
 

Update "&1".client a set a.name = (select b.name 
from client_temp b where b.id=a.id) where
a.id in (55,67,91);

commit;

drop table client_temp;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:13 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:44 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:40:58 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:40 PM Debashish Mishra  
--  2    DevTSM    1.1         8/30/2002 12:43:19 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  1    DevTSM    1.0         3/20/2002 9:24:15 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

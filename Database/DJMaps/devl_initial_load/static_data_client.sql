--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_client.sql$ 
--
-- $Revision: 7$        $Date: 2/27/2008 3:16:44 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--select 'Insert into client(id,name,main_contact_id,
--client_identifier,client_acronym,de_acronym) values
--('||id||','''||name||''','||decode(main_contact_id,null,'null',main_contact_id)||',
--'''||client_identifier||''','''||client_acronym||''','''||de_acronym||''');'
--from client order by id

set define off                                                        
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(2,'Abbott Laboratories',null,                                                  
'ABB','ABB','ABB');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(3,'Amgen Inc.',null,                                                           
'Amgen','AMG','AMG');

--Update client set de_acronym = 'AMG' where upper(name) like '%AMGEN%';   

Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(9,'Alza Corporation',null,                                                     
'ALZ','ALZ','ALZ');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(12,'Astra Zeneca Pharmaceuticals, Inc.',null,                                  
'AZP','AZP','AZP');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(13,'Aventis Pharmaceuticals',null,                                             
'AVT','AVT','AVT');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(15,'Bayer Corporation',null,                                                   
'BAY','BAY','BAY');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(17,'Biogen, Inc.',null,                                                        
'BIO','BIO','BIO');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(18,'Boehringer Ingelheim Pharmaceuticals, Inc.',null,                          
'BIH','BIH','BIH');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(19,'Bristol-Myers Squibb',null,                                                
'BMS','BMS','BMS');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(22,'Cephalon, Inc.',null,                                                      
'CEP','CEP','CEP');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(23,'Chiron Corporation',null,                                                  
'CHI','CHI','CHI');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(28,'Eisai Inc.',null,                                                          
'ESI','ESI','ESI');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(29,'Eli Lilly Corporation',null,                                               
'LIL','LIL','LIL');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(31,'F. Hoffmann-La Roche, Inc.',null,                                          
'HLR','HLR','HLR');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(35,'Genentech, Inc.',null,                                                     
'GEN','GEN','GEN');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(38,'Genzyme Corporation',null,                                                 
'GZY','GZY','GZY');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(42,'Immunex Corporation',null,                                                 
'IMU','IMU','IMU');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(55,'Merck & Co., Inc.',null,                                                   
'MRK','MRK','MRK');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(57,'Novartis Pharmaceuticals',null,                                            
'NVT','NVT','NVT');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(59,'Organon, Inc.',null,                                                       
'ORG','ORG','ORG');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(63,'Otsuka America Pharmaceutical, Inc.',null,                                 
'OTS','OTS','OTS');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(65,'Pharmacia Corporation',null,                                               
'UPJ','UPJ','UPJ');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(67,'Procter & Gamble Pharmaceuticals',null,                                    
'PGP','PGP','PGP');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(68,'Purdue Pharaceuticals',null,                                               
'PUR','PUR','PUR');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(72,'Sanofi-Synthelabo',null,                                                   
'SSL','SSL','SSL');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(79,'Takeda Pharmaceutical America, Inc.',null,                                 
'TAK','TAK','TAK');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(80,'Tap Pharmaceutical',null,                                                  
'TAP','TAP','TAP');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(83,'UCB Pharma, Inc.',null,                                                    
'UCB','UCB','UCB');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(86,'Wyeth-Ayerst Laboratories',null,                                           
'WAT','WAT','WAT');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(87,'Yamanouchi Europe, B.V.',null,                                             
'YAM','YAM','YAM');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(91,'Johnson & Johnson',null,                                                   
'JNJ','JNJ','JNJ');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(92,'Pfizer, Inc',null,                                                         
'PKD','PNY','PNY');                                                             
                                                                                
Insert into client(id,name,main_contact_id,                                     
client_identifier,client_acronym,de_acronym) values                             
(93,'Pharmacyclics',null,                                                       
'PHC','PHC','PHC');                                                             
 
set define on

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  7    DevTSM    1.6         2/27/2008 3:16:44 PM Debashish Mishra  
--  6    DevTSM    1.5         3/3/2005 6:39:23 AM  Debashish Mishra  
--  5    DevTSM    1.4         8/29/2003 5:12:07 PM Debashish Mishra  
--  4    DevTSM    1.3         3/14/2002 4:04:39 PM Debashish Mishra  
--  3    DevTSM    1.2         2/13/2002 12:11:15 PMDebashish Mishra  
--  2    DevTSM    1.1         2/5/2002 10:55:00 AM Debashish Mishra    
--  1    DevTSM    1.0         2/1/2002 11:05:30 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

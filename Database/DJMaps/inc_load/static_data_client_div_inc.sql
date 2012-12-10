--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_client_div_inc.sql$ 
--
-- $Revision: 11$        $Date: 2/27/2008 3:17:13 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------


--Select 'insert into "&1".client_div (ID,CLIENT_ID,
--NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,
--CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values
--('||ID||','||decode(CLIENT_ID,null,'null',
--CLIENT_ID)||','||decode(name,null,'null',
--''''||name||'''')||',
--'||decode(DEF_COUNTRY_ID,null,'null',
--DEF_COUNTRY_ID)||','||decode(DEF_PLAN_CURRENCY_ID,null,'null',
--DEF_PLAN_CURRENCY_ID)||','||decode(DEF_OVERHEAD_PCT,null,'null',
--DEF_OVERHEAD_PCT)||','||decode(DEF_BUDGET_TYPE,null,'null',
--''''||DEF_BUDGET_TYPE||'''')||','||decode(CLIENT_DIV_IDENTIFIER,null,'null',
--''''||CLIENT_DIV_IDENTIFIER||'''')||','||decode(STARTING_VIEW,null,'null',
--''''||STARTING_VIEW||'''')||');'
--from "&1".client_div
--order by id;

drop table client_div_temp;
create table client_div_temp (id number(10), name varchar2(128));

set define off

Insert into client_div_temp values (55,'Procter & Gamble Pharmaceuticals');
Insert into client_div_temp values (57,'Procter & Gamble Pharmaceuticals');

set define on

commit;

                                                                             
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(1,3,'Amgen Inc.',                                                              
24,0,null,'Industry Cost','AMGUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(2,3,'Amgen Inc.',                                                              
24,0,null,'Industry Cost','AMGUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(3,2,'Abbott Laboratories',                                                     
24,0,null,'Industry Cost','ABB',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(6,12,'Astra USA, Inc.',                                                        
24,0,null,'Industry Cost','AST',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(7,15,'Bayer Corporation',                                                      
24,0,null,'Industry Cost','BAYUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(8,15,'Bayer Corporation',                                                      
24,0,null,'Industry Cost','BAYCAN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(9,18,'Boehringer Ingelheim LTD',                                               
24,0,null,'Industry Cost','BIHUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(10,19,'Dupont Pharmaceuticals',                                                
24,0,null,'Industry Cost','DMP',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(11,19,'Bristol-Myers Squibb',                                                  
24,0,null,'Industry Cost','BMS',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(12,19,'Bristol-Myers Squibb',                                                  
24,0,null,'Industry Cost','BMSUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(13,19,'Bristol-Myers Squibb',                                                  
24,0,null,'Industry Cost','BMSBEL',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(14,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRSWI',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(15,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRFRA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(16,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRCAN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(17,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRITA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(18,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRESP',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(19,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRAUS',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(20,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,32,'Industry Cost','HLR',null);                                           
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(21,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(22,91,'Janssen Pharmaceutical Research Foundation/PRI',                        
24,0,null,'Industry Cost','JAN',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(23,91,'Janssen Pharmaceutical Research Foundation/PRI',                        
24,0,null,'Industry Cost','JBLUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(25,29,'Eli Lilly Corporation',                                                 
24,0,null,'Industry Cost','LIL',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(26,31,'F. Hoffmann-La Roche, Inc.',                                            
24,0,null,'Industry Cost','HLRUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(27,55,'Merck Research Laboratories',                                           
24,0,null,'Industry Cost','MRK',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(29,59,'Organon, Inc.',                                                         
24,0,null,'Industry Cost','ORG',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(30,63,'Otsuka America Pharmaceutical, Inc.',                                   
24,0,null,'Industry Cost','OTS',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(31,92,'Pfizer Parke-Davis',                                                    
24,0,25,'Industry Cost','PKD',null);                                           
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(32,92,'Pfizer Parke-Davis',                                                    
24,0,null,'Industry Cost','PKDDEU',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(33,92,'Pfizer LTD',                                                            
24,0,null,'Industry Cost','PKDUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(35,91,'The RW Johnson Pharmaceutical Research Institute',                      
24,0,null,'Industry Cost','PRI',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(43,65,'Pharmacia Corporation',                                                 
24,0,null,'Industry Cost','UPEITA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(49,65,'Pharmacia Corporation',                                                 
24,0,null,'Industry Cost','UPEUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(51,86,'Wyeth-Ayerst Laboratories',                                             
24,0,null,'Industry Cost','WATUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(52,86,'Wyeth-Ayerst Laboratories',                                             
24,0,null,'Industry Cost','WATFRA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(55,67,'Procter and Gamble Pharmaceuticals',                                      
24,0,null,'Industry Cost','PGPUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(56,91,'Ortho-McNeil Pharmaceuticals, Inc.',                                    
24,0,null,'Industry Cost','OMP',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(57,67,'Procter and Gamble Pharmaceuticals',                                      
24,0,null,'Industry Cost','PGPUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(58,35,'Genentech, Inc.',                                                       
24,0,null,'Industry Cost','GEN',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(59,12,'Astra Merck, Inc.',                                                     
24,0,null,'Industry Cost','ARK',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(61,80,'Tap Pharmaceuticals, Inc.',                                             
24,0,null,'Industry Cost','TAP',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(64,91,'McNeil Consumer Healthcare',                                            
24,0,null,'Industry Cost','MCP',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(72,17,'Biogen, Inc.',                                                          
24,0,null,'Industry Cost','BGNUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(73,9,'Alza Corporation',                                                       
24,0,null,'Industry Cost','ALZ',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(74,17,'Biogen, Inc.',                                                          
24,0,null,'Industry Cost','BGNUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(75,87,'Yamanouchi Europe, B.V.',                                               
24,0,null,'Industry Cost','YAM',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(77,18,'Boehringer Ingelheim Pharmaceuticals,Inc.',                             
24,0,null,'Industry Cost','BIHUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(78,18,'Boehringer Ingelheim Pharmaceuticals, Inc.',                            
24,0,null,'Industry Cost','BIHCAN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(79,23,'Chiron Corporation',                                                    
24,0,null,'Industry Cost','CHI',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(80,57,'Novartis Pharmaceuticals',                                              
24,0,null,'Industry Cost','NVT',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(82,65,'Pharmacia Corporation',                                                 
24,0,null,'Industry Cost','UPJUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(84,22,'Cephalon, Inc.',                                                        
24,0,null,'Industry Cost','CEP',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(88,29,'Eli Lilly Corporation',                                                 
24,0,null,'Industry Cost','LILUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(89,29,'Eli Lilly Corporation',                                                 
24,0,null,'Industry Cost','LILCAN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(90,29,'Eli Lilly Corporation',                                                 
24,0,null,'Industry Cost','LILDEN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(92,83,'UCB Pharma',                                                            
24,0,null,'Industry Cost','UCBBEL',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(93,28,'Eisai Inc.',                                                            
24,0,null,'Industry Cost','ESI',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(94,83,'UCB Pharma',                                                            
24,0,null,'Industry Cost','UCBUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(95,91,'Ortho Biotech',                                                         
24,0,null,'Industry Cost','OBT',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(96,91,'Centocor, Inc.',                                                        
24,0,null,'Industry Cost','CEN',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(97,12,'AstraZeneca Pharmaceuticals LP',                                        
24,0,null,'Industry Cost','AZP',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(98,13,'Aventis Pharmaceuticals',                                               
24,0,null,'Industry Cost','AVT',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(99,72,'Sanofi-Synthelabo',                                                     
24,0,null,'Industry Cost','SSLFRA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(100,65,'Sugen, Inc.',                                                          
24,0,null,'Industry Cost','SUG',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(101,72,'Sanofi-Synthelabo',                                                    
24,0,null,'Industry Cost','SSLUSA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(104,68,'Purdue Pharma L.P.',                                                   
24,0,null,'Industry Cost','PUR',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(105,79,'Takeda Pharmaceuticals',                                               
24,0,null,'Industry Cost','TAK',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(106,13,'Aventis Pharmaceuticals',                                              
24,0,null,'Industry Cost','AVTNET',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(107,13,'Aventis Pharmaceuticals',                                              
24,0,null,'Industry Cost','AVTFRA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(108,13,'Aventis Pharmaceuticals',                                              
24,0,null,'Industry Cost','AVTDEU',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(109,13,'Aventis Pharmaceuticals',                                              
24,0,null,'Industry Cost','AVTAUS',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(111,38,'Genzyme Corporation',                                                  
24,0,null,'Industry Cost','GZYNET',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(112,38,'Genzyme Corporation',                                                  
24,0,null,'Industry Cost','GZY',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(113,42,'Immunex Corporation',                                                  
24,0,null,'Industry Cost','IMU',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(115,91,'Janssen Pharmaceutical Research Foundation/PRI',                       
24,0,null,'Industry Cost','JBLBEL',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(116,93,'Pharmacyclics',                                                        
24,0,null,'Industry Cost','PHC',null);                                         
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(117,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTSWI',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(118,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTITA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(119,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTDEU',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(120,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTESP',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(121,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTDEN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(122,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTFIN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(123,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTCAN',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(124,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTNOR',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(125,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTSWE',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(126,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTNET',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(127,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTARI',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(128,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTFRA',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(129,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTUK',null);                                       
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(130,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTIRL',null);                                      
                                                                                
insert into "&1".client_div (ID,CLIENT_ID,                                     
NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,      
CLIENT_DIV_IDENTIFIER,STARTING_VIEW) values                                     
(131,57,'Novartis Pharmaceuticals',                                             
24,0,null,'Industry Cost','NVTAUS',null);                                      
                                                                                

declare
 usaid number(10);
begin

 select currency_id into usaid from "&1".country where id=24;
 update "&1".client_div set def_plan_currency_id=usaid;
 commit;

end;
/

-- update "&1".client_div set locale = 'ENG' ;
commit;

Update "&1".client_div a set a.name = (select b.name 
from client_div_temp b where b.id=a.id) where
a.id in (55,57);

commit;

drop table client_div_temp;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/27/2008 3:17:13 PM Debashish Mishra  
--  10   DevTSM    1.9         2/7/2007 10:28:43 PM Debashish Mishra  
--  9    DevTSM    1.8         3/3/2005 6:40:57 AM  Debashish Mishra  
--  8    DevTSM    1.7         8/29/2003 5:13:39 PM Debashish Mishra  
--  7    DevTSM    1.6         8/30/2002 12:43:18 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  6    DevTSM    1.5         7/12/2002 3:41:55 PM Debashish Mishra  
--  5    DevTSM    1.4         5/23/2002 5:25:05 PM Debashish Mishra  
--  4    DevTSM    1.3         5/21/2002 1:01:23 PM Debashish Mishra  
--  3    DevTSM    1.2         5/17/2002 11:34:54 AMDebashish Mishra Modified after
--       dropping principal* columns
--  2    DevTSM    1.1         3/22/2002 12:51:49 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:14 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

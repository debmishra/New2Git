--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_client_div.sql$ 
--
-- $Revision: 10$        $Date: 2/27/2008 3:16:44 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--Select 'insert into client_div (ID,CLIENT_ID,
--PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,
--PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
--DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
--STARTING_VIEW) values
--('||ID||','||decode(CLIENT_ID,null,'null',
--CLIENT_ID)||','||decode(PRINCIPAL_CONTACT_ID,null,'null',
--PRINCIPAL_CONTACT_ID)||','||decode(name,null,'null',
--''''||name||'''')||',
--'||decode(PRINCIPAL_CONTACT,null,'null',
--''''||PRINCIPAL_CONTACT||'''')||','||decode(PRINCIPAL_PHONE,null,'null',
--''''||PRINCIPAL_PHONE||'''')||','||decode(PRINCIPAL_EMAIL,null,'null',
--''''||PRINCIPAL_EMAIL||'''')||','||decode(DEF_COUNTRY_ID,null,'null',
--DEF_COUNTRY_ID)||',
--'||decode(DEF_PLAN_CURRENCY_ID,null,'null',
--DEF_PLAN_CURRENCY_ID)||','||decode(DEF_OVERHEAD_PCT,null,'null',
--DEF_OVERHEAD_PCT)||','||decode(DEF_BUDGET_TYPE,null,'null',
--''''||DEF_BUDGET_TYPE||'''')||','||decode(CLIENT_DIV_IDENTIFIER,null,'null',
--''''||CLIENT_DIV_IDENTIFIER||'''')||','||decode(STARTING_VIEW,null,'null',
--''''||STARTING_VIEW||'''')||');'
--from client_div
--order by id;


set define off

insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(0,0,null,'Dummy',                                                              
'NONE',null,null,0,                                                             
0,null,'Industry Cost','Dummy',null);                                                
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(1,3,null,'Amgen Inc.',                                                         
'Michelle Schumacher',null,null,24,                                             
0,null,'Industry Cost','AMGUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(2,3,null,'Amgen Inc.',                                                         
'Camilla Wilkinson',null,null,24,                                               
0,null,'Industry Cost','AMGUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(3,2,null,'Abbott Laboratories',                                                
'Anne Hubloux;Tamara Yancy',null,null,24,                                       
0,null,'Industry Cost','ABB',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(6,12,null,'Astra USA, Inc.',                                                   
'Bill Colman, Cory Carlson-Hipple',null,null,24,                                
0,null,'Industry Cost','AST',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(7,15,null,'Bayer Corporation',                                                 
'Susan Kronick',null,null,24,                                                   
0,null,'Industry Cost','BAYUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(8,15,null,'Bayer Corporation',                                                 
'June Chen',null,null,24,                                                       
0,null,'Industry Cost','BAYCAN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(9,18,null,'Boehringer Ingelheim LTD',                                          
'Viv Jemmeson',null,null,24,                                                    
0,null,'Industry Cost','BIHUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(10,19,null,'Dupont Pharmaceuticals',                                           
'John Demay',null,null,24,                                                      
0,null,'Industry Cost','DMP',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(11,19,null,'Bristol-Myers Squibb',                                             
'Pascale Paimbault',null,null,24,                                               
0,null,'Industry Cost','BMS',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(12,19,null,'Bristol-Myers Squibb',                                             
'Sean Egan',null,null,24,                                                       
0,null,'Industry Cost','BMSUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(13,19,null,'Bristol-Myers Squibb',                                             
'Philippe Hoogmartens',null,null,24,                                            
0,null,'Industry Cost','BMSBEL',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(14,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Beatrice Fiechter',null,null,24,                                               
0,null,'Industry Cost','HLRSWI',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(15,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Nicolas Denys',null,null,24,                                                   
0,null,'Industry Cost','HLRFRA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(16,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Antonio Vergara',null,null,24,                                                 
0,null,'Industry Cost','HLRCAN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(17,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Sergio Scaccabarozzi',null,null,24,                                            
0,null,'Industry Cost','HLRITA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(18,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Elena Perez del Notario',null,null,24,                                         
0,null,'Industry Cost','HLRESP',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(19,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'David Kingston',null,null,24,                                                  
0,null,'Industry Cost','HLRAUS',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(20,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Wolfgang Neis',null,null,24,                                                   
0,32,'Industry Cost','HLR',null);                                                   
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(21,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Simon Twiddy',null,null,24,                                                    
0,null,'Industry Cost','HLRUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(22,91,null,'Janssen Pharmaceutical Research Foundation/PRI',                   
'Linda Phillips',null,null,24,                                                  
0,null,'Industry Cost','JAN',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(23,91,null,'Janssen Pharmaceutical Research Foundation/PRI',                   
'Mark Travers',null,null,24,                                                    
0,null,'Industry Cost','JBLUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(25,29,null,'Eli Lilly Corporation',                                            
'Frank Collura',null,null,24,                                                   
0,null,'Industry Cost','LIL',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(26,31,null,'F. Hoffmann-La Roche, Inc.',                                       
'Bonnie Wagner',null,null,24,                                                   
0,null,'Industry Cost','HLRUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(27,55,null,'Merck Research Laboratories',                                      
'Nick VanDuesen',null,null,24,                                                  
0,null,'Industry Cost','MRK',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(29,59,null,'Organon, Inc.',                                                    
'Charlotte Mayne',null,null,24,                                                 
0,null,'Industry Cost','ORG',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(30,63,null,'Otsuka America Pharmaceutical, Inc.',                              
'Matt Allegrucci',null,null,24,                                                 
0,null,'Industry Cost','OTS',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(31,92,null,'Pfizer Parke-Davis',                                               
'Kathy Ekin',null,null,24,                                                      
0,25,'Industry Cost','PKD',null);                                                   
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(32,92,null,'Pfizer Parke-Davis',                                               
'TBA',null,null,24,                                                             
0,null,'Industry Cost','PKDDEU',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(33,92,null,'Pfizer LTD',                                                       
'Khalid Malik',null,null,24,                                                    
0,null,'Industry Cost','PKDUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(35,91,null,'The RW Johnson Pharmaceutical Research Institute',                 
'Charlie Nucera',null,null,24,                                                  
0,null,'Industry Cost','PRI',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(43,65,null,'Pharmacia Corporation',                                            
'John Porter',null,null,24,                                                     
0,null,'Industry Cost','UPEITA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(49,65,null,'Pharmacia Corporation',                                            
'John Porter',null,null,24,                                                     
0,null,'Industry Cost','UPEUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(51,86,null,'Wyeth-Ayerst Laboratories',                                        
'Jim Kirwin',null,null,24,                                                      
0,null,'Industry Cost','WATUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(52,86,null,'Wyeth-Ayerst Laboratories',                                        
'Cecile Guegan',null,null,24,                                                   
0,null,'Industry Cost','WATFRA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(55,67,null,'Procter & Gamble Pharmaceuticals',                                 
'Diane Allen',null,null,24,                                                     
0,null,'Industry Cost','PGPUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(56,91,null,'Ortho-McNeil Pharmaceuticals, Inc.',                               
'Linda Sabatura',null,null,24,                                                  
0,null,'Industry Cost','OMP',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(57,67,null,'Procter & Gamble Pharmaceuticals',                                 
'Vicki Boyd',null,null,24,                                                      
0,null,'Industry Cost','PGPUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(58,35,null,'Genentech, Inc.',                                                  
'Julia Galperin',null,null,24,                                                  
0,null,'Industry Cost','GEN',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(59,12,null,'Astra Merck, Inc.',                                                
'Chris Fielden',null,null,24,                                                   
0,null,'Industry Cost','ARK',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(61,80,null,'Tap Pharmaceuticals, Inc.',                                        
'Dory Rodriguez',null,null,24,                                                  
0,null,'Industry Cost','TAP',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(64,91,null,'McNeil Consumer Healthcare',                                       
'Donna Votto',null,null,24,                                                     
0,null,'Industry Cost','MCP',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(72,17,null,'Biogen, Inc.',                                                     
'Jeremy Hickling',null,null,24,                                                 
0,null,'Industry Cost','BGNUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(73,9,null,'Alza Corporation',                                                  
'Sandra Herman',null,null,24,                                                   
0,null,'Industry Cost','ALZ',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(74,17,null,'Biogen, Inc.',                                                     
'Alicia Goudreau(Training) Patricia Fan (Delivery)',null,null,24,               
0,null,'Industry Cost','BGNUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(75,87,null,'Yamanouchi Europe, B.V.',                                          
'Pauline Heiningen',null,null,24,                                               
0,null,'Industry Cost','YAM',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(77,18,null,'Boehringer Ingelheim Pharmaceuticals,Inc.',                                                              
'Pat Washburn',null,null,24,                                                    
0,null,'Industry Cost','BIHUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(78,18,null,'Boehringer Ingelheim Pharmaceuticals, Inc.',                       
'Fred Harris',null,null,24,                                                     
0,null,'Industry Cost','BIHCAN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(79,23,null,'Chiron Corporation',                                               
'Charleen Pagel Jue',null,null,24,                                              
0,null,'Industry Cost','CHI',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(80,57,null,'Novartis Pharmaceuticals',                                         
'Cherle Rothermel',null,null,24,                                                
0,null,'Industry Cost','NVT',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(82,65,null,'Pharmacia Corporation',                                            
'Jan Ake Westin',null,null,24,                                                  
0,null,'Industry Cost','UPJUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(84,22,null,'Cephalon, Inc.',                                                   
'Steve Girard',null,null,24,                                                    
0,null,'Industry Cost','CEP',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(88,29,null,'Eli Lilly Corporation',                                            
'Need a contact',null,null,24,                                                  
0,null,'Industry Cost','LILUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(89,29,null,'Eli Lilly Corporation',                                            
'Ron Fehst',null,null,24,                                                       
0,null,'Industry Cost','LILCAN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(90,29,null,'Eli Lilly Corporation',                                            
'Grethe Bjerre Sorensen',null,null,24,                                          
0,null,'Industry Cost','LILDEN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(92,83,null,'UCB Pharma',                                                       
'Bernard Dignef',null,null,24,                                                  
0,null,'Industry Cost','UCBBEL',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(93,28,null,'Eisai Inc.',                                                       
'Mike Melfi',null,null,24,                                                      
0,null,'Industry Cost','ESI',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(94,83,null,'UCB Pharma',                                                       
'Jamie Kime',null,null,24,                                                      
0,null,'Industry Cost','UCBUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(95,91,null,'Ortho Biotech',                                                    
'Tina Soares',null,null,24,                                                     
0,null,'Industry Cost','OBT',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(96,91,null,'Centocor, Inc.',                                                   
'Rick O''Hara',null,null,24,                                                     
0,null,'Industry Cost','CEN',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(97,12,null,'AstraZeneca Pharmaceuticals LP',                                   
'Johnathan Segal',null,null,24,                                                 
0,null,'Industry Cost','AZP',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(98,13,null,'Aventis Pharmaceuticals',                                          
'Tracy Trainor',null,null,24,                                                   
0,null,'Industry Cost','AVT',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(99,72,null,'Sanofi-Synthelabo',                                                
'Francoise Bruere',null,null,24,                                                
0,null,'Industry Cost','SSLFRA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(100,65,null,'Sugen, Inc.',                                                     
'Annette Pineda',null,null,24,                                                  
0,null,'Industry Cost','SUG',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(101,72,null,'Sanofi-Synthelabo',                                               
'Karen McCarraher',null,null,24,                                                
0,null,'Industry Cost','SSLUSA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(104,68,null,'Purdue Pharma L.P.',                                              
'Andrea Margrottai',null,null,24,                                               
0,null,'Industry Cost','PUR',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(105,79,null,'Takeda Pharmaceuticals',                                          
'Jay Hansen (del.) Janis St. John (training)',null,null,24,                     
0,null,'Industry Cost','TAK',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(106,13,null,'Aventis Pharmaceuticals',                                         
'P. Wouterse',null,null,24,                                                     
0,null,'Industry Cost','AVTNET',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(107,13,null,'Aventis Pharmaceuticals',                                         
'Sylvie Maral',null,null,24,                                                    
0,null,'Industry Cost','AVTFRA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(108,13,null,'Aventis Pharmaceuticals',                                         
'Barbel Fruhbeis',null,null,24,                                                 
0,null,'Industry Cost','AVTDEU',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(109,13,null,'Aventis Pharmaceuticals',                                         
'Carolyn Chillcott',null,null,24,                                               
0,null,'Industry Cost','AVTAUS',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(111,38,null,'Genzyme Corporation',                                             
'Marlies Hoijtink',null,null,24,                                                
0,null,'Industry Cost','GZYNET',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(112,38,null,'Genzyme Corporation',                                             
'Dennis LaCroix',null,null,24,                                                  
0,null,'Industry Cost','GZY',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(113,42,null,'Immunex Corporation',                                             
'Joye Emmens',null,null,24,                                                     
0,null,'Industry Cost','IMU',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(115,91,null,'Janssen Pharmaceutical Research Foundation/PRI',                  
'Catherine Michielsens',null,null,24,                                           
0,null,'Industry Cost','JBLBEL',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(116,93,null,'Pharmacyclics',                                                   
'Olga Gorbecheva',null,null,24,                                                 
0,null,'Industry Cost','PHC',null);                                                 
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(117,57,null,'Novartis Pharmaceuticals',                                        
'Karen Hollander',null,null,24,                                                 
0,null,'Industry Cost','NVTSWI',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(118,57,null,'Novartis Pharmaceuticals',                                        
'Dr. Giancarlo Monza',null,null,24,                                             
0,null,'Industry Cost','NVTITA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(119,57,null,'Novartis Pharmaceuticals',                                        
'Helmut Wolf',null,null,24,                                                     
0,null,'Industry Cost','NVTDEU',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(120,57,null,'Novartis Pharmaceuticals',                                        
'Joan Pere Perez',null,null,24,                                                 
0,null,'Industry Cost','NVTESP',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(121,57,null,'Novartis Pharmaceuticals',                                        
'Susan Buus Jensen',null,null,24,                                               
0,null,'Industry Cost','NVTDEN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(122,57,null,'Novartis Pharmaceuticals',                                        
'Tero Laulagainen',null,null,24,                                                
0,null,'Industry Cost','NVTFIN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(123,57,null,'Novartis Pharmaceuticals',                                        
'Joanne Godin',null,null,24,                                                    
0,null,'Industry Cost','NVTCAN',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(124,57,null,'Novartis Pharmaceuticals',                                        
'Ms. Laila Buo',null,null,24,                                                   
0,null,'Industry Cost','NVTNOR',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(125,57,null,'Novartis Pharmaceuticals',                                        
'Ulf Vigonius',null,null,24,                                                    
0,null,'Industry Cost','NVTSWE',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(126,57,null,'Novartis Pharmaceuticals',                                        
'Jacues van Bree',null,null,24,                                                 
0,null,'Industry Cost','NVTNET',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(127,57,null,'Novartis Pharmaceuticals',                                        
'Ms. Gerlinde Haider',null,null,24,                                             
0,null,'Industry Cost','NVTARI',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(128,57,null,'Novartis Pharmaceuticals',                                        
'Laurence Laigle',null,null,24,                                                 
0,null,'Industry Cost','NVTFRA',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(129,57,null,'Novartis Pharmaceuticals',                                        
'David Crowder',null,null,24,                                                   
0,null,'Industry Cost','NVTUK',null);                                               
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(130,57,null,'Novartis Pharmaceuticals',                                        
'Oriol Ros',null,null,24,                                                       
0,null,'Industry Cost','NVTIRL',null);                                              
                                                                                
insert into client_div (ID,CLIENT_ID,                                           
PRINCIPAL_CONTACT_ID,NAME,PRINCIPAL_CONTACT,PRINCIPAL_PHONE,                    
PRINCIPAL_EMAIL,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                            
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW) values                                                           
(131,57,null,'Novartis Pharmaceuticals',                                        
'Albert Florido',null,null,24,                                                  
0,null,'Industry Cost','NVTAUS',null);                                             
                                                                                

set define on

declare
 usaid number(10);
begin

 select currency_id into usaid from country where id=24;
 update client_div set default_planning_currency_id=usaid;
 commit;

end;
/




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  10   DevTSM    1.9         2/27/2008 3:16:44 PM Debashish Mishra  
--  9    DevTSM    1.8         3/3/2005 6:39:24 AM  Debashish Mishra  
--  8    DevTSM    1.7         8/29/2003 5:12:08 PM Debashish Mishra  
--  7    DevTSM    1.6         3/22/2002 4:40:21 PM Debashish Mishra  
--  6    DevTSM    1.5         2/22/2002 6:35:26 PM Debashish Mishra  
--  5    DevTSM    1.4         2/18/2002 5:07:13 PM Debashish Mishra  
--  4    DevTSM    1.3         2/13/2002 12:11:16 PMDebashish Mishra  
--  3    DevTSM    1.2         2/7/2002 3:10:16 PM  Debashish Mishra  
--  2    DevTSM    1.1         2/5/2002 10:55:01 AM Debashish Mishra    
--  1    DevTSM    1.0         2/1/2002 11:05:31 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

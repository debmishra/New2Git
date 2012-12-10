--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_country_inc.sql$ 
--
-- $Revision: 10$        $Date: 2/27/2008 3:17:14 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

--Select 'Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,
--CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)
--values ('||id||','||decode(name,null,'null',''''||name||'''')||',
--'||decode(ABBREVIATION,null,'null',
--''''||ABBREVIATION||'''')||','||COUNTRY_LEVEL||','||decode(CURRENCY_ID,
--null,'null',CURRENCY_ID)||','||decode(COUNTRY_SEARCH_ID,null,'null',
--COUNTRY_SEARCH_ID)||','||VIRTUAL_FLG||','||IS_VIEWABLE||','||decode(ISO_COUNTRY,
--null,'null',''''||ISO_COUNTRY||'''')||');'
--from "&1".country order by id

Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (9,'Lithuania, Latvia, Estonia, Russia',                                 
'FSU',2,null,9,1,1,null);                                                       

Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (1,'Australia',                                                          
'AUS',2,null,null,0,1,'AU');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (2,'Austria',                                                            
'ARI',2,null,null,0,1,'AT');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (3,'Belgium',                                                            
'BEL',2,null,null,0,1,'BE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (4,'Bulgaria, Romania',                                                  
'BUL',2,null,9,0,1,null);                                                       
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (5,'Canada',                                                             
'CAN',1,null,null,0,1,'CA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (6,'Czech Republic, Slovakia',                                           
'PHC',2,null,9,0,1,null);                                                       
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (7,'Denmark',                                                            
'DEN',2,null,null,0,1,'DK');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (8,'Finland',                                                            
'FIN',2,null,null,0,1,'FI');                                                    
                                                                                                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (10,'France',                                                            
'FRA',2,null,null,0,1,'FR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (11,'Germany',                                                           
'DEU',2,null,null,0,1,'DE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (12,'Hungary',                                                           
'HUN',2,null,9,0,1,'HU');                                                       
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (13,'Ireland',                                                           
'IRL',2,null,null,0,1,'IE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (14,'Israel',                                                            
'ISR',2,null,null,0,1,'IL');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (15,'Italy',                                                             
'ITA',2,null,null,0,1,'IT');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (16,'Netherlands',                                                       
'NET',2,null,null,0,1,'NL');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (17,'Norway',                                                            
'NOR',2,null,null,0,1,'NO');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (18,'Poland',                                                            
'POL',2,null,9,0,1,'PL');                                                       
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (19,'South Africa',                                                      
'SAF',2,null,null,0,1,'ZA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (20,'Spain',                                                             
'ESP',2,null,null,0,1,'ES');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (21,'Sweden',                                                            
'SWE',2,null,null,0,1,'SE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (22,'Switzerland',                                                       
'SWI',2,null,null,0,1,'CH');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (23,'United Kingdom',                                                    
'UK',2,null,null,0,1,'GB');                                                     
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (24,'United States',                                                     
'USA',1,null,null,0,1,'US');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (25,'Yugoslavia, Slovenia, Croatia',                                     
'SCY',2,null,9,0,1,null);                                                       
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (26,'South and Central America',                                         
'SCA',2,null,null,1,0,null);                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (27,'Eastern European',                                                  
'EAE',2,null,null,1,0,null);                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (28,'EUR',                                                               
'EUR',2,null,null,0,0,null);                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (29,'Argentina',                                                         
'ARG',2,null,null,0,0,'AR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (30,'Chile',                                                             
'CHI',2,null,null,0,0,'CL');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (31,'Greece',                                                            
'GCE',2,null,null,0,0,'GR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (32,'Hong Kong',                                                         
'HKG',2,null,null,0,0,'HK');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (33,'Iceland',                                                           
'ICE',2,null,null,0,0,'IS');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (34,'Indonesia',                                                         
'INS',2,null,null,0,0,'ID');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (35,'Japan',                                                             
'JAP',2,null,null,0,0,'JP');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (36,'Latvia',                                                            
'LAT',2,null,null,0,0,'LV');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (37,'Luxembourg',                                                        
'LUX',2,null,null,0,0,'LU');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (38,'Malaysia',                                                          
'MIA',2,null,null,0,0,'MY');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (39,'Mexico',                                                            
'MEX',2,null,null,0,0,'MX');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (40,'Morocco',                                                           
'MOR',2,null,null,0,0,'MA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (41,'Portugal',                                                          
'POR',2,null,null,0,0,'PT');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (42,'Singapore',                                                         
'SIN',2,null,null,0,0,'SG');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (43,'Taiwan',                                                            
'TAI',2,null,null,0,0,'TW');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (44,'Thailand',                                                          
'THA',2,null,null,0,0,'TH');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (45,'Turkey',                                                            
'TUR',2,null,null,0,0,'TR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (46,'Croatia',                                                           
'CRO',2,null,null,0,0,'HR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (47,'Czech Republic',                                                    
'CZE',2,null,null,0,0,'CZ');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (48,'Estonia',                                                           
'EST',2,null,null,0,0,'EE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (49,'Lithuania',                                                         
'LIT',2,null,null,0,0,'LT');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (50,'New Zealand',                                                       
'NZE',2,null,null,0,0,'NZ');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (51,'Rumania, Romania',                                                  
'RUM',2,null,null,0,0,'RO');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (52,'Russia',                                                            
'RIA',2,null,null,0,0,'RU');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (53,'Slovak Republic',                                                   
'SVK',2,null,null,0,0,'SK');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (54,'Slovenia',                                                          
'SLO',2,null,null,0,0,'SI');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (55,'Bosnia',                                                            
'BOS',2,null,null,0,0,'BA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (56,'Philippines',                                                       
'PHI',2,null,null,0,0,'PH');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (57,'Nigeria',                                                           
'NIG',2,null,null,0,0,'NG');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (58,'Algeria',                                                           
'ALG',2,null,null,0,0,'DZ');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (59,'Brazil',                                                            
'BRA',2,null,null,0,0,'BR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (60,'Bulgaria',                                                          
'BLG',2,null,null,0,0,'BG');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (61,'China',                                                             
'CHN',2,null,null,0,0,'CN');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (62,'Colombia',                                                          
'COL',2,null,null,0,0,'CO');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (63,'Costa Rica',                                                        
'CRA',2,null,null,0,0,'CR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (64,'Egypt',                                                             
'EGY',2,null,null,0,0,'EG');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (65,'El Salvador',                                                       
'ELS',2,null,null,0,0,'SV');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (66,'Guatemala',                                                         
'GUA',2,null,null,0,0,'GT');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (67,'India',                                                             
'IND',2,null,null,0,0,'IN');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (68,'Kuwait',                                                            
'KUW',2,null,null,0,0,'KW');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (69,'Lebanon',                                                           
'LEB',2,null,null,0,0,'LB');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (70,'Liechtenstein',                                                     
'LIE',2,null,null,0,0,'LI');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (71,'Malta',                                                             
'MAL',2,null,null,0,0,'MT');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (72,'Monacco',                                                           
'MON',2,null,null,0,0,'MC');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (73,'Pakistan',                                                          
'PAK',2,null,null,0,0,'PK');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (74,'Panama',                                                            
'PAN',2,null,null,0,0,'PA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (75,'Puerto Rico',                                                       
'PRT',2,null,null,0,0,'PR');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (76,'Republic of Belarus',                                               
'RBL',2,null,null,0,0,'BY');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (77,'Saudi Arabia',                                                      
'SAU',2,null,null,0,0,'SA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (78,'Tunisia',                                                           
'TUN',2,null,null,0,0,'TN');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (79,'United Arab Emirates',                                              
'UAE',2,null,null,0,0,'AE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (80,'Uruguay',                                                           
'UGY',2,null,null,0,0,'UY');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (81,'Ukraine',                                                           
'UKR',2,null,null,0,0,'UA');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (82,'Venezuela',                                                         
'VEN',2,null,null,0,0,'VE');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (83,'Yugoslavia',                                                        
'YUG',2,null,null,0,0,'YU');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (84,'Honduras',                                                          
'HON',2,null,null,0,0,'HN');                                                    
                                                                                
Insert into "&1".country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                   
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE,ISO_COUNTRY)              
values (85,'Cyprus',                                                            
'CYP',2,null,null,0,0,'CY');                                                    


update "&1".country set currency_id = null;

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  10   DevTSM    1.9         2/27/2008 3:17:14 PM Debashish Mishra  
--  9    DevTSM    1.8         2/7/2007 10:28:45 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:40:59 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:13:41 PM Debashish Mishra  
--  6    DevTSM    1.5         8/30/2002 12:43:19 PMDebashish Mishra Modified for
--       passing the schema name as an parameter
--  5    DevTSM    1.4         7/12/2002 3:41:56 PM Debashish Mishra  
--  4    DevTSM    1.3         6/18/2002 9:38:49 AM Debashish Mishra updates for
--       country.iso_country
--  3    DevTSM    1.2         6/17/2002 10:58:12 AMDebashish Mishra name changed
--       from former soviet union block to Lithuania, Latvia, Estonia, Russia
--  2    DevTSM    1.1         3/22/2002 12:51:50 PMDebashish Mishra  
--  1    DevTSM    1.0         3/20/2002 9:24:16 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

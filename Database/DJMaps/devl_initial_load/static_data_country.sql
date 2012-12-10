--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: static_data_country.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:16:45 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
--Select 'Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,
--CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)
--values ('||id||','||decode(name,null,'null',''''||name||'''')||',
--'||decode(ABBREVIATION,null,'null',
--''''||ABBREVIATION||'''')||','||COUNTRY_LEVEL||','||decode(CURRENCY_ID,
--null,'null',CURRENCY_ID)||','||decode(COUNTRY_SEARCH_ID,null,'null',
--COUNTRY_SEARCH_ID)||','||VIRTUAL_FLG||','||IS_VIEWABLE||');'
--from country order by id                                                     
  
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (0,'Dummy Country',                                                      
null,2,null,null,0,0);                                                          
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (1,'Australia',                                                          
'AUS',2,1,null,0,1);                                                            
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (2,'Austria',                                                            
'ARI',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (3,'Belgium',                                                            
'BEL',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (4,'Bulgaria, Romania',                                                  
'BUL',2,24,9,0,1);                                                              
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (5,'Canada',                                                             
'CAN',1,5,null,0,1);                                                            
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (6,'Czech Republic, Slovakia',                                           
'PHC',2,24,9,0,1);                                                              
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (7,'Denmark',                                                            
'DEN',2,7,null,0,1);                                                            
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (8,'Finland',                                                            
'FIN',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (9,'Former Soviet Union Block',                                          
'FSU',2,24,9,1,1);                                                              
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (10,'France',                                                            
'FRA',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (11,'Germany',                                                           
'DEU',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (12,'Hungary',                                                           
'HUN',2,12,9,0,1);                                                              
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (13,'Ireland',                                                           
'IRL',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (14,'Israel',                                                            
'ISR',2,14,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (15,'Italy',                                                             
'ITA',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (16,'Netherlands',                                                       
'NET',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (17,'Norway',                                                            
'NOR',2,17,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (18,'Poland',                                                            
'POL',2,18,9,0,1);                                                              
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (19,'South Africa',                                                      
'SAF',2,19,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (20,'Spain',                                                             
'ESP',2,26,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (21,'Sweden',                                                            
'SWE',2,21,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (22,'Switzerland',                                                       
'SWI',2,22,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (23,'United Kingdom',                                                    
'UK',2,23,null,0,1);                                                            
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (24,'United States',                                                     
'USA',1,24,null,0,1);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (25,'Yugoslavia, Slovenia, Croatia',                                     
'SCY',2,25,9,0,1);                                                              
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (26,'South and Central America',                                         
'SCA',2,null,null,1,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (27,'Eastern European',                                                  
'EAE',2,null,null,1,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (28,'EUR',                                                               
'EUR',2,26,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (29,'Argentina',                                                         
'ARG',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (30,'Chile',                                                             
'CHI',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (31,'Greece',                                                            
'GCE',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (32,'Hong Kong',                                                         
'HKG',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (33,'Iceland',                                                           
'ICE',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (34,'Indonesia',                                                         
'INS',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (35,'Japan',                                                             
'JAP',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (36,'Latvia',                                                            
'LAT',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (37,'Luxembourg',                                                        
'LUX',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (38,'Malaysia',                                                          
'MIA',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (39,'Mexico',                                                            
'MEX',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (40,'Morocco',                                                           
'MOR',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (41,'Portugal',                                                          
'POR',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (42,'Singapore',                                                         
'SIN',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (43,'Taiwan',                                                            
'TAI',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (44,'Thailand',                                                          
'THA',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (45,'Turkey',                                                            
'TUR',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (46,'Croatia',                                                           
'CRO',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (47,'Czech Republic',                                                    
'CZE',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (48,'Estonia',                                                           
'EST',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (49,'Lithuania',                                                         
'LIT',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (50,'New Zealand',                                                       
'NZE',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (51,'Rumania, Romania',                                                  
'RUM',2,24,null,0,0);                                                           
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (52,'Russia',                                                            
'RIA',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (53,'Slovak Republic',                                                   
'SVK',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (54,'Slovenia',                                                          
'SLO',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (55,'Bosnia',                                                            
'BOS',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (56,'Philippines',                                                       
'PHI',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (57,'Nigeria',                                                           
'NIG',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (58,'Algeria',                                                           
'ALG',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (59,'Brazil',                                                            
'BRA',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (60,'Bulgaria',                                                          
'BLG',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (61,'China',                                                             
'CHN',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (62,'Colombia',                                                          
'COL',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (63,'Costa Rica',                                                        
'CRA',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (64,'Egypt',                                                             
'EGY',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (65,'El Salvador',                                                       
'ELS',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (66,'Guatemala',                                                         
'GUA',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (67,'India',                                                             
'IND',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (68,'Kuwait',                                                            
'KUW',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (69,'Lebanon',                                                           
'LEB',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (70,'Liechtenstein',                                                     
'LIE',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (71,'Malta',                                                             
'MAL',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (72,'Monacco',                                                           
'MON',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (73,'Pakistan',                                                          
'PAK',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (74,'Panama',                                                            
'PAN',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (75,'Puerto Rico',                                                       
'PRT',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (76,'Republic of Belarus',                                               
'RBL',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (77,'Saudi Arabia',                                                      
'SAU',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (78,'Tunisia',                                                           
'TUN',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (79,'United Arab Emirates',                                              
'UAE',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (80,'Uruguay',                                                           
'UGY',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (81,'Ukraine',                                                           
'UKR',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (82,'Venezuela',                                                         
'VEN',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (83,'Yugoslavia',                                                        
'YUG',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (84,'Honduras',                                                          
'HON',2,null,null,0,0);                                                         
                                                                                
Insert into country(ID,NAME,ABBREVIATION,COUNTRY_LEVEL,                         
CURRENCY_ID,COUNTRY_SEARCH_ID,VIRTUAL_FLG,IS_VIEWABLE)                          
values (85,'Cyprus',                                                          
'CYP',2,null,null,0,0); 

update country set currency_id = null;

commit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:16:45 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:39:25 AM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:12:10 PM Debashish Mishra  
--  6    DevTSM    1.5         3/18/2002 7:42:23 PM Debashish Mishra  
--  5    DevTSM    1.4         3/14/2002 12:11:01 PMDebashish Mishra  
--  4    DevTSM    1.3         2/21/2002 3:32:27 PM Debashish Mishra  
--  3    DevTSM    1.2         2/18/2002 5:07:14 PM Debashish Mishra  
--  2    DevTSM    1.1         2/7/2002 3:10:17 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/1/2002 5:54:12 PM  Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

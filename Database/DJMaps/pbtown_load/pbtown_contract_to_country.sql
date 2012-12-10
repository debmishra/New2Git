--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: pbtown_contract_to_country.sql$ 
--
-- $Revision: 5$        $Date: 2/27/2008 3:19:52 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 



	drop sequence tsm_stage.cro_contract_to_country_seq;
	create sequence tsm_stage.cro_contract_to_country_seq;

	drop table tsm_stage.x;
	create table tsm_stage.x  (cid varchar2(3));

declare 

countryid number(10);


begin

	
	select id into countryid from "&1".country 
	  where abbreviation = 'USA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where usa = 'True';	
	commit;
	select id into countryid from "&1".country 
	  where abbreviation = 'EUR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where EUR = 'True';	
	commit;

/*	select id into countryid from "&1".country 
	  where abbreviation = 'EE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where EE = 'True';	
	commit;
*/
	select id into countryid from "&1".country 
	  where abbreviation = 'SCA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SCA = 'True';	
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'FSU';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where FSU = 'True';	
	commit;

/*	select id into countryid from "&1".country 
	  where abbreviation = 'FBT';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where FBT = 'True';
	commit;
*/
	select id into countryid from "&1".country 
	  where abbreviation = 'ALG';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ALG = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'AUS';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where AUS = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ARG';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ARG = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ARI';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ARI = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'BAH';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where BAH = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'BEL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where BEL= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'BRA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where BRA= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'BLG';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where BLG= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'BOS';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where BOS= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'BUL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where BUL= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'CAN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CAN= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'CHI';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CHI = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'CHN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CHN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'COL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where COL = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'CRA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CRA = 'True';
	commit;

/*	select id into countryid from "&1".country 
	  where abbreviation = 'CROA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CROA = 'True';
	commit;
*/
	select id into countryid from "&1".country 
	  where abbreviation = 'CYP';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CYP = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'CZE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where CZE = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'DEN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where DEN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'EGY';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where EGY = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ELS';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ELS = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ESP';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ESP = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'EST';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where EST = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'FIN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where FIN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'FRA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where FRA= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'DEU';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where DEU= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'GCE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where GCE= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'GUA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where GUA= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'HKG';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where HKG = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'HON';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where HON = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'HUN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where HUN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ICE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ICE = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'IND';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where IND = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'INS';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where INS = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'IRL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where IRL = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ISR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ISR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ITA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ITA = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'JAP';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where JAP = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'KOR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where KOR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'KUW';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where KUW = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'LAT';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where LAT = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'LEB';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where LEB = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'LIE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where LIE = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'LIT';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where LIT = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'LUX';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where LUX = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'MAL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where MAL = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'MEX';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where MEX = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'MIA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where MIA = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'MON';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where MON = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'MOR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where MOR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'NET';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where NET = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'NIG';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where NIG = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'NZE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where NZE = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'NOR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where NOR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'PAK';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where PAK = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'PAN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where PAN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'PER';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where PER = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'PHC';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where PHC = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'PHI';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where PHI = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'POL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where POL = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'POR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where POR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'PRT';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where PRT = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'RBL';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where RBL = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'RIA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where RIA = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'RUM';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where RUM = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SAU';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SAU = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SLO';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SLO = 'True';
	commit;
	
	select id into countryid from "&1".country 
	  where abbreviation = 'SAF';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SAF = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SCY';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SCY= 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SIN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SIN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SVK';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SVK = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SWE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SWE = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'SWI';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where SWI = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'TAI';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where TAI = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'THA';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where THA = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'TUN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where TUN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'TUR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where TUR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'UAE';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where UAE = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'UGY';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where UGY = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'UK';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where UK = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'UKR';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where UKR = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'VEN';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where VEN = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'YUG';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where YUG = 'True';
	commit;

	select id into countryid from "&1".country 
	  where abbreviation = 'ZIM';
	insert into "&1".cro_contract_to_country ( id, cro_contract_id, country_id) 
	  select tsm_stage.cro_contract_to_country_seq.nextval, id, countryid
          from tsm_stage.cro_contract1 where ZIM = 'True';  
	commit;
exception
when others then
insert into tsm_stage.x values (countryid);

end;
/


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  5    DevTSM    1.4         2/27/2008 3:19:52 PM Debashish Mishra  
--  4    DevTSM    1.3         1/4/2007 6:38:02 PM  Debashish Mishra  
--  3    DevTSM    1.2         11/10/2006 12:29:45 PMDebashish Mishra  
--  2    DevTSM    1.1         10/2/2006 10:06:59 PMDebashish Mishra  
--  1    DevTSM    1.0         9/28/2006 12:13:29 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------











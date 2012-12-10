--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ipm_ph1_coeff.sql$ 
--
-- $Revision: 6$        $Date: 2/27/2008 3:17:08 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

update tsm_stage.ipm_ph1_sm set word1='duration' where trim(name)='duration1';
update tsm_stage.ipm_ph1_sm set word1='treatment' where trim(name)='treatment';
commit;

drop table tsm_stage.ipm_ph1_coeff;
drop sequence tsm_stage.ipm_ph1_coeff_seq;

create sequence tsm_stage.ipm_ph1_coeff_seq;

create table tsm_stage.ipm_ph1_coeff (
	word1 varchar2(20) not null,
	word2  varchar2(40),
	word3 varchar2(20),
	word4 varchar2(40),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

truncate table tsm_stage.ipm_ph1_coeff;

Insert into tsm_stage.ipm_ph1_coeff select word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph1_sm where trim(upper(name)) not in ('_NAME_','_RMSE_','USIPTCPPSQ') ;

Insert into tsm_stage.ipm_ph1_coeff select word1,word2,word3,word4,coeff from 
tsm_stage.ipm_ph1_coeff_population where trim(upper(coeff)) <> 'FACTOR';



update tsm_stage.ipm_ph1_coeff set word1 = trim(word1);
update tsm_stage.ipm_ph1_coeff set word2 = trim(word2);
update tsm_stage.ipm_ph1_coeff set word3 = trim(word3);
update tsm_stage.ipm_ph1_coeff set word4 = trim(word4);

update tsm_stage.ipm_ph1_coeff set word1='DURATION' where word1='duration';
update tsm_stage.ipm_ph1_coeff set word1='TREATMENT' where word1='treatment';
update tsm_stage.ipm_ph1_coeff set word1='COUNTRY GROUP' where word1='xcntry';
update tsm_stage.ipm_ph1_coeff set word1='AGE' where word1='age';
update tsm_stage.ipm_ph1_coeff set word1='PH1TYPE' where word1='phase1type';
update tsm_stage.ipm_ph1_coeff set word1='POPULATION' where word1='population';
update tsm_stage.ipm_ph1_coeff set word1='CONFINEMENT' where word1='confinement';
update tsm_stage.ipm_ph1_coeff set word1='FACILITY' where word1='facility1';
update tsm_stage.ipm_ph1_coeff set word1='POP' where word1='pop';
update tsm_stage.ipm_ph1_coeff set word1='DOSING' where word1='dosing';
update tsm_stage.ipm_ph1_coeff set word1='INDAYS' where word1='indays';
update tsm_stage.ipm_ph1_coeff set word1='YEAR' where word1='year';


update tsm_stage.ipm_ph1_coeff set word3='DURATION' where word3='duration';
update tsm_stage.ipm_ph1_coeff set word3='TREATMENT' where word3='treatment';
update tsm_stage.ipm_ph1_coeff set word3='COUNTRY  GROUP' where word3='xcntry';
update tsm_stage.ipm_ph1_coeff set word3='AGE' where word3='age';
update tsm_stage.ipm_ph1_coeff set word3='PH1TYPE' where word3='phase1type';
update tsm_stage.ipm_ph1_coeff set word3='POPULATION' where word3='population';
update tsm_stage.ipm_ph1_coeff set word3='CONFINEMENT' where word3='confinement';
update tsm_stage.ipm_ph1_coeff set word3='FACILITY' where word3='facility1';
update tsm_stage.ipm_ph1_coeff set word3='POP' where word3='pop';
update tsm_stage.ipm_ph1_coeff set word3='DOSING' where word3='dosing';
update tsm_stage.ipm_ph1_coeff set word3='INDAYS' where word3='indays';
update tsm_stage.ipm_ph1_coeff set word3='YEAR' where word3='year';

commit;

update tsm_stage.ipm_ph1_coeff set word2 = decode (word2,'A',6,'B',7,'C',8,'D',9,'E',10,'F',11,'G',12,'H',13,'I',14,'J',15,'K',16,'L',17,'M',18,
'N',21,'O',22,'P',23,'Q',24,'R',25,'S',26,'T',27,'U',28,'V',29,'X',30,'AA',31,'AB',32,'AC',33,
'AD',34,'AE',35,'AF',36,'AG',37,'AH',38,'AI',39,'AJ',40,'AK',41,'AL',42,'AM',43,'AN',44,'AO',45,
'AP',46,'AQ',47,'AR',48,'AS',49,'AT',50,'AU',51,'AV',52,'AW',53,'AX',54,'AY',55,'AZ',56,'BA',57,
'BB',58,'BC',59,'BD',60,'BE',61,'BF',62) where word1 = 'PH1TYPE';

update tsm_stage.ipm_ph1_coeff set word4 = decode (word4,'A',6,'B',7,'C',8,'D',9,'E',10,'F',11,'G',12,'H',13,'I',14,'J',15,'K',16,'L',17,'M',18,
'N',21,'O',22,'P',23,'Q',24,'R',25,'S',26,'T',27,'U',28,'V',29,'X',30,'AA',31,'AB',32,'AC',33,
'AD',34,'AE',35,'AF',36,'AG',37,'AH',38,'AI',39,'AJ',40,'AK',41,'AL',42,'AM',43,'AN',44,'AO',45,
'AP',46,'AQ',47,'AR',48,'AS',49,'AT',50,'AU',51,'AV',52,'AW',53,'AX',54,'AY',55,'AZ',56,'BA',57,
'BB',58,'BC',59,'BD',60,'BE',61,'BF',62) where word3 = 'PH1TYPE';

update tsm_stage.ipm_ph1_coeff set word2 = decode (word2,'A','Adult','G','Geriatric','M','Mixed',
'N','Any','P','Pediatric','O','Postmenopause','Z','Unknown') where word1 = 'AGE';

update tsm_stage.ipm_ph1_coeff set word4 = decode (word4,'A','Adult','G','Geriatric','M','Mixed',
'N','Any','P','Pediatric','O','Postmenopause','Z','Unknown') where word3 = 'AGE';

commit;

truncate table "&1".ipm_ph1_coeff;

Insert into "&1".ipm_ph1_coeff select tsm_stage.ipm_ph1_coeff_seq.nextval,
word1, word2, word3, word4, coeff from tsm_stage.ipm_ph1_coeff;
commit;

 













---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  6    DevTSM    1.5         2/27/2008 3:17:08 PM Debashish Mishra  
--  5    DevTSM    1.4         2/7/2007 10:28:13 PM Debashish Mishra  
--  4    DevTSM    1.3         3/3/2005 6:40:34 AM  Debashish Mishra  
--  3    DevTSM    1.2         8/29/2003 5:13:20 PM Debashish Mishra  
--  2    DevTSM    1.1         4/1/2003 5:24:07 PM  Debashish Mishra  
--  1    DevTSM    1.0         3/14/2003 6:00:22 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

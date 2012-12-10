--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4_IPT.sql$ 
--
-- $Revision: 23$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop table ipm_ph2to4_lkup_coeff;
drop table ipm_ph2to4_adj_country_ratio;
drop table ipm_ph2to4_adj_coeff;
drop table ipm_std;
drop table ipm_weight;
drop table ipm_cpp;
drop table ipm_ph2to4_coeff;
drop table ipm_geographical_location;

delete from id_control where table_name in ('ipm_ph2to4_lkup_coeff','ipm_ph2to4_adj_country_ratio',
'ipm_ph2to4_adj_coeff','ipm_std','ipm_weight','ipm_cpp','ipm_ph2to4_coeff','ipm_geographical_location');

-- Following changes are as per the import requirements new IP modelled data

Create table IPM_geographical_location (
	country_id number(10),
	country_group varchar2(40),
	geographical_location varchar2(10))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table IPM_geographical_location add constraint IPM_geographical_location_pk
	primary key (country_id) using index tablespace tsmsmall_indx
	pctfree 20;

Alter table IPM_geographical_location add constraint IPM_geographical_location_fk1
	foreign key (country_id) references country(id);

create table IPM_ph2to4_coeff (
	id number (10),
	geographical_location varchar2(10),
	INPATIENT_STATUS  VARCHAR2(20),
	cpp_cpv varchar2(3),
	coeff_type varchar2(20) not null,
	coeff_value varchar2(40),
	cross_coeff_type varchar2(20),
	cross_coeff_value varchar2(40),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table IPM_ph2to4_coeff add constraint IPM_ph2to4_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_ph2to4_coeff add constraint IPC_ph2to4_coeff_type_check
	check (coeff_type in 
	( 'AFFILIATION','COUNTRY GROUP','DURATION','TA','INDGRP','IPT COMPLEX','PHASE','YEAR'));

Create table IPM_cpp(
	id number(10),
	phase_id number(10) not null,
	indmap_id number(10) not null,
	low number(12,2),
	mid number(12,2),
	high number(12,2),
	clow number(12,2),
	cmid number(12,2),	 
	chigh number(12,2),
	olow number(12,2),
	omid number(12,2),	 
	ohigh number(12,2),
	cpv number(12,2),
	patient_status varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table IPM_cpp add constraint IPM_cpp_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_cpp add constraint IPM_cpp_fk1
	foreign key (phase_id) references 
	phase(id);

Alter table IPM_cpp add constraint IPM_cpp_fk2
	foreign key (indmap_id) references 
	indmap(id);

Create table IPM_weight(
	id number(10),
	country_id number(10) not null,
	phase_id number(10) not null,
	indmap_id number(10) not null,
	Affiliation varchar2(20),
	complex_minvalue number(12,2),
	minvalue number(12,2) not null,
	inpatient_status varchar2(20))
	tablespace tsmsmall 
	pctused 60 pctfree 25;

Alter table IPM_weight add constraint IPM_weight_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_weight add constraint IPM_weight_fk1
	foreign key (Country_id) references 
	Country(id);

Alter table IPM_weight add constraint IPM_weight_fk2
	foreign key (phase_id) references 
	phase(id);

Alter table IPM_weight add constraint IPM_weight_fk3
	foreign key (indmap_id) references 
	indmap(id);

Create table IPM_std(
	id number(10),
	geographical_location varchar2(10),
	country_group varchar2(40),
	phase_id number(10) not null,
	mean_cpp number(20,10),
	mean_cpv number(20,10),
	std_cpp number(20,10),
	std_cpv number(20,10))
	tablespace tsmsmall 
	pctused 60 pctfree 25;	

Alter table IPM_std add constraint IPM_std_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table IPM_std add constraint IPM_std_fk1
	foreign key (phase_id) references 
	phase(id);

Insert into id_control values('tsm10','ipm_ph2to4_coeff',1);
Insert into id_control values('tsm10','ipm_cpp',1);
Insert into id_control values('tsm10','ipm_weight',1);
Insert into id_control values('tsm10','ipm_std',1);

commit;

-- Following changes are done on 03/17/2003 at 12:14pm

Insert into ipm_geographical_location select id,'ARG','EEUX' from country where abbreviation = 'ARG';
Insert into ipm_geographical_location select id,'ARI','WEUX' from country where abbreviation = 'ARI';
Insert into ipm_geographical_location select id,'AUS1','CANX' from country where abbreviation = 'AUS';
Insert into ipm_geographical_location select id,'AUS1','CANX' from country where abbreviation = 'NZE';
Insert into ipm_geographical_location select id,'BEL','WEUX' from country where abbreviation = 'BEL';
Insert into ipm_geographical_location select id,'BRA','EEUX' from country where abbreviation = 'BRA';
Insert into ipm_geographical_location select id,'BUL','EEUX' from country where abbreviation = 'BLG';
Insert into ipm_geographical_location select id,'BUL','EEUX' from country where abbreviation = 'RUM';
Insert into ipm_geographical_location select id,'CAN','CANX' from country where abbreviation = 'CAN';
Insert into ipm_geographical_location select id,'CHI','EEUX' from country where abbreviation = 'CHI';
Insert into ipm_geographical_location select id,'DEU','WEUX' from country where abbreviation = 'DEU';
Insert into ipm_geographical_location select id,'FRA','WEUX' from country where abbreviation = 'FRA';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'RIA';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'EST';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'LAT';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'LIT';
Insert into ipm_geographical_location select id,'HUN','EEUX' from country where abbreviation = 'HUN';
Insert into ipm_geographical_location select id,'ISR','EEUX' from country where abbreviation = 'ISR';
Insert into ipm_geographical_location select id,'ITA','WEUX' from country where abbreviation = 'ITA';
Insert into ipm_geographical_location select id,'MEX','EEUX' from country where abbreviation = 'MEX';
Insert into ipm_geographical_location select id,'NET','WEUX' from country where abbreviation = 'NET';
Insert into ipm_geographical_location select id,'PHC','EEUX' from country where abbreviation = 'CZE';
Insert into ipm_geographical_location select id,'PHC','EEUX' from country where abbreviation = 'SLO';
Insert into ipm_geographical_location select id,'POL','EEUX' from country where abbreviation = 'POL';
Insert into ipm_geographical_location select id,'SAF','EEUX' from country where abbreviation = 'SAF';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'SWE';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'NOR';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'DEN';
Insert into ipm_geographical_location select id,'SCAN','WEUX' from country where abbreviation = 'FIN';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'YUG';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'SVK';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'CRO';
Insert into ipm_geographical_location select id,'SWI','WEUX' from country where abbreviation = 'SWI';
Insert into ipm_geographical_location select id,'UK1','WEUX' from country where abbreviation = 'UK';
Insert into ipm_geographical_location select id,'UK1','WEUX' from country where abbreviation = 'IRL';
Insert into ipm_geographical_location select id,'USA','USAX' from country where abbreviation = 'USA';
Insert into ipm_geographical_location select id,'BUL','EEUX' from country where abbreviation = 'BUL';
Insert into ipm_geographical_location select id,'PHC','EEUX' from country where abbreviation = 'PHC';
Insert into ipm_geographical_location select id,'FSU','EEUX' from country where abbreviation = 'FSU';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'SCY';
Insert into ipm_geographical_location select id,'SCY','EEUX' from country where abbreviation = 'ESP';

commit;


-- Following changes are as per the second phase of work requested by Chik/Kelly

create table ipm_ph2to4_adj_coeff(
	id number (10),
	geographical_location varchar2(10),
	INPATIENT_STATUS  VARCHAR2(20),
	cpp_cpv varchar2(7),
	coeff_type varchar2(20) not null,
	coeff_value varchar2(40),
	coeff number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table ipm_ph2to4_adj_coeff add constraint ipm_ph2to4_adj_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;

Alter table ipm_ph2to4_adj_coeff add constraint ipac_coeff_type_check
	check (coeff_type in ('LOCATION','INDGRP','PHASE','DURATION'));

create table ipm_ph2to4_adj_country_ratio(
	id number (10),
	country_id number(10),
	geographical_location varchar2(10),
	p2 number(20,12),
	p3 number(20,12),
	y3p2 number(20,12),
	y3p3 number(20,12))
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table ipm_ph2to4_adj_country_ratio add constraint ipm_ph2_adj_country_ratio_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;	

Alter table ipm_ph2to4_adj_country_ratio add constraint ipm_ph2_adj_country_ratio_fk1
	foreign key (country_id) references country(id);

-- Following chnages are as per the new look up tables given y  Chik on 04/28/2003

create table ipm_ph2to4_lkup_coeff(
	id number (10),
	country_id number(10) not null, 
	phase_id number(10) not null,
	indmap_id number(10) not null,
	pct25 number(20,12) not null,
	pct50 number(20,12) not null,
	pct75 number(20,12) not null,
	duration number(6,2) not null,
	cpp_cpv varchar2(10) not null)
	tablespace tsmsmall 
	pctused 60 pctfree 20;

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_pk
	primary key (id) using index tablespace 
	tsmsmall_indx ;	

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_fk1
	foreign key (country_id) references country(id);

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_fk2
	foreign key (phase_id) references phase(id);

Alter table ipm_ph2to4_lkup_coeff add constraint ipm_ph2to4_lkup_coeff_fk3
	foreign key (indmap_id) references indmap(id);


Insert into id_control values('tsm10','ipm_ph2to4_adj_coeff',1);
Insert into id_control values('tsm10','ipm_ph2to4_adj_country_ratio',1);
Insert into id_control values('tsm10','ipm_ph2to4_lkup_coeff',1);

commit;

--***********************************************************
-- implemented upto this in tsm10@test, tsm10e@test, tsm10e@prev,
-- tsm10p@prev, tsm10e@prod, tsm10@prod on 02-17-2004
-- implemented upto this in tsm10g@prod on 05-01-2004 at 1am
--***********************************************************

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  23   DevTSM    1.22        2/22/2008 11:56:00 AMDebashish Mishra  
--  22   DevTSM    1.21        9/19/2006 12:11:25 AMDebashish Mishra   
--  21   DevTSM    1.20        3/2/2005 10:50:59 PM Debashish Mishra  
--  20   DevTSM    1.19        5/6/2004 8:15:33 PM  Debashish Mishra  
--  19   DevTSM    1.18        2/20/2004 4:54:27 PM Debashish Mishra  
--  18   DevTSM    1.17        11/24/2003 2:45:26 PMDebashish Mishra  
--  17   DevTSM    1.16        11/18/2003 4:08:30 PMDebashish Mishra modified to
--       push the data into production
--  16   DevTSM    1.15        8/29/2003 5:17:41 PM Debashish Mishra  
--  15   DevTSM    1.14        5/19/2003 11:13:15 AMDebashish Mishra  
--  14   DevTSM    1.13        5/8/2003 3:05:33 PM  Debashish Mishra  
--  13   DevTSM    1.12        5/2/2003 9:54:44 AM  Debashish Mishra  
--  12   DevTSM    1.11        4/29/2003 9:02:53 AM Debashish Mishra new lookup
--       tables
--  11   DevTSM    1.10        4/18/2003 8:09:37 PM Debashish Mishra  
--  10   DevTSM    1.9         4/7/2003 10:15:20 AM Debashish Mishra Colin's
--       ftadmin and Joel's installshield changes
--  9    DevTSM    1.8         4/1/2003 5:23:51 PM  Debashish Mishra  
--  8    DevTSM    1.7         3/28/2003 4:06:25 PM Debashish Mishra  
--  7    DevTSM    1.6         3/27/2003 4:56:47 PM Debashish Mishra  
--  6    DevTSM    1.5         3/26/2003 10:04:18 AMDebashish Mishra  
--  5    DevTSM    1.4         3/20/2003 12:09:45 PMDebashish Mishra added
--       inpatient_status to ipm_weight
--  4    DevTSM    1.3         3/19/2003 2:24:14 PM Debashish Mishra  
--  3    DevTSM    1.2         3/14/2003 6:26:54 PM Debashish Mishra Modified while
--       writing dataload scripts
--  2    DevTSM    1.1         3/12/2003 2:31:21 PM Debashish Mishra new IPM_*
--       tables
--  1    DevTSM    1.0         3/12/2003 10:24:57 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

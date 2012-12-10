--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_changes_for_build_code_update.sql$ 
--
-- $Revision: 8$        $Date: 2/22/2008 11:56:00 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop table reference_prices;

alter table temp_overhead add entry_date date;

alter table  temp_ip_study_price add grant_date date;

alter table  temp_ip_study_price add entry_date date;

CREATE OR REPLACE procedure update_tspd_proc_pricing(BuildTag number) as
BuildTagExists   number(5);
GMBuildExists   number(5);
TSDBuildExists   number(5);
GMTableExists   number(5);
TSDTableExists   number(5);
curruser   varchar2(30);
stmt    varchar2(512);
max_price_num   number(10);
InvalidBuildTag   exception;
InvalidGMBuild   exception;
InvalidTSDBuild   exception;
InvalidGMTable   exception;
InvalidTSDTable   exception;
begin
select count(*) into BuildTagExists from build_tag where id=BuildTag;
   if BuildTagExists =0 then
      raise InvalidBuildTag;
   end if;
select user into currUser from dual;
select count(*) into GMBuildExists from all_users where username=CurrUser||'_'||BuildTag;
select count(*) into TSDBuildExists from all_users where username=CurrUser||'_TSPD_'||BuildTag;
If GMBuildExists=0 then
   raise InvalidGMBuild;
end if;
If TSDBuildExists=0 then
   raise InvalidTSDBuild;
end if;
select count(*) into GMTableExists from all_tables where owner=CurrUser||'_'||BuildTag and table_name='PAP_CLINICAL_PROC_COST';
select count(*) into TSDTableExists from all_tables where owner=CurrUser||'_TSPD_'||BuildTag and table_name='TSPD_PROC_PRICING';
If GMTableExists=0 then
   raise InvalidGMTable;
end if;
If TSDTableExists=0 then
   raise InvalidTSDTable;
end if;
stmt:='update '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing a set a.pct50=
(select pct50 from '||CurrUser||'_'||BuildTag||'.pap_clinical_proc_cost b, country c
where b.mapper_id=a.mapper_id and b.country_id=c.id and c.abbreviation='||''''||'USA'||''''||'
and b.phase_id=0 and b.indmap_id=0)';
execute immediate(stmt);
stmt:='insert into '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing
(ID,PHASE_ID,INDMAP_ID,MAPPER_ID,PCT50,CNT,YEARS_BACK)
select '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing_seq.nextval,
0,0,a.mapper_id,a.pct50,a.OTHER_EXP_CNT,
nvl(to_number(to_char(sysdate,''YYYY''))+1-a.IND_YEAR,0) from
'||CurrUser||'_'||BuildTag||'.pap_clinical_proc_cost a where not exists
(select 1 from '||CurrUser||'_TSPD_'||BuildTag||'.tspd_proc_pricing b
where b.mapper_id=a.mapper_id and
b.phase_id=0 and b.indmap_id=0) and
a.phase_id=0 and a.indmap_id=0 and a.country_id=24';
execute immediate(stmt);
commit;
exception
  when InvalidBuildTag then
      raise_application_error(-20111,'Invalid Build Tag');
  when InvalidGMBuild then
      raise_application_error(-20112,'GM Build phase-1 master client schema not found with build tag '||BuildTag);
  when InvalidTSDBuild then
      raise_application_error(-20113,'TSD build not found with build tag '||BuildTag);
  when InvalidGMTable then
      raise_application_error(-20114,'table PAP_CLINICAL_PROC_COST not found in the master-client build');
  when InvalidTSDTable then
      raise_application_error(-20115,'table TSPD_PROC_PRICING not found in TSD build');
end;
/

sho err


create table reference_prices(
ID      		NUMBER(10),
procedure_def_id    	number(10) not null,
payment      		number(14,2),
country_id     		number(10) not null,
build_code_id     	number(10),
INVCODE                 VARCHAR2(35), 
CODE                    VARCHAR2(35),
CURR                    VARCHAR2(3),
OTLR_PMT                NUMBER(1),
CHECKED                 VARCHAR2(10), 
FIRSTCHK                VARCHAR2(12),
PL_CHECK                NUMBER(1),
PTLEVEL                 NUMBER(14,2),
GRANTLVL                NUMBER(14,2), 
ODCEST                  VARCHAR2(1))
tablespace cropbt_data pctfree 20;

Alter table reference_prices add constraint reference_prices_pk 
	primary key (id) using index tablespace 
	cropbt_indx pctfree 20;

Alter table reference_prices add constraint reference_prices_fk1
	foreign key (country_id) references 
	country(id);

Alter table reference_prices add constraint reference_prices_fk2
	foreign key (procedure_def_id) references 
	procedure_def(id);

Alter table reference_prices add constraint reference_prices_fk3
	foreign key (build_code_id) references 
	build_code(id);



delete from id_control where table_name='reference_prices';
insert into id_control values('tsm10','reference_prices',1);
commit; 


--************************************************
-- deployed till here in tsm10e@test on 12/8/2006
-- deployed till here in tsm10@tt03 on 12/19/2006
-- deployed till here in tsm10t@prev on 2/9/2006
-- deployed till here in tsm10e@prev  
-- deployed till here in tsm10@prod  
-- deployed till here in tsm10e@prod  
-- deployed till here in tsm10g@prod  
--************************************************


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  8    DevTSM    1.7         2/22/2008 11:56:00 AMDebashish Mishra  
--  7    DevTSM    1.6         3/17/2007 7:38:57 AM Debashish Mishra  
--  6    DevTSM    1.5         2/15/2007 4:46:17 PM Debashish Mishra  
--  5    DevTSM    1.4         12/20/2006 11:53:46 AMDebashish Mishra  
--  4    DevTSM    1.3         12/10/2006 11:51:45 PMDebashish Mishra  
--  3    DevTSM    1.2         12/4/2006 3:31:46 PM Debashish Mishra  
--  2    DevTSM    1.1         11/27/2006 2:24:12 PMDebashish Mishra  
--  1    DevTSM    1.0         10/10/2006 3:54:56 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------













#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsm10_client_industry_update.ksh$ 
#
# $Revision: 18$        $Date: 2/27/2008 3:17:45 PM$
#
#
# Description:  <ADD>
#
#############################################################
 


if  test  $# != 6
 then
    echo 'Usage :  tsm10_client_industry_update.ksh <master_schema_name>  <master_password> <master_client_schema_name> <client_schema_name> <database_connect string> <client_div_id>'
    echo 
    echo This script requires six arguments. 
    echo master schema name and password  
    echo master client schema name 
    echo client schema name 
    echo database connect string and client_div_id
    echo for example, tsm10_client_industry_update.ksh tsm10 welcome tsm10_42 tsm10_pkd_42 devl 34
    exit 2
 fi

sqlplus    $1/$2@$5    << EOF 

--*****************************************
--PAP_CLINICAL_PROC_COST update starts here
--*****************************************

declare

 pap_proc_cost_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into pap_proc_cost_nextid from $4.id_control where table_name='pap_clinical_proc_cost';
  seq_stmt:='create sequence pap_proc_cost_seq start with '||pap_proc_cost_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/


update $4.pap_clinical_proc_cost b set (b.PCT25,b.PCT50,b.PCT75,b.OTHER_EXP_CNT,b.IND_YEAR,
b.IND_UNUSED_CNT,b.IND_ENTRY_YEAR,b.NUM_COMPANIES,
b.INDUSTRY_PCT_IDS,b.DE_PRICE ) =(select a.PCT25,a.PCT50,a.PCT75,a.OTHER_EXP_CNT,a.IND_YEAR,
a.IND_UNUSED_CNT,a.IND_ENTRY_YEAR,a.NUM_COMPANIES, 
a.INDUSTRY_PCT_IDS, a.DE_PRICE from $3.pap_clinical_proc_cost a where b.country_id=a.country_id and 
b.mapper_id=a.mapper_id and b.indmap_id= a.indmap_id and b.phase_id= a.phase_id) 
where b.specificity is not null and exists 
(select 1 from $3.pap_clinical_proc_cost c where c.country_id=b.country_id and 
c.mapper_id=b.mapper_id and c.indmap_id= b.indmap_id and c.phase_id= b.phase_id );
commit;


update $4.pap_clinical_proc_cost b set (b.PCT25,b.PCT50,b.PCT75,b.OTHER_EXP_CNT,b.IND_YEAR,
b.IND_UNUSED_CNT,b.IND_ENTRY_YEAR,b.NUM_COMPANIES, b.specificity,
b.INDUSTRY_PCT_IDS,b.DE_PRICE ) =( select a.PCT25,a.PCT50,a.PCT75,a.OTHER_EXP_CNT,a.IND_YEAR,
a.IND_UNUSED_CNT,a.IND_ENTRY_YEAR,a.NUM_COMPANIES, a.specificity,
a.INDUSTRY_PCT_IDS, a.DE_PRICE from $3.pap_clinical_proc_cost a where b.country_id=a.country_id and 
b.mapper_id=a.mapper_id and b.indmap_id= a.indmap_id and b.phase_id= a.phase_id) 
where b.specificity is null and exists 
(select 1 from $3.pap_clinical_proc_cost c where c.country_id=b.country_id and 
c.mapper_id=b.mapper_id and c.indmap_id= b.indmap_id and c.phase_id= b.phase_id );
commit;


insert into $4.pap_clinical_proc_cost(ID ,COUNTRY_ID,INDMAP_ID,PHASE_ID,MAPPER_ID,PCT25,PCT50,PCT75,          
COMPANY_PCT50,DE_PRICE,CO_EXP_CNT,OTHER_EXP_CNT,SPECIFICITY,IND_YEAR ,IND_UNUSED_CNT,CO_YEAR,       
CO_UNUSED_CNT,LEVEL2_SKIP_FLG,IND_ENTRY_YEAR ,NUM_COMPANIES,COMPANY_PCT25 ,COMPANY_PCT75,
INDUSTRY_PCT_IDS) 
select pap_proc_cost_seq.nextval,a.COUNTRY_ID ,a.INDMAP_ID,a.PHASE_ID,       
a.MAPPER_ID,a.PCT25,a.PCT50,a.PCT75 ,a.COMPANY_PCT50,a.DE_PRICE,a.CO_EXP_CNT,a.OTHER_EXP_CNT,  
a.SPECIFICITY,a.IND_YEAR ,a.IND_UNUSED_CNT,a.CO_YEAR,a.CO_UNUSED_CNT ,a.LEVEL2_SKIP_FLG,
a.IND_ENTRY_YEAR,a.NUM_COMPANIES ,a.COMPANY_PCT25 ,a.COMPANY_PCT75,
INDUSTRY_PCT_IDS 
  from $3.pap_clinical_proc_cost a, $1.client_div_to_lic_country b 
where a.country_id = b.country_id and b.client_div_id = $6 and not exists 
(select 1 from $4.pap_clinical_proc_cost c where c.country_id=a.country_id and 
c.mapper_id=a.mapper_id and c.indmap_id= a.indmap_id and c.phase_id= a.phase_id );
commit;

declare
 nval  number(10);
begin
 select pap_proc_cost_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
   where table_name='pap_clinical_proc_cost';
 commit;
end;
/

drop sequence pap_proc_cost_seq;


--*****************************************
--PAP_OVERHEAD update starts here
--*****************************************

declare

 pap_overhead_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into pap_overhead_nextid from $4.id_control where table_name='pap_overhead';
  seq_stmt:='create sequence pap_overhead_seq start with '||pap_overhead_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/


update $4.pap_overhead b set (b.OFC_OVRHD_P25,
b.OFC_OVRHD_P50,b.OFC_OVRHD_P75,
b.ADJ_OVRHD_P25,b.ADJ_OVRHD_P50,b.ADJ_OVRHD_P75,b.ODC_P50,
b.PCT_PAID_P50,b.ADJ_OVRHD_PCT_IDS,b.OFC_OVRHD_PCT_IDS,b.PCT_PAID_PCT_IDS,
b.ODC_PCT_IDS) =(
select a.OFC_OVRHD_P25,a.OFC_OVRHD_P50,a.OFC_OVRHD_P75,
a.ADJ_OVRHD_P25,a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.ODC_P50,
a.PCT_PAID_P50,a.ADJ_OVRHD_PCT_IDS,a.OFC_OVRHD_PCT_IDS,a.PCT_PAID_PCT_IDS,
a.ODC_PCT_IDS
from $3.pap_overhead a where b.country_id=a.country_id and 
b.affiliation=a.affiliation and b.indmap_id= a.indmap_id and b.phase_id= a.phase_id) 
where b.specificity is not null and exists 
(select 1 from $3.pap_overhead c where c.country_id=b.country_id and 
c.affiliation=b.affiliation and c.indmap_id= b.indmap_id and c.phase_id= b.phase_id);
commit;


update $4.pap_overhead b set (b.OFC_OVRHD_P25,
b.OFC_OVRHD_P50,b.OFC_OVRHD_P75,
b.ADJ_OVRHD_P25,b.ADJ_OVRHD_P50,b.ADJ_OVRHD_P75,b.ODC_P50,
b.PCT_PAID_P50,b.ADJ_OVRHD_PCT_IDS,b.OFC_OVRHD_PCT_IDS,b.PCT_PAID_PCT_IDS,
b.ODC_PCT_IDS,b.specificity ) =(
select a.OFC_OVRHD_P25,a.OFC_OVRHD_P50,a.OFC_OVRHD_P75,
a.ADJ_OVRHD_P25,a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.ODC_P50,
a.PCT_PAID_P50,a.ADJ_OVRHD_PCT_IDS,a.OFC_OVRHD_PCT_IDS,a.PCT_PAID_PCT_IDS,
a.ODC_PCT_IDS,a.specificity
  from $3.pap_overhead a where b.country_id=a.country_id and 
b.affiliation=a.affiliation and b.indmap_id= a.indmap_id and b.phase_id= a.phase_id)
where b.specificity is null and exists 
(select 1 from $3.pap_overhead c where c.country_id=b.country_id and 
c.affiliation=b.affiliation and c.indmap_id= b.indmap_id and c.phase_id= b.phase_id);
commit;


insert into $4.pap_overhead(ID,COUNTRY_ID,PHASE_ID,INDMAP_ID,COMPANY_OVRHD_P50,
COMPANY_ODC_P50,OFC_OVRHD_P25,
OFC_OVRHD_P50,OFC_OVRHD_P75,ADJ_OVRHD_P25,ADJ_OVRHD_P50,ADJ_OVRHD_P75,AFFILIATION,
ODC_P50,COMPANY_PCT_PAID_P50,PCT_PAID_P50,SPECIFICITY,ADJ_OVRHD_PCT_IDS,
OFC_OVRHD_PCT_IDS,PCT_PAID_PCT_IDS,ODC_PCT_IDS,COMPANY_OVRHD_PCT_IDS,
COMPANY_ODC_PCT_IDS,COMPANY_PCT_PAID_PCT_IDS  ) 
select pap_overhead_seq.nextval,a.COUNTRY_ID,a.PHASE_ID,a.INDMAP_ID,a.COMPANY_OVRHD_P50,
a.COMPANY_ODC_P50,a.OFC_OVRHD_P25,
a.OFC_OVRHD_P50,a.OFC_OVRHD_P75,a.ADJ_OVRHD_P25,a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.AFFILIATION,
a.ODC_P50,a.COMPANY_PCT_PAID_P50,a.PCT_PAID_P50,a.SPECIFICITY,a.ADJ_OVRHD_PCT_IDS,
a.OFC_OVRHD_PCT_IDS,a.PCT_PAID_PCT_IDS,a.ODC_PCT_IDS,a.COMPANY_OVRHD_PCT_IDS,
a.COMPANY_ODC_PCT_IDS,a.COMPANY_PCT_PAID_PCT_IDS 
  from $3.pap_overhead a, $1.client_div_to_lic_country b 
where a.country_id = b.country_id and b.client_div_id = $6 and not exists 
(select 1 from $4.pap_overhead c where c.country_id=a.country_id and 
c.affiliation=a.affiliation and c.indmap_id= a.indmap_id and c.phase_id= a.phase_id );
commit;

declare
  nval number(10);
begin
 select pap_overhead_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
   where table_name='pap_overhead';
 commit;
end;
/

drop sequence pap_overhead_seq;


--*****************************************
--industry_pap_odc_cost update starts here
--*****************************************

declare

 industry_pap_odc_cost_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into industry_pap_odc_cost_nextid from $4.id_control 
  where table_name='industry_pap_odc_cost';
  seq_stmt:='create sequence industry_pap_odc_cost_seq start with '||industry_pap_odc_cost_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/

insert into $4.industry_pap_odc_cost(ID,COUNTRY_ID,INDMAP_ID,PHASE_ID,MAPPER_ID,PRICE_TYPE,
PRICE_P25,PRICE_P50,PRICE_P75,SPECIFICITY,YEAR,USED_CNT,UNUSED_CNT,NUM_COMPANIES,
ENTRY_YEAR,PCT_IDS) 
select industry_pap_odc_cost_seq.nextval,a.COUNTRY_ID,a.INDMAP_ID,a.PHASE_ID,
a.MAPPER_ID,a.PRICE_TYPE,a.PRICE_P25,a.PRICE_P50,
a.PRICE_P75,a.SPECIFICITY,a.YEAR,a.USED_CNT,a.UNUSED_CNT,a.NUM_COMPANIES,
a.ENTRY_YEAR,a.PCT_IDS from $3.industry_pap_odc_cost a, $1.client_div_to_lic_country b 
where a.country_id = b.country_id and b.client_div_id = $6 and not exists 
(select 1 from $4.industry_pap_odc_cost c where c.country_id=a.country_id and 
c.mapper_id=a.mapper_id and c.indmap_id= a.indmap_id and c.phase_id= a.phase_id 
and c.specificity = a.specificity and c.price_type = a.price_type);
commit;

declare
 nval number(10);
begin
 select industry_pap_odc_cost_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
   where table_name='industry_pap_odc_cost';
 commit;
end;
/

drop sequence industry_pap_odc_cost_seq;

--*****************************************
--institution_overhead update starts here
--*****************************************

declare

 institution_overhead_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into institution_overhead_nextid from $4.id_control 
  where table_name='institution_overhead';
  seq_stmt:='create sequence institution_overhead_seq start with '||institution_overhead_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/

insert into $4.institution_overhead(ID,INSTITUTION_ID,OFC_OVRHD_P25,OFC_OVRHD_P50,OFC_OVRHD_P75,
ADJ_OVRHD_P25,ADJ_OVRHD_P50,ADJ_OVRHD_P75,OVRHD_BASE_PCT,EXPERIENCE_COUNT,PCT_PAID_P50,
OVRHD_18MO_P50,OFC_OVRHD_PCT_IDS,ADJ_OVRHD_PCT_IDS,OVRHD_BASE_PCT_IDS,
PCT_PAID_PCT_IDS,OVRHD_18MO_PCT_IDS ) 
select institution_overhead_seq.nextval,a.INSTITUTION_ID,a.OFC_OVRHD_P25,a.OFC_OVRHD_P50,
a.OFC_OVRHD_P75,a.ADJ_OVRHD_P25,a.ADJ_OVRHD_P50,a.ADJ_OVRHD_P75,a.OVRHD_BASE_PCT,
a.EXPERIENCE_COUNT,a.PCT_PAID_P50,a.OVRHD_18MO_P50,a.OFC_OVRHD_PCT_IDS,a.ADJ_OVRHD_PCT_IDS,
a.OVRHD_BASE_PCT_IDS,a.PCT_PAID_PCT_IDS,a.OVRHD_18MO_PCT_IDS 
from $3.institution_overhead a 
where not exists 
(select 1 from $4.institution_overhead c where c.institution_id=a.institution_id);
commit;

declare
 nval number(10);
begin
 select institution_overhead_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
   where table_name='institution_overhead';
 commit;
end;
/


drop sequence institution_overhead_seq;

--********************************************
--pap_institution_proc_cost update starts here
--********************************************

declare

 pap_inst_proc_cost_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into pap_inst_proc_cost_nextid from $4.id_control 
  where table_name='pap_institution_proc_cost';
  seq_stmt:='create sequence pap_institution_proc_cost_seq start with '||pap_inst_proc_cost_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/

insert into $4.pap_institution_proc_cost(ID,INSTITUTION_ID,MAPPER_ID,PCT50,PCT_IDS ) 
select pap_institution_proc_cost_seq.nextval,a.INSTITUTION_ID,a.MAPPER_ID,a.PCT50,a.PCT_IDS  
from $3.pap_institution_proc_cost a 
where not exists 
(select 1 from $4.pap_institution_proc_cost c where c.institution_id=a.institution_id
and c.mapper_id=a.mapper_id);
commit;

declare
 nval number(10);
begin
 select pap_institution_proc_cost_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
  where table_name='pap_institution_proc_cost';
 commit;
end;
/

drop sequence pap_institution_proc_cost_seq;

--*****************************************
--pap_institution_odc_cost update starts here
--*****************************************

declare

 pap_inst_odc_cost_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into pap_inst_odc_cost_nextid from $4.id_control 
  where table_name='pap_institution_odc_cost';
  seq_stmt:='create sequence pap_institution_odc_cost_seq start with '||pap_inst_odc_cost_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/

insert into $4.pap_institution_odc_cost(ID,INSTITUTION_ID,MAPPER_ID,PCT50,PRICE_TYPE,PCT_IDS ) 
select pap_institution_odc_cost_seq.nextval,a.INSTITUTION_ID,a.MAPPER_ID,a.PCT50,a.PRICE_TYPE,a.PCT_IDS  
from $3.pap_institution_odc_cost a 
where not exists 
(select 1 from $4.pap_institution_odc_cost c where c.institution_id=a.institution_id
and c.mapper_id=a.mapper_id );
commit;

declare
 nval number(10);
begin
 select pap_institution_odc_cost_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
  where table_name='pap_institution_odc_cost';
 commit;
end;
/

drop sequence pap_institution_odc_cost_seq;

--*****************************************
--ip_study_price update starts here
--*****************************************


declare

 ip_study_price_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into ip_study_price_nextid from $4.id_control 
  where table_name='ip_study_price';
  seq_stmt:='create sequence ip_study_price_seq start with '||ip_study_price_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/

update $4.ip_study_price b set (b.PCT25,b.PCT50,b.PCT75,b.OTHER_CPP_EXP_CNT,b.INDUSTRY_PCT_IDS,b.DE_PRICE ) =(
select a.PCT25,a.PCT50,a.PCT75,a.OTHER_CPP_EXP_CNT,a.INDUSTRY_PCT_IDS,a.DE_PRICE
  from $3.ip_study_price a where b.country_id=a.country_id  
and b.indmap_id= a.indmap_id and b.phase_id= a.phase_id and b.cpp_flg=a.cpp_flg)
where exists 
(select 1 from $3.ip_study_price c where c.country_id=b.country_id and 
 c.indmap_id= b.indmap_id and c.phase_id= b.phase_id and c.cpp_flg=b.cpp_flg);
commit;

insert into $4.ip_study_price(ID,COUNTRY_ID,INDMAP_ID,PHASE_ID,PCT25,PCT50,PCT75,COMPANY_PCT50,
DE_PRICE,CPP_FLG,CO_CPP_EXP_CNT,OTHER_CPP_EXP_CNT,INDUSTRY_PCT_IDS,CO_PCT_IDS ) 
select ip_study_price_seq.nextval,a.COUNTRY_ID,a.INDMAP_ID,a.PHASE_ID,a.PCT25,a.PCT50,a.PCT75,a.COMPANY_PCT50,
a.DE_PRICE,a.CPP_FLG,a.CO_CPP_EXP_CNT,a.OTHER_CPP_EXP_CNT,a.INDUSTRY_PCT_IDS,a.CO_PCT_IDS  
from $3.ip_study_price a 
where not exists 
(select 1 from $4.ip_study_price c where c.COUNTRY_ID=a.COUNTRY_ID
and c.INDMAP_ID=a.INDMAP_ID and c.PHASE_ID=a.PHASE_ID and c.CPP_FLG=a.CPP_FLG);
commit;

declare
 nval number(10);
begin
 select ip_study_price_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
  where table_name='ip_study_price';
 commit;
end;
/

drop sequence ip_study_price_seq;

--*****************************************
--industry_pap_odc_cost update starts here
--*****************************************


declare

 industry_pap_odc_cost_nextid number(10);
 id_control_exists  number(1);
 seq_stmt  varchar2(1000);
 MissingIdControl exception;

begin

  select count(*) into id_control_exists from all_tables 
  where table_name='ID_CONTROL' and owner=upper('$4');

  if id_control_exists=0 then
    raise MissingIdControl;
  end if;

  select nvl(next_id,1) into industry_pap_odc_cost_nextid from $4.id_control where table_name='industry_pap_odc_cost';
  seq_stmt:='create sequence ipoc_seq start with '||industry_pap_odc_cost_nextid;
  execute immediate (seq_stmt);
exception
 when MissingIdControl then
  Raise_application_error(-20301,'ID Control table missing from client_schema. Please upgrade it first');
end;
/


update $4.industry_pap_odc_cost a set (a.PRICE_P25,a.PRICE_P50,a.PRICE_P75) = (
select b.PCT25,b.PCT50,b.PCT75 from $1.add_study b, $4.mapper c where
b.odc_def_id=c.odc_def_id and a.mapper_id=c.id and 
b.country_id=a.country_id and b.specificity=a.specificity and
a.price_type='GLOBAL' and a.indmap_id=0 and a.phase_id=0)
where exists 
(select 1 from $1.add_study c, $4.mapper d where c.COUNTRY_ID=a.country_id
and c.odc_def_id=d.odc_def_id and d.id=a.mapper_id and c.specificity=a.specificity and
a.price_type='GLOBAL' and a.indmap_id=0 and a.phase_id=0);
commit;


Insert into $4.industry_pap_odc_cost(ID,COUNTRY_ID,INDMAP_ID,PHASE_ID,
MAPPER_ID,PRICE_TYPE,PRICE_P25,PRICE_P50,PRICE_P75,SPECIFICITY)
select ipoc_seq.nextval,a.COUNTRY_ID,0,0,b.id,'GLOBAL',a.PCT25,a.PCT50,a.PCT75,a.SPECIFICITY
from $1.add_study a,$4.mapper b where a.odc_def_id=b.odc_def_id
and not exists 
(select 1 from $4.industry_pap_odc_cost c, $4.mapper d where c.COUNTRY_ID=a.country_id
and c.mapper_id=d.id and d.odc_def_id=a.odc_def_id and c.specificity=a.specificity and
c.price_type='GLOBAL' and c.indmap_id=0 and c.phase_id=0);
commit;

declare
 nval  number(10);
begin
 select ipoc_seq.nextval into nval from dual;
 update $4.id_control set next_id= nval
   where table_name='industry_pap_odc_cost';
 commit;
end;
/

drop sequence ipoc_seq;

exit  

EOF
exit 0

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  18   DevTSM    1.17        2/27/2008 3:17:45 PM Debashish Mishra  
#  17   DevTSM    1.16        10/10/2007 11:29:23 AMDebashish Mishra bug fix for
#       pap_overhead
#  16   DevTSM    1.15        7/25/2007 2:54:40 PM Debashish Mishra Updated for
#       de_price update
#  15   DevTSM    1.14        7/17/2007 2:46:41 PM Debashish Mishra  add_study
#       data in industry_pap_odc_cost
#  14   DevTSM    1.13        7/12/2007 12:01:43 PMDebashish Mishra Updated for
#       ip_study_price update
#  13   DevTSM    1.12        7/9/2007 11:31:39 AM Debashish Mishra Added
#       ip_study_price
#  12   DevTSM    1.11        2/7/2007 11:26:40 AM Debashish Mishra updated the
#       scripts for specificity updates
#  11   DevTSM    1.10        1/17/2007 1:31:27 PM Debashish Mishra  
#  10   DevTSM    1.9         1/17/2007 10:24:39 AMDebashish Mishra Added columns
#       to pap_clinical_proc_cost copy
#  9    DevTSM    1.8         12/13/2006 2:23:05 PMDebashish Mishra Removed spool
#       file commands
#  8    DevTSM    1.7         12/11/2006 12:29:17 PMDebashish Mishra  
#  7    DevTSM    1.6         11/20/2006 2:14:43 PMDebashish Mishra fixed typos
#       for file name in usage
#  6    DevTSM    1.5         11/9/2006 5:53:25 PM Debashish Mishra  
#  5    DevTSM    1.4         11/8/2006 5:58:17 PM Debashish Mishra  
#  4    DevTSM    1.3         11/7/2006 2:50:14 PM Debashish Mishra  
#  3    DevTSM    1.2         9/21/2006 11:53:27 AMDebashish Mishra fixed bugs
#  2    DevTSM    1.1         9/21/2006 7:26:38 AM Debashish Mishra modified usage
#       comments
#  1    DevTSM    1.0         9/20/2006 11:03:17 PMDebashish Mishra 
# $
# 
#############################################################
#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsm10_client_sequences.ksh$ 
#
# $Revision: 10$        $Date: 1/27/2009 1:22:28 PM$
#
#
# Description:  create sequences for tsm client
#
#############################################################


INSTITUTION_OVERHEAD_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from INSTITUTION_OVERHEAD;
EOF`
PAP_CLINICAL_PROC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from PAP_CLINICAL_PROC_COST;
EOF`
PAP_INSTITUTION_PROC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from PAP_INSTITUTION_PROC_COST;
EOF`
PAP_OVERHEAD_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from PAP_OVERHEAD;
EOF`
IP_STUDY_PRICE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from IP_STUDY_PRICE;
EOF`
MAPPER_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MAPPER;
EOF`
MODELLED_COEFF_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_COEFF;
EOF`  
MD_ODC_OH_PCT_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MD_ODC_OH_PCT;
EOF`
MODELLED_INCLUSION_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_INCLUSION;
EOF`
MODELLED_UPFENCE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_UPFENCE;
EOF`
MODELLED_STANDARDIZE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_STANDARDIZE;
EOF`
MODELLED_CPP_FENCE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_CPP_FENCE;
EOF`
G50_PAP_CLINICAL_PROC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from G50_PAP_CLINICAL_PROC_COST;
EOF`
G50_PAP_OVERHEAD_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from G50_PAP_OVERHEAD;
EOF`
G50_IP_STUDY_PRICE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from G50_IP_STUDY_PRICE;
EOF`
COMPANY_PAP_ODC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from COMPANY_PAP_ODC_COST;
EOF`
INDUSTRY_PAP_ODC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from INDUSTRY_PAP_ODC_COST;
EOF`
G50_COMPANY_PAP_ODC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from G50_COMPANY_PAP_ODC_COST;
EOF`
PAP_INSTITUTION_ODC_COST_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from PAP_INSTITUTION_ODC_COST;
EOF`
DATA_BY_YEAR_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from DATA_BY_YEAR;
EOF`
GM_PROC_FREQ_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from gm_proc_freq;
EOF`
GM_TRIAL_FREQ_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from gm_trial_freq;
EOF`

sqlplus -s $DB_USER/$DB_PWD <<EOF

drop sequence INSTITUTION_OVERHEAD_seq;
drop sequence PAP_CLINICAL_PROC_COST_seq;
drop sequence PAP_INSTITUTION_PROC_COST_seq;
drop sequence PAP_OVERHEAD_seq;
drop sequence IP_STUDY_PRICE_seq;
drop sequence mapper_seq;
drop sequence g50_PAP_clinical_proc_cost_seq;
drop sequence g50_pap_overhead_seq;
drop sequence g50_ip_study_price_seq;
drop sequence COMPANY_PAP_ODC_COST_seq;
drop sequence INDUSTRY_PAP_ODC_COST_seq;
drop sequence g50_COMPANY_PAP_ODC_COST_seq;
drop sequence PAP_INSTITUTION_ODC_COST_seq;
drop sequence DATA_BY_YEAR_seq;
drop sequence gm_proc_freq_seq;
drop sequence gm_trial_freq_seq;

create sequence INSTITUTION_OVERHEAD_seq start with $INSTITUTION_OVERHEAD_MAXID ;
create sequence PAP_CLINICAL_PROC_COST_seq start with $PAP_CLINICAL_PROC_COST_MAXID ;
create sequence PAP_INSTITUTION_PROC_COST_seq start with $PAP_INSTITUTION_PROC_COST_MAXID ;
create sequence PAP_OVERHEAD_seq start with $PAP_OVERHEAD_MAXID ;
create sequence IP_STUDY_PRICE_seq start with $IP_STUDY_PRICE_MAXID ;
create sequence mapper_seq start with $MAPPER_MAXID;
Create sequence g50_PAP_clinical_proc_cost_seq start with $G50_PAP_CLINICAL_PROC_COST_MAXID;
Create sequence g50_pap_overhead_seq start with $G50_PAP_OVERHEAD_MAXID;
Create sequence g50_ip_study_price_seq start with $G50_IP_STUDY_PRICE_MAXID;
Create sequence COMPANY_PAP_ODC_COST_seq start with $COMPANY_PAP_ODC_COST_MAXID;
Create sequence INDUSTRY_PAP_ODC_COST_seq start with $INDUSTRY_PAP_ODC_COST_MAXID;
Create sequence g50_COMPANY_PAP_ODC_COST_seq start with $G50_COMPANY_PAP_ODC_COST_MAXID;
create sequence PAP_INSTITUTION_ODC_COST_seq start with $PAP_INSTITUTION_ODC_COST_MAXID ;
create sequence DATA_BY_YEAR_seq start with $DATA_BY_YEAR_MAXID ;
create sequence gm_proc_freq_seq start with $GM_PROC_FREQ_MAXID;
create sequence gm_trial_freq_seq start with $GM_TRIAL_FREQ_MAXID;
EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  10   DevTSM    1.9         1/27/2009 1:22:28 PM Mahesh Pasupuleti As per
#       Changes by Phil.
#  9    DevTSM    1.8         2/27/2008 3:17:45 PM Debashish Mishra  
#  8    DevTSM    1.7         12/11/2006 10:55:03 AMDebashish Mishra  
#  7    DevTSM    1.6         9/19/2006 12:08:09 AMDebashish Mishra  removed
#       references to obsolete tables
#  6    DevTSM    1.5         3/3/2005 6:33:29 AM  Debashish Mishra   
#  5    DevTSM    1.4         3/3/2005 6:32:20 AM  Debashish Mishra  
#  4    DevTSM    1.3         8/2/2004 1:31:59 PM  Debashish Mishra new table
#       data_by_year
#  3    DevTSM    1.2         3/3/2004 10:54:59 AM Debashish Mishra Added new
#       table pap_institution_odc_cost
#  2    DevTSM    1.1         7/2/2003 5:43:11 PM  Debashish Mishra  
#  1    DevTSM    1.0         6/13/2003 8:02:42 AM Debashish Mishra 
# $
# 
#############################################################

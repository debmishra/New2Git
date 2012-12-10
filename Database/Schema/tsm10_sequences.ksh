#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsm10_sequences.ksh$ 
#
# $Revision: 35$        $Date: 2/22/2008 11:56:05 AM$
#
#
# Description:  create sequences for tsm client
#
#############################################################

BUILD_TAG_TO_CLIENT_DIV_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from BUILD_TAG_TO_CLIENT_DIV;
EOF`  
INDMAP_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from INDMAP;
EOF`
MAPPER_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MAPPER;
EOF`
PRICE_LEVEL_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from PRICE_LEVEL;
EOF`             
TEMP_INST_TO_COMPANY_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from TEMP_INST_TO_COMPANY ;
EOF`
TEMP_ODC_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from TEMP_ODC ;
EOF`                
TEMP_OVERHEAD_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from TEMP_OVERHEAD ;
EOF`           
TEMP_PROCEDURE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from TEMP_PROCEDURE ;
EOF`          
TEMP_IP_STUDY_PRICE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from TEMP_IP_STUDY_PRICE;
EOF`  
ADD_STUDY_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ADD_STUDY;
EOF`
USER_PREF_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from USER_PREF;
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
MODELLED_STANDARDIZE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_STANDARDIZE;
EOF`
MODELLED_CPP_FENCE_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from MODELLED_UPFENCE;
EOF`    

sqlplus -s $DB_USER/$DB_PWD <<EOF

drop sequence BUILD_TAG_TO_CLIENT_DIV_seq;   
drop sequence INDMAP_seq;
drop sequence MAPPER_seq;
drop sequence PRICE_LEVEL_seq;               
drop sequence temp_procedure_seq;
drop sequence temp_odc_seq;
drop sequence temp_overhead_seq;
drop sequence temp_inst_to_company_seq;
drop sequence temp_ip_study_price_seq;
drop sequence add_study_seq;
drop sequence user_pref_seq;
drop sequence modelled_coeff_seq;
drop sequence md_odc_oh_pct_seq;
drop sequence modelled_inclusion_seq;
drop sequence modelled_cpp_fence_seq;
drop sequence modelled_standardize_seq;


create sequence BUILD_TAG_TO_CLIENT_DIV_seq start with $BUILD_TAG_TO_CLIENT_DIV_MAXID ;  
create sequence INDMAP_seq start with $INDMAP_MAXID ;
create sequence MAPPER_seq start with $MAPPER_MAXID ;
create sequence PRICE_LEVEL_seq start with $PRICE_LEVEL_MAXID ;             
create sequence temp_procedure_seq start with $TEMP_PROCEDURE_MAXID;
create sequence temp_odc_seq start with $TEMP_ODC_MAXID;
create sequence temp_overhead_seq start with $TEMP_OVERHEAD_MAXID;
create sequence temp_inst_to_company_seq start with $TEMP_INST_TO_COMPANY_MAXID;
create sequence temp_ip_study_price_seq start with $TEMP_IP_STUDY_PRICE_MAXID;
create sequence add_study_seq start with $ADD_STUDY_MAXID;
create sequence user_pref_seq start with $USER_PREF_MAXID;
create sequence modelled_coeff_seq start with $MODELLED_COEFF_MAXID;
create sequence md_odc_oh_pct_seq start with $MD_ODC_OH_PCT_MAXID;
create sequence modelled_inclusion_seq start with $MODELLED_INCLUSION_MAXID;
create sequence modelled_cpp_fence_seq start with $MODELLED_CPP_FENCE_MAXID;
create sequence modelled_standardize_seq start with $MODELLED_STANDARDIZE_MAXID;


EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  35   DevTSM    1.34        2/22/2008 11:56:05 AMDebashish Mishra  
#  34   DevTSM    1.33        9/19/2006 12:11:45 AMDebashish Mishra   
#  33   DevTSM    1.32        3/2/2005 10:51:16 PM Debashish Mishra  
#  32   DevTSM    1.31        8/29/2003 5:17:50 PM Debashish Mishra  
#  31   DevTSM    1.30        10/24/2002 3:40:35 PMDebashish Mishra  
#  30   DevTSM    1.29        9/26/2002 4:09:14 PM Debashish Mishra 3 new tables
#  29   DevTSM    1.28        9/6/2002 11:19:37 AM Debashish Mishra new table
#       md_odc_oh_pct
#  28   DevTSM    1.27        9/3/2002 2:30:06 PM  Debashish Mishra New table
#       modelled_coeff
#  27   DevTSM    1.26        7/17/2002 12:44:15 PMDebashish Mishra dropped table
#       user_preferences
#  26   DevTSM    1.25        7/12/2002 3:41:22 PM Debashish Mishra New table
#       user_pref
#  25   DevTSM    1.24        7/11/2002 4:31:22 PM Debashish Mishra Modified for
#       deleted tables after beta
#  24   DevTSM    1.23        5/10/2002 11:59:29 AMDebashish Mishra  
#  23   DevTSM    1.22        4/25/2002 2:31:09 PM Debashish Mishra  
#  22   DevTSM    1.21        4/24/2002 3:17:18 PM Debashish Mishra  
#  21   DevTSM    1.20        4/12/2002 2:54:10 PM Debashish Mishra  
#  20   DevTSM    1.19        4/9/2002 8:23:04 AM  Debashish Mishra  
#  19   DevTSM    1.18        4/3/2002 6:58:48 PM  Debashish Mishra  
#  18   DevTSM    1.17        3/22/2002 12:52:16 PMDebashish Mishra  
#  17   DevTSM    1.16        3/6/2002 7:02:52 PM  Debashish Mishra  
#  16   DevTSM    1.15        2/12/2002 12:20:47 PMDebashish Mishra  
#  15   DevTSM    1.14        2/5/2002 2:54:34 PM  Debashish Mishra  
#  14   DevTSM    1.13        1/23/2002 12:52:41 PMDebashish Mishra  
#  13   DevTSM    1.12        1/17/2002 5:31:07 PM Debashish Mishra  
#  12   DevTSM    1.11        1/4/2002 4:26:00 PM  Debashish Mishra  
#  11   DevTSM    1.10        12/21/2001 10:39:43 AMDebashish Mishra Modifications
#       for client_country_list and client_country_list_item
#  10   DevTSM    1.9         12/19/2001 3:43:34 PMDebashish Mishra  
#  9    DevTSM    1.8         12/13/2001 3:05:12 PMDebashish Mishra  
#  8    DevTSM    1.7         12/13/2001 10:48:21 AMDebashish Mishra  
#  7    DevTSM    1.6         12/10/2001 12:26:02 PMDebashish Mishra  
#  6    DevTSM    1.5         12/6/2001 5:46:31 PM Debashish Mishra  
#  5    DevTSM    1.4         12/4/2001 1:11:46 PM Debashish Mishra Added four
#       temp tables for ph1 build
#  4    DevTSM    1.3         12/4/2001 11:48:01 AMDebashish Mishra Modifications
#       for Nancy and Peter
#  3    DevTSM    1.2         11/21/2001 5:01:54 PMDebashish Mishra  
#  2    DevTSM    1.1         11/21/2001 2:12:21 PMDebashish Mishra  
#  1    DevTSM    1.0         11/21/2001 1:15:14 PMDebashish Mishra 
# $
# 
#############################################################

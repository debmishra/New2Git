#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c1.ksh$ 
#
# $Revision: 1$        $Date: 6/2/2010 10:32:41 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
if test $# -lt 2
then echo "Usage: compare_client_data.ksh <userid1>/passwd1>@<alias1> <userid2>/passwd2>@<alias2>"
exit
fi


username=`echo $2 | cut -d"/" -f1`
password=`echo $2 | cut -d"/" -f2 | cut -d"@" -f1`
db=`echo $2 | cut -d"@" -f2`

echo $username
echo $password
echo $db

chk=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from user_db_links where db_link = 'DBL.FASTTRACK.COM';
EOF`
if test $chk -eq 1
then
   sqlplus -s $1 << EOF
   set feedback off
   drop database link dbl;
EOF
fi
sqlplus -s $1 << EOF
set feedback off
create database link dbl connect to $username
identified by $password using '$db';
EOF

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from institution_overhead;
EOF`

echo "Var1 is $var1"
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from institution_overhead@dbl;
EOF` 

echo "Var2 is $var2"

if test $var1 -ne $var2
   then
     echo "INSTITUTION_OVERHEAD : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from institution_overhead a, institution_overhead@dbl b
  where  nvl(a.INSTITUTION_ID,0) = nvl(b.INSTITUTION_ID,0) and
  nvl(a.OFC_OVRHD_P25,0) = nvl(b.OFC_OVRHD_P25,0) and
  nvl(a.OFC_OVRHD_P50,0) = nvl(b.OFC_OVRHD_P50,0) and
  nvl(a.OFC_OVRHD_P75,0) = nvl(b.OFC_OVRHD_P75,0) and
  nvl(a.ADJ_OVRHD_P25,0) = nvl(b.ADJ_OVRHD_P25,0) and
  nvl(a.ADJ_OVRHD_P50,0) = nvl(b.ADJ_OVRHD_P50,0) and
  nvl(a.ADJ_OVRHD_P75,0) = nvl(b.ADJ_OVRHD_P75,0) and
  nvl(a.OVRHD_BASE_PCT,0) = nvl(b.OVRHD_BASE_PCT,0) and
  nvl(a.EXPERIENCE_COUNT,0) = nvl(b.EXPERIENCE_COUNT,0) and
  nvl(a.PCT_PAID_P50,0) = nvl(b.PCT_PAID_P50,0) and
  nvl(a.OVRHD_18MO_P50,0) = nvl(b.OVRHD_18MO_P50,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "INSTITUTION_OVERHEAD : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "INSTITUTION_OVERHEAD: #rows mismatch: $var4"
  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ip_study_price;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ip_study_price@dbl;
EOF`
 
if test $var1 -ne $var2
   then
     echo "IP_STUDY_PRICE : Total no. of rows do not match"
else

sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  set copycommit 5000
  set arraysize 5000

  create table IP_STUDY_PRICE_TEMP as select * from IP_STUDY_PRICE@dbl; 
EOF

  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ip_study_price a, ip_study_price_temp b
  where  a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID  = b.PHASE_ID and
  nvl(a.PCT25,0)  = nvl(b.PCT25,0) and
  nvl(a.PCT50,0)  = nvl(b.PCT50,0) and
  nvl(a.PCT75,0)   = nvl(b.PCT75,0)  and
  nvl(a.COMPANY_PCT50,0) = nvl(b.COMPANY_PCT50,0) and
  a.DE_PRICE = b.DE_PRICE and
  a.CPP_FLG  = b.CPP_FLG and
  nvl(a.CO_CPP_EXP_CNT,0) = nvl(b.CO_CPP_EXP_CNT,0) and
  nvl(a.OTHER_CPP_EXP_CNT,0) = nvl(b.OTHER_CPP_EXP_CNT,0);
EOF`

 
  if test $var1 -eq $var3
   then
    echo "IP_STUDY_PRICE : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "IP_STUDY_PRICE: #rows mismatch: $var4"
  fi
fi

sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  set copycommit 5000
  set arraysize 5000

  drop table IP_STUDY_PRICE_TEMP; 
EOF



sqlplus -s $1 << EOF
   set feedback off
   drop database link dbl;
EOF

echo " "



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         6/2/2010 10:32:41 AM Mahesh Pasupuleti 
# $
# 
#############################################################

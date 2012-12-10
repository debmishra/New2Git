#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: compare_gm20_client_data_new.ksh$ 
#
# $Revision: 1$        $Date: 4/15/2011 10:38:37 AM$
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
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from institution_overhead@dbl;
EOF` 
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
   echo "INSTITUTION_OVERHEAD: $username#rows mismatch: $var4"
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
   echo "IP_STUDY_PRICE: $username#rows mismatch: $var4"
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

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from mapper;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from mapper@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MAPPER : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from mapper a, mapper@dbl b
  where  nvl(a.ODC_DEF_ID,0) = nvl(b.ODC_DEF_ID,0) and
  nvl(a.PROCEDURE_DEF_ID,0) = nvl(b.PROCEDURE_DEF_ID,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MAPPER : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "MAPPER: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MD_ODC_OH_PCT;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MD_ODC_OH_PCT@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MD_ODC_OH_PCT : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MD_ODC_OH_PCT a, MD_ODC_OH_PCT@dbl b
  where  a.country_id=b.country_id and
  a.ta_id=b.ta_id and
  nvl(a.OH_PCT,0) = nvl(b.OH_PCT,0) and
  nvl(a.ODC_PCT,0) = nvl(b.ODC_PCT,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MD_ODC_OH_PCT : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "MD_ODC_OH_PCT: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_COEFF;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_COEFF@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MODELLED_COEFF : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_COEFF a, MODELLED_COEFF@dbl b
  where  a.country_id=b.country_id and
  a.COEFF_TYPE=b.COEFF_TYPE and
  nvl(a.COEFF_VALUE,0) = nvl(b.COEFF_VALUE,0) and
  nvl(a.CROSS_COEFF_TYPE,0) = nvl(b.CROSS_COEFF_TYPE,0)and
  nvl(a.CROSS_COEFF_VALUE,0) = nvl(b.CROSS_COEFF_VALUE,0) and
  nvl(a.COEFF,0) = nvl(b.COEFF,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MODELLED_COEFF : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "MODELLED_COEFF: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_INCLUSION;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_INCLUSION@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MODELLED_INCLUSION : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_INCLUSION a, MODELLED_INCLUSION@dbl b
  where a.COEFF_TYPE=b.COEFF_TYPE and
  nvl(a.COEFF_VALUE,0) = nvl(b.COEFF_VALUE,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MODELLED_INCLUSION : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "MODELLED_INCLUSION: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_STANDARDIZE;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_STANDARDIZE@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MODELLED_STANDARDIZE : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_STANDARDIZE a, MODELLED_STANDARDIZE@dbl b
  where nvl(a.COUNTRY_ID,0)=nvl(b.COUNTRY_ID,0) and
  a.TYPE = b.TYPE and
  a.PATIENT = b.PATIENT and
  a.DURATION = b.DURATION;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MODELLED_STANDARDIZE : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "MODELLED_STANDARDIZE: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_CPP_FENCE;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_CPP_FENCE@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MODELLED_UPFENCE : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_CPP_FENCE a, MODELLED_CPP_FENCE@dbl b
  where a.ID=b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.CPP_LOW = b.CPP_LOW and
  a.CPP_HIGH = b.CPP_HIGH;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MODELLED_CPP_FENCE : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "MODELLED_CPP_FENCE: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_CLINICAL_PROC_COST where de_price <>1;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_CLINICAL_PROC_COST@dbl where de_price <> 1;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_CLINICAL_PROC_COST(without DE PRICE) : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_CLINICAL_PROC_COST a, PAP_CLINICAL_PROC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0) and
  nvl(a.COMPANY_PCT50,0) = nvl(b.COMPANY_PCT50,0) and
  a.DE_PRICE = b.DE_PRICE and
  nvl(a.CO_EXP_CNT,0) = nvl(b.CO_EXP_CNT,0) and
  nvl(a.OTHER_EXP_CNT,0) = nvl(b.OTHER_EXP_CNT,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) and
  nvl(a.IND_YEAR,0) = nvl(b.IND_YEAR,0) and       
  nvl(a.IND_UNUSED_CNT,0) = nvl(b.IND_UNUSED_CNT,0) and 
  nvl(a.CO_YEAR,0) = nvl(b.CO_YEAR,0) and        
  nvl(a.CO_UNUSED_CNT,0) = nvl(b.CO_UNUSED_CNT,0) and  
  nvl(a.LEVEL2_SKIP_FLG,0) = nvl(b.LEVEL2_SKIP_FLG,0) and
  nvl(a.IND_ENTRY_YEAR,0) = nvl(b.IND_ENTRY_YEAR,0) and
  nvl(a.NUM_COMPANIES,0) = nvl(b.NUM_COMPANIES,0) and
  nvl(a.COMPANY_PCT25,0) = nvl(b.COMPANY_PCT25,0) and
  nvl(a.COMPANY_PCT75,0) = nvl(b.COMPANY_PCT75,0) and
  a.de_price <>1;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_CLINICAL_PROC_COST(without DE PRICE) : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "PAP_CLINICAL_PROC_COST(without DE PRICE): $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_CLINICAL_PROC_COST where de_price=1;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_CLINICAL_PROC_COST@dbl where de_price=1;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_CLINICAL_PROC_COST(with DE PRICE) : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_CLINICAL_PROC_COST a, PAP_CLINICAL_PROC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0) and
  nvl(a.COMPANY_PCT50,0) = nvl(b.COMPANY_PCT50,0) and
  a.DE_PRICE = b.DE_PRICE and
  nvl(a.CO_EXP_CNT,0) = nvl(b.CO_EXP_CNT,0) and
  nvl(a.OTHER_EXP_CNT,0) = nvl(b.OTHER_EXP_CNT,0) and
--  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) and
  nvl(a.IND_YEAR,0) = nvl(b.IND_YEAR,0) and       
  nvl(a.IND_UNUSED_CNT,0) = nvl(b.IND_UNUSED_CNT,0) and 
  nvl(a.CO_YEAR,0) = nvl(b.CO_YEAR,0) and        
  nvl(a.CO_UNUSED_CNT,0) = nvl(b.CO_UNUSED_CNT,0) and  
  nvl(a.LEVEL2_SKIP_FLG,0) = nvl(b.LEVEL2_SKIP_FLG,0) and
  nvl(a.IND_ENTRY_YEAR,0) = nvl(b.IND_ENTRY_YEAR,0) and
  nvl(a.NUM_COMPANIES,0) = nvl(b.NUM_COMPANIES,0) and
  nvl(a.COMPANY_PCT25,0) = nvl(b.COMPANY_PCT25,0) and
  nvl(a.COMPANY_PCT75,0) = nvl(b.COMPANY_PCT75,0) and
  a.de_price=1;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_CLINICAL_PROC_COST(with DE PRICE) : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "PAP_CLINICAL_PROC_COST(with DE PRICE): $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_INSTITUTION_PROC_COST;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_INSTITUTION_PROC_COST@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_INSTITUTION_PROC_COST : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_INSTITUTION_PROC_COST a, PAP_INSTITUTION_PROC_COST@dbl b
  where nvl(a.INSTITUTION_ID,0) = nvl(b.INSTITUTION_ID,0) and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_INSTITUTION_PROC_COST : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "PAP_INSTITUTION_PROC_COST: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_OVERHEAD;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_OVERHEAD@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_OVERHEAD : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_OVERHEAD a, PAP_OVERHEAD@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.PHASE_ID = b.PHASE_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  nvl(a.COMPANY_OVRHD_P50,0) = nvl(b.COMPANY_OVRHD_P50,0) and
  nvl(a.COMPANY_ODC_P50,0) = nvl(b.COMPANY_ODC_P50,0) and
  nvl(a.OFC_OVRHD_P25,0) = nvl(b.OFC_OVRHD_P25,0) and
  nvl(a.OFC_OVRHD_P50,0) = nvl(b.OFC_OVRHD_P50,0) and
  nvl(a.OFC_OVRHD_P75,0) = nvl(b.OFC_OVRHD_P75,0) and
  nvl(a.ADJ_OVRHD_P25,0) = nvl(b.ADJ_OVRHD_P25,0) and
  nvl(a.ADJ_OVRHD_P50,0) = nvl(b.ADJ_OVRHD_P50,0) and
  nvl(a.ADJ_OVRHD_P75,0) = nvl(b.ADJ_OVRHD_P75,0) and
  a.AFFILIATION = b.AFFILIATION and
  nvl(a.ODC_P50,0) = nvl(b.ODC_P50,0) and
  nvl(a.COMPANY_PCT_PAID_P50,0) = nvl(b.COMPANY_PCT_PAID_P50,0) and
  nvl(a.PCT_PAID_P50,0) = nvl(b.PCT_PAID_P50,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_OVERHEAD : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "PAP_OVERHEAD: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST where de_price <>1;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST@dbl where de_price <> 1;
EOF` 
if test $var1 -ne $var2
   then
     echo "G50_PAP_CLINICAL_PROC_COST(without DE PRICE) : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST a, G50_PAP_CLINICAL_PROC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0) and
  nvl(a.COMPANY_PCT50,0) = nvl(b.COMPANY_PCT50,0) and
  a.DE_PRICE = b.DE_PRICE and
  nvl(a.CO_EXP_CNT,0) = nvl(b.CO_EXP_CNT,0) and
  nvl(a.OTHER_EXP_CNT,0) = nvl(b.OTHER_EXP_CNT,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) and
  nvl(a.IND_YEAR,0) = nvl(b.IND_YEAR,0) and       
  nvl(a.IND_UNUSED_CNT,0) = nvl(b.IND_UNUSED_CNT,0) and 
  nvl(a.CO_YEAR,0) = nvl(b.CO_YEAR,0) and        
  nvl(a.CO_UNUSED_CNT,0) = nvl(b.CO_UNUSED_CNT,0) and  
  nvl(a.LEVEL2_SKIP_FLG,0) = nvl(b.LEVEL2_SKIP_FLG,0) and
  nvl(a.IND_ENTRY_YEAR,0) = nvl(b.IND_ENTRY_YEAR,0) and
  nvl(a.NUM_COMPANIES,0) = nvl(b.NUM_COMPANIES,0) and
  nvl(a.COMPANY_PCT25,0) = nvl(b.COMPANY_PCT25,0) and
  nvl(a.COMPANY_PCT75,0) = nvl(b.COMPANY_PCT75,0) and
  a.de_price <>1;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_PAP_CLINICAL_PROC_COST(without DE PRICE) : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "G50_PAP_CLINICAL_PROC_COST(without DE PRICE): $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST where de_price=1;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST@dbl where de_price=1;
EOF` 
if test $var1 -ne $var2
   then
     echo "G50_PAP_CLINICAL_PROC_COST(with DE PRICE) : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST a, G50_PAP_CLINICAL_PROC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0) and
  nvl(a.COMPANY_PCT50,0) = nvl(b.COMPANY_PCT50,0) and
  a.DE_PRICE = b.DE_PRICE and
  nvl(a.CO_EXP_CNT,0) = nvl(b.CO_EXP_CNT,0) and
  nvl(a.OTHER_EXP_CNT,0) = nvl(b.OTHER_EXP_CNT,0) and
--  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) and
  nvl(a.IND_YEAR,0) = nvl(b.IND_YEAR,0) and       
  nvl(a.IND_UNUSED_CNT,0) = nvl(b.IND_UNUSED_CNT,0) and 
  nvl(a.CO_YEAR,0) = nvl(b.CO_YEAR,0) and        
  nvl(a.CO_UNUSED_CNT,0) = nvl(b.CO_UNUSED_CNT,0) and  
  nvl(a.LEVEL2_SKIP_FLG,0) = nvl(b.LEVEL2_SKIP_FLG,0) and
  nvl(a.IND_ENTRY_YEAR,0) = nvl(b.IND_ENTRY_YEAR,0) and
  nvl(a.NUM_COMPANIES,0) = nvl(b.NUM_COMPANIES,0) and
  nvl(a.COMPANY_PCT25,0) = nvl(b.COMPANY_PCT25,0) and
  nvl(a.COMPANY_PCT75,0) = nvl(b.COMPANY_PCT75,0) and
  a.de_price=1;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_PAP_CLINICAL_PROC_COST(with DE PRICE) : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "G50_PAP_CLINICAL_PROC_COST(with DE PRICE): $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_OVERHEAD;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_OVERHEAD@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "G50_PAP_OVERHEAD : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_OVERHEAD a, G50_PAP_OVERHEAD@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.PHASE_ID = b.PHASE_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  nvl(a.COMPANY_OVRHD_P50,0) = nvl(b.COMPANY_OVRHD_P50,0) and
  nvl(a.COMPANY_ODC_P50,0) = nvl(b.COMPANY_ODC_P50,0) and
  nvl(a.OFC_OVRHD_P25,0) = nvl(b.OFC_OVRHD_P25,0) and
  nvl(a.OFC_OVRHD_P50,0) = nvl(b.OFC_OVRHD_P50,0) and
  nvl(a.OFC_OVRHD_P75,0) = nvl(b.OFC_OVRHD_P75,0) and
  nvl(a.ADJ_OVRHD_P25,0) = nvl(b.ADJ_OVRHD_P25,0) and
  nvl(a.ADJ_OVRHD_P50,0) = nvl(b.ADJ_OVRHD_P50,0) and
  nvl(a.ADJ_OVRHD_P75,0) = nvl(b.ADJ_OVRHD_P75,0) and
  a.AFFILIATION = b.AFFILIATION and
  nvl(a.ODC_P50,0) = nvl(b.ODC_P50,0) and
  nvl(a.COMPANY_PCT_PAID_P50,0) = nvl(b.COMPANY_PCT_PAID_P50,0) and
  nvl(a.PCT_PAID_P50,0) = nvl(b.PCT_PAID_P50,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_PAP_OVERHEAD : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "G50_PAP_OVERHEAD: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_COMPANY_PAP_ODC_COST;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_COMPANY_PAP_ODC_COST@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "G50_COMPANY_PAP_ODC_COST : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_COMPANY_PAP_ODC_COST a, G50_COMPANY_PAP_ODC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  a.PRICE_TYPE = b.PRICE_TYPE and
  nvl(a.PRICE_P50,0) = nvl(b.PRICE_P50,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) 	and
  nvl(a.YEAR,0) = nvl(b.YEAR,0) 		and
  nvl(a.USED_CNT,0) = nvl(b.USED_CNT,0) 	and
  nvl(a.UNUSED_CNT,0) = nvl(b.UNUSED_CNT,0) 	and
  nvl(a.PRICE_P25,0) = nvl(b.PRICE_P25,0) 	and
  nvl(a.PRICE_P75,0) = nvl(b.PRICE_P75,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_COMPANY_PAP_ODC_COST : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "G50_COMPANY_PAP_ODC_COST: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_IP_STUDY_PRICE;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_IP_STUDY_PRICE@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "G50_IP_STUDY_PRICE : Total no. of rows do not match"
else

sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  set copycommit 5000
  set arraysize 5000

  create table G50_IP_STUDY_PRICE_TEMP as select * from G50_IP_STUDY_PRICE@dbl; 
EOF

  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_IP_STUDY_PRICE a, G50_IP_STUDY_PRICE_TEMP b
  where a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0) and
  nvl(a.COMPANY_PCT50,0) = nvl(b.COMPANY_PCT50,0) and
  a.DE_PRICE = b.DE_PRICE and
  a.CPP_FLG = b.CPP_FLG and
  nvl(a.CO_CPP_EXP_CNT,0) = nvl(b.CO_CPP_EXP_CNT,0) and
  nvl(a.OTHER_CPP_EXP_CNT,0) = nvl(b.OTHER_CPP_EXP_CNT,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_IP_STUDY_PRICE : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "G50_IP_STUDY_PRICE: $username#rows mismatch: $var4"
  fi
fi

sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  set copycommit 5000
  set arraysize 5000

  drop table G50_IP_STUDY_PRICE_TEMP; 
EOF

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from COMPANY_PAP_ODC_COST;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from COMPANY_PAP_ODC_COST@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "COMPANY_PAP_ODC_COST : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from COMPANY_PAP_ODC_COST a, COMPANY_PAP_ODC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  a.PRICE_TYPE = b.PRICE_TYPE and
  nvl(a.PRICE_P50,0) = nvl(b.PRICE_P50,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) 	and
  nvl(a.YEAR,0) = nvl(b.YEAR,0) 		and
  nvl(a.USED_CNT,0) = nvl(b.USED_CNT,0) 	and
  nvl(a.UNUSED_CNT,0) = nvl(b.UNUSED_CNT,0) 	and
  nvl(a.PRICE_P25,0) = nvl(b.PRICE_P25,0) 	and
  nvl(a.PRICE_P75,0) = nvl(b.PRICE_P75,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "COMPANY_PAP_ODC_COST : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "COMPANY_PAP_ODC_COST: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INDUSTRY_PAP_ODC_COST;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INDUSTRY_PAP_ODC_COST@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "INDUSTRY_PAP_ODC_COST : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INDUSTRY_PAP_ODC_COST a, INDUSTRY_PAP_ODC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  a.PRICE_TYPE = b.PRICE_TYPE and
  nvl(a.PRICE_P25,0) = nvl(b.PRICE_P25,0) and
  nvl(a.PRICE_P50,0) = nvl(b.PRICE_P50,0) and
  nvl(a.PRICE_P75,0) = nvl(b.PRICE_P75,0) and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0) 	and
  nvl(a.YEAR,0) = nvl(b.YEAR,0) 		and
  nvl(a.USED_CNT,0) = nvl(b.USED_CNT,0) 	and
  nvl(a.UNUSED_CNT,0) = nvl(b.UNUSED_CNT,0) 	and
  nvl(a.NUM_COMPANIES,0) = nvl(b.NUM_COMPANIES,0) and
  nvl(a.ENTRY_YEAR,0) = nvl(b.ENTRY_YEAR,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "INDUSTRY_PAP_ODC_COST : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "INDUSTRY_PAP_ODC_COST: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_INVESTIG;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_INVESTIG@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "OWN_INVESTIG : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_INVESTIG a, OWN_INVESTIG@dbl b
  where nvl(a.PROTOCOL_CODE,0) = nvl(b.PROTOCOL_CODE,0) and
  nvl(a.INVESTIG_CODE,0) = nvl(b.INVESTIG_CODE,0) and
  nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  nvl(a.COUNTRY_CODE,0) = nvl(b.COUNTRY_CODE,0) and
  nvl(a.COUNTRY_NAME,0) = nvl(b.COUNTRY_NAME,0) and
  nvl(a.CURRENCY_ID,0) = nvl(b.CURRENCY_ID,0) and
  nvl(a.PLAN_CURR_ID,0) = nvl(b.PLAN_CURR_ID,0) and
  nvl(a.INSTITUTION_ID,0) = nvl(b.INSTITUTION_ID,0) and
  nvl(a.PHASE,0) = nvl(b.PHASE,0) and
  nvl(a.PHASE_ID,0) = nvl(b.PHASE_ID,0) and
  nvl(a.INDMAP_ID,0) = nvl(b.INDMAP_ID,0) and
  nvl(a.IND_DESC,0) = nvl(b.IND_DESC,0) and
  nvl(a.TA_DESC,0) = nvl(b.TA_DESC,0) and
  nvl(a.TA_INDMAP_ID,0) = nvl(b.TA_INDMAP_ID,0) and
  nvl(a.DRUG,0) = nvl(b.DRUG,0) and
  nvl(a.CPP,0) = nvl(b.CPP,0) and
  nvl(a.CPP_PLAN,0) = nvl(b.CPP_PLAN,0) and
  nvl(a.CPV,0) = nvl(b.CPV,0) and
  nvl(a.CPV_PLAN,0) = nvl(b.CPV_PLAN,0) and
  nvl(a.CPPUS,0) = nvl(b.CPPUS,0) and
  nvl(a.CPVUS,0) = nvl(b.CPVUS,0) and
  nvl(a.GRANT_DATE,trunc(sysdate)+3650) = nvl(b.GRANT_DATE,trunc(sysdate)+3650) and
  nvl(a.PCT_PAID,0) = nvl(b.PCT_PAID,0) and
  nvl(a.BUILD_CODE_ID,0) = nvl(b.BUILD_CODE_ID,0) and
  nvl(a.ADJ_OVRHD_PCT,0) = nvl(b.ADJ_OVRHD_PCT,0) and
  nvl(a.INST_NAME,0) = nvl(b.INST_NAME,0) and
  nvl(a.INST_COUNTRY_ID,0) = nvl(b.INST_COUNTRY_ID,0) and
  nvl(a.INST_COUNTRY_NAME,0) = nvl(b.INST_COUNTRY_NAME,0) and
  nvl(a.INST_ZIP_CODE,0) = nvl(b.INST_ZIP_CODE,0) and
  nvl(a.GRANT_TOTAL,0) = nvl(b.GRANT_TOTAL,0) and
  nvl(a.STATE,0) = nvl(b.STATE,0) and
  nvl(a.CITY,0) = nvl(b.CITY,0) and
  nvl(a.AFFILIATION,0) = nvl(b.AFFILIATION,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "OWN_INVESTIG : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "OWN_INVESTIG: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_PROTOCOL;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_PROTOCOL@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "OWN_PROTOCOL : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_PROTOCOL a, OWN_PROTOCOL@dbl b
  where nvl(a.PROTOCOL_CODE,0) = nvl(b.PROTOCOL_CODE,0) and
  nvl(a.PHASE_ID,0) = nvl(b.PHASE_ID,0) and
  nvl(a.PHASE,0) = nvl(b.PHASE,0) and
  nvl(a.IND_DESC,0) = nvl(b.IND_DESC,0) and
  nvl(a.INDMAP_ID,0) = nvl(b.INDMAP_ID,0) and
  nvl(a.TA_INDMAP_ID,0) = nvl(b.TA_INDMAP_ID,0) and
  nvl(a.TA_DESC,0) = nvl(b.TA_DESC,0) and
  nvl(a.DRUG,0) = nvl(b.DRUG,0) and
  nvl(a.OVERHEAD_PCT,0) = nvl(b.OVERHEAD_PCT,0) and
  nvl(a.PCT_PAID,0) = nvl(b.PCT_PAID,0) and
  nvl(a.NUM_INV,0) = nvl(b.NUM_INV,0) and
  nvl(a.CPPUS,0) = nvl(b.CPPUS,0) and
  nvl(a.CPVUS,0) = nvl(b.CPVUS,0) and
  nvl(a.CPP_PLAN,0) = nvl(b.CPP_PLAN,0) and
  nvl(a.CPV_PLAN,0) = nvl(b.CPV_PLAN,0) and
  nvl(a.PLAN_CURR_ID,0) = nvl(b.PLAN_CURR_ID,0) and
  nvl(a.BUILD_CODE_ID,0) = nvl(b.BUILD_CODE_ID,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "OWN_PROTOCOL : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "OWN_PROTOCOL: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_ODC;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_ODC@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "OWN_ODC : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_ODC a, OWN_ODC@dbl b
  where nvl(a.CURRENCY_ID,0) = nvl(b.CURRENCY_ID,0) and
  nvl(a.PLAN_CURR_ID,0) = nvl(b.PLAN_CURR_ID,0) and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.CPP,0) = nvl(b.CPP,0) and
  nvl(a.CPPUS,0) = nvl(b.CPPUS,0) and
  nvl(a.CPP_PLAN,0) = nvl(b.CPP_PLAN,0) and
  nvl(a.PROTOCOL_CPP,0) = nvl(b.PROTOCOL_CPP,0) and
  nvl(a.PROTOCOL_CPP_US,0) = nvl(b.PROTOCOL_CPP_US,0) and
  nvl(a.CPV,0) = nvl(b.CPV,0) and
  nvl(a.CPVUS,0) = nvl(b.CPVUS,0) and
  nvl(a.CPV_PLAN,0) = nvl(b.CPV_PLAN,0) and
  nvl(a.PROTOCOL_CPV,0) = nvl(b.PROTOCOL_CPV,0) and
  nvl(a.PROTOCOL_CPV_US,0) = nvl(b.PROTOCOL_CPV_US,0) and
  nvl(a.BUILD_CODE_ID,0) = nvl(b.BUILD_CODE_ID,0) and
  nvl(a.PICAS_CODE,0) = nvl(b.PICAS_CODE,0) and
  nvl(a.LONG_DESC,0) = nvl(b.LONG_DESC,0) and
  nvl(a.INVESTIG_CODE,0) = nvl(b.INVESTIG_CODE,0) and
  nvl(a.PROTOCOL_CODE,0) = nvl(b.PROTOCOL_CODE,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "OWN_ODC : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "OWN_ODC: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_PROCEDURE;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_PROCEDURE@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "OWN_PROCEDURE : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_PROCEDURE a, OWN_PROCEDURE@dbl b
  where nvl(a.CURRENCY_ID,0) = nvl(b.CURRENCY_ID,0) and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.CPV,0) = nvl(b.CPV,0) and
  nvl(a.CPVUS,0) = nvl(b.CPVUS,0) and
  nvl(a.CPV_PLAN,0) = nvl(b.CPV_PLAN,0) and
  nvl(a.PROTOCOL_CPV,0) = nvl(b.PROTOCOL_CPV,0) and
  nvl(a.PROTOCOL_CPV_US,0) = nvl(b.PROTOCOL_CPV_US,0) and
  nvl(a.BUILD_CODE_ID,0) = nvl(b.BUILD_CODE_ID,0) and
  nvl(a.CPT_CODE,0) = nvl(b.CPT_CODE,0) and
  nvl(a.LONG_DESC,0) = nvl(b.LONG_DESC,0) and
  nvl(a.INVESTIG_CODE,0) = nvl(b.INVESTIG_CODE,0) and
  nvl(a.PROTOCOL_CODE,0) = nvl(b.PROTOCOL_CODE,0) and
  nvl(a.PLAN_CURR_ID,0) = nvl(b.PLAN_CURR_ID,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "OWN_PROCEDURE : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "OWN_PROCEDURE: $username#rows mismatch: $var4"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_SITE;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_SITE@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "OWN_SITE : Total no. of rows do not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from OWN_SITE a, OWN_SITE@dbl b
  where nvl(a.INSTITUTION_ID,0) = nvl(b.INSTITUTION_ID,0) and
  nvl(a.NAME,0) = nvl(b.NAME,0) and
  nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  nvl(a.COUNTRY_NAME,0) = nvl(b.COUNTRY_NAME,0) and
  nvl(a.COUNTRY_CODE,0) = nvl(b.COUNTRY_CODE,0) and
  nvl(a.ZIP_CODE,0) = nvl(b.ZIP_CODE,0) and
  nvl(a.OVERHEAD_PCT25,0) = nvl(b.OVERHEAD_PCT25,0) and
  nvl(a.OVERHEAD_PCT50,0) = nvl(b.OVERHEAD_PCT50,0) and
  nvl(a.OVERHEAD_PCT75,0) = nvl(b.OVERHEAD_PCT75,0) and
  nvl(a.PCT_PAID,0) = nvl(b.PCT_PAID,0) and
  nvl(a.NUM_INV,0) = nvl(b.NUM_INV,0) and
  nvl(a.CPPUS,0) = nvl(b.CPPUS,0) and
  nvl(a.CPVUS,0) = nvl(b.CPVUS,0) and
  nvl(a.CPP_PLAN,0) = nvl(b.CPP_PLAN,0) and
  nvl(a.CPV_PLAN,0) = nvl(b.CPV_PLAN,0) and
  nvl(a.PLAN_CURR_ID,0) = nvl(b.PLAN_CURR_ID,0) and
  nvl(a.LATEST_OVERHEAD,0) = nvl(b.LATEST_OVERHEAD,0) and
  nvl(a.LATEST_OVRHEAD_DATE,trunc(sysdate)+3650) = nvl(b.LATEST_OVRHEAD_DATE,trunc(sysdate)+3650) and
--  nvl(a.BUILD_CODE_ID,0) = nvl(b.BUILD_CODE_ID,0) and
  nvl(a.STATE,0) = nvl(b.STATE,0) and
  nvl(a.CITY,0) = nvl(b.CITY,0) and
  nvl(a.AFFILIATION,0) = nvl(b.AFFILIATION,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "OWN_SITE : 0 row mismatch"
  else
   var4=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select $var1-$var3 from dual;
EOF`
   echo "OWN_SITE: $username#rows mismatch: $var4"
  fi
fi

sqlplus -s $1 << EOF
   set feedback off
   drop database link dbl;
EOF

echo " "



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         4/15/2011 10:38:37 AMMahesh Pasupuleti 
# $
# 
#############################################################

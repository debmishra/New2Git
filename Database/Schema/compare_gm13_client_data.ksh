#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: compare_gm13_client_data.ksh$ 
#
# $Revision: 4$        $Date: 2/22/2008 11:55:22 AM$
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
     echo "INSTITUTION_OVERHEAD : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "INSTITUTION_OVERHEAD : $var4 rows mismatch"
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
     echo "IP_STUDY_PRICE : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ip_study_price a, ip_study_price@dbl b
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
   var4=`expr $var1 - $var3`
   echo "IP_STUDY_PRICE : $var4 rows mismatch"
  fi
fi

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
     echo "MAPPER : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "MAPPER : $var4 rows mismatch"
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
     echo "MD_ODC_OH_PCT : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "MD_ODC_OH_PCT : $var4 rows mismatch"
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
     echo "MODELLED_COEFF : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "MODELLED_COEFF : $var4 rows mismatch"
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
     echo "MODELLED_INCLUSION : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "MODELLED_INCLUSION : $var4 rows mismatch"
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
     echo "MODELLED_STANDARDIZE : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "MODELLED_STANDARDIZE : $var4 rows mismatch"
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
     echo "MODELLED_UPFENCE : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "MODELLED_CPP_FENCE : $var4 rows mismatch"
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
     echo "PAP_CLINICAL_PROC_COST(without DE PRICE) : Total no. of rows does not match"
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
  a.de_price <>1;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_CLINICAL_PROC_COST(without DE PRICE) : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAP_CLINICAL_PROC_COST(without DE PRICE) : $var4 rows mismatch"
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
     echo "PAP_CLINICAL_PROC_COST(with DE PRICE) : Total no. of rows does not match"
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
  a.de_price=1;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_CLINICAL_PROC_COST(with DE PRICE) : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAP_CLINICAL_PROC_COST(with DE PRICE) : $var4 rows mismatch"
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
     echo "PAP_INSTITUTION_PROC_COST : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "PAP_INSTITUTION_PROC_COST : $var4 rows mismatch"
  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_COST;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_COST@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_ODC_COST : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_COST a, PAP_ODC_COST@dbl b
  where nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.MAPPER_ID,0) = nvl(b.MAPPER_ID,0) and
  nvl(a.CPP_P25,0) = nvl(b.CPP_P25,0) and
  nvl(a.CPP_P50,0) = nvl(b.CPP_P50,0) and
  nvl(a.CPP_P75,0) = nvl(b.CPP_P75,0) and
  nvl(a.COMPANY_CPP_P50,0) = nvl(b.COMPANY_CPP_P50,0) and
  nvl(a.VISIT_P25,0) = nvl(b.VISIT_P25,0) and
  nvl(a.VISIT_P50,0) = nvl(b.VISIT_P50,0) and
  nvl(a.VISIT_P75,0) = nvl(b.VISIT_P75,0) and
  nvl(a.COMPANY_VISIT_P50,0) = nvl(b.COMPANY_VISIT_P50,0) and
  nvl(a.GLOBAL_P25,0) = nvl(b.GLOBAL_P25,0) and
  nvl(a.GLOBAL_P50,0) = nvl(b.GLOBAL_P50,0) and
  nvl(a.GLOBAL_P75,0) = nvl(b.GLOBAL_P75,0) and
  nvl(a.COMPANY_GLOBAL_P50,0) = nvl(b.COMPANY_GLOBAL_P50,0) and
  a.DE_PRICE = b.DE_PRICE and
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_ODC_COST : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAP_ODC_COST : $var4 rows mismatch"
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
     echo "PAP_OVERHEAD : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "PAP_OVERHEAD : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_PAP_CLINICAL_PROC_COST@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "G50_PAP_CLINICAL_PROC_COST : Total no. of rows does not match"
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
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_PAP_CLINICAL_PROC_COST : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "G50_PAP_CLINICAL_PROC_COST : $var4 rows mismatch"
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
     echo "G50_PAP_OVERHEAD : Total no. of rows does not match"
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
   var4=`expr $var1 - $var3`
   echo "G50_PAP_OVERHEAD : $var4 rows mismatch"
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
     echo "G50_COMPANY_PAP_ODC_COST : Total no. of rows does not match"
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
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "G50_COMPANY_PAP_ODC_COST : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "G50_COMPANY_PAP_ODC_COST : $var4 rows mismatch"
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
     echo "G50_IP_STUDY_PRICE : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from G50_IP_STUDY_PRICE a, G50_IP_STUDY_PRICE@dbl b
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
   var4=`expr $var1 - $var3`
   echo "G50_IP_STUDY_PRICE : $var4 rows mismatch"
  fi
fi

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
     echo "COMPANY_PAP_ODC_COST : Total no. of rows does not match"
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
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "COMPANY_PAP_ODC_COST : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "COMPANY_PAP_ODC_COST : $var4 rows mismatch"
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
     echo "INDUSTRY_PAP_ODC_COST : Total no. of rows does not match"
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
  nvl(a.SPECIFICITY,0) = nvl(b.SPECIFICITY,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "INDUSTRY_PAP_ODC_COST : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "INDUSTRY_PAP_ODC_COST : $var4 rows mismatch"
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
#  4    DevTSM    1.3         2/22/2008 11:55:22 AMDebashish Mishra  
#  3    DevTSM    1.2         9/19/2006 12:10:44 AMDebashish Mishra   
#  2    DevTSM    1.1         3/2/2005 10:48:45 PM Debashish Mishra  
#  1    DevTSM    1.0         2/28/2005 9:58:06 AM Debashish Mishra 
# $
# 
#############################################################

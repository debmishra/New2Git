#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: compare_master_data.ksh$ 
#
# $Revision: 18$        $Date: 10/14/2008 3:21:22 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if test $# -lt 2
then echo "Usage: compare_master_data.ksh <userid1>/passwd1>@<alias1> <userid2>/passwd2>@<alias2>"
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
  select count(*) from currency;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from currency@dbl;
EOF`


if test $var1 -ne $var2
   then
     echo "CURRENCY : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from currency a, currency@dbl b
  where a.ID = b.ID and
  nvl(a.NAME,0) = nvl(b.NAME,0) and
  nvl(a.SYMBOL,0) = nvl(b.SYMBOL,0) and
  nvl(a.CNV_RATE,0) = nvl(b.CNV_RATE,0) and
  a.viewable_flg=b.viewable_flg;
EOF`

  if test $var1 -eq $var3
   then
    echo "CURRENCY : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "CURRENCY : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from COUNTRY;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from COUNTRY@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "COUNTRY : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from COUNTRY a, COUNTRY@dbl b
  where a.ID = b.ID and
  nvl(a.NAME,0) = nvl(b.NAME,0) and
  nvl(a.ABBREVIATION,0) = nvl(b.ABBREVIATION,0) and
  a.COUNTRY_LEVEL = b.COUNTRY_LEVEL and
  nvl(a.CURRENCY_ID,0) = nvl(b.CURRENCY_ID,0) and
  nvl(a.COUNTRY_SEARCH_ID,0) = nvl(b.COUNTRY_SEARCH_ID,0) and
  a.VIRTUAL_FLG = b.VIRTUAL_FLG and
  a.IS_VIEWABLE = b.IS_VIEWABLE and
  nvl(a.FTE_HOURS_MONTH,0) = nvl(b.FTE_HOURS_MONTH,0) and
  nvl(a.ISO_COUNTRY,0) = nvl(b.ISO_COUNTRY,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "COUNTRY : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "COUNTRY : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from LOCAL_TO_EURO;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from LOCAL_TO_EURO@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "LOCAL_TO_EURO : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from LOCAL_TO_EURO a, LOCAL_TO_EURO@dbl b
  where a.ID = b.ID and
  nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  nvl(a.CNV_RATE_TO_EURO,0) = nvl(b.CNV_RATE_TO_EURO,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "LOCAL_TO_EURO : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "LOCAL_TO_EURO : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PHASE;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PHASE@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "PHASE : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PHASE a, PHASE@dbl b
  where a.ID = b.ID and
  nvl(a.SHORT_DESC,0) = nvl(b.SHORT_DESC,0) and
  nvl(a.SEQUENCE,0) = nvl(b.SEQUENCE,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "PHASE : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PHASE : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from BUILD_CODE;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from BUILD_CODE@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "BUILD_CODE : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from BUILD_CODE a, BUILD_CODE@dbl b
  where a.ID = b.ID and
  nvl(a.CODE,0) = nvl(b.CODE,0) and
  nvl(a.NAME,0) = nvl(b.NAME,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "BUILD_CODE : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "BUILD_CODE : $var4 rows mismatch"

  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INDMAP;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INDMAP@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "INDMAP : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INDMAP a, INDMAP@dbl b
  where a.ID = b.ID and
  nvl(a.PARENT_INDMAP_ID,0) = nvl(b.PARENT_INDMAP_ID,0) and
  nvl(a.CODE,0) = nvl(b.CODE,0) and
  nvl(a.SHORT_DESC,0) = nvl(b.SHORT_DESC,0) and
  nvl(a.TYPE,0) = nvl(b.TYPE,0) and
  nvl(a.EXECUTION_TYPE,0) = nvl(b.EXECUTION_TYPE,0) and
  nvl(a.EXECUTION_IND_ID,0) = nvl(b.EXECUTION_IND_ID,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "INDMAP : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "INDMAP : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from AFFILIATION_FACTOR;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from AFFILIATION_FACTOR@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "AFFILIATION_FACTOR : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from AFFILIATION_FACTOR a, AFFILIATION_FACTOR@dbl b
  where a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  nvl(a.INDMAP_ID,0) = nvl(b.INDMAP_ID,0) and
  nvl(a.TYPE,0) = nvl(b.TYPE,0) and
  nvl(a.AFFILIATED_FACTOR,0) = nvl(b.AFFILIATED_FACTOR,0) and
  nvl(a.UNAFFILIATED_FACTOR,0) = nvl(b.UNAFFILIATED_FACTOR,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "AFFILIATION_FACTOR : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "AFFILIATION_FACTOR : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_DURATION_FACTOR;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_DURATION_FACTOR@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "IP_DURATION_FACTOR : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_DURATION_FACTOR a, IP_DURATION_FACTOR@dbl b
  where a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  nvl(a.PHASE2_FACTOR,0) = nvl(b.PHASE2_FACTOR,0) and
  nvl(a.PHASE3_FACTOR,0) = nvl(b.PHASE3_FACTOR,0) and
  nvl(a.Y3PHASE2_FACTOR,0) = nvl(b.Y3PHASE2_FACTOR,0) and
  nvl(a.Y3PHASE3_FACTOR,0) = nvl(b.Y3PHASE3_FACTOR,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "IP_DURATION_FACTOR : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "IP_DURATION_FACTOR : $var4 rows mismatch"

  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_WEIGHT;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_WEIGHT@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "IP_WEIGHT : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_WEIGHT a, IP_WEIGHT@dbl b
  where a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.PHASE_ID = b.PHASE_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  nvl(a.AFFILIATION,0) = nvl(b.AFFILIATION,0) and
  nvl(a.COMPLEX_MINVALUE,0) = nvl(b.COMPLEX_MINVALUE,0) and
  a.FACTOR = b.FACTOR and
  a.MINVALUE = b.MINVALUE;
EOF`

  if test $var1 -eq $var3
   then
    echo "IP_WEIGHT : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "IP_WEIGHT : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_CPP;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_CPP@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "IP_CPP : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_CPP a, IP_CPP@dbl b
  where a.ID = b.ID and
  a.PHASE_ID = b.PHASE_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  nvl(a.LOW,0) = nvl(b.LOW,0) and
  nvl(a.MID,0) = nvl(b.MID,0) and
  nvl(a.HIGH,0) = nvl(b.HIGH,0) and
  nvl(a.SLOPE,0) = nvl(b.SLOPE,0) and
  nvl(a.INTERCEPT,0) = nvl(b.INTERCEPT,0) and
  nvl(a.CLOW,0) = nvl(b.CLOW,0) and
  nvl(a.CMID,0) = nvl(b.CMID,0) and
  nvl(a.CHIGH,0) = nvl(b.CHIGH,0) and
  nvl(a.CSLOPE,0) = nvl(b.CSLOPE,0) and
  nvl(a.CINTERCEPT,0) = nvl(b.CINTERCEPT,0) and
  nvl(a.OLOW,0) = nvl(b.OLOW,0) and
  nvl(a.OMID,0) = nvl(b.OMID,0) and
  nvl(a.OHIGH,0) = nvl(b.OHIGH,0) and
  nvl(a.OSLOPE,0) = nvl(b.OSLOPE,0) and
  nvl(a.OINTERCEPT,0) = nvl(b.OINTERCEPT,0) and
  nvl(a.CPV,0) = nvl(b.CPV,0) and
  nvl(a.PATIENT_STATUS,0) = nvl(b.PATIENT_STATUS,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "IP_CPP : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "IP_CPP : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_DURATION;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_DURATION@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "IP_DURATION : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_DURATION a, IP_DURATION@dbl b
  where a.ID = b.ID and
  nvl(a.PHASE_ID,0) = nvl(b.PHASE_ID,0) and
  a.INDMAP_ID = b.INDMAP_ID and
  nvl(a.LOW1YEAR,0) = nvl(b.LOW1YEAR,0) and
  nvl(a.MID1YEAR,0) = nvl(b.MID1YEAR,0) and
  nvl(a.HIGH1YEAR,0) = nvl(b.HIGH1YEAR,0) and
  nvl(a.LOW2YEAR,0) = nvl(b.LOW2YEAR,0) and
  nvl(a.MID2YEAR,0) = nvl(b.MID2YEAR,0) and
  nvl(a.HIGH2YEAR,0) = nvl(b.HIGH2YEAR,0) and
  nvl(a.LOW3YEAR,0) = nvl(b.LOW3YEAR,0) and
  nvl(a.MID3YEAR,0) = nvl(b.MID3YEAR,0) and
  nvl(a.HIGH3YEAR,0) = nvl(b.HIGH3YEAR,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "IP_DURATION : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "IP_DURATION : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_BUSINESS_FACTORS;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_BUSINESS_FACTORS@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "IP_BUSINESS_FACTORS : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from IP_BUSINESS_FACTORS a, IP_BUSINESS_FACTORS@dbl b
  where a.ID = b.ID and
  a.TYPE = b.TYPE and
  nvl(a.IBF_ORDER,0) = nvl(b.IBF_ORDER,0) and
  a.FACTOR = b.FACTOR and
  nvl(a.SHORT_DESC,0) = nvl(b.SHORT_DESC,0) and
  nvl(a.LOW,0) = nvl(b.LOW,0) and
  nvl(a.MED,0) = nvl(b.MED,0) and
  nvl(a.HIGH,0) = nvl(b.HIGH,0) and
  nvl(a.NUM_DAYS,0) = nvl(b.NUM_DAYS,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "IP_BUSINESS_FACTORS : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "IP_BUSINESS_FACTORS : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from REGION;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from REGION@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "REGION : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from REGION a, REGION@dbl b
  where a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  nvl(a.ABBREVIATION,0) = nvl(b.ABBREVIATION,0) and
  a.TYPE = b.TYPE and
  nvl(a.NAME,0) = nvl(b.NAME,0) and
  a.FACTOR = b.FACTOR;
EOF`

  if test $var1 -eq $var3
   then
    echo "REGION : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "REGION : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INSTITUTION;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INSTITUTION@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "INSTITUTION : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INSTITUTION a, INSTITUTION@dbl b
  where a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  nvl(a.REGION_ID,0) = nvl(b.REGION_ID,0) and
  nvl(a.NAME,0) = nvl(b.NAME,0) and
  nvl(a.ZIP_CODE,0) = nvl(b.ZIP_CODE,0) and
  nvl(a.ABBREVIATION,0) = nvl(b.ABBREVIATION,0) and
  nvl(a.INSTADDR1,0) = nvl(b.INSTADDR1,0) and
  nvl(a.INSTADDR2,0) = nvl(b.INSTADDR2,0) and
  nvl(a.INSTADDR3,0) = nvl(b.INSTADDR3,0) and
  nvl(a.AFFILIATION,0) = nvl(b.AFFILIATION,0) and
  nvl(a.CITY,0) = nvl(b.CITY,0) and
  nvl(a.COUNTY,0) = nvl(b.COUNTY,0) and
  nvl(a.COMMENTS,0) = nvl(b.COMMENTS,0) and
  nvl(a.FAX,0) = nvl(b.FAX,0) and
  nvl(a.PHONE,0) = nvl(b.PHONE,0) and
  nvl(a.POBOX,0) = nvl(b.POBOX,0) and
  nvl(a.PROV_TERR,0) = nvl(b.PROV_TERR,0) and
  a.QUERIABLE = b.QUERIABLE and
  a.UMBRELLA_FLG = b.UMBRELLA_FLG and
  nvl(a.TIMESUSED,0) = nvl(b.TIMESUSED,0) and
  nvl(a.BURDEN_PCT,0) = nvl(b.BURDEN_PCT,0);
EOF`

  if test $var1 -eq $var3
   then
    echo "INSTITUTION : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "INSTITUTION : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROCEDURE_DEF;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROCEDURE_DEF@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "PROCEDURE_DEF : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROCEDURE_DEF a, PROCEDURE_DEF@dbl b
  where a.ID = b.ID and
  a.CPT_CODE = b.CPT_CODE and
  nvl(a.LONG_DESC,0) = nvl(b.LONG_DESC,0) and
  a.OBSOLETE_FLG = b.OBSOLETE_FLG and
  a.PROCEDURE_LEVEL = b.PROCEDURE_LEVEL and
  /* nvl(a.OBSOLETE_BUILD_TAG_ID,0)=nvl(b.OBSOLETE_BUILD_TAG_ID,0) and
  nvl(a.ADDED_BUILD_TAG_ID,0)=nvl(b.ADDED_BUILD_TAG_ID,0)  and */
  a.HIDE=b.HIDE and
  a.FOXPRO_FLG=b.FOXPRO_FLG;
EOF`

  if test $var1 -eq $var3
   then
    echo "PROCEDURE_DEF : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PROCEDURE_DEF : $var4 rows mismatch"

  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ODC_DEF;
EOF`

var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ODC_DEF@dbl;
EOF`

if test $var1 -ne $var2
   then
     echo "ODC_DEF : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ODC_DEF a, ODC_DEF@dbl b
  where a.ID = b.ID and
  a.PICAS_CODE = b.PICAS_CODE and
  nvl(a.LONG_DESC,0) = nvl(b.LONG_DESC,0) and
  a.OBSOLETE_FLG = b.OBSOLETE_FLG and
  a.PROCEDURE_LEVEL = b.PROCEDURE_LEVEL and
  a.HIDE = b.HIDE and
  /* nvl(a.OBSOLETE_BUILD_TAG_ID,0)=nvl(b.OBSOLETE_BUILD_TAG_ID,0) and
  nvl(a.ADDED_BUILD_TAG_ID,0)=nvl(b.ADDED_BUILD_TAG_ID,0)  and */
  a.FOXPRO_FLG=b.FOXPRO_FLG;
EOF`

  if test $var1 -eq $var3
   then
    echo "ODC_DEF : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "ODC_DEF : $var4 rows mismatch"

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
  where  a.ID = b.ID and
  nvl(a.ODC_DEF_ID,0) = nvl(b.ODC_DEF_ID,0) and
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
  select count(*) from PAP_ODC_PCT;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_PCT@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_ODC_PCT : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_PCT a, PAP_ODC_PCT@dbl b
  where  a.ID = b.ID and
  nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  nvl(a.BASE_PCT,0) = nvl(b.BASE_PCT,0) and
  nvl(a.AFFILIATED_PCT,0) = nvl(b.AFFILIATED_PCT,0) and
  nvl(a.UNAFFILIATED_PCT,0) = nvl(b.UNAFFILIATED_PCT,0) and
  nvl(a.AFF_UNAFF_PCT,0) = nvl(b.AFF_UNAFF_PCT,0) and
  nvl(a.PHASE_ONE_PCT,0) = nvl(b.PHASE_ONE_PCT,0) and
  nvl(a.PHASE_TWOTHREE_PCT,0) = nvl(b.PHASE_TWOTHREE_PCT,0) and
  nvl(a.PHASE_FOUR_PCT,0) = nvl(b.PHASE_FOUR_PCT,0) and
  nvl(a.PHASE_ALL_PCT,0) = nvl(b.PHASE_ALL_PCT,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_ODC_PCT : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAP_ODC_PCT : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_PCT_TO_INDMAP;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_PCT_TO_INDMAP@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_ODC_PCT_TO_INDMAP : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_ODC_PCT_TO_INDMAP a, PAP_ODC_PCT_TO_INDMAP@dbl b
  where  a.ID = b.ID and
  nvl(a.PAP_ODC_PCT_ID,0) = nvl(b.PAP_ODC_PCT_ID,0) and
  nvl(a.INDMAP_ID,0) = nvl(b.INDMAP_ID,0) and
  nvl(a.INDMAP_PCT,0) = nvl(b.INDMAP_PCT,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_ODC_PCT_TO_INDMAP : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAP_ODC_PCT_TO_INDMAP : $var4 rows mismatch"
  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_EURO_OVERHEAD;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_EURO_OVERHEAD@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAP_EURO_OVERHEAD : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAP_EURO_OVERHEAD a, PAP_EURO_OVERHEAD@dbl b
  where  a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.ADJUSTED_FLG = b.ADJUSTED_FLG and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0) and
  nvl(a.REGION_ID,0) = nvl(b.REGION_ID,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAP_EURO_OVERHEAD : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAP_EURO_OVERHEAD : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ADD_STUDY;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ADD_STUDY@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "ADD_STUDY : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from ADD_STUDY a, ADD_STUDY@dbl b
  where  a.ID = b.ID and
  nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
  nvl(a.ODC_DEF_ID,0) = nvl(b.ODC_DEF_ID,0) and
  nvl(a.PAYMENT_COUNTRY_ID,0) = nvl(b.PAYMENT_COUNTRY_ID,0) and
  nvl(a.PCT25,0) = nvl(b.PCT25,0) and
  nvl(a.PCT50,0) = nvl(b.PCT50,0) and
  nvl(a.PCT75,0) = nvl(b.PCT75,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "ADD_STUDY : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "ADD_STUDY : $var4 rows mismatch"
  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROTOCOL;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROTOCOL@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PROTOCOL : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROTOCOL a, PROTOCOL@dbl b
  where  a.ID = b.ID and
  a.COUNTRY_ID = b.COUNTRY_ID and
  nvl(a.DE_INTERNAL_ID,0) = nvl(b.DE_INTERNAL_ID,0) and
  nvl(a.PICAS_PROTOCOL,0) = nvl(b.PICAS_PROTOCOL,0) and
  nvl(a.COMMENTS,0) = nvl(b.COMMENTS,0) and
  a.PHASE_ID = b.PHASE_ID and
  nvl(a.PHASE1TYPE_ID,0) = nvl(b.PHASE1TYPE_ID,0) and
  nvl(a.DOSING,0) = nvl(b.DOSING,0) and
  nvl(a.INPATIENT_STATUS,0) = nvl(b.INPATIENT_STATUS,0) and
  nvl(a.AGE_RANGE,0) = nvl(b.AGE_RANGE,0) and
  nvl(a.INPATIENT_DAYS,0) = nvl(b.INPATIENT_DAYS,0) and
  nvl(a.TOTAL_CONFINEMENT,0) = nvl(b.TOTAL_CONFINEMENT,0) and
  nvl(a.HOURS_CONFINED,0) = nvl(b.HOURS_CONFINED,0) and
  nvl(a.ADMIN_ROUTE,0) = nvl(b.ADMIN_ROUTE,0) and
  nvl(a.TOTAL_VISIT,0) = nvl(b.TOTAL_VISIT,0) and
  nvl(a.STUDY_TYPE,0) = nvl(b.STUDY_TYPE,0) and
  nvl(a.STUDY_BLIND_TYPE,0) = nvl(b.STUDY_BLIND_TYPE,0) and
  nvl(a.DURATION,0) = nvl(b.DURATION,0) and
  nvl(a.DURATION_UNIT,0) = nvl(b.DURATION_UNIT,0) and
  nvl(a.CENTRAL_LAB_USED,0) = nvl(b.CENTRAL_LAB_USED,0) and
  nvl(a.ENTRY_DATE,sysdate) = nvl(b.ENTRY_DATE,sysdate) and
  a.ACTIVE_FLAG = b.ACTIVE_FLAG and
  nvl(a.COMPLETED_PATIENTS,0) = nvl(b.COMPLETED_PATIENTS,0) and
  nvl(a.RANDOMIZED_FLAG,0) = nvl(b.RANDOMIZED_FLAG,0) and
  nvl(a.TREATMENT_CYCLE_CNT,0) = nvl(b.TREATMENT_CYCLE_CNT,0) and
  nvl(a.STUDY_STRUCT_TYPE,0) = nvl(b.STUDY_STRUCT_TYPE,0) and
  nvl(a.NUM_TREATMENTS,0) = nvl(b.NUM_TREATMENTS,0) and
  nvl(a.SCREEN_DAYS,0) = nvl(b.SCREEN_DAYS,0) and
  nvl(a.GROUP1_PRETREAT_DAYS,0) = nvl(b.GROUP1_PRETREAT_DAYS,0) and
  nvl(a.GROUP1_TREAT_DAYS,0) = nvl(b.GROUP1_TREAT_DAYS,0) and
  nvl(a.GROUP1_POST_TREAT_DAYS,0) = nvl(b.GROUP1_POST_TREAT_DAYS,0) and
  nvl(a.GROUP2_TREAT_DAYS,0) = nvl(b.GROUP2_TREAT_DAYS,0) and
  nvl(a.GROUP2_POST_TREAT_DAYS,0) = nvl(b.GROUP2_POST_TREAT_DAYS,0) and
  nvl(a.GROUP3_TREAT_DAYS,0) = nvl(b.GROUP3_TREAT_DAYS,0) and
  nvl(a.GROUP3_POST_TREAT_DAYS,0) = nvl(b.GROUP3_POST_TREAT_DAYS,0) and
  nvl(a.GROUP4_TREAT_DAYS,0) = nvl(b.GROUP4_TREAT_DAYS,0) and
  nvl(a.GROUP4_POST_TREAT_DAYS,0) = nvl(b.GROUP4_POST_TREAT_DAYS,0) and
  nvl(a.GROUP5_TREAT_DAYS,0) = nvl(b.GROUP5_TREAT_DAYS,0) and
  nvl(a.GROUP5_POST_TREAT_DAYS,0) = nvl(b.GROUP5_POST_TREAT_DAYS,0) and
  nvl(a.GROUP6_TREAT_DAYS,0) = nvl(b.GROUP6_TREAT_DAYS,0) and
  nvl(a.GROUP6_POST_TREAT_DAYS,0) = nvl(b.GROUP6_POST_TREAT_DAYS,0) and
  nvl(a.GROUP7_TREAT_DAYS,0) = nvl(b.GROUP7_TREAT_DAYS,0) and
  nvl(a.GROUP7_POST_TREAT_DAYS,0) = nvl(b.GROUP7_POST_TREAT_DAYS,0) and
  nvl(a.GROUP8_TREAT_DAYS,0) = nvl(b.GROUP8_TREAT_DAYS,0) and
  nvl(a.GROUP8_POST_TREAT_DAYS,0) = nvl(b.GROUP8_POST_TREAT_DAYS,0) and
  nvl(a.GROUP9_TREAT_DAYS,0) = nvl(b.GROUP9_TREAT_DAYS,0) and
  nvl(a.GROUP9_POST_TREAT_DAYS,0) = nvl(b.GROUP9_POST_TREAT_DAYS,0) and
  nvl(a.GROUPA_TREAT_DAYS,0) = nvl(b.GROUPA_TREAT_DAYS,0) and
  nvl(a.GROUPA_POST_TREAT_DAYS,0) = nvl(b.GROUPA_POST_TREAT_DAYS,0) and
  nvl(a.GROUP1_EXTENSION_EXISTS,0) = nvl(b.GROUP1_EXTENSION_EXISTS,0) and
  nvl(a.GROUP2_EXTENSION_EXISTS,0) = nvl(b.GROUP2_EXTENSION_EXISTS,0) and
  nvl(a.GROUP3_EXTENSION_EXISTS,0) = nvl(b.GROUP3_EXTENSION_EXISTS,0) and
  nvl(a.GROUP4_EXTENSION_EXISTS,0) = nvl(b.GROUP4_EXTENSION_EXISTS,0) and
  nvl(a.GROUP5_EXTENSION_EXISTS,0) = nvl(b.GROUP5_EXTENSION_EXISTS,0) and
  nvl(a.GROUP6_EXTENSION_EXISTS,0) = nvl(b.GROUP6_EXTENSION_EXISTS,0) and
  nvl(a.GROUP7_EXTENSION_EXISTS,0) = nvl(b.GROUP7_EXTENSION_EXISTS,0) and
  nvl(a.GROUP8_EXTENSION_EXISTS,0) = nvl(b.GROUP8_EXTENSION_EXISTS,0) and
  nvl(a.GROUP9_EXTENSION_EXISTS,0) = nvl(b.GROUP9_EXTENSION_EXISTS,0) and
  nvl(a.GROUPA_EXTENSION_EXISTS,0) = nvl(b.GROUPA_EXTENSION_EXISTS,0) and
  nvl(a.CENT_LAB_CONTRACT_EXISTS,0) = nvl(b.CENT_LAB_CONTRACT_EXISTS,0) and
  nvl(a.CRO_LAB_CONTRACT_EXISTS,0) = nvl(b.CRO_LAB_CONTRACT_EXISTS,0) and
  nvl(a.CENT_LAB_PRICE_MODEL,0) = nvl(b.CENT_LAB_PRICE_MODEL,0) and
  nvl(a.EXTENSION_EXISTS,0) = nvl(b.EXTENSION_EXISTS,0) and
  nvl(a.TREATMENT_CONTROL,0) = nvl(b.TREATMENT_CONTROL,0) and
  a.BUILD_CODE_ID = b.BUILD_CODE_ID and
  nvl(a.PROTOCOL_FAMILY_ID,0) = nvl(b.PROTOCOL_FAMILY_ID,0) and
  nvl(a.COLLECTION_COUNTRY_ID,0) = nvl(b.COLLECTION_COUNTRY_ID,0) and
  nvl(a.SAME_AS_PROT,0) = nvl(b.SAME_AS_PROT,0) and
  nvl(a.TITLE,0) = nvl(b.TITLE,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PROTOCOL : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PROTOCOL : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INVESTIG;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INVESTIG@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "INVESTIG : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from INVESTIG a, INVESTIG@dbl b
  where a.ID = b.ID and
  a.PROTOCOL_ID = b.PROTOCOL_ID and
  nvl(a.TOTAL_PAYMENT,0) = nvl(b.TOTAL_PAYMENT,0) and
  nvl(a.OTHER_FEE,0) = nvl(b.OTHER_FEE,0) and
  nvl(a.OVERHEAD,0) = nvl(b.OVERHEAD,0) and
  nvl(a.IRB_FEE,0) = nvl(b.IRB_FEE,0) and
  nvl(a.FIXED_FEE,0) = nvl(b.FIXED_FEE,0) and
  nvl(a.DROPPED_PAT_FEE,0) = nvl(b.DROPPED_PAT_FEE,0) and
  nvl(a.DROPPED_PATIENTS,0) = nvl(b.DROPPED_PATIENTS,0) and
  nvl(a.FAILURE_FEE,0) = nvl(b.FAILURE_FEE,0) and
  nvl(a.FAILED_PATIENTS,0) = nvl(b.FAILED_PATIENTS,0) and
  nvl(a.GRANT_ADJUSTMENT,0) = nvl(b.GRANT_ADJUSTMENT,0) and
  nvl(a.GRANT_ADJUST_CODE,0) = nvl(b.GRANT_ADJUST_CODE,0) and
  nvl(a.LAB_COST,0) = nvl(b.LAB_COST,0) and
  nvl(a.GRANT_TOTAL,0) = nvl(b.GRANT_TOTAL,0) and
  a.COUNTRY_ID = b.COUNTRY_ID and
  nvl(a.AFFILIATION,0) = nvl(b.AFFILIATION,0) and
  nvl(a.ZIP_CODE,0) = nvl(b.ZIP_CODE,0) and
  nvl(a.REGION_ID,0) = nvl(b.REGION_ID,0) and
  nvl(a.METRO_REGION_ID,0) = nvl(b.METRO_REGION_ID,0) and
  nvl(a.STATE_REGION_ID,0) = nvl(b.STATE_REGION_ID,0) and
  nvl(a.PATIENTS,0) = nvl(b.PATIENTS,0) and
  nvl(a.PCT_PAID,0) = nvl(b.PCT_PAID,0) and
  nvl(a.GRANT_DATE,sysdate) = nvl(b.GRANT_DATE,sysdate) and
  nvl(a.OVERHEAD_BASIS,0) = nvl(b.OVERHEAD_BASIS,0) and
  nvl(a.OVERHEAD_PCT,0) = nvl(b.OVERHEAD_PCT,0) and
  a.PRIMARY_FLAG = b.PRIMARY_FLAG and
  nvl(a.CRO_USED,0) = nvl(b.CRO_USED,0) and
--  nvl(a.ADJ_OVRHD_PCT,0) = nvl(b.ADJ_OVRHD_PCT,0) and
--  nvl(a.ADJ_OTHER_PCT,0) = nvl(b.ADJ_OTHER_PCT,0) and
  nvl(a.BURDEN_PCT,0) = nvl(b.BURDEN_PCT,0) and
  nvl(a.INSTITUTION_ID,0) = nvl(b.INSTITUTION_ID,0) and
  nvl(a.REGION,0) = nvl(b.REGION,0) and
  nvl(a.METRO,0) = nvl(b.METRO,0) and
  nvl(a.STATE,0) = nvl(b.STATE,0) and
  nvl(a.INVESTIGATOR_CODE,0) = nvl(b.INVESTIGATOR_CODE,0) and
  nvl(a.PAYMENT_COUNTRY_ID,0) = nvl(b.PAYMENT_COUNTRY_ID,0) and
  a.BUILD_CODE_ID = b.BUILD_CODE_ID and
--  nvl(a.NO_PAY,0) = nvl(b.NO_PAY,0) and
--  nvl(a.NO_PROC,0) = nvl(b.NO_PROC,0) and
  nvl(a.INCOMPLETE,0) = nvl(b.INCOMPLETE,0) and
  nvl(a.SAMPLED,0) = nvl(b.SAMPLED,0) and
  nvl(a.MANAGED,0) = nvl(b.MANAGED,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "INVESTIG : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "INVESTIG : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAYMENTS;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAYMENTS@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PAYMENTS : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PAYMENTS a, PAYMENTS@dbl b
  where a.ID = b.ID and
  a.PROCEDURE_CODE = b.PROCEDURE_CODE and
  nvl(a.PAYMENT,0) = nvl(b.PAYMENT,0) and
  a.TYPE = b.TYPE and
  nvl(a.ODC_DEF_ID,0) = nvl(b.ODC_DEF_ID,0) and
  nvl(a.PROCEDURE_DEF_ID,0) = nvl(b.PROCEDURE_DEF_ID,0) and
  a.PAYMENT_COUNTRY_ID = b.PAYMENT_COUNTRY_ID and
  a.INVESTIG_ID = b.INVESTIG_ID;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PAYMENTS : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PAYMENTS : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROTOCOL_TO_INDMAP;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROTOCOL_TO_INDMAP@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PROTOCOL_TO_INDMAP : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROTOCOL_TO_INDMAP a, PROTOCOL_TO_INDMAP@dbl b
  where a.ID = b.ID and
  a.PROTOCOL_ID = b.PROTOCOL_ID and
  a.INDMAP_ID = b.INDMAP_ID;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PROTOCOL_TO_INDMAP : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PROTOCOL_TO_INDMAP : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROCEDURE_TO_PROTOCOL;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROCEDURE_TO_PROTOCOL@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PROCEDURE_TO_PROTOCOL : Total no. of rows does not match"
else

sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  set copycommit 5000
  set arraysize 5000

  create table PROCEDURE_TO_PROTOCOL_TEMP as select * from PROCEDURE_TO_PROTOCOL@dbl; 
EOF

  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PROCEDURE_TO_PROTOCOL a, PROCEDURE_TO_PROTOCOL_TEMP  b
  where a.ID = b.ID and
  a.PROTOCOL_ID = b.PROTOCOL_ID and
  nvl(a.TIMES_PERFORMED,0) = nvl(b.TIMES_PERFORMED,0) and
  nvl(a.CENTRAL_LAB_USED,0) = nvl(b.CENTRAL_LAB_USED,0) and
  nvl(a.INVESTIGATOR_TIMES_PERF,0) = nvl(b.INVESTIGATOR_TIMES_PERF,0) and
  nvl(a.TYPE,0) = nvl(b.TYPE,0) and
  nvl(a.ODC_DEF_ID,0) = nvl(b.ODC_DEF_ID,0) and
  nvl(a.PROCEDURE_DEF_ID,0) = nvl(b.PROCEDURE_DEF_ID,0) and
  a.BUILD_CODE_ID = b.BUILD_CODE_ID;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PROCEDURE_TO_PROTOCOL : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PROCEDURE_TO_PROTOCOL : $var4 rows mismatch"
  fi
sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off

drop table PROCEDURE_TO_PROTOCOL_TEMP;
EOF

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
  where  a.ID = b.ID and
  a.country_id=b.country_id and
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
  where  a.ID = b.ID and
  a.country_id=b.country_id and
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
  where a.ID = b.ID and
  a.COEFF_TYPE=b.COEFF_TYPE and
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
  where a.ID = b.ID and
  nvl(a.COUNTRY_ID,0)=nvl(b.COUNTRY_ID,0) and
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
  select count(*) from MODELLED_UPFENCE;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_UPFENCE@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "MODELLED_STANDARDIZE : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from MODELLED_UPFENCE a, MODELLED_UPFENCE@dbl b
  where a.ID = b.ID and
  a.COUNTRY_ID=b.COUNTRY_ID and
  a.TA_ID = b.TA_ID and
  a.UPFENCE = b.UPFENCE;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "MODELLED_UPFENCE : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "MODELLED_UPFENCE : $var4 rows mismatch"
  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from DERIVED_PRICES;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from DERIVED_PRICES@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "DERIVED_PRICES : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from derived_prices a, derived_prices@dbl b
	where
	a.COUNTRY_ID=b.COUNTRY_ID AND
	nvl(a.LOW_PRICE,0)=nvl(b.LOW_PRICE,0) AND
	nvl(a.MED_PRICE,0)=nvl(b.MED_PRICE,0) AND
	nvl(a.HIGH_PRICE,0)=nvl(b.HIGH_PRICE,0) AND
	a.TYPE=b.TYPE AND
	nvl(a.PROCEDURE_DEF_ID,0)=nvl(b.PROCEDURE_DEF_ID,0) AND
	nvl(a.ODC_DEF_ID,0)=nvl(b.ODC_DEF_ID,0);
EOF`
 
  if test $var1 -eq $var3
   then
    echo "DERIVED_PRICES : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "DERIVED_PRICES : $var4 rows mismatch"
  fi
fi

var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from REFERENCE_PRICES;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from REFERENCE_PRICES@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "REFERENCE_PRICES : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from REFERENCE_PRICES a, REFERENCE_PRICES@dbl b
	where
        a.ID=b.ID and
	a.PROCEDURE_DEF_ID = b.PROCEDURE_DEF_ID and
	nvl(a.PAYMENT,0) = nvl(b.PAYMENT,0) and
	nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
	a.BUILD_CODE_ID = b.BUILD_CODE_ID and
	nvl(a.INVCODE,0) = nvl(b.INVCODE,0) and
	nvl(a.CODE,0) = nvl(b.CODE,0) and
	nvl(a.CURR,0) = nvl(b.CURR,0) and
	nvl(a.OTLR_PMT,0) = nvl(b.OTLR_PMT,0) and
	nvl(a.CHECKED,0) = nvl(b.CHECKED,0) and
	nvl(a.FIRSTCHK,0) = nvl(b.FIRSTCHK,0) and
	nvl(a.PL_CHECK,0) = nvl(b.PL_CHECK,0) and
	nvl(a.PTLEVEL,0) = nvl(b.PTLEVEL,0) and
	nvl(a.GRANTLVL,0) = nvl(b.GRANTLVL,0) and
	nvl(a.ODCEST,0) = nvl(b.ODCEST,0) ;
EOF`
 
  if test $var1 -eq $var3
   then
    echo "REFERENCE_PRICES : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "REFERENCE_PRICES : $var4 rows mismatch"
  fi
fi


var1=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PRICE_LEVEL;
EOF`
 
var2=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PRICE_LEVEL@dbl;
EOF` 
if test $var1 -ne $var2
   then
     echo "PRICE_LEVEL : Total no. of rows does not match"
else
  var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from PRICE_LEVEL a, PRICE_LEVEL@dbl b
	where
        a.ID=b.ID and
	nvl(a.COUNTRY_ID,0) = nvl(b.COUNTRY_ID,0) and
	nvl(a.TYPE,0) = nvl(b.TYPE,0) and
	nvl(a.LOW_PRICE,0) = nvl(b.LOW_PRICE,0) and
	nvl(a.MED_PRICE,0) = nvl(b.MED_PRICE,0) and
	nvl(a.HIGH_PRICE,0) = nvl(b.HIGH_PRICE,0) and
	nvl(a.ODC_DEF_ID,0) = nvl(b.ODC_DEF_ID,0) and
	nvl(a.PROCEDURE_DEF_ID,0) = nvl(b.PROCEDURE_DEF_ID,0) and
	nvl(a.PLIST,0) = nvl(b.PLIST,0);             
EOF`
 
  if test $var1 -eq $var3
   then
    echo "PRICE_LEVEL : 0 row mismatch"
  else
   var4=`expr $var1 - $var3`
   echo "PRICE_LEVEL : $var4 rows mismatch"
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
#  18   DevTSM    1.17        10/14/2008 3:21:22 PMDebashish Mishra  
#  17   DevTSM    1.16        10/14/2008 12:49:54 PMDebashish Mishra added ID
#       comparison to reference_prices to avoid duplicate counts
#  16   DevTSM    1.15        2/22/2008 11:55:23 AMDebashish Mishra  
#  15   DevTSM    1.14        11/8/2007 10:19:59 PMDebashish Mishra  
#  14   DevTSM    1.13        9/11/2007 5:12:01 PM Debashish Mishra  
#  13   DevTSM    1.12        5/8/2007 5:57:17 PM  Debashish Mishra  
#  12   DevTSM    1.11        3/17/2007 7:38:56 AM Debashish Mishra  
#  11   DevTSM    1.10        10/31/2006 11:27:45 AMDebashish Mishra  
#  10   DevTSM    1.9         9/19/2006 12:10:46 AMDebashish Mishra   
#  9    DevTSM    1.8         9/4/2006 2:53:39 PM  Debashish Mishra  
#  8    DevTSM    1.7         10/31/2005 2:20:14 PMDebashish Mishra  
#  7    DevTSM    1.6         10/26/2005 3:43:40 PMDebashish Mishra  
#  6    DevTSM    1.5         9/9/2005 3:06:39 PM  Debashish Mishra  
#  5    DevTSM    1.4         3/2/2005 10:48:46 PM Debashish Mishra  
#  4    DevTSM    1.3         7/16/2003 4:48:15 PM Debashish Mishra Modified for
#       GM1.1 
#  3    DevTSM    1.2         6/5/2003 9:39:29 AM  Debashish Mishra Bypassed few
#       columns in odc_def and procedure_def to do the comparison between GM1.0x
#       and GM1.1 schema
#  2    DevTSM    1.1         4/8/2003 9:42:22 AM  Debashish Mishra Fixed the
#       problem with spaces before EOF
#  1    DevTSM    1.0         10/23/2002 3:50:40 PMDebashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: compare_pbt_data.ksh$ 
#
# $Revision: 2$        $Date: 2/22/2008 11:55:23 AM$
#
#
# Description:  <ADD>
#
#############################################################



if test $# -ne 2
then
  echo "Usage : compare_pbt_data.ksh <userid1>/<password1>@<db1> <userid2>/<password2>@<db2>"
  exit
fi

username=`echo $2 | cut -d"/" -f1`
password=`echo $2 | cut -d"/" -f2 | cut -d"@" -f1`
dbname=`echo $2 | cut -d"@" -f2`

lnk=`sqlplus -s $1 << EOF
set pages 0
set heading off
set feedback off
select count(*) from user_db_links where db_link = 'MYLINK.FASTTRACK.COM';
EOF`


if test $lnk -eq 1
then
 sqlplus -s $1 << EOF
   set feedback off
   drop database link mylink;
EOF
fi

sqlplus -s $1 << EOF
 set feedback off
 create database link mylink connect to $username identified by $password using '$dbname';
EOF
 
var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_adjusted_salary;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_adjusted_salary@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_ADJUSTED_SALARY: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_adjusted_salary a, cro_adjusted_salary@mylink b, indmap c, indmap@mylink d
   where a.ID = b.id and a.COUNTRY_ID = b.country_id and              
   a.INDMAP_ID = c.id and b.indmap_id = d.id and c.code = d.code and c.type = d.type and nvl(a.PHASE_ID,99999999) = nvl(b.PHASE_ID,99999999)              
   and a.CRO_JOB_TYPE_ID = b.CRO_JOB_TYPE_ID and nvl(a.LOW_SALARY,99999999) = nvl(b.LOW_SALARY,99999999)           
   and nvl(a.MED_SALARY,99999999) = nvl(b.MED_SALARY,99999999) and nvl(a.HIGH_SALARY,99999999) = nvl(b.HIGH_SALARY,99999999);           
EOF`

 if test $var1 -eq $var3
 then
    echo "CRO_ADJUSTED_SALARY: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_ADJUSTED_SALARY: $var4 rows mismatch"
 fi
fi

           
####### comparison for cro_choice_factor table begins ############

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_choice_factor;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_choice_factor@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_CHOICE_FACTOR: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_choice_factor a, cro_choice_factor@mylink b
   where a.ID = b.id and a.CRO_TYPE = b.CRO_TYPE and a.factor = b.factor
   and a.cro_choice_id = b.cro_choice_id;     
EOF`
 if test $var1 -eq $var3
 then
    echo "CRO_CHOICE_FACTOR: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_CHOICE_FACTOR: $var4 rows mismatch"
 fi
fi


####### comparison for cro_category_factor table begins ############
            
var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_category_factor;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_category_factor@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_CATEGORY_FACTOR: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_category_factor a, cro_category_factor@mylink b
   where a.ID = b.id and a.COUNTRY_ID = b.country_id and a.cro_category_id = b.CRO_CATEGORY_ID
   and a.CRO_TYPE = b.cro_type and a.low_price = b.LOW_PRICE and a.med_price = b.MED_PRICE      
   and a.HIGH_PRICE = b.high_price and a.mean_price = b.MEAN_PRICE;     
EOF`
 if test $var1 -eq $var3
 then
    echo "CRO_CATEGORY_FACTOR: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_CATEGORY_FACTOR: $var4 rows mismatch"
 fi
fi
       


####### comparison for cro_choice table begins ############

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_choice;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_choice@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_CHOICE: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_choice a, cro_choice@mylink b
   where a.ID = b.id and a.CRO_COMPONENT_ID = b.CRO_COMPONENT_ID and       
   nvl(a.CHOICE_LABEL,99999999) = nvl(b.CHOICE_LABEL,99999999) and          
   nvl(a.SEQUENCE,99999999) = nvl(b.SEQUENCE,99999999) and                
   nvl(a.LOW_RANGE,99999999) = nvl(b.LOW_RANGE,99999999) and       
   nvl(a.HIGH_RANGE,99999999) = nvl(b.HIGH_RANGE,99999999) and            
   a.SHORT_DESC = b.short_desc ;     
EOF`
 if test $var1 -eq $var3
 then
    echo "CRO_CHOICE: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_CHOICE: $var4 rows mismatch"
 fi
fi

            
####### comparison for cro_component table begins ############

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_component;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_component@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_COMPONENT: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_component a, cro_component@mylink b
   where a.ID = b.id and a.CRO_CATEGORY_ID = b.CRO_CATEGORY_ID and        
   a.COMPONENT_TYPE = b.COMPONENT_TYPE and nvl(a.COMPONENT_LABEL,99999999) = nvl(b.COMPONENT_LABEL,99999999)       
   and a.COMPONENT_SEQ = b.COMPONENT_SEQ and nvl(a.LABEL_COL,99999999) = nvl(b.LABEL_COL,99999999) and
   nvl(a.VALUE_COL,99999999) =  nvl(b.VALUE_COL,99999999) and nvl(a.PARENT_COMPONENT_ID,99999999) = nvl(b.PARENT_COMPONENT_ID,99999999)
   and nvl(a.WEIGHT,99999999) = nvl(b.WEIGHT,99999999) and a.short_desc = b.SHORT_DESC             
   and nvl(a.SUB_CATEGORY_ID,99999999) = nvl(b.SUB_CATEGORY_ID,99999999) and nvl(a.DEFAULT_VAL,99999999) = nvl(b.DEFAULT_VAL,99999999);        
EOF`

 if test $var1 -eq $var3
 then
    echo "CRO_COMPONENT: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_COMPONENT: $var4 rows mismatch"
 fi
fi

                    
           
####### comparison for cro_country_factor table begins ############

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_country_factor;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_country_factor@mylink;
EOF`


if test $var1 -ne $var2
then
 echo "CRO_COUNTRY_FACTOR: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_country_factor a, cro_country_factor@mylink b
   where a.ID = b.id and a.COUNTRY_ID = b.COUNTRY_ID and      
   a.FACTOR = b.FACTOR;        
EOF`

 if test $var1 -eq $var3
 then
    echo "CRO_COUNTRY_FACTOR: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_COUNTRY_FACTOR: $var4 rows mismatch"
 fi
fi


####### comparison for cro_job_type table begins ############         

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_job_type;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_job_type@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_JOB_TYPE: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_job_type a, cro_job_type@mylink b
   where a.ID = b.id and a.SHORT_DESC = b.SHORT_DESC;        
EOF`

 if test $var1 -eq $var3
 then
    echo "CRO_JOB_TYPE: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_JOB_TYPE: $var4 rows mismatch"
 fi
fi


####### comparison for cro_phase_factor table begins ############ 
        

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_phase_factor;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_phase_factor@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_PHASE_FACTOR: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_phase_factor a, cro_phase_factor@mylink b
   where a.ID = b.id and a.PHASE_ID = b.phase_id and a.factor = b.FACTOR and                
   nvl(a.CRO_CATEGORY_ID,99999999) = nvl(a.CRO_CATEGORY_ID,99999999);        
EOF`

 if test $var1 -eq $var3
 then
    echo "CRO_PHASE_FACTOR: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_PHASE_FACTOR: $var4 rows mismatch"
 fi
fi

              
      
####### comparison for cro_ta_factor table begins ############

var1=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_ta_factor;
EOF`

var2=`sqlplus -s $1 << EOF
 set pages 0 
 set heading off
 set feedback off
 select count(*) from cro_ta_factor@mylink;
EOF`

if test $var1 -ne $var2
then
 echo "CRO_TA_FACTOR: Total no. of rows does not match"
else
 var3=`sqlplus -s $1 << EOF
  set pages 0
  set hea off
  set feedback off
  select count(*) from cro_ta_factor a, cro_ta_factor@mylink b, indmap c, indmap@mylink d
   where a.ID = b.id and a.INDMAP_ID = c.id and b.indmap_id = d.id and c.code = d.code and c.type = d.type and           
   a.TA_FACTOR = b.ta_factor and  nvl(a.CRO_CATEGORY_ID,99999999) = nvl(b.CRO_CATEGORY_ID,99999999);
EOF`

 if test $var1 -eq $var3
 then
    echo "CRO_TA_FACTOR: 0 rows mismatch"
 else
   var4=`expr $var1 - $var3`
   echo "CRO_TA_FACTOR: $var4 rows mismatch"
 fi
fi

sqlplus -s $1 << EOF
   set feedback off
   drop database link mylink;
EOF

echo " "
                    
 



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         2/22/2008 11:55:23 AMDebashish Mishra  
#  1    DevTSM    1.0         11/17/2006 5:35:51 PMDebashish Mishra 
# $
# 
#############################################################

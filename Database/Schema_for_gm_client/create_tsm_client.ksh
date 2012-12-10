#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: create_tsm_client.ksh$ 
#
# $Revision: 11$        $Date: 2/27/2008 3:17:43 PM$
#
#
# Description:  Create a tsmclient. Client name is the first argument 
# and master schema is the second argument
#
#############################################################

typeset -l adminuser
typeset -l masteruser
typeset -l clientuser
typeset -u ADMINUSER
typeset -u MASTERUSER
typeset -u CLIENTUSER
silentmode=0
typeset -l IndustryFlag

if [[ `echo $1 | cut -c 1` = "-" ]] then

 if [[ $1 = "-s" ]] then 
    silentmode=1

  if [[ $8 = '' ]] then

    echo
    echo "Usage :  create_tsm_client.ksh -s <client_schema> <client_password> <master_schema> <master_password> <oracle_admin_user> <oracle_admin_passwd> <database connect string>"
    echo
    echo This script requires at least seven arguments. 
    echo client schema name and password  
    echo master schema name and passwoed
    echo oracle admin user name and password
    echo and database connect string
    echo 
    exit 2
  fi

   adminuser=$6
   ADMINUSER=$6
   masteruser=$4
   MASTERUSER=$4
   clientuser=$2
   CLIENTUSER=$2
   adminpwd=$7
   masterpwd=$5
   clientpwd=$3
   dbname=$8
   IndustryFlag=$9

 else

   echo "Only -s option is currently supported by the script"
   exit 2

 fi

else


 if [[ $7 = '' ]] then

    echo
    echo "Usage :  create_tsm_client.ksh <client_schema> <client_password> <master_schema> <master_password> <oracle_admin_user> <oracle_admin_passwd> <database connect string>"
    echo
    echo This script requires at least seven arguments. 
    echo client schema name and password  
    echo master schema name and passwoed
    echo oracle admin user name and password
    echo and database connect string
    echo 
    exit 2
 fi

  adminuser=$5
  ADMINUSER=$5
  masteruser=$3
  MASTERUSER=$3
  clientuser=$1
  CLIENTUSER=$1
  adminpwd=$6
  masterpwd=$4
  clientpwd=$2
  dbname=$7
  IndustryFlag=$8

fi

tabname='v$session'

adminconnect=$adminuser/$adminpwd@$dbname
masterconnect=$masteruser/$masterpwd@$dbname
clientconnect=$clientuser/$clientpwd@$dbname


if [[ $silentmode -ne 1 ]] then

 clienttabexist=`sqlplus -s $adminconnect << EOF
 set heading off
 set feedback off
 select count(*) from dba_tables where owner='$CLIENTUSER' and table_name = 'PAP_CLINICAL_PROC_COST';
EOF`

 if [[ $clienttabexist -gt 0 ]] then

  dataexist=`sqlplus -s $adminconnect << EOF
  set heading off
  set feedback off
  select count(*) from $CLIENTUSER.pap_clinical_proc_cost;
EOF`

  if [[ $dataexist -gt 0 ]] then
 
   cnt1=0
   while [ cnt1 -ne 1 ]
   do 
    echo
    print -n 'Client already exists. Do you want to delete and recreate it ? y/n [n]: '
    read client

    if [[ $client = "n" || $client = "N" || $client = "" ]] then

      echo
      echo exiting...
      echo 
      exit 1

    elif [[ $client = "y" || $client = "Y" ]] then

      cnt1=1 
    fi
   done
  fi
 fi
fi  


clientloggedin=`sqlplus -s $adminconnect << EOF
set heading off
set feedback off
select count(*) from $tabname where username='$CLIENTUSER';
EOF`


if [[ $clientloggedin -gt 0 ]] then

	echo
	echo This client has currently logged into database and can not be recreated
	echo exiting ...
	echo
	exit 2
fi

sqlplus -s $adminconnect  << EOF  >clientschema.out 2>&1
drop user $clientuser cascade;
create user $clientuser identified by $clientpwd default tablespace tsmsmall
temporary tablespace temp;
grant ftconnect,resource to $clientuser;
grant create sequence to $clientuser;
EOF

sqlplus -s $masterconnect  << EOF >>clientschema.out 2>&1
@tsm10_grants_given_to_clients $CLIENTUSER 
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_tables 
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_indexes 
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_sequences 
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_foreign_keys $MASTERUSER
EOF


sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_synonyms $MASTERUSER
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_grants_given $MASTERUSER
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_client_inserts $MASTERUSER
EOF

sqlplus -s $masterconnect  << EOF >>clientschema.out 2>&1
@tsm10_special_grants_to_tsmclient0 $CLIENTUSER 
EOF

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsmclient0_special_synonyms $MASTERUSER
EOF

if [[ $IndustryFlag = industry ]] then

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@tsm10_industry_schema $MASTERUSER
EOF
fi

sqlplus -s $clientconnect  << EOF >>clientschema.out 2>&1
@views_client 
EOF

exit 0

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  11   DevTSM    1.10        2/27/2008 3:17:43 PM Debashish Mishra  
#  10   DevTSM    1.9         1/15/2007 2:13:23 PM Debashish Mishra updated for
#       Kelly's build code changes
#  9    DevTSM    1.8         11/7/2006 1:59:23 PM Debashish Mishra  
#  8    DevTSM    1.7         9/19/2006 12:08:00 AMDebashish Mishra  removed
#       references to obsolete tables
#  7    DevTSM    1.6         1/20/2006 11:08:05 PMDebashish Mishra Updated the
#       script for Oracle 10g
#  6    DevTSM    1.5         7/13/2005 9:43:06 AM Debashish Mishra New procedure
#       increment_build_sequence
#  5    DevTSM    1.4         4/28/2005 10:48:52 PMDebashish Mishra  Commented out
#       the if condition for special permissions
#  4    DevTSM    1.3         3/3/2005 6:33:25 AM  Debashish Mishra   
#  3    DevTSM    1.2         3/3/2005 6:32:16 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:19:13 PM Debashish Mishra  
#  1    DevTSM    1.0         6/13/2003 8:02:41 AM Debashish Mishra 
# $
# 
#############################################################

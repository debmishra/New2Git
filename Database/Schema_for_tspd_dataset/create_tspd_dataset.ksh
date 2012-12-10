#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: create_tspd_dataset.ksh$ 
#
# $Revision: 6$        $Date: 2/27/2008 3:18:00 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
typeset -l adminuser
typeset -l masteruser
typeset -l clientuser
typeset -u ADMINUSER
typeset -u MASTERUSER
typeset -u CLIENTUSER
silentmode=0


if [[ `echo $1 | cut -c 1` = "-" ]] then

 if [[ $1 = "-s" ]] then 
    silentmode=1

  if [[ $7 = '' ]] then

    echo
    echo "Usage :  create_tspd_dataset.ksh -s <client_schema> <client_password> <master_schema> <master_password> <oracle_admin_user> <oracle_admin_passwd> <database connect string>"
    echo
    echo This script requires at least six arguments. 
    echo client schema name and password  
    echo master schema name and passwoed
    echo oracle admin user name and password
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

 else

   echo "Only -s option is currently supported by the script"
   exit 2

 fi

else


 if [[ $6 = '' ]] then

    echo
    echo "Usage :  create_tspd_dataset.ksh <client_schema> <client_password> <master_schema> <master_password> <oracle_admin_user> <oracle_admin_passwd> <database connect string>"
    echo
    echo This script requires at least six arguments. 
    echo client schema name and password  
    echo master schema name and passwoed
    echo oracle admin user name and password
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

fi





tabname='v$session'

if [[ $dbname = '' ]] then

  adminconnect=$adminuser/$adminpwd
  masterconnect=$masteruser/$masterpwd
  clientconnect=$clientuser/$clientpwd

else 

  adminconnect=$adminuser/$adminpwd@$dbname
  masterconnect=$masteruser/$masterpwd@$dbname
  clientconnect=$clientuser/$clientpwd@$dbname

fi

if [[ $silentmode -ne 1 ]] then

 clienttabexist=`sqlplus -s $adminconnect << EOF
 set heading off
 set feedback off
 select count(*) from dba_tables where owner='$CLIENTUSER' and table_name = 'TSPD_PROC_FREQ';
EOF`

 if [[ $clienttabexist -gt 0 ]] then

  dataexist=`sqlplus -s $adminconnect << EOF
  set heading off
  set feedback off
  select count(*) from $CLIENTUSER.tspd_proc_freq;
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

sqlplus -s $adminconnect  << EOF  >TspdDataset.out 2>&1
drop user $clientuser cascade;
create user $clientuser identified by $clientpwd default tablespace tsmsmall
temporary tablespace temp;
grant ftconnect,resource to $clientuser;
EOF

sqlplus -s $masterconnect  << EOF >>TspdDataset.out 2>&1
@tsm10_grants_given_to_tspd_dataset $CLIENTUSER 
EOF

sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_tables 
EOF

sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_indexes 
EOF

sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_sequences 
EOF

sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_foreign_keys $MASTERUSER
EOF


sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_synonyms $MASTERUSER
EOF

sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_grants_given $MASTERUSER
EOF

sqlplus -s $clientconnect  << EOF >>TspdDataset.out 2>&1
@tspd_dataset_views 
EOF


exit 0


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/27/2008 3:18:00 PM Debashish Mishra  
#  5    DevTSM    1.4         5/16/2007 5:32:17 PM Debashish Mishra New TSD views
#  4    DevTSM    1.3         1/20/2006 11:18:26 PMDebashish Mishra updated for
#       10g
#  3    DevTSM    1.2         3/3/2005 6:34:45 AM  Debashish Mishra  
#  2    DevTSM    1.1         6/13/2003 10:01:45 AMDebashish Mishra Initial
#       creation
#  1    DevTSM    1.0         6/13/2003 8:04:38 AM Debashish Mishra 
# $
# 
#############################################################

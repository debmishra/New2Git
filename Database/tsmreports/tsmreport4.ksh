#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsmreport4.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:49 PM$
#
#
# Description:  <ADD>
#
#############################################################



if [[ $2 = '' ]] then

  echo 
  echo "usage : tsmreport4.ksh <master conect string> <build_tag_id>"
  echo "for example: tsmreport4.ksh tsm10/welcome@fasttrackdevl.world 3"
  echo
  exit 0
fi

CONNECT_STRING=$1
BUILD_TAG=$2
REPORT_HOME=//rossvr7/reports/tsm_reports
ORACLE_HOME=/c/oracle/orareport

master_schema1=`/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off
select user||'_'||$BUILD_TAG from dual;
exit;
EOF`

master_schema=`echo $master_schema1`

/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off
drop synonym master_temp_procedure;
create synonym master_temp_procedure for $master_schema.temp_procedure;
exit;
EOF

$ORACLE_HOME/bin/RWRUN60 "c:\tsm_reports\tsmreport4.rep" \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="c:\tsm_reports\GrantsByIndication.pdf" batch=yes  

/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off
drop synonym master_temp_procedure;
exit;
EOF

mkdir -p $REPORT_HOME/build_tag_$2
mv /c/tsm_reports/GrantsByIndication.pdf $REPORT_HOME/build_tag_$2/


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:18:49 PM Debashish Mishra  
#  3    DevTSM    1.2         9/10/2007 11:44:31 AMDebashish Mishra updated to use
#       master client schema
#  2    DevTSM    1.1         3/3/2005 6:37:07 AM  Debashish Mishra  
#  1    DevTSM    1.0         4/11/2002 3:24:52 PM Debashish Mishra 
# $
# 
#############################################################

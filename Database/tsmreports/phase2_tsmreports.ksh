#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: phase2_tsmreports.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:48 PM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ $3 = '' ]] then

  echo 
  echo "usage : phase2_tsmreports.ksh <client conect string> <build_tag_id> <client_identifier>"
  echo "for example: phase2_tsmreports.ksh tsmclient_pkd_3/welcome@fasttrackdevl.world 3 PKD"
  echo
  exit 0
fi

test_db1=`/c/oracle/ora901/bin/sqlplus -s $1 << EOF
set heading off
set pages 0
set feedback off
select 999 from dual;

EOF`

test_db=`echo $test_db1`

if [[ $test_db != 999 ]] then

  echo
  echo "Can not connect to database with the given connect string"
  echo
  exit 0

fi

rm -rf /r/tsm_reports/build_tag_$2/$3

tsmreport1.ksh $1 $2 $3
tsmreport2.ksh $1 $2 $3
tsmreport3.ksh $1 $2 $3

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:48 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:37:02 AM  Debashish Mishra  
#  1    DevTSM    1.0         4/11/2002 3:24:50 PM Debashish Mishra 
# $
# 
#############################################################

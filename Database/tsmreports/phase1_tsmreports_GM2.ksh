#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: phase1_tsmreports_GM2.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:48 PM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ $2 = '' ]] then

  echo 
  echo "usage : phase1_tsmreports.ksh <master conect string> <build_tag_id>"
  echo "for example: phase1_tsmreports.ksh tsm10/welcome@fasttrackdevl.world 3"
  echo
  exit 0
fi

test_db1=`/c/oracle/ora920/bin/sqlplus -s $1 << EOF
set heading off
set pages 0
set feedback off
select 999 from dual;

EOF`

test_db=`echo $test_db1`



if [[ $test_db -ne 999 ]] then

  echo "Can not connect to database with the given connect string"
  echo
  exit 0

fi

echo "running report4 ...."
tsmreport4.ksh $1 $2
echo "running report5 USA ...."
tsmreport5_US.ksh $1 $2
echo "running report5 for grouped countries ...."
tsmreport5_grp.ksh $1 $2
echo "running report5 Others ...."
tsmreport5.ksh $1 $2

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:48 PM Debashish Mishra  
#  2    DevTSM    1.1         9/14/2007 2:28:51 PM Debashish Mishra  
#  1    DevTSM    1.0         6/18/2005 11:38:33 AMDebashish Mishra 
# $
# 
#############################################################

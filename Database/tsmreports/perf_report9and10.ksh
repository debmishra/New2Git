#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: perf_report9and10.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:48 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $# -ne 5 ]] then

  echo 
  echo "usage : perf_report9and10.ksh <Run ID1> <Run ID2> <Run ID3> <Run ID4> <Run ID5>"
  echo 'for example: perf_report9and10.ksh 74 77 80 -1 -1'
  echo
  exit 0
fi

#CONNECT_STRING=emul/welcome@emul.world
#ORACLE_HOME=/c/oracle/orareports

CONNECT_STRING=emul/welcome@devl
ORACLE_HOME=/c/oracle/orareport

$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report9.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report9.pdf" \
batch=yes runid1=$1  runid2=$2 runid3=$3  runid4=$4 runid5=$5

$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report10.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report10.pdf" \
batch=yes runid1=$1  runid2=$2 runid3=$3  runid4=$4 runid5=$5


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:48 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:37:02 AM  Debashish Mishra  
#  1    DevTSM    1.0         3/12/2003 10:25:15 AMDebashish Mishra 
# $
# 
#############################################################

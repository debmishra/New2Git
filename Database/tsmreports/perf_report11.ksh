#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: perf_report11.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:46 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $# -ne 2 ]] then

  echo 
  echo "usage : perf_report11.ksh <Run ID1> <Run ID2>"
  echo 'for example: perf_report11.ksh 42 45'
  echo
  exit 0
fi

CONNECT_STRING=emul/welcome@emul.world
ORACLE_HOME=/c/oracle/orareports


$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report11.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report11.pdf" \
batch=yes runid=$1  runid2=$2


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:46 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:36:53 AM  Debashish Mishra  
#  1    DevTSM    1.0         5/20/2003 2:57:57 PM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: perf_report5.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:47 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $# -ne 4 ]] then

  echo 
  echo "usage : perf_report5.ksh <Run ID> <Start Time> <End Time> <CPU Idle time>"
  echo 'for example: perf_report5.ksh 27 "02/05/2003 13:00" "02/05/2003 15:00" 80'
  echo "Please give the dates and time in double quotes"
  echo
  exit 0
fi

CONNECT_STRING=emul/welcome@devl
ORACLE_HOME=/c/oracle/orareport


$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report5.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report5.pdf" \
batch=yes runid=$1  starttime="$2" endtime="$3" cpu_idle_time=$4


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:47 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:36:57 AM  Debashish Mishra  
#  1    DevTSM    1.0         2/19/2003 1:29:54 PM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: perf_report4.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:47 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $# -ne 2 ]] then

  echo 
  echo "usage : perf_report4.ksh <Run ID> <Action Name>"
  echo "for example: perf_report4.ksh 27 Login"
  echo
  exit 0
fi


CONNECT_STRING=emul/welcome@devl
ORACLE_HOME=/c/oracle/orareport


$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report4.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report4.pdf" \
batch=yes runid=$1  actionname=$2


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:47 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:36:56 AM  Debashish Mishra  
#  1    DevTSM    1.0         2/19/2003 1:29:53 PM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: perf_report123.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:46 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $1 = '' ]] then

  echo 
  echo "usage : perf_report123.ksh <Run ID>"
  echo "for example: perf_report123.ksh 27"
  echo
  exit 0
fi


CONNECT_STRING=emul/welcome@emul.world
ORACLE_HOME=/c/oracle/orareports

$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report1.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report1.pdf" \
batch=yes runid=$1  

$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report2.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report2.pdf" \
batch=yes runid=$1

$ORACLE_HOME/bin/RWRUN60 "\\\\romsvr1\users\dmishra\public\perf\source\perf_report3.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="\\\\romsvr1\users\dmishra\public\perf\output\perf_report3.pdf" \
batch=yes runid=$1


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:46 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:36:54 AM  Debashish Mishra  
#  1    DevTSM    1.0         2/19/2003 1:29:52 PM Debashish Mishra 
# $
# 
#############################################################

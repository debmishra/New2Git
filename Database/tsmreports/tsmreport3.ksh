#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsmreport3.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:49 PM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ $3 = '' ]] then

  echo 
  echo "usage : tsmreport3.ksh <client conect string> <build_tag_id> <client_identifier>"
  echo "for example: tsmreport3.ksh tsmclient_pkd_3/welcome@fasttrackdevl.world 3 PKD"
  echo
  exit 0
fi

CONNECT_STRING=$1
REPORT_HOME=/r/tsm_reports
ORACLE_HOME=/c/oracle/orareports

$ORACLE_HOME/bin/RWRUN60 "c:\tsm_reports\tsmreport3.rep"  \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="r:\tsm_reports\InitPayments.pdf" batch=yes 

mkdir -p $REPORT_HOME/build_tag_$2/$3
mv $REPORT_HOME/InitPayments.pdf $REPORT_HOME/build_tag_$2/$3/

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:49 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:37:06 AM  Debashish Mishra  
#  1    DevTSM    1.0         4/11/2002 3:24:52 PM Debashish Mishra 
# $
# 
#############################################################

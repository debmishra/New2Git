#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: update_cro_factors.ksh$ 
#
# $Revision: 3$        $Date: 2/22/2008 11:56:06 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
if test $# -ne 1
then echo "Usage: update_cro_factors.ksh <userid1>/passwd1>@<alias1>"
exit
fi

sqlplus -s $1 <<EOF
set pages 0
  set hea off
  set feedback off
  execute update_cro_factors
EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/22/2008 11:56:06 AMDebashish Mishra  
#  2    DevTSM    1.1         9/19/2006 12:11:52 AMDebashish Mishra   
#  1    DevTSM    1.0         11/16/2005 2:05:19 PMDebashish Mishra 
# $
# 
#############################################################

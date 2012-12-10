#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: licensewarning.ksh$ 
#
# $Revision: 5$        $Date: 2/22/2008 11:55:59 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

sqlplus -s tsm10/`get_pwd tsm10` << EOF
execute licensewarning
exit;
EOF


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         2/22/2008 11:55:59 AMDebashish Mishra  
#  4    DevTSM    1.3         9/19/2006 12:11:19 AMDebashish Mishra   
#  3    DevTSM    1.2         3/2/2005 10:50:55 PM Debashish Mishra  
#  2    DevTSM    1.1         8/29/2003 5:17:40 PM Debashish Mishra  
#  1    DevTSM    1.0         5/10/2002 10:23:19 AMDebashish Mishra 
# $
# 
#############################################################

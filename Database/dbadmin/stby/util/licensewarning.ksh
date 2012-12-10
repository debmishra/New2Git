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
# $Revision: 6$        $Date: 4/18/2011 8:06:35 AM$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

export ORACLE_SID=prod

sqlplus -s tsm10/`get_pwd tsm10` << EOF
execute licensewarning
exit;
EOF


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         4/18/2011 8:06:35 AM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:46:22 AM  Debashish Mishra  
#  4    DevTSM    1.3         12/26/2003 4:24:49 PMDebashish Mishra  
#  3    DevTSM    1.2         2/25/2003 12:41:32 PMDebashish Mishra  
#  2    DevTSM    1.1         1/13/2003 11:24:10 AMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:57 AM Debashish Mishra 
# $
# 
#############################################################

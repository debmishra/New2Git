#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: activate_stbydb.ksh$ 
#
# $Revision: 2$        $Date: 3/3/2005 6:46:19 AM$
#
#
# Description:  To activate standby database
#
#############################################################
sqlplus /nolog  << EOF
connect / as sysdba
ALTER DATABASE ACTIVATE STANDBY DATABASE;
shutdown immediate 
startup
exit;
EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         3/3/2005 6:46:19 AM  Debashish Mishra  
#  1    DevTSM    1.0         12/26/2003 4:24:36 PMDebashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile$ 
#
# $Revision$        $Date$
#
#
# Description:  <ADD>
#
#############################################################
 
. /etc/profile
cd ~oracle
. ./.profile

ORACLE_USER=backup_user 
ORACLE_PWD=`get_pwd $ORACLE_USER`

export ORACLE_SID=prd2

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
execute dbms_stats.gather_schema_stats('cs10');
EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log$
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: sync_sequences.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:22:34 PM$
#
#
# Description:  <ADD>
#
#############################################################

. /etc/profile
cd ~oracle
. ./.profile

export DB_USER=ft14a
/export/home/oracle/schema/sequence14.ksh
/export/home/oracle/schema/sequence14a.ksh

export DB_USER=fasttrack14a
/export/home/oracle/schema/sequence14.ksh
/export/home/oracle/schema/sequence14a.ksh

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:22:34 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:42:54 AM  Debashish Mishra  
#  2    DevTSM    1.1         12/26/2003 4:23:36 PMDebashish Mishra  
#  1    DevTSM    1.0         2/25/2003 12:34:54 PMDebashish Mishra 
# $
# 
#############################################################

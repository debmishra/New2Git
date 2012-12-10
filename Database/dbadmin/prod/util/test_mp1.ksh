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

email="5105011758@txt.att.net mpasupuleti@mdsol.com"
pager="5105011758@txt.att.net mpasupuleti@mdsol.com"

  echo "Alert: Archive log force delete. Recreate standby database" | mailx -s ArchiveLogs $email
  ##echo "Alert: Archive log force delete. Recreate standby database" | mailx -s ArchiveLogs $pager
#############################################################
# MODIFICATION HISTORY:
#
# $Log$
# 
#############################################################

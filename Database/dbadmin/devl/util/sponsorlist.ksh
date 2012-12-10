#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: sponsorlist.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:22:34 PM$
#
#
# Description:  Creates a file sponsorlist.xsd with list of sponsors
#
#############################################################
 
sqlplus -s fasttrack14a/welcome <<EOF

set pages 0
set echo off
set feedback off
set heading off
set termout off

spool sponsorlist.xsd

select '<xsd:enumeration value="'||short_name||'"/>' from sponsor 
where trim(short_name) is not null ;

spool off

EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:22:34 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:42:53 AM  Debashish Mishra  
#  2    DevTSM    1.1         12/26/2003 4:23:36 PMDebashish Mishra  
#  1    DevTSM    1.0         2/25/2003 12:34:53 PMDebashish Mishra 
# $
# 
#############################################################

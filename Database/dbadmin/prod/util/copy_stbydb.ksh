#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: copy_stbydb.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:21:50 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
mv /archive/oracle/prod/*.log /archive/oracle/prod/temp/
rcp /archive/oracle/prod/temp/*.log rossvr4:/arch/oracle/prod/
sleep 10
mv /archive/oracle/prod/temp/*.log /orabackup/prod/hot/archive/


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:21:50 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:44:50 AM  Debashish Mishra  
#  2    DevTSM    1.1         9/9/2003 8:25:12 AM  Debashish Mishra  
#  1    DevTSM    1.0         2/11/2003 6:47:57 PM Debashish Mishra 
# $
# 
#############################################################

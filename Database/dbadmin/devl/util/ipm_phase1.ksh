#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: ipm_phase1.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:22:33 PM$
#
#
# Description:  <ADD>
#
#############################################################

export load_ctl_dir=/c/ipt_data
export ORA_HOME=/c/oracle/po9i
export connect_string=tsm10/welcome@devl
export dos_load_ctl_dir=c:\\ipt_data

rm -rf $load_ctl_dir/ipm_phase1.dat

for filename in `ls *.txt`
do
cat $filename | grep -v country >> $load_ctl_dir/ipm_phase1.dat
done

$ORA_HOME/bin/sqlldr \
CONTROL=$dos_load_ctl_dir\\ipm_phase1.ctl, LOG=$dos_load_ctl_dir\\ipm_phase1.log, \
BAD=$dos_load_ctl_dir\\ipm_phase1.bad, \
USERID=$connect_string 


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:22:33 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:42:51 AM  Debashish Mishra  
#  2    DevTSM    1.1         12/26/2003 4:23:33 PMDebashish Mishra  
#  1    DevTSM    1.0         3/28/2003 5:11:56 PM Debashish Mishra 
# $
# 
#############################################################

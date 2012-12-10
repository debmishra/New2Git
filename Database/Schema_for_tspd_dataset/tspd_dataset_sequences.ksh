#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tspd_dataset_sequences.ksh$ 
#
# $Revision: 6$        $Date: 2/27/2008 3:18:01 PM$
#
#
# Description:  create sequences for tsm client
#
#############################################################


TSPD_PROC_FREQ_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from tspd_proc_freq;
EOF`
TSPD_PROC_PRICING_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from tspd_proc_pricing;
EOF`
TSPD_TRIAL_FREQ_MAXID=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from tspd_trial_freq;
EOF`


sqlplus -s $DB_USER/$DB_PWD <<EOF

drop sequence tspd_proc_freq_seq;
drop sequence tspd_proc_pricing_seq;
drop sequence tspd_trial_freq_seq;

create sequence tspd_proc_freq_seq start with $TSPD_PROC_FREQ_MAXID ;
create sequence tspd_proc_pricing_seq start with $TSPD_PROC_PRICING_MAXID;
create sequence tspd_trial_freq_seq start with $TSPD_TRIAL_FREQ_MAXID;
EOF

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/27/2008 3:18:01 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:34:47 AM  Debashish Mishra  
#  4    DevTSM    1.3         7/10/2003 9:34:29 AM Debashish Mishra Added new
#       table tspd_trial_freq
#  3    DevTSM    1.2         7/2/2003 6:01:12 PM  Debashish Mishra Added new
#       table tspd_proc_pricing
#  2    DevTSM    1.1         6/13/2003 10:01:45 AMDebashish Mishra Initial
#       creation
#  1    DevTSM    1.0         6/13/2003 8:04:39 AM Debashish Mishra 
# $
# 
#############################################################

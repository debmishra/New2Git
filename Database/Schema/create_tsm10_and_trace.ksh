#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: create_tsm10_and_trace.ksh$ 
#
# $Revision: 20$        $Date: 2/22/2008 11:55:23 AM$
#
#
# Description:  <ADD>
#
#############################################################

# Before running this script, make sure that ft15,tsm10,ftcommon and ftadmin users are created
# with connect and resource role with the following additional privileges for ftadmin user
# grant connect,resource, alter any procedure, create any index, create any procedure, 
# create any sequence,create any synonym, create any table, create any trigger, 
# create any view, delete any table, drop any index, drop any procedure, 
# drop any sequence, drop any synonym, drop any table, drop any trigger, drop any view, 
# drop user, create user, execute any procedure, insert any table, select any sequence,
# select any table, update any table,grant any privilege, grant any role to ftadmin

# Also connect as sysdba and execute "grant select on sys.v_$session to ftadmin;" 


if [[ $3 = '' ]] then

    echo
    echo "Usage :  create_tsm10_and_trace.ksh <tsm_master_schema> <ft_exec_suite_schema> <ft_common_schema>"
    echo
    echo This script requires two arguments. 
    echo First, Name of the master tsm schema such as tsm10
    echo second, name of the execution suit schema whose objects are being referred
    echo 
    exit 0
fi

echo "Have you edited the ftcommon_views.sql for all appropriate schemas y/n: \c"
read var1
if [[ $var1 != y ]] then
   echo exiting....
   exit 0
fi
 
typeset -u MASTERUSER
typeset -u FTUSER
typeset -u COMMONUSER

typeset -l masteruser
typeset -l ftuser
typeset -l commonuser

MASTERUSER=$1
FTUSER=$2
COMMONUSER=$3
masteruser=$1
ftuser=$2
commonuser=$3



imp admin/`get_pwd admin` file=./ft15.dmp fromuser=ft15 touser=$ftuser


sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_tables 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_constraints 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_tables 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_constraints 
EOF

sqlplus -s $3/`get_pwd $3`  << EOF
@ftcommon_tables 
EOF

sqlplus -s $3/`get_pwd $3`  << EOF
@ftcommon_constraints 
EOF


sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_indexes 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_sequences 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_sequences 
EOF

sqlplus -s $3/`get_pwd $3`  << EOF
@ftcommon_sequences 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_grants_given_to_ft15 $FTUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_grants_given_to_ft15 $FTUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_required_data 
EOF

sqlplus -s $3/`get_pwd $3`  << EOF
@ftcommon_required_data 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_milestone_template
EOF


sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_role_template
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_task_template
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_task_group_template
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_role_to_task_template
EOF

# Following script will not be required in production
# and it will be setup for each client_division

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_rate_set
EOF

# Following script will not be required in production
# and it will be setup for each client_division

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_role_inst
EOF

sqlplus -s $2/`get_pwd $2`  << EOF
@ft15_schema_changes_for_tsm10 $MASTERUSER $FTUSER
EOF

sqlplus -s $2/`get_pwd $2`  << EOF
@ft15_grants_given_to_tsm10 $MASTERUSER
EOF

sqlplus -s $2/`get_pwd $2`  << EOF
@ft15_grants_given_to_trace $MASTERUSER
EOF

sqlplus -s $2/`get_pwd $2`  << EOF
@ft15_grants_given_to_ftcommon $COMMONUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_grants_given_to_ftcommon $COMMONUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_synonyms $FTUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_synonyms $FTUSER
EOF

sqlplus -s $2/`get_pwd` $2 <<EOF
@ft15_synonyms $MASTERUSER


sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_foreign_keys 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_foreign_keys 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_triggers 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_procedures 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@trace_procedures 
EOF


export DB_USER=$ftuser
export DB_PWD=`get_pwd $DB_USER`

ft15_sequences.ksh $1

export DB_USER=$masteruser
export DB_PWD=`get_pwd $DB_USER`

tsm10_sequences.ksh

export DB_USER=$commonuser
export DB_PWD=`get_pwd $DB_USER`

ftcommon_sequences.ksh

sqlplus -s $3/`get_pwd $3`   << EOF
@ftcommon_views
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@static_data_id_control 
EOF

sqlplus -s $3/`get_pwd $3`   << EOF
@ftcommon_procedures
EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  20   DevTSM    1.19        2/22/2008 11:55:23 AMDebashish Mishra  
#  19   DevTSM    1.18        9/19/2006 12:10:47 AMDebashish Mishra   
#  18   DevTSM    1.17        3/2/2005 10:48:48 PM Debashish Mishra  
#  17   DevTSM    1.16        11/16/2004 12:38:28 AMDebashish Mishra  
#  16   DevTSM    1.15        4/8/2004 4:09:25 PM  Debashish Mishra  
#  15   DevTSM    1.14        8/29/2003 5:15:40 PM Debashish Mishra  
#  14   DevTSM    1.13        4/7/2003 10:15:18 AM Debashish Mishra Colin's
#       ftadmin and Joel's installshield changes
#  13   DevTSM    1.12        10/4/2002 9:30:04 AM Debashish Mishra changes
#       relatred to new id_control table
#  12   DevTSM    1.11        9/16/2002 3:46:34 PM Debashish Mishra New table:
#       Application
#  11   DevTSM    1.10        9/12/2002 9:05:52 AM Debashish Mishra New views in
#       ftcommon
#  10   DevTSM    1.9         8/30/2002 12:43:52 PMDebashish Mishra  
#  9    DevTSM    1.8         8/20/2002 12:47:35 PMDebashish Mishra Changes for
#       multiple product and schema support
#  8    DevTSM    1.7         6/13/2002 11:51:22 AMDebashish Mishra all changes
#       done after Picas-e beta
#  7    DevTSM    1.6         6/4/2002 8:53:34 AM  Debashish Mishra Modified for
#       constraints stuff
#  6    DevTSM    1.5         5/23/2002 5:26:02 PM Debashish Mishra  
#  5    DevTSM    1.4         5/21/2002 1:01:32 PM Debashish Mishra  
#  4    DevTSM    1.3         5/15/2002 3:10:30 PM Debashish Mishra Modified the
#       comments section for usage notes
#  3    DevTSM    1.2         5/15/2002 9:45:29 AM Debashish Mishra  
#  2    DevTSM    1.1         4/17/2002 3:47:44 PM Debashish Mishra  
#  1    DevTSM    1.0         4/15/2002 3:26:04 PM Debashish Mishra 
# $
# 
#############################################################

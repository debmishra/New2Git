#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: create_tsd_schema.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:19:07 PM$
#
#
# Description:  <ADD>
#
#############################################################

# Before running this script, make sure that TSM10,tsm10,ftcommon and tsdadmin users are created


if [[ $4 = '' ]] then

    echo
    echo "Usage :  create_tsd_schema.ksh <tsm10_password> <ft15_password> <ftcommon_password> <connect_string>"
    echo
    echo This script requires four arguments. 
    echo password for tsm10, ft15, ftcommon schemas and database connect string.
    echo 
    exit 1
fi

sqlplus FT15/$2@$4 <<EOF

@baseft15_tables
@baseft15_foreign_keys
@baseft15_index
@baseft15_sequence
@baseft15_req_data
@baseft15_1_3
@baseft15_1_4
@baseft15_1_4a
EOF


sqlplus -s TSM10/$1@$4  << EOF
@tsm10_tables 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_constraints 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_tables 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_constraints 
EOF

sqlplus -s FTCOMMON/$3@$4  << EOF
@ftcommon_tables 
EOF

sqlplus -s FTCOMMON/$3@$4  << EOF
@ftcommon_constraints 
EOF


sqlplus -s TSM10/$1@$4  << EOF
@tsm10_indexes 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_sequences 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_sequences 
EOF

sqlplus -s FTCOMMON/$3@$4  << EOF
@ftcommon_sequences 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_procedures_1 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_grants_given_to_ft15 FT15
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_grants_given_to_ft15 FT15
EOF

sqlplus -s TSM10/$1@$4  << EOF
@static_data_id_control_1 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_required_data 
EOF

sqlplus -s FTCOMMON/$3@$4  << EOF
@ftcommon_required_data 
EOF

sqlplus -s FT15/$2@$4  << EOF
@ft15_schema_changes_for_tsm10_1 TSM10 FT15
EOF

sqlplus -s FT15/$2@$4  << EOF
@ft15_grants_given_to_tsm10 TSM10
EOF

sqlplus -s FT15/$2@$4  << EOF
@ft15_grants_given_to_trace TSM10
EOF

sqlplus -s FT15/$2@$4  << EOF
@ft15_grants_given_to_ftcommon FTCOMMON
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_grants_given_to_ftcommon FTCOMMON
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_synonyms FT15
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_synonyms FT15
EOF

sqlplus -s FT15/$2@$4 <<EOF
@ft15_synonyms TSM10
EOF

sqlplus -s TSM10/$1@$4  << EOF
@static_data_id_control_2 
EOF

sqlplus -s FT15/$2@$4  << EOF
@ft15_schema_changes_for_tsm10_2 TSM10 FT15
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_foreign_keys 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_foreign_keys 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_triggers 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@tsm10_procedures_2 
EOF

sqlplus -s TSM10/$1@$4  << EOF
@trace_procedures 
EOF

sqlplus -s FTCOMMON/$3@$4   << EOF
@ftcommon_views
EOF


sqlplus -s FTCOMMON/$3@$4   << EOF
@ftcommon_procedures
EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:19:07 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:37:51 AM  Debashish Mishra  
#  1    DevTSM    1.0         11/17/2004 8:26:49 AMDebashish Mishra 
# $
# 
#############################################################

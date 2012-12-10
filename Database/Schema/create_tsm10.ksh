#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: create_tsm10.ksh$ 
#
# $Revision: 9$        $Date: 2/22/2008 11:55:23 AM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ $2 = '' ]] then

    echo
    echo "Usage :  create_tsm10.ksh <tsm_master_schema> <ft_exec_suite_schema>"
    echo
    echo This script requires two arguments. 
    echo First, Name of the master tsm schema such as tsm10
    echo second, name of the execution suit schema whose objects are being referred
    echo 
    exit 0
fi
 
typeset -u MASTERUSER
typeset -u FTUSER

MASTERUSER=$1
FTUSER=$2

imp $2/`get_pwd $2` file=./ft15.dmp fromuser=ft15 touser=ft15


sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_tables 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_indexes 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_sequences 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_grants_given_to_ft15 $FTUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_required_data 
EOF

sqlplus -s $2/`get_pwd $2`  << EOF
@ft15_schema_changes_for_tsm10 $MASTERUSER $FTUSER
EOF

sqlplus -s $2/`get_pwd $2`  << EOF
@ft15_grants_given_to_tsm10 $MASTERUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_synonyms $FTUSER
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_foreign_keys 
EOF


sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_triggers 
EOF

sqlplus -s $1/`get_pwd $1`  << EOF
@tsm10_procedures 
EOF



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  9    DevTSM    1.8         2/22/2008 11:55:23 AMDebashish Mishra  
#  8    DevTSM    1.7         9/19/2006 12:10:47 AMDebashish Mishra   
#  7    DevTSM    1.6         3/2/2005 10:48:47 PM Debashish Mishra  
#  6    DevTSM    1.5         8/29/2003 5:15:39 PM Debashish Mishra  
#  5    DevTSM    1.4         4/4/2002 5:18:59 PM  Debashish Mishra  
#  4    DevTSM    1.3         3/22/2002 12:52:13 PMDebashish Mishra  
#  3    DevTSM    1.2         3/14/2002 4:04:23 PM Debashish Mishra  
#  2    DevTSM    1.1         1/21/2002 5:29:19 PM Debashish Mishra  
#  1    DevTSM    1.0         12/19/2001 10:51:02 AMDebashish Mishra 
# $
# 
#############################################################

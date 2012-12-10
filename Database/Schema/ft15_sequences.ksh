#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: ft15_sequences.ksh$ 
#
# $Revision: 6$        $Date: 2/22/2008 11:55:24 AM$
#
#
# Description:  create sequences for ft15
#
#############################################################

criterion_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from criterion;
EOF`
handheld_device_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from handheld_device;
EOF`
handheld_group_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from handheld_group;
EOF`
protocol_version_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from protocol_version;
EOF`
site_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from site;
EOF`
site_to_trial_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from site_to_trial;
EOF`
trial_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from trial;
EOF`
ftuser_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+101 from ftuser;
EOF`
ftgroup_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ftgroup;
EOF`
ftuser_to_ftgroup_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ftuser_to_ftgroup;
EOF`
aclentries_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from aclentries;
EOF`
patient_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from patient;
EOF`
subject_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from subject;
EOF`
medical_record_number_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from medical_record_number;
EOF`
sponsor_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from sponsor;
EOF`
protocol_type_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from protocol_type;
EOF`
site_checklist_template_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF 
set heading off
set feedback off
select nvl(max(id),0)+1 from Site_Checklist_Template;
EOF`
visit_checklist_template_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from Visit_Checklist_Template;
EOF`
therapeutic_area_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from Therapeutic_Area;
EOF`
taclassifier_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from TAClassifier;
EOF`
taclassifier_to_ta_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from taclassifier_to_ta;
EOF`
ftuser_taclassifier_filter_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from FTUser_TAClassifier_Filter;
EOF`
ftuser_trial_filter_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from FTUser_Trial_Filter;
EOF`
hhgroup_to_classifiers_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from HHGroup_to_Classifiers;
EOF`
ftuser_to_aclentries_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ftuser_to_aclentries;
EOF`
ftgroup_to_aclentries_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ftgroup_to_aclentries;
EOF`
ft_foreign_key_info_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ft_foreign_key_info;
EOF`
pv_to_classifier_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from pv_to_classifier;
EOF`
cra_manager_to_monitor_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from cra_manager_to_monitor;
EOF`
cra_manager_to_trial_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from cra_manager_to_trial;
EOF`
monitor_to_site_to_trial_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from monitor_to_site_to_trial;
EOF`
event_core_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from event_core;
EOF`
misc_event_prototype_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from misc_event_prototype;
EOF`
patient_management_task_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from patient_management_task;
EOF`
peg_to_event_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from peg_to_event;
EOF`
peg_to_peg_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from peg_to_peg;
EOF`
protocol_event_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from protocol_event;
EOF`
protocol_event_group_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from protocol_event_group;
EOF`
task_to_protocol_event_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from task_to_protocol_event;
EOF`
site_to_trial_pv_history_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from site_to_trial_pv_history;
EOF`
ftuser_login_history_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from ftuser_login_history;
EOF`
handheld_use_history_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from handheld_use_history;
EOF` 
usage_history_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from usage_history;
EOF`

trial_metrics_history_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from trial_metrics_history;
EOF`

client_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from client;
EOF`

subject_disposition_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from subject_disposition;
EOF`

global_tmf_deliverable_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from global_tmf_deliverable;
EOF`

tmf_deliverable_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from tmf_deliverable;
EOF`

comment_item_maxid=`sqlplus -s $DB_USER/$DB_PWD <<EOF
set heading off
set feedback off
select nvl(max(id),0)+1 from comment_item;
EOF`

sqlplus -s $DB_USER/$DB_PWD <<EOF

drop sequence ftuser_seq;
drop sequence ftgroup_seq;
drop sequence ftuser_to_ftgroup_seq;
drop sequence aclentries_seq;
drop sequence patient_seq;
drop sequence subject_seq;
drop sequence medical_record_number_seq;
drop sequence sponsor_seq;
drop sequence criterion_seq;
drop sequence handheld_device_seq;
drop sequence handheld_group_seq;
drop sequence protocol_version_seq;
drop sequence site_seq;
drop sequence site_to_trial_seq;
drop sequence trial_seq;
drop sequence protocol_type_seq;
drop sequence Site_Checklist_Template_seq;
drop sequence Visit_Checklist_Template_seq;
drop sequence Therapeutic_Area_seq;
drop sequence TAClassifier_seq;
drop sequence TAClassifier_to_TA_seq;
drop sequence FTUser_TAClassifier_Filter_seq;
drop sequence FTUser_Trial_Filter_seq;
drop sequence HHGroup_to_Classifiers_seq;
drop sequence ftuser_to_aclentries_seq;
drop sequence ftgroup_to_aclentries_seq;
drop sequence ft_foreign_key_info_seq;
drop sequence pv_to_classifier_seq;
drop sequence cra_manager_to_monitor_seq;
drop sequence cra_manager_to_trial_seq;
drop sequence monitor_to_site_to_trial_seq;
drop sequence event_core_seq;
drop sequence misc_event_prototype_seq;
drop sequence patient_management_task_seq;
drop sequence peg_to_event_seq;
drop sequence peg_to_peg_seq;
drop sequence protocol_event_seq;
drop sequence protocol_event_group_seq;
drop sequence task_to_protocol_event_seq;
drop sequence site_to_trial_pv_history_seq;
drop sequence ftuser_login_history_seq;
drop sequence handheld_use_history_seq;
drop sequence USAGE_HISTORY_seq;
drop sequence TRIAL_METRICS_HISTORY_seq;
drop sequence client_seq;
drop sequence subject_disposition_seq;
drop sequence global_tmf_deliverable_seq;
drop sequence tmf_deliverable_seq;
drop sequence comment_item_seq;

create sequence criterion_seq start with $criterion_maxid ;
create sequence handheld_device_seq start with $handheld_device_maxid ;
create sequence handheld_group_seq start with $handheld_group_maxid ;
create sequence protocol_version_seq start with $protocol_version_maxid ;
create sequence site_seq start with $site_maxid ;
create sequence site_to_trial_seq start with $site_to_trial_maxid ;
create sequence trial_seq start with $trial_maxid ;
create sequence ftuser_seq start with $ftuser_maxid ;
create sequence ftgroup_seq start with $ftgroup_maxid ;
create sequence ftuser_to_ftgroup_seq start with $ftuser_to_ftgroup_maxid ;
create sequence aclentries_seq start with $aclentries_maxid ;
create sequence patient_seq start with $patient_maxid ;
create sequence subject_seq start with $subject_maxid ;
create sequence medical_record_number_seq start with $medical_record_number_maxid ;
create sequence sponsor_seq start with $sponsor_maxid ;
create sequence protocol_type_seq start with $protocol_type_maxid ;
create sequence Site_Checklist_Template_seq start with $site_checklist_template_maxid ;
create sequence Visit_Checklist_Template_seq start with $visit_checklist_template_maxid ;
create sequence Therapeutic_Area_seq start with $therapeutic_area_maxid ;
create sequence TAClassifier_seq start with $taclassifier_maxid ;
create sequence taclassifier_to_ta_seq start with $taclassifier_to_ta_maxid;
create sequence FTUser_TAClassifier_Filter_seq start with $ftuser_taclassifier_filter_maxid ;
create sequence FTUser_Trial_Filter_seq start with $ftuser_trial_filter_maxid ;
create sequence HHGroup_to_Classifiers_seq start with $hhgroup_to_classifiers_maxid ;
create sequence ftuser_to_aclentries_seq start with $ftuser_to_aclentries_maxid ;
create sequence ftgroup_to_aclentries_seq start with $ftgroup_to_aclentries_maxid ;
create sequence ft_foreign_key_info_seq start with $ft_foreign_key_info_maxid;
create sequence pv_to_classifier_seq start with $pv_to_classifier_maxid;
create sequence cra_manager_to_monitor_seq start with $cra_manager_to_monitor_maxid;
create sequence cra_manager_to_trial_seq start with $cra_manager_to_trial_maxid;
create sequence monitor_to_site_to_trial_seq start with $monitor_to_site_to_trial_maxid;
create sequence event_core_seq start with $event_core_maxid;
create sequence misc_event_prototype_seq start with $misc_event_prototype_maxid;
create sequence patient_management_task_seq start with $patient_management_task_maxid;
create sequence peg_to_event_seq start with $peg_to_event_maxid;
create sequence peg_to_peg_seq start with $peg_to_peg_maxid;
create sequence protocol_event_seq start with $protocol_event_maxid;
create sequence protocol_event_group_seq start with $protocol_event_group_maxid;
create sequence task_to_protocol_event_seq start with $task_to_protocol_event_maxid;
create sequence site_to_trial_pv_history_seq start with $site_to_trial_pv_history_maxid;
create sequence ftuser_login_history_seq start with $ftuser_login_history_maxid;
create sequence handheld_use_history_seq start with $handheld_use_history_maxid;
create sequence USAGE_HISTORY_seq start with $usage_history_maxid;
create sequence TRIAL_METRICS_HISTORY_seq start with $trial_metrics_history_maxid;
create sequence client_seq start with $client_maxid;
create sequence subject_disposition_seq start with $subject_disposition_maxid;
create sequence global_tmf_deliverable_seq start with $global_tmf_deliverable_maxid;
create sequence tmf_deliverable_seq start with $tmf_deliverable_maxid;
create sequence comment_item_seq start with $comment_item_maxid;

grant select on usage_history_seq to $1;
grant select on trial_metrics_history_seq to $1;
grant select on trial_seq to $1;
grant select on ftuser_seq to $1;
grant select on ftuser_to_ftgroup_seq to $1;

EOF


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  6    DevTSM    1.5         2/22/2008 11:55:24 AMDebashish Mishra  
#  5    DevTSM    1.4         9/19/2006 12:10:51 AMDebashish Mishra   
#  4    DevTSM    1.3         3/2/2005 10:48:50 PM Debashish Mishra  
#  3    DevTSM    1.2         8/29/2003 5:15:42 PM Debashish Mishra  
#  2    DevTSM    1.1         8/30/2002 12:43:53 PMDebashish Mishra  
#  1    DevTSM    1.0         5/10/2002 10:18:33 AMDebashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: site_backup.ksh$ 
#
# $Revision: 5$        $Date: 2/27/2008 3:22:34 PM$
#
#
# Description:  Site backup/delete/restore
#
#############################################################
 
if [[ $3 = '' ]] then

    echo "Usage :  site_backup.ksh <schema_name> <site_id> <backup/drop/restore>"
    echo This script requires three arguments. 
    echo First one is the schema name from which you want to delete/restore the data 
    echo "Second, the site_id (The id value from the site table)"
    echo Third, the type of operation i.e. backup/delete/restore
    exit 0
fi

##############################
# change these two parameters
##############################

admin_user=dmishra 
admin_pwd=welcome

schema_name_tmp=`sqlplus -s $admin_user/$admin_pwd   <<EOF
set heading off
set feedback off
select upper('$1') from dual;
EOF`
schema_name=`echo $schema_name_tmp`


valid_schema_tmp=`sqlplus -s $admin_user/$admin_pwd  <<EOF
set heading off
set feedback off
select count(*) from dba_users where username='$schema_name';
EOF`
valid_schema=`echo $valid_schema_tmp`



if [[ $valid_schema -ne 1 ]] then
    echo The schema name as the first parameter is not valid
    echo Plz. enter a valid schema name
    exit 0
fi

if [[ $3 != backup && $3 != delete && $3 != restore ]] then
     echo Please enter a valid operation in lower case as the third parameter
     exit 0
fi

if [[ $3 = backup ]] then

     valid_site_tmp=`sqlplus -s $admin_user/$admin_pwd <<EOF
     set heading off
     set feedback off
     select count(*) from "$schema_name".site where id=$2;
EOF`
     valid_site=`echo $valid_site_tmp`

     valid_site1_tmp=`sqlplus -s $admin_user/$admin_pwd <<EOF
     set heading off
     set feedback off
     select count(*) from deleted_sites.site where id=$2;
EOF`
     valid_site1=`echo $valid_site1_tmp`

     if [[ $valid_site -ne 1 ]] then
          echo The site id is not valid
          echo This site does not exist in the $1 schema
          exit 0   
     fi
     if [[ $valid_site1 -ne 0 ]] then
          echo A old backup of this site_id already exists
          echo First delete the old backup to make a fresh backup
          echo You can use this script itself to delete the old backup
          echo Hint :  Pass "deleted_sites" as the first parameter to this script
          exit 0   
     fi

	sqlplus -s $admin_user/$admin_pwd <<EOF
              
	Insert into deleted_sites.site select * from "$schema_name".site where id = $2;

	Insert into deleted_sites.handheld_group 
	select * from "$schema_name".handheld_group where site_id = $2;

	Insert into deleted_sites.handheld_device
	select * from "$schema_name".handheld_device where handheld_group_id in 
	(select id from "$schema_name".handheld_group where site_id = $2);

	Insert into deleted_sites.handheld_group_to_disease
	select * from "$schema_name".handheld_group_to_disease 
	where handheld_group_id in 
	(select id from "$schema_name".handheld_group where site_id = $2);

	Insert into deleted_sites.site_to_trial 
	select * from "$schema_name".site_to_trial where site_id = $2;

	Insert into deleted_sites.patient
	select * from "$schema_name".patient where site_id = $2;

	Insert into deleted_sites.subject
	select * from "$schema_name".subject where patient_id in
	(select id from "$schema_name".patient where site_id = $2);

	Insert into deleted_sites.medical_record_number
	select * from "$schema_name".medical_record_number where patient_id in
	(select id from "$schema_name".patient where site_id = $2);

	Insert into deleted_sites.ftuser  
	select * from "$schema_name".ftuser where site_id = $2;

	Insert into deleted_sites.ftuser_to_disease
	select * from "$schema_name".ftuser_to_disease where ftuser_id in
	(select id from "$schema_name".ftuser where site_id = $2);

	Insert into deleted_sites.ftgroup
	select * from "$schema_name".ftgroup where member in
	(select name from "$schema_name".ftuser where site_id = $2);

	Insert into deleted_sites.Aclentries
	select * from "$schema_name".Aclentries where ftgroup_id in 
	(select a.id from "$schema_name".ftgroup a, "$schema_name".ftuser b 
	where a.member = b.name and b.site_id = $2);

	commit;
EOF
fi

if [[ $3 = delete ]] then

     valid_site_tmp=`sqlplus -s $admin_user/$admin_pwd <<EOF
     set heading off
     set feedback off
     select count(*) from "$schema_name".site where id=$2;
EOF`
     valid_site=`echo $valid_site_tmp`

     if [[ $valid_site -ne 1 ]] then
          echo The site id $2 does not exist in in $schema_name schema
          echo can not proceed with deletion
          exit 0   
     fi

	echo Make sure that you have done the backup
	echo "Do you want to proceed y/n \c"
	read var1
	if [[ $var1 != y ]] then
   		echo exiting....
   		exit 0

        else

	sqlplus -s $admin_user/$admin_pwd <<EOF
	Delete from "$schema_name".Aclentries where ftgroup_id in 
	(select a.id from "$schema_name".ftgroup a, "$schema_name".ftuser b 
	where a.member = b.name and b.site_id = $2);

	Delete from "$schema_name".ftgroup where member in
	(select name from "$schema_name".ftuser where site_id = $2);

	Delete from "$schema_name".ftuser_to_disease where ftuser_id in
	(select id from "$schema_name".ftuser where site_id = $2);

	Delete from "$schema_name".ftuser where site_id = $2;

	Delete from "$schema_name".medical_record_number where patient_id in
	(select id from "$schema_name".patient where site_id = $2);

	Delete from "$schema_name".subject where patient_id in
	(select id from "$schema_name".patient where site_id = $2);

	Delete from "$schema_name".patient where site_id = $2;

	Delete from "$schema_name".site_to_trial where site_id = $2;

	Delete from "$schema_name".handheld_group_to_disease where handheld_group_id in 
	(select id from "$schema_name".handheld_group where site_id = $2);

	Delete from "$schema_name".handheld_device where handheld_group_id in 
	(select id from "$schema_name".handheld_group where site_id = $2);

	Delete from "$schema_name".handheld_group where site_id = $2;

	Delete from "$schema_name".site where id = $2;
        commit;
EOF

	fi

fi

if [[ $3 = restore ]] then

     valid_site_tmp=`sqlplus -s $admin_user/$admin_pwd <<EOF
     set heading off
     set feedback off
     select count(*) from deleted_sites.site where id=$2;
EOF`
     valid_site=`echo $valid_site_tmp`

     valid_site1_tmp=`sqlplus -s $admin_user/$admin_pwd <<EOF
     set heading off
     set feedback off
     select count(*) from "$schema_name".site where id=$2;
EOF`
     valid_site1=`echo $valid_site1_tmp`

     if [[ $valid_site -ne 1 ]] then
          echo This site_id has not been backed up.
          echo No backup exists to restore for the site_id $2
          exit 0   
     fi

     if [[ $valid_site1 -ne 0 ]] then
          echo This site_id already exists in $schema_name schema
          echo This site can not be restored
          exit 0   
     fi

	sqlplus -s $admin_user/$admin_pwd <<EOF

	Insert into "$schema_name".site select * from deleted_sites.site where id = $2;

	Insert into "$schema_name".handheld_group 
	select * from deleted_sites.handheld_group where site_id = $2;

	Insert into "$schema_name".handheld_device
	select * from deleted_sites.handheld_device where handheld_group_id in 
	(select id from deleted_sites.handheld_group where site_id = $2);

	Insert into "$schema_name".handheld_group_to_disease
	select * from deleted_sites.handheld_group_to_disease 
	where handheld_group_id in 
	(select id from deleted_sites.handheld_group where site_id = $2);

	Insert into "$schema_name".site_to_trial 
	select * from deleted_sites.site_to_trial where site_id = $2;

	Insert into "$schema_name".patient
	select * from deleted_sites.patient where site_id = $2;

	Insert into "$schema_name".subject
	select * from deleted_sites.subject where patient_id in
	(select id from deleted_sites.patient where site_id = $2);

	Insert into "$schema_name".medical_record_number
	select * from deleted_sites.medical_record_number where patient_id in
	(select id from deleted_sites.patient where site_id = $2);

	Insert into "$schema_name".ftuser 
	select * from deleted_sites.ftuser where site_id = $2;

	Insert into "$schema_name".ftuser_to_disease
	select * from deleted_sites.ftuser_to_disease where ftuser_id in
	(select id from deleted_sites.ftuser where site_id = $2);

	Insert into "$schema_name".ftgroup
	select * from deleted_sites.ftgroup where member in
	(select name from deleted_sites.ftuser where site_id = $2);

	Insert into "$schema_name".Aclentries
	select * from deleted_sites.Aclentries where ftgroup_id in 
	(select a.id from deleted_sites.ftgroup a, deleted_sites.ftuser b 
	where a.member = b.name and b.site_id = $2);
        commit;
EOF
fi

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  5    DevTSM    1.4         2/27/2008 3:22:34 PM Debashish Mishra  
#  4    DevTSM    1.3         3/3/2005 6:42:53 AM  Debashish Mishra  
#  3    DevTSM    1.2         12/26/2003 4:23:35 PMDebashish Mishra  
#  2    DevTSM    1.1         2/25/2003 12:33:12 PMDebashish Mishra  
#  1    DevTSM    1.0         8/1/2002 11:41:10 AM Debashish Mishra 
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsmreport5_US.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:49 PM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ $2 = '' ]] then

  echo 
  echo "usage : tsmreport5.ksh <master conect string> <build_tag_id>"
  echo "for example: tsmreport5.ksh tsm10/welcome@fasttrackdevl.world 3"
  echo
  exit 0
fi



CONNECT_STRING=$1
REPORT_HOME=/r/tsm_reports
ORACLE_HOME=/c/oracle/orareport


/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF >/c/tsm_reports/cntrylist.txt
set heading off
set pages 0
set feedback off

select distinct country_id
from institution
where country_id not in (select
id from country where abbreviation <> 'USA');

EOF


for cntryid in `cat /c/tsm_reports/cntrylist.txt`
do

cntry_name1=`/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off
select abbreviation from country where id=$cntryid;
EOF`

grosslen=`echo $cntry_name1 | wc -m`
netlen=`expr $grosslen - 2`


cntry_name=`echo $cntry_name1 | cut -c1-$netlen`

cntryid1=`echo $cntryid| awk '{print $1}'`

grosslen=`echo $cntryid1 | wc -m`
netlen=`expr $grosslen - 2`

cntryid2=`echo $cntryid1 | cut -c1-$netlen`

RWRUN60 "c:\tsm_reports\tsmreport5_4_US.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes ll="A" ul="D"

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/USA_A_C
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2/SitesByCountry/USA_A_C/

RWRUN60 "c:\tsm_reports\tsmreport5_4_US.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes ll="D" ul="M"

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/USA_D_L
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2//SitesByCountry/USA_D_L/

RWRUN60 "c:\tsm_reports\tsmreport5_4_US.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes ll="M" ul="R"

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/USA_M_Q
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2/SitesByCountry/USA_M_Q/


RWRUN60 "c:\tsm_reports\tsmreport5_4_US.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes ll="R" ul="ZZZZZZZ"

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/USA_R_Z
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2/SitesByCountry/USA_R_Z/

done

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:49 PM Debashish Mishra  
#  2    DevTSM    1.1         9/14/2007 2:28:52 PM Debashish Mishra  
#  1    DevTSM    1.0         6/18/2005 11:38:34 AMDebashish Mishra 
# $
# 
#############################################################

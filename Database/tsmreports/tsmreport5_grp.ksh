#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsmreport5_grp.ksh$ 
#
# $Revision: 2$        $Date: 2/27/2008 3:18:49 PM$
#
#
# Description:  <ADD>  ('IND','PAK','AUS','NZE')
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

select distinct parent_country_id from country where id in (
select country_id
from institution
where queriable=1 and country_id in (select
id from country where  
parent_country_id is not null));

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

RWRUN60 "c:\tsm_reports\tsmreport5_grp.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes countryid=$cntryid2

echo "SitesByCountry for $cntry_name ...."

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/$cntry_name
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2/SitesByCountry/$cntry_name

done



/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF >/c/tsm_reports/cntrylist.txt
set heading off
set pages 0
set feedback off

select id from country where abbreviation='IND' and
exists (select country_id from institution a, country b
where a.country_id=b.id and a.queriable=1 and b.abbreviation in ('IND','PAK'));

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

RWRUN60 "c:\tsm_reports\tsmreport5_grp_ind.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes countryid=$cntryid2

echo "SitesByCountry for $cntry_name ...."

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/$cntry_name
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2/SitesByCountry/$cntry_name

done

/c/oracle/ora920/bin/sqlplus -s $CONNECT_STRING << EOF >/c/tsm_reports/cntrylist.txt
set heading off
set pages 0
set feedback off

select id from country where abbreviation='AUS' and
exists (select country_id from institution a, country b
where a.country_id=b.id and a.queriable=1 and b.abbreviation in ('AUS','NZE'));

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

RWRUN60 "c:\tsm_reports\tsmreport5_grp_aus.rep" userid=$CONNECT_STRING \
mode=bitmap desformat=PDF destype=file desname="c:\tsm_reports\SitesByCountry.pdf" \
batch=yes countryid=$cntryid2

echo "SitesByCountry for $cntry_name ...."

mkdir -p $REPORT_HOME/build_tag_$2/SitesByCountry/$cntry_name
mv /c/tsm_reports/SitesByCountry.pdf $REPORT_HOME/build_tag_$2/SitesByCountry/$cntry_name

done


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  2    DevTSM    1.1         2/27/2008 3:18:49 PM Debashish Mishra  
#  1    DevTSM    1.0         9/14/2007 2:29:16 PM Debashish Mishra 
# $
# 
#############################################################

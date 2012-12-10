#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: tsmreport2.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:48 PM$
#
#
# Description:  <ADD>
#
#############################################################

if [[ $3 = '' ]] then

  echo 
  echo "usage : tsmreport2.ksh <client conect string> <build_tag_id> <client_identifier>"
  echo "for example: tsmreport2.ksh tsmclient_pkd_3/welcome@fasttrackdevl.world 3 PKD"
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

select distinct a.country_id
from ip_study_price a, indmap b
where a.indmap_id = b.id and
a.phase_id=0 and
b.type='Indication' and
b.id <> 0 and
a.company_pct50 is not null;

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


$ORACLE_HOME/bin/RWRUN60 "c:\tsm_reports\tsmreport2.rep" \
userid=$CONNECT_STRING mode=bitmap desformat=PDF destype=file \
desname="c:\tsm_reports\CPPByIndication.pdf" batch=yes countryid=$cntryid2

mkdir -p $REPORT_HOME/build_tag_$2/$3/$cntry_name
mv /c/tsm_reports/CPPByIndication.pdf $REPORT_HOME/build_tag_$2/$3/$cntry_name/CPPByIndication.pdf

done

#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:18:48 PM Debashish Mishra  
#  3    DevTSM    1.2         3/24/2005 10:33:34 AMDebashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:37:05 AM  Debashish Mishra  
#  1    DevTSM    1.0         4/11/2002 3:24:51 PM Debashish Mishra 
# $
# 
#############################################################

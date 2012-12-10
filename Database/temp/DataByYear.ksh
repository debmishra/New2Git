#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: DataByYear.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:12 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if [[ $4 = '' ]] then

  echo 
  echo "usage : DataByYear.ksh <old_client_name> <new_client_name> <dataset_type> <spec>"
  echo "for example: DataByYear.ksh TSM10_PKD_26 TSM10_PKD_28  ind_grant 2"
  echo
  exit 1
fi

CONNECT_STRING=tsm10/welcome@devl
REPORT_HOME=/c/reports/dby
ORACLE_HOME=/c/oracle/ora920


$ORACLE_HOME/bin/sqlplus -s $CONNECT_STRING << EOF >$REPORT_HOME/cntrylist.txt
set heading off
set pages 0
set feedback off

select distinct new.country 
FROM  "$1".data_by_year old, "$2".data_by_year new
WHERE   old.year = new.year AND
old.dataset_type='$3' AND old.dataset_type=new.dataset_type 
AND old.spec=$4 AND new.spec=old.spec;

EOF

$ORACLE_HOME/bin/sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off

drop synonym dby1;
drop synonym dby2;

create synonym dby1 for "$1".data_by_year;
create synonym dby2 for "$2".data_by_year;

create or replace function cum_cnt1(schemaname in varchar2, yr in number,
dstype in varchar2, spc in number, cntry in varchar2) return number is

CumCnt number(15);

begin

select sum(cnt) into CumCnt from dby1 where to_number(year)>= yr 
and dataset_type=dstype and spec=spc and country=cntry;

return(CumCnt);
end;
/

create or replace function cum_cnt2(schemaname in varchar2, yr in number,
dstype in varchar2, spc in number, cntry in varchar2) return number is

CumCnt number(15);

begin

select sum(cnt) into CumCnt from dby2 where to_number(year)>= yr 
and dataset_type=dstype and spec=spc and country=cntry;

return(CumCnt);
end;
/

EOF

rm -rf $REPORT_HOME/output
mkdir -p $REPORT_HOME/output


for cntryid in `cat $REPORT_HOME/cntrylist.txt`
do

WordLength=`echo $cntryid | wc -m`
ActualLength=`expr $WordLength - 2`
file_name=`echo $cntryid|cut -c1-$ActualLength`
touch $REPORT_HOME/output/$file_name.csv

echo "Report for Country: $file_name" >>$REPORT_HOME/output/$file_name.csv
echo " " >>$REPORT_HOME/output/$file_name.csv
echo ",Yearly Counts for Cutyear Procedures,,,,,Cumulative SUMS">>$REPORT_HOME/output/$file_name.csv
echo ",NEW,,OLD,,,NEW2,,OLD" >> $REPORT_HOME/output/$file_name.csv

$ORACLE_HOME/bin/sqlplus -s $CONNECT_STRING << EOF >>$REPORT_HOME/output/$file_name.csv
set heading off
set pages 0
set feedback off

SELECT 'the sum YR'||new.year||','||new.cnt||','||round(
(new.cnt/on_sum.new_sum)*100)||','||old.cnt||','||round(
(old.cnt/on_sum.old_sum)*100)||',,'||cum_cnt2('$2',to_number(new.year),
'$3',$4,'$file_name')||','||round(
(cum_cnt2('$2',to_number(new.year),
'$3',$4,'$file_name')/on_sum.new_sum)*100)||','||cum_cnt1('$1',to_number(old.year),
'$3',$4,'$file_name')||','||round(
(cum_cnt1('$1',to_number(old.year),'$3',$4,'$file_name')/on_sum.old_sum)*100)
FROM  "$1".data_by_year old, "$2".data_by_year new ,
(select sum(new.cnt) new_sum,sum(old.cnt) old_sum
FROM  "$1".data_by_year old, "$2".data_by_year new 
WHERE   old.year = NEW.year AND
old.dataset_type='$3' AND old.dataset_type=new.dataset_type 
AND old.spec=$4 AND new.spec=old.spec
and old.country='$file_name' and old.country=new.country) on_sum
WHERE old.year = new.year AND  
old.dataset_type='$3' AND old.dataset_type=new.dataset_type 
AND old.spec=$4 AND new.spec=old.spec
and old.country='$file_name' and old.country=new.country 
ORDER by new.year DESC;

EOF

echo " " >>$REPORT_HOME/output/$file_name.csv

$ORACLE_HOME/bin/sqlplus -s $CONNECT_STRING << EOF >>$REPORT_HOME/output/$file_name.csv
set heading off
set pages 0
set feedback off

select 'TOTAL'||','||sum(new.cnt)||',,'||sum(old.cnt)
FROM  "$1".data_by_year old, "$2".data_by_year new 
WHERE   old.year = NEW.year AND
old.dataset_type='$3' AND old.dataset_type=new.dataset_type 
AND old.spec=$4 AND new.spec=old.spec
and old.country='$file_name' and old.country=new.country;

EOF

done

$ORACLE_HOME/bin/sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off

drop function cum_cnt1;
drop function cum_cnt2;

drop synonym dby1;
drop synonym dby2;

EOF




#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:12 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:35:39 AM  Debashish Mishra  
#  1    DevTSM    1.0         2/28/2005 10:08:48 AMDebashish Mishra 
# $
# 
#############################################################

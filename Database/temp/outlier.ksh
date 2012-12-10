#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: outlier.ksh$ 
#
# $Revision: 4$        $Date: 2/27/2008 3:18:16 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if test $# -lt 4
then echo "Usage: outlier.ksh <userid1> <userid2> spec percentage"
exit
fi


CONNECT_STRING=tsm10/welcome@devl
OUTFILE=outlier${spec}.csv
spec=$3
percentage=$4

rm -rf $OUTFILE

sqlplus -s $CONNECT_STRING << EOF
set heading off
set pages 0
set feedback off

drop synonym pcpc1;
drop synonym pcpc2;

create synonym pcpc1 for "$1".pap_clinical_proc_cost;
create synonym pcpc2 for "$2".pap_clinical_proc_cost;


create or replace function num_rows(spc in number, abbr in varchar2) 
return number is

NumRows number(15);

begin

select count(*) into NumRows 
from pcpc1,country
where country_id=country.id and specificity=spc
and abbreviation=abbr;

return(NumRows);
end;
/

create or replace function num_rows_all(spc in number) 
return number is

NumRows number(15);

begin

select count(*) into NumRows 
from pcpc1
where  specificity=spc;

return(NumRows);
end;
/
EOF

echo Running $OUTFILE report...

echo "country, Total rows, #rows+/-, %,,#rows+,%rows+,#rows-,%rows-
" > $OUTFILE

sqlplus -s $CONNECT_STRING <<EOF >> $OUTFILE
  set pages 0
  set lin 300
  set hea off
  set feedback off
  column abbreviation format a3 
  
select x.abbreviation||','||x.numrows||','||(nvl(y.count1,0)+nvl(z.count2,0))||','||
round(((nvl(y.count1,0)+nvl(z.count2,0))/x.numrows)*100)||',,'||
nvl(y.count1,0)||','||round(((nvl(y.count1,0))/x.numrows)*100)||','||
nvl(z.count2,0)||','||
round(((nvl(z.count2,0))/x.numrows)*100)  from
  (select abbreviation,  num_rows($spec,abbreviation) numrows
  from pcpc1 a, pcpc2 b,country
  where a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  a.MAPPER_ID = b.MAPPER_ID and
  a.de_price = 0 and b.de_price=0 
  and a.specificity = $spec
  and a.country_id=country.id 
  and (round(((b.pct50-a.pct50)/a.pct50)*100) < -$percentage or
  round(((b.pct50-a.pct50)/a.pct50)*100) > $percentage )
  group by abbreviation) x,
  (select abbreviation,count(*) count1 from
  pcpc1 a, pcpc2 b,country where
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  a.MAPPER_ID = b.MAPPER_ID and
  a.de_price = 0 and b.de_price=0 
  and a.specificity = $spec
  and a.country_id=country.id 
  and round(((b.pct50-a.pct50)/a.pct50)*100) > $percentage
  group by abbreviation) y,
  (select abbreviation,count(*) count2 from
  pcpc1 a, pcpc2 b,country where
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  a.MAPPER_ID = b.MAPPER_ID and
  a.de_price = 0 and b.de_price=0 
  and a.specificity = $spec
  and a.country_id=country.id 
  and round(((b.pct50-a.pct50)/a.pct50)*100) < -$percentage
  group by abbreviation) z
  where x.abbreviation=y.abbreviation(+) and
  x.abbreviation=z.abbreviation(+);
EOF

echo " " >> $OUTFILE

sqlplus -s $CONNECT_STRING <<EOF >> $OUTFILE
  set pages 0
  set lin 300
  set hea off
  set feedback off
  column abbreviation format a3 

  select 'ALL,'||x.numrows||','||(nvl(y.count1,0)+nvl(z.count2,0))||','||
  round(((nvl(y.count1,0)+nvl(z.count2,0))/x.numrows)*100)||',,'||
  nvl(y.count1,0)||','||
  round(((nvl(y.count1,0))/x.numrows)*100)||','||nvl(z.count2,0)||','||
  round(((nvl(z.count2,0))/x.numrows)*100) from
  (select num_rows_all($spec) numrows
  from dual) x,
  (select count(*) count1 from
  pcpc1 a, pcpc2 b,country where
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  a.MAPPER_ID = b.MAPPER_ID and
  a.de_price = 0 and b.de_price=0 
  and a.specificity = $spec
  and a.country_id=country.id 
  and round(((b.pct50-a.pct50)/a.pct50)*100) > $percentage) y,
  (select count(*) count2 from
  pcpc1 a, pcpc2 b,country where
  a.COUNTRY_ID = b.COUNTRY_ID and
  a.INDMAP_ID = b.INDMAP_ID and
  a.PHASE_ID = b.PHASE_ID and
  a.MAPPER_ID = b.MAPPER_ID and
  a.de_price = 0 and b.de_price=0 
  and a.specificity = $spec
  and a.country_id=country.id 
  and round(((b.pct50-a.pct50)/a.pct50)*100) < -$percentage) z; 
EOF

sqlplus -s $CONNECT_STRING <<EOF 
  set pages 0
  set hea off
  set feedback off 

drop function num_rows;
drop function num_rows_all;

drop synonym pcpc1;
drop synonym pcpc2;
EOF





#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  4    DevTSM    1.3         2/27/2008 3:18:16 PM Debashish Mishra  
#  3    DevTSM    1.2         3/3/2005 6:36:02 AM  Debashish Mishra  
#  2    DevTSM    1.1         8/3/2004 12:35:29 PM Debashish Mishra updated the
#       script  as required
#  1    DevTSM    1.0         8/2/2004 10:34:09 AM Kelly Kingdon   
# $
# 
#############################################################

#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: top_proc.ksh$ 
#
# $Revision: 3$        $Date: 2/27/2008 3:18:17 PM$
#
#
# Description:  <ADD>
#
#############################################################
 
if test $# -lt 1
then echo "Usage: top_proc.ksh <client_schema_name>"
exit
fi


CONNECT_STRING=tsm10/welcome@devl
OUTFILE=top_proc.csv

clientdiv_identifier=`echo $1|cut -f 2 -d "_"`
clientdiv_id1=`sqlplus -s $CONNECT_STRING <<EOF
  set pages 0
  set hea off
  set feedback off
select id from client_div where 
client_div_identifier='$clientdiv_identifier';
EOF`

clientdiv_id=`echo $clientdiv_id1`
echo $clientdiv_id

rm -rf $OUTFILE

echo Running $OUTFILE report...

echo "Procedure code,times_used,percentage,year" > $OUTFILE

sqlplus -s $CONNECT_STRING <<EOF >> $OUTFILE
  set pages 0
  set lin 300
  set hea off
  set feedback off

select zz.cpt_code||','||x.times_used||','||
round((x.times_used/z.tot)*100)||','||y.ind_year from
(select a.procedure_def_id, count(*) times_used 
from cost_item a, trial_budget b, trial c where
a.trial_budget_id=b.id and b.trial_id=c.id and
c.client_div_id=$clientdiv_id
group by a.procedure_def_id) x,
(SELECT r.id,p.ind_year FROM
"$1".pap_clinical_proc_cost p,
"$1".mapper q,procedure_def r 
WHERE r.id=q.procedure_def_id AND
q.id=p.mapper_id AND 
p.country_id=24 and
p.phase_id=0 and
p.indmap_id=0) y,
(select count(*) tot from cost_item a,trial_budget b, trial c where
a.trial_budget_id=b.id and b.trial_id=c.id and
c.client_div_id=$clientdiv_id) z,
procedure_def zz
where
x.procedure_def_id=y.id(+) AND
x.procedure_def_id=zz.id(+)
order by x.times_used desc;

EOF

echo " " >> $OUTFILE

sqlplus -s $CONNECT_STRING <<EOF >> $OUTFILE
  set pages 0
  set lin 300
  set hea off
  set feedback off
select 'Total:,'||count(*) from cost_item  a,trial_budget b, trial c 
where a.trial_budget_id=b.id and b.trial_id=c.id and
c.client_div_id=$clientdiv_id;

EOF





#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         2/27/2008 3:18:17 PM Debashish Mishra  
#  2    DevTSM    1.1         3/3/2005 6:36:05 AM  Debashish Mishra  
#  1    DevTSM    1.0         8/3/2004 2:28:47 PM  Debashish Mishra 
# $
# 
#############################################################

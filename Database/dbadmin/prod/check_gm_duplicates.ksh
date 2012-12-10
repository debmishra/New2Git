. /etc/profile
cd ~oracle
. ./.profile

ORACLE_USER=dmishra
ORACLE_PWD=`get_pwd $ORACLE_USER`

sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
truncate table dmishra.xyz;
insert into dmishra.xyz
select distinct d.client_div_id from tsm10.picas_visit_to_cost_item a, tsm10.picas_visit b, tsm10.trial_budget c,
tsm10.trial d  where
a.picas_visit_id=b.id and b.trial_budget_id=c.id and
c.trial_id=d.id
and (a.picas_visit_id,a.cost_item_id) in
(select f.picas_visit_id,f.cost_item_id from tsm10.picas_visit_to_cost_item f
group by f.picas_visit_id,f.cost_item_id having count(distinct f.frequency) > 1);
exit;
EOF


var1=`sqlplus -s $ORACLE_USER/$ORACLE_PWD << EOF
set feedback off
set pages 0
set heading off
set echo off
select count(count(*)) from tsm10.picas_visit_to_cost_item p
where p.id > 6097792 AND NOT EXISTS
(SELECT 1 FROM tsm10.picas_visit q, tsm10.trial_budget r, tsm10.trial s
WHERE p.picas_visit_id=q.id AND q.trial_budget_id=r.id AND r.trial_id=s.id
AND s.client_div_id IN
(select client_div_id from dmishra.xyz))
group by picas_visit_id, cost_item_id having count(*) > 1;
EOF`
var2=`echo $var1`
echo "var2 is: $var2"

echo "$var2 duplicate row(s) found" | mailx -s dup_rows dmishra@mdsol.com
echo "$var2 duplicate row(s) found" | mailx -s dup_rows pservedio@mdsol.com
echo "$var2 duplicate row(s) found" | mailx -s dup_rows ttang@mdsol.com

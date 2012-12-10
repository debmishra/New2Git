130Training

SELECT x.username,
Decode(y.TRIAL_BUDGET_EXISTS,NULL,'NO',y.TRIAL_BUDGET_EXISTS) TRIAL_BUDGET_EXISTS, 
decode(z.CURRENT_release,x.username,'YES','NO') current_release,
decode(zz.username,null,'NO','YES') latest_release
from (SELECT username FROM all_users WHERE username LIKE 'TSM10E______%') x,
(SELECT distinct 'TSM10E_'||c.client_div_identifier||'_'||a.build_tag_id  username,
'YES' TRIAL_BUDGET_EXISTS 
FROM tsm10e.trial_budget a, ft15e.trial b, tsm10e.client_div c
WHERE a.trial_id=b.id AND
b.client_div_id=c.id) y,
(SELECT 'TSM10E_'||client_div_identifier||'_'||build_tag_id  current_release
FROM client_div) z,
(select clientdiv||maxbuildtagid username from
(select clientdiv, max(buildtagid) maxbuildtagid from
(select substr(username,1,instr(username,'_',1,2)) clientdiv,
to_number(substr(username,instr(username,'_',1,2)+1)) buildtagid from all_users) 
where clientdiv like 'TSM10E%'
group by clientdiv)) zz
WHERE x.username=y.username(+) AND
SubStr(x.username,1,10)=SubStr(z.current_release,1,10) and
x.username=zz.username(+)
and Decode(y.TRIAL_BUDGET_EXISTS,NULL,'NO',y.TRIAL_BUDGET_EXISTS)='NO'
and decode(z.CURRENT_release,x.username,'YES','NO')='NO'
and decode(zz.username,null,'NO','YES') = 'NO'
ORDER BY 1;

130 PROD
=========

SELECT x.username,
Decode(y.TRIAL_BUDGET_EXISTS,NULL,'NO',y.TRIAL_BUDGET_EXISTS) TRIAL_BUDGET_EXISTS, 
decode(z.CURRENT_release,x.username,'YES','NO') current_release,
decode(zz.username,null,'NO','YES') latest_release
from (SELECT username FROM all_users WHERE username LIKE 'TSM10______%') x,
(SELECT distinct 'TSM10_'||c.client_div_identifier||'_'||a.build_tag_id  username,
'YES' TRIAL_BUDGET_EXISTS 
FROM tsm10.trial_budget a, ft15.trial b, tsm10.client_div c
WHERE a.trial_id=b.id AND
b.client_div_id=c.id) y,
(SELECT 'TSM10_'||client_div_identifier||'_'||build_tag_id  current_release
FROM client_div) z,
(select clientdiv||maxbuildtagid username from
(select clientdiv, max(buildtagid) maxbuildtagid from
(select substr(username,1,instr(username,'_',1,2)) clientdiv,
to_number(substr(username,instr(username,'_',1,2)+1)) buildtagid from all_users) 
where clientdiv like 'TSM10%'
group by clientdiv)) zz
WHERE x.username=y.username(+) AND
SubStr(x.username,1,10)=SubStr(z.current_release,1,10) and
x.username=zz.username(+)
and Decode(y.TRIAL_BUDGET_EXISTS,NULL,'NO',y.TRIAL_BUDGET_EXISTS)='NO'
and decode(z.CURRENT_release,x.username,'YES','NO')='NO'
and decode(zz.username,null,'NO','YES') = 'NO'
and x.username not like 'TSM10E%'
ORDER BY 1;
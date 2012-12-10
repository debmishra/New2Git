SELECT decode(x.app_type,'CROCAS','CRO Contractor','GMOWN','GM Analysis','PBTOWN','CRO Contractor Analysis',
'PICASE','Grants Manager','TSN','GM Contracting',x.app_type),To_Char(x.monyr,'Mon-YY'),x.num_usr, x.tot_login,x.tot_clients,y.num_trial 
from
(SELECT app_type, Trunc(modify_date,'MM') monyr,Count(DISTINCT ftuser_id) num_usr, Count(*) tot_login, Count(DISTINCT b.client_div_id) tot_clients
FROM audit_hist a, ftuser b, client_div c
WHERE a.ftuser_id=b.id AND b.client_div_id=c.id AND   a.action ='auditAction.login_succeeded' AND a.modify_date >= Trunc(SYSDATE-365,'YYYY')
   AND c.client_div_identifier NOT LIKE 'FT%'   AND c.client_div_identifier <> 'MDT' AND b.NAME NOT LIKE 'fasttrack%'  AND a.app_type <>'TSPD'
GROUP BY app_type, Trunc(modify_date,'MM')
ORDER BY 1,2) X,
(SELECT app_type, Trunc(modify_date,'MM') monyr , Count(*) num_trial
FROM audit_hist a, ftuser b, client_div c
WHERE a.ftuser_id=b.id AND b.client_div_id=c.id AND   a.action ='auditAction.trialNewlyCreated' AND a.modify_date >= Trunc(SYSDATE-365,'YYYY')
   AND c.client_div_identifier NOT LIKE 'FT%'   AND c.client_div_identifier <> 'MDT' AND b.NAME NOT LIKE 'fasttrack%'  AND a.app_type <>'TSPD'
GROUP BY app_type, Trunc(modify_date,'MM')
ORDER BY 1,2) Y
WHERE x.app_type=y.app_type(+) AND x.monyr=y.monyr(+)

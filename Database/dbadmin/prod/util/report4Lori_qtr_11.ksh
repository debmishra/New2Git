#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: c:\tsm\Database\dbadmin\prod\util\report4Lori_qtr_11.ksh$ 
#
# $Revision: 1$        $Date: 6/7/2011 10:09:15 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com"
#mailinglist="dmishra@mdsol.com"
cclist="dmishra@mdsol.com"
sender="noreply@mdsol.com"

export ORACLE_SID=prod
sqlplus -s tsm10/`get_pwd tsm10` <<EOF 

create function lori_report_cro_lic_country (ClientDivId in number)
return varchar2 is
cntrylist varchar2(1024):=null;
cursor C1 is select a.abbreviation abv from country a, cro_client_div_to_lic_country b
             where a.id=b.country_id and b.client_div_id=ClientDivId order by 1;
begin
 for ix1 in c1 loop
    cntrylist:=cntrylist||' '||ix1.abv;
 end loop;
return(substr(cntrylist,2));
end;
/
sho err


set feedback off
set lin 300
set pages 1000
set heading off

spool /export/home/oracle/log/Report4Lori_qtr_11.txt
select '"Quarterly build report of all clients (including old clients)"' from dual;
select 'client'||','||'Version'||','||'Build'||','||'License Expires'||','||'License Countries'
from dual;

select a.client_div_identifier||','||c.frontend_version||','||c.version||','||
to_char(c.license_exp_date,'mm-dd-yyyy')||','||lori_report_cro_lic_country(a.id)
from client_div a, client_div_to_lic_app c
where 
a.id=c.client_div_id and
c.app_name = 'CROCAS' 
order by a.client_div_identifier;


set heading on

spool off
drop function lori_report_cro_lic_country;

exit;
EOF


cat /export/home/oracle/log/Report4Lori_qtr_11.txt|grep -v ^$|mailx -s "CROCAS quarterly all client build report" -r $sender -c $cclist $mailinglist


#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  1    DevTSM    1.0         6/7/2011 10:09:15 PM Debashish Mishra 
# $
# 
#############################################################

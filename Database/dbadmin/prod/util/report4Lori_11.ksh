#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_11.ksh$ 
#
# $Revision: 3$        $Date: 6/7/2011 10:05:18 PM$
#
#
# Description:  <ADD>
#
#############################################################
cd /export/home/oracle
. /etc/profile
. ./.profile

mailinglist="trialplanning@mdsol.com,spepe@mdsol.com,joschwartz@mdsol.com"
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

spool /export/home/oracle/log/Report4Lori_11.txt
select 'client'||','||'Version'||','||'Build'||','||'License Expires'||','||'License Countries'
from dual;

select a.client_div_identifier||','||c.frontend_version||','||c.version||','||
to_char(c.license_exp_date,'mm-dd-yyyy')||','||lori_report_cro_lic_country(a.id)
from client_div a, client_div_to_lic_app c
where 
a.id=c.client_div_id and
c.app_name = 'CROCAS' and c.license_exp_date > sysdate
order by a.client_div_identifier;


set heading on

spool off
drop function lori_report_cro_lic_country;

exit;
EOF


cat /export/home/oracle/log/Report4Lori_11.txt|grep -v ^$|mailx -s "CROCAS client build report" -r $sender -c $cclist $mailinglist

#cat /export/home/oracle/log/Report4Lori_11.txt|grep -v ^$|mailx -s "CROCAS client build report" dmishra@fast-track.com



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  3    DevTSM    1.2         6/7/2011 10:05:18 PM Debashish Mishra  
#  2    DevTSM    1.1         8/11/2009 12:03:30 AMDebashish Mishra  
#  1    DevTSM    1.0         9/3/2008 12:02:08 PM Debashish Mishra 
# $
# 
#############################################################

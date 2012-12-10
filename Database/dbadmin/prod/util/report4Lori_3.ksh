#!/bin/ksh
#
#
# This program is the confidential and proprietary product of 
# Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
# or transfer of this program is strictly prohibited.  
# Copyright (C) 2000 by Fast Track Systems, Inc.  
# All rights reserved.
# 
# $Workfile: report4Lori_3.ksh$ 
#
# $Revision: 11$        $Date: 6/7/2011 10:05:19 PM$
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

create function lori_report_lic_country (ClientDivId in number)
return varchar2 is
cntrylist varchar2(1024):=null;
cursor C1 is select a.abbreviation abv from country a, client_div_to_lic_country b
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

spool /export/home/oracle/log/Report4Lori_3.txt
select 'client'||','||'Version'||','||'Build'||','||'Data Built'||','||'Exchange Rate'||','||'License Expires'||','||'License Countries'
from dual;

select a.client_div_identifier||','||c.frontend_version||','||c.version||','||to_char
(b.tag_date,'mm-dd-yyyy')||','||d.exchange_rate||','||to_char
(c.license_exp_date,'mm-dd-yyyy')||','||lori_report_lic_country(a.id)
from client_div a, build_tag b, client_div_to_lic_app c, 
(select to_char(tag_date,'mm-dd-yyyy') exchange_rate from build_tag 
where id in (select max(id) from build_tag)) d
where a.build_tag_id=b.id and
a.id=c.client_div_id and
c.app_name = 'PICASE' and c.license_exp_date > sysdate 
order by a.client_div_identifier;


set heading on

spool off
drop function lori_report_lic_country;

exit;
EOF


cat /export/home/oracle/log/Report4Lori_3.txt|grep -v ^$|mailx -s "Production client build report" -r $sender -c $cclist $mailinglist

#cat /export/home/oracle/log/Report4Lori_3.txt|grep -v ^$|mailx -s "Production client build report" dmishra@fast-track.com



#############################################################
# MODIFICATION HISTORY:
#
# $Log: 
#  11   DevTSM    1.10        6/7/2011 10:05:19 PM Debashish Mishra  
#  10   DevTSM    1.9         8/11/2009 12:03:31 AMDebashish Mishra  
#  9    DevTSM    1.8         9/3/2008 11:58:50 AM Debashish Mishra  
#  8    DevTSM    1.7         2/27/2008 3:21:52 PM Debashish Mishra  
#  7    DevTSM    1.6         9/6/2006 9:49:59 PM  Debashish Mishra  
#  6    DevTSM    1.5         3/15/2005 7:16:39 PM Debashish Mishra  
#  5    DevTSM    1.4         3/3/2005 6:44:59 AM  Debashish Mishra  
#  4    DevTSM    1.3         10/13/2004 8:01:27 AMDebashish Mishra  
#  3    DevTSM    1.2         8/4/2004 2:39:20 PM  Debashish Mishra  
#  2    DevTSM    1.1         2/12/2004 10:40:37 AMDebashish Mishra  
#  1    DevTSM    1.0         1/12/2004 2:10:46 PM Debashish Mishra 
# $
# 
#############################################################

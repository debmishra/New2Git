--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_4_joels_Installshield.sql$ 
--
-- $Revision: 9$        $Date: 2/22/2008 11:56:01 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
-- Following chnages are as per the request of Joel for 
-- the new exe file to replace webstart on 01/28/2003

Alter table client_div_to_lic_app add (frontend_version  varchar2(30));


conn ftcommon/****@????

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,'tsm10' environment 
from tsm10.CLIENT_DIV_TO_LIC_APP;

conn tsm10/*****@?????

-- Following chnages are as per the request of Joel for 
-- the new exe file to replace webstart on 02/06/2003

Alter table client_div add (using_webstart NUMBER(1) default 1 not null);

Alter table client_div_to_lic_app add (patch_available NUMBER(1) default 0 not null);

create or replace view client_div as select
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,'tsm10' environment from tsm10.client_div;

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,
'tsm10' environment 
from tsm10.CLIENT_DIV_TO_LIC_APP;



--**********************************************************
--updated upto this in tsm10@test on 02/12/2003
--updated upto this in tsm10e@test on 03/06/2003
--updated upto this in tsm10p@prev on 03/24/2003
--updated upto this in tsm10e@prev on 03/26/2003
--updated upto this in tsm10,tsm10e,tsm10d@prod on 03/28/2003
--***********************************************************




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/22/2008 11:56:01 AMDebashish Mishra  
--  8    DevTSM    1.7         9/19/2006 12:11:26 AMDebashish Mishra   
--  7    DevTSM    1.6         3/2/2005 10:50:59 PM Debashish Mishra  
--  6    DevTSM    1.5         8/29/2003 5:17:42 PM Debashish Mishra  
--  5    DevTSM    1.4         3/28/2003 4:06:26 PM Debashish Mishra  
--  4    DevTSM    1.3         3/27/2003 4:56:47 PM Debashish Mishra  
--  3    DevTSM    1.2         3/26/2003 10:04:19 AMDebashish Mishra  
--  2    DevTSM    1.1         3/6/2003 6:53:53 PM  Debashish Mishra  
--  1    DevTSM    1.0         2/19/2003 1:48:30 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

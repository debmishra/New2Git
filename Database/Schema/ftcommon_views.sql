--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: ftcommon_views.sql$ 
--
-- $Revision: 12$        $Date: 2/22/2008 11:55:25 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
create or replace view ftuser as select 
ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,
ACTIVE_TSM_USER,old_password,ACTIVE_TSPD_USER,DEF_PLAN_CURRENCY_ID,
locked,failed_login_attempts,'tsm10' environment from ft15.ftuser;

create or replace view ftgroup as select
id, name,'tsm10' environment from ft15.ftgroup;


create or replace view ftuser_to_ftgroup as select
id,ftuser_id,ftgroup_id,'tsm10' environment from 
ft15.ftuser_to_ftgroup;

create or replace view client_div as select
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,TSPD_BUILD_TAG_ID,
'tsm10' environment from tsm10.client_div;

create or replace view CLIENT_DIV_TO_LIC_APP as select
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,
'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP;


create or replace view ftuser_to_client_group as select
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10' environment from tsm10.ftuser_to_client_group;

create or replace view password_rule as
select ID,CLIENT_DIV_ID,USERNAME_MIN_CHARS,USERNAME_MAX_CHARS,
PASSWORD_MIN_CHARS,PASSWORD_MAX_CHARS,PASSWORD_HAS_NUMERIC,
PASSWORD_VALID_DAYS,PASSWORD_NTFY_USER_DAYS,PASSWORD_ALLOW_REUSE_DAYS,
LOCKOUT_INACTIVITY_DAYS,LOCKOUT_LOGIN_ATTEMPTS,
'tsm10' environment from tsm10.password_rule;











exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  12   DevTSM    1.11        2/22/2008 11:55:25 AMDebashish Mishra  
--  11   DevTSM    1.10        9/19/2006 12:11:02 AMDebashish Mishra   
--  10   DevTSM    1.9         3/2/2005 10:48:56 PM Debashish Mishra  
--  9    DevTSM    1.8         11/16/2004 12:38:31 AMDebashish Mishra  
--  8    DevTSM    1.7         4/8/2004 4:09:29 PM  Debashish Mishra  
--  7    DevTSM    1.6         8/29/2003 5:15:48 PM Debashish Mishra  
--  6    DevTSM    1.5         4/7/2003 10:15:19 AM Debashish Mishra Colin's
--       ftadmin and Joel's installshield changes
--  5    DevTSM    1.4         2/19/2003 1:48:15 PM Debashish Mishra  
--  4    DevTSM    1.3         9/23/2002 11:34:17 AMDebashish Mishra  
--  3    DevTSM    1.2         9/13/2002 2:47:53 PM Debashish Mishra New column
--       client_div_to_lic_app.version
--  2    DevTSM    1.1         9/12/2002 9:05:55 AM Debashish Mishra New views in
--       ftcommon
--  1    DevTSM    1.0         8/20/2002 12:47:52 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

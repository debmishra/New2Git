create or replace view CLIENT_DIV as                                                                     
select                                                                          
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                          
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,                          
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,                                             
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,                 
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,null TSPD_BUILD_TAG_ID,                                          
'tsm10' environment from tsm10.client_div                                       
union all select                                                                
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                          
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,                          
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,                                             
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,                 
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,null,                                         
'tsm10d' environment from tsm10d.client_div                                     
union all select                                                                
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                          
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,                          
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,                                             
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,                 
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,null,                                          
'tsm10e' environment from tsm10e.client_div 
union all select
ID,CLIENT_ID,NAME,DEF_COUNTRY_ID,DEF_PLAN_CURRENCY_ID,                          
DEF_OVERHEAD_PCT,DEF_BUDGET_TYPE,CLIENT_DIV_IDENTIFIER,                         
STARTING_VIEW,COUNTRY_ID,BUILD_TAG_ID,USE_OWN_CNV_FLG,                          
DEF_PRICE_RANGE,LOGON_TIMEOUT_SECS,                                             
ISO_LANG,USING_WEBSTART,G50_COL_ENABLED,G50_HDNG,G50_SPEC_HDNG,                 
G50_PCKLST_DESC,ALLOW_CREATE_UNLISTED,TSPD_BUILD_TAG_ID,                                          
'tsm10t' environment from tsm10t.client_div;                                     
                                                                                
create or replace view CLIENT_DIV_TO_LIC_APP as                                                           
select                                                                          
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,                                     
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,                  
PATCH_VERSION,'tsm10' environment from tsm10.CLIENT_DIV_TO_LIC_APP              
union all select                                                                
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,                                     
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,                  
PATCH_VERSION,'tsm10d' environment from tsm10d.CLIENT_DIV_TO_LIC_APP            
union all select                                                                
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,                                     
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,                  
PATCH_VERSION,'tsm10e' environment from tsm10e.CLIENT_DIV_TO_LIC_APP            
union all select                                                                
ID,CLIENT_DIV_ID,APP_NAME,LICENSE_EXP_DATE,                                     
PRINCIPAL_CONTACT_ID,VERSION,frontend_version,patch_available,                  
PATCH_VERSION,'tsm10t' environment from tsm10t.CLIENT_DIV_TO_LIC_APP;


                                                                                
create or replace view FTGROUP as                                                                         
select                                                                          
id, name,'tsm10' environment from ft15.ftgroup                                  
union all select                                                                
id, name,'tsm10d' environment from ft15d.ftgroup                                
union all select                                                                
id, name,'tsm10e' environment from ft15e.ftgroup;                                
                                                                                
create or replace view FTUSER as                                                                          
select                                                                          
ID,NAME||'@tsm10' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE,  
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,              
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,                       
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,                      
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,                         
ACTIVE_TSM_USER,CAN_MODEL_FLAG,DEF_PLAN_CURRENCY_ID,null OLD_PASSWORD,           
null ACTIVE_TSPD_USER,null LOCKED,                            
'tsm10' environment from ft15.ftuser                                            
union all select                                                                
ID,NAME||'@tsm10d' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE, 
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,              
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,                       
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,                      
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,                         
ACTIVE_TSM_USER,CAN_MODEL_FLAG,DEF_PLAN_CURRENCY_ID,null,
null,null,                           
'tsm10d' environment from ft15d.ftuser                                          
union all select                                                                
ID,NAME||'@tsm10e' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE, 
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,              
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,                       
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,                      
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,                         
ACTIVE_TSM_USER,CAN_MODEL_FLAG,DEF_PLAN_CURRENCY_ID,null,
null,null,                            
'tsm10e' environment from ft15e.ftuser 
union all select                                                                
ID,NAME||'@tsm10t' name ,PASSWORD,SITE_ID,STARTING_SCREEN,LAST_PASSWORD_UPDATE, 
FIRST_NAME,LAST_NAME,LAST_LOGIN_DATE,PRIMARY_TA_ID,ADDRESS_LINE_1,              
ADDRESS_LINE_2,CITY,STATE,POSTAL_CODE,COUNTRY,WORK_PHONE,                       
HOME_PHONE,FAX,MOBILE_PHONE,EMAIL,PREFERRED_CONTACT,TITLE,                      
CLIENT_ID,CLIENT_DIV_ID,DISPLAY_NAME,ACTIVE_TRACE_USER,                         
ACTIVE_TSM_USER,CAN_MODEL_FLAG,DEF_PLAN_CURRENCY_ID,OLD_PASSWORD,           
ACTIVE_TSPD_USER,LOCKED,                             
'tsm10t' environment from ft15t.ftuser; 
                                                                                
create or replace view FTUSER_TO_CLIENT_GROUP as                                                          
select                                                                          
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10' environment from tsm10.ftuser_to_client_group                                                                              
union all select                                                                
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10d' environment from tsm10d.ftuser_to_client_group                                                                            
union all select                                                                
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10e' environment from tsm10e.ftuser_to_client_group   
union all select                                                                
ID,CLIENT_GROUP_ID,FTUSER_ID,'tsm10t' environment from tsm10t.ftuser_to_client_group;                                                                         
                                                                                
create or replace view FTUSER_TO_FTGROUP as                                                               
select                                                                          
id,ftuser_id,ftgroup_id,'tsm10' environment from                                
ft15.ftuser_to_ftgroup                                                          
union all select                                                                
id,ftuser_id,ftgroup_id,'tsm10d' environment from                               
ft15d.ftuser_to_ftgroup                                                         
union all select                                                                
id,ftuser_id,ftgroup_id,'tsm10e' environment from                               
ft15e.ftuser_to_ftgroup    
union all select                                                                
id,ftuser_id,ftgroup_id,'tsm10t' environment from                               
ft15t.ftuser_to_ftgroup;                                                      

                                                                                
create or replace view PASSWORD_RULE as                                                                   
select ID,CLIENT_DIV_ID,USERNAME_MIN_CHARS,USERNAME_MAX_CHARS,                  
PASSWORD_MIN_CHARS,PASSWORD_MAX_CHARS,PASSWORD_HAS_NUMERIC,                     
PASSWORD_VALID_DAYS,PASSWORD_NTFY_USER_DAYS,PASSWORD_ALLOW_REUSE_DAYS,          
LOCKOUT_INACTIVITY_DAYS,LOCKOUT_LOGIN_ATTEMPTS,                                 
'tsm10t' environment from tsm10t.password_rule;

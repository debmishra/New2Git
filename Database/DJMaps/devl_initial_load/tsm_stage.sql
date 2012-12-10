--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm_stage.sql$ 
--
-- $Revision: 11$        $Date: 2/27/2008 3:16:47 PM$
--
--
-- Description:  Data Processing in TSM_STAGE
--
---------------------------------------------------------------------
 
conn ft15/welcome

grant select on ft15.client to tsm_stage;

conn tsm_stage/welcome

create table tsm_stage.client as select id,name,main_contact_id,
        client_identifier,
	client_acronym,de_acronym from ft15.client where
	upper(name) like '%AMGEN%' or id=0;


@static_data_currency
@static_data_country
@static_data_local_to_euro
@static_data_client
@static_data_phase
@static_data_client_div

@country_differential
@currency_differential

--@country
--@country2
--@phase
@build_code
@indmap

@static_data_lic_country
@static_data_lic_phase
@static_data_lic_indmap
@static_data_cd2bc

@industry_build_required_data

@pap_euro_overhead
@affiliation_factor
@ip_duration_factor
@ip_weight
@ip_cpp
@ip_duration
@ip_business_factors
@region
@institution
@procedure_def
@odc_def
@mapper
--@client
@protocol
@investig
@payments
@protocol_to_indmap
@report_template
@study_level_service_master
@study_level_service_inst
@price_level
@pap_odc_pct
@procedure_to_protocol
@euro_updates



-- Carry out a manual check for the conversion rates
 




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  11   DevTSM    1.10        2/27/2008 3:16:47 PM Debashish Mishra  
--  10   DevTSM    1.9         3/3/2005 6:39:39 AM  Debashish Mishra  
--  9    DevTSM    1.8         8/29/2003 5:12:22 PM Debashish Mishra  
--  8    DevTSM    1.7         3/18/2002 7:42:24 PM Debashish Mishra  
--  7    DevTSM    1.6         3/14/2002 12:11:02 PMDebashish Mishra  
--  6    DevTSM    1.5         3/12/2002 4:40:13 PM Debashish Mishra  
--  5    DevTSM    1.4         2/21/2002 3:32:28 PM Debashish Mishra  
--  4    DevTSM    1.3         2/18/2002 5:07:15 PM Debashish Mishra  
--  3    DevTSM    1.2         2/7/2002 3:10:18 PM  Debashish Mishra  
--  2    DevTSM    1.1         2/4/2002 6:16:50 PM  Debashish Mishra  
--  1    DevTSM    1.0         1/24/2002 6:33:47 PM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

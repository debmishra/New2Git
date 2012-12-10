--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_grants_given_to_tspd_dataset.sql$ 
--
-- $Revision: 9$        $Date: 2/27/2008 3:18:01 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 

grant select,references on indmap to "&1";
grant select,references on phase to "&1";
grant select,references on procedure_def to "&1";
grant select,references on mapper to "&1";
grant select,references on protocol to "&1";
grant select,references on procedure_to_protocol to "&1";
grant select,references on protocol_to_indmap to "&1";
grant select,references on odc_def to "&1";
grant select,references on investig to "&1";
grant select,references on payments to "&1";
grant select,references on country to "&1";
grant select,references on currency to "&1";
grant select,references on ft_foreign_key_info to "&1";
grant select,references on build_tag to "&1";
grant select,references on price_level to "&1";

exit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  9    DevTSM    1.8         2/27/2008 3:18:01 PM Debashish Mishra  
--  8    DevTSM    1.7         3/3/2005 6:34:45 AM  Debashish Mishra  
--  7    DevTSM    1.6         7/10/2003 3:18:22 PM Debashish Mishra Added grants
--       for price level
--  6    DevTSM    1.5         7/7/2003 8:57:36 AM  Debashish Mishra grants for
--       build_tag
--  5    DevTSM    1.4         7/7/2003 8:12:13 AM  Debashish Mishra Added grants
--       for ft_foreign_key_info
--  4    DevTSM    1.3         7/3/2003 4:26:16 PM  Debashish Mishra added grants,
--       synonyms for country and currency
--  3    DevTSM    1.2         7/3/2003 9:49:20 AM  Debashish Mishra Added grants,
--       synonyms for Investig and payments
--  2    DevTSM    1.1         6/30/2003 10:28:41 AMDebashish Mishra Added grants
--       for protocol,procedure_to_protocol,protocol_to_indmap and created
--       sysnonyms, created new mapper table modified procedure_def_id to mapper_id
--       in tspd_proc_freq table
--  1    DevTSM    1.0         6/13/2003 10:01:29 AMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tspd_dataset_synonyms.sql$ 
--
-- $Revision: 10$        $Date: 2/27/2008 3:18:01 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
drop synonym odc_def;
drop synonym phase;
drop synonym procedure_def;
drop synonym indmap;
drop synonym protocol;
drop synonym procedure_to_protocol;
drop synonym protocol_to_indmap;
drop synonym investig;
drop synonym payments;
drop synonym country;
drop synonym currency;
drop synonym ft_foreign_key_info;
drop synonym build_tag;
drop synonym price_level;

create synonym odc_def for "&1".odc_def;
create synonym phase for "&1".phase;
create synonym procedure_def for "&1".procedure_def;
create synonym indmap for "&1".indmap;
create synonym protocol for "&1".protocol;
create synonym procedure_to_protocol for "&1".procedure_to_protocol;
create synonym protocol_to_indmap for "&1".protocol_to_indmap;
create synonym investig for "&1".investig;
create synonym payments for "&1".payments;
create synonym country for "&1".country;
create synonym currency for "&1".currency;
create synonym ft_foreign_key_info for "&1".ft_foreign_key_info;
create synonym build_tag for "&1".build_tag;
create synonym price_level for "&1".price_level;

exit;

---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  10   DevTSM    1.9         2/27/2008 3:18:01 PM Debashish Mishra  
--  9    DevTSM    1.8         3/3/2005 6:34:48 AM  Debashish Mishra  
--  8    DevTSM    1.7         7/10/2003 3:18:22 PM Debashish Mishra Added grants
--       for price level
--  7    DevTSM    1.6         7/7/2003 8:57:36 AM  Debashish Mishra grants for
--       build_tag
--  6    DevTSM    1.5         7/7/2003 8:12:13 AM  Debashish Mishra Added grants
--       for ft_foreign_key_info
--  5    DevTSM    1.4         7/3/2003 4:26:16 PM  Debashish Mishra added grants,
--       synonyms for country and currency
--  4    DevTSM    1.3         7/3/2003 9:49:20 AM  Debashish Mishra Added grants,
--       synonyms for Investig and payments
--  3    DevTSM    1.2         6/30/2003 10:28:43 AMDebashish Mishra Added grants
--       for protocol,procedure_to_protocol,protocol_to_indmap and created
--       sysnonyms, created new mapper table modified procedure_def_id to mapper_id
--       in tspd_proc_freq table
--  2    DevTSM    1.1         6/13/2003 10:01:46 AMDebashish Mishra Initial
--       creation
--  1    DevTSM    1.0         6/13/2003 8:04:40 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: schema_updates_for_2008Q1_import.sql$ 
--
-- $Revision: 3$        $Date: 2/22/2008 11:56:02 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

alter table reference_prices add INTL_CODE VARCHAR2(8);

--update client_div set
--g50_hdng='REF' where g50_hdng in ('MEDCR','MCR');

--update client_div set
--g50_spec_hdng='REFSC' where g50_spec_hdng='MCRSC';

--update client_div set
--g50_pcklst_desc='REF' where 
--g50_pcklst_desc in ('MEDCR','MCR');

--commit;



---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/22/2008 11:56:02 AMDebashish Mishra  
--  2    DevTSM    1.1         1/26/2008 6:00:00 PM Debashish Mishra  
--  1    DevTSM    1.0         1/25/2008 4:16:38 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

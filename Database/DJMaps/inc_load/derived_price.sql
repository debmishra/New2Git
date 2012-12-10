--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: derived_price.sql$ 
--
-- $Revision: 3$        $Date: 2/27/2008 3:17:06 PM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------
 
update tsm_stage.derived_price1 set cntry='VNM' where cntry='VTM';
commit;
update tsm_stage.derived_price1 set country_id=null;
commit;
update tsm_stage.derived_price1 set prc_def_id=null;
commit;
update tsm_stage.derived_price1 set odc_def_id=null;
commit;

update tsm_stage.derived_price1 a set a.country_id=(select b.id from
"&1".country b where b.abbreviation=a.cntry) where a.country_id is null;
commit;

update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VBED*' where  "PROCEDURE" =  '*BED*';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VDAY*' where  "PROCEDURE" =  '*DAY*';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VPHRM' where  "PROCEDURE" =  '*PHRM';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VREIM' where  "PROCEDURE" =  '*REIM';
update tsm_stage.DERIVED_PRICE1 set "PROCEDURE" = 'VHOTL' where  "PROCEDURE" =  '*HOTL';
commit;

update tsm_stage.derived_price1 a set a.PRC_DEF_ID=(select b.id from
"&1".procedure_def b where b.cpt_code=a."PROCEDURE");
commit;

update tsm_stage.derived_price1 a set a.ODC_DEF_ID=(select b.id from
"&1".odc_def b where b.picas_code=a."PROCEDURE");
commit;




---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  3    DevTSM    1.2         2/27/2008 3:17:06 PM Debashish Mishra  
--  2    DevTSM    1.1         2/7/2007 10:27:59 PM Debashish Mishra  
--  1    DevTSM    1.0         4/19/2005 1:51:55 AM Debashish Mishra 
-- $
-- 
---------------------------------------------------------------------

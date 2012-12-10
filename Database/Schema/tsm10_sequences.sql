--
--
-- This program is the confidential and proprietary product of 
-- Fast Track Systems, Inc.  Any unauthorized use, reproduction, 
-- or transfer of this program is strictly prohibited.  
-- Copyright (C) 2000 by Fast Track Systems, Inc.  
-- All rights reserved.
-- 
-- $Workfile: tsm10_sequences.sql$ 
--
-- $Revision: 38$        $Date: 2/22/2008 11:56:05 AM$
--
--
-- Description:  <ADD>
--
---------------------------------------------------------------------

drop sequence mapper_seq;
drop sequence indmap_seq;
drop sequence build_tag_to_client_div_seq;
drop sequence price_level_Seq;
drop sequence temp_procedure_seq;
drop sequence temp_odc_seq;
drop sequence temp_overhead_seq;
drop sequence temp_inst_to_company_seq;
drop sequence temp_ip_study_price_seq;
drop sequence add_study_seq;
drop sequence user_pref_seq;
drop sequence modelled_coeff_seq;
drop sequence md_odc_oh_pct_seq;
drop sequence modelled_inclusion_seq;
drop sequence modelled_cpp_fence_seq;
drop sequence modelled_standardize_seq;


create sequence mapper_seq;
create sequence indmap_seq;
create sequence build_tag_to_client_div_seq;
create sequence price_level_Seq;
create sequence temp_procedure_seq;
create sequence temp_odc_seq;
create sequence temp_overhead_seq;
create sequence temp_inst_to_company_seq;
create sequence temp_ip_study_price_seq;
create sequence add_study_seq;
create sequence user_pref_seq;
create sequence modelled_coeff_seq;
Create sequence md_odc_oh_pct_seq;
create sequence modelled_inclusion_seq;
create sequence modelled_cpp_fence_seq;
create sequence modelled_standardize_seq;


exit;


---------------------------------------------------------------------
-- MODIFICATION HISTORY:
--
-- $Log: 
--  38   DevTSM    1.37        2/22/2008 11:56:05 AMDebashish Mishra  
--  37   DevTSM    1.36        9/19/2006 12:11:46 AMDebashish Mishra   
--  36   DevTSM    1.35        3/2/2005 10:51:17 PM Debashish Mishra  
--  35   DevTSM    1.34        8/29/2003 5:17:51 PM Debashish Mishra  
--  34   DevTSM    1.33        10/24/2002 3:40:36 PMDebashish Mishra  
--  33   DevTSM    1.32        9/26/2002 4:09:15 PM Debashish Mishra 3 new tables
--  32   DevTSM    1.31        9/6/2002 11:19:37 AM Debashish Mishra new table
--       md_odc_oh_pct
--  31   DevTSM    1.30        9/3/2002 2:30:07 PM  Debashish Mishra New table
--       modelled_coeff
--  30   DevTSM    1.29        7/17/2002 12:44:16 PMDebashish Mishra dropped table
--       user_preferences
--  29   DevTSM    1.28        7/12/2002 3:41:22 PM Debashish Mishra New table
--       user_pref
--  28   DevTSM    1.27        7/11/2002 4:31:23 PM Debashish Mishra Modified for
--       deleted tables after beta
--  27   DevTSM    1.26        5/10/2002 11:59:30 AMDebashish Mishra  
--  26   DevTSM    1.25        4/25/2002 2:31:10 PM Debashish Mishra  
--  25   DevTSM    1.24        4/24/2002 3:17:18 PM Debashish Mishra  
--  24   DevTSM    1.23        4/12/2002 2:54:11 PM Debashish Mishra  
--  23   DevTSM    1.22        4/9/2002 8:23:05 AM  Debashish Mishra  
--  22   DevTSM    1.21        4/3/2002 6:58:49 PM  Debashish Mishra  
--  21   DevTSM    1.20        3/22/2002 12:52:17 PMDebashish Mishra  
--  20   DevTSM    1.19        3/6/2002 7:02:53 PM  Debashish Mishra  
--  19   DevTSM    1.18        2/12/2002 12:20:47 PMDebashish Mishra  
--  18   DevTSM    1.17        1/28/2002 3:15:41 PM Debashish Mishra  
--  17   DevTSM    1.16        1/23/2002 12:52:41 PMDebashish Mishra  
--  16   DevTSM    1.15        1/17/2002 5:31:08 PM Debashish Mishra  
--  15   DevTSM    1.14        1/4/2002 4:26:01 PM  Debashish Mishra  
--  14   DevTSM    1.13        1/2/2002 2:33:27 PM  Debashish Mishra  
--  13   DevTSM    1.12        12/21/2001 10:39:44 AMDebashish Mishra Modifications
--       for client_country_list and client_country_list_item
--  12   DevTSM    1.11        12/19/2001 3:43:35 PMDebashish Mishra  
--  11   DevTSM    1.10        12/19/2001 10:50:36 AMDebashish Mishra  
--  10   DevTSM    1.9         12/13/2001 3:05:13 PMDebashish Mishra  
--  9    DevTSM    1.8         12/13/2001 10:48:21 AMDebashish Mishra  
--  8    DevTSM    1.7         12/6/2001 5:46:31 PM Debashish Mishra  
--  7    DevTSM    1.6         12/4/2001 1:11:47 PM Debashish Mishra Added four
--       temp tables for ph1 build
--  6    DevTSM    1.5         12/4/2001 11:48:02 AMDebashish Mishra Modifications
--       for Nancy and Peter
--  5    DevTSM    1.4         11/26/2001 2:04:34 PMKelly Kingdon   added
--       institution_id to investig and changed IP_euro_overhead to
--       PAP_euro_overhead.
--  4    DevTSM    1.3         11/21/2001 5:01:55 PMDebashish Mishra  
--  3    DevTSM    1.2         11/21/2001 1:15:34 PMDebashish Mishra  
--  2    DevTSM    1.1         11/20/2001 6:52:53 PMDebashish Mishra  
--  1    DevTSM    1.0         11/18/2001 6:58:43 PMDebashish Mishra 
-- $
-- 
---------------------------------------------------------------------

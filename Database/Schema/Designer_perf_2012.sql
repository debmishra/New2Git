/*************
Create date :12-MAR-12     Author-Vikram
**************/
create index tsm10.tspd_document_idx1 on tsm10.tspd_document(trial_id) tablespace TSMSMALL_INDX;
create index tsm10.icp_instance_idx1 on tsm10.icp_instance(trial_id) tablespace TSMSMALL_INDX;
create index tsm10.tspd_document_authors_idx1 on tsm10.tspd_document(tspd_document_id) tablespace TSMSMALL_INDX;

alter trigger TSM10.FTUSER_NAME_CHECK_TRG1 disable;
alter table tsm10.ftuser add(RESTRICTED_USER  number(1) default 0);
alter trigger TSM10.FTUSER_NAME_CHECK_TRG1 enable;
/**** Added to q004 database 05-Mar-12****/
create or replace
procedure tsm10.deletefulltspdtrial (trialID in number, ftuserid in number)
 as
begin
INSERT INTO Audit_Hist(ID,FTUSER_ID,COMMENTS,APP_TYPE,ACTION,TARGET_NAME,
TARGET_PRIMARY_TABLE,TARGET_ID,ENTITY_TYPE,ENTITY_ID,START_DATE,
MODIFY_DATE,TSPD_ROLE) select increment_sequence('audit_hist_seq'),
ftUserID, null,'TSPD','DELETE_TRIAL', protocol_identifier,
'tspd_trial', trialID, 'tspd_trial', trialID, sysdate,sysdate, null
 from trial where id=trialid;
DELETE FROM tspd_doc_advisory WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_doc_comment where tspd_doc_thread_reply_id IN
(select a.id from tspd_doc_thread_reply a,  tspd_document b 
WHERE a.tspd_document_id=b.id AND b.trial_id=trialID);
DELETE FROM tspd_doc_thread_reply WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_doc_comment WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_doc_reviewer WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_document_authors WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_document_history WHERE  tspd_document_id IN
(SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_diagram WHERE  icp_instance_id  IN
(SELECT id FROM icp_instance WHERE icp_instance.trial_id = trialID);
DELETE FROM dg_trial_version WHERE  tspd_document_id IN
    (SELECT id FROM Tspd_document WHERE tspd_document.trial_id = trialID);
DELETE FROM tspd_document WHERE trial_id = trialID;
DELETE FROM icp_instance WHERE trial_id = trialID;
UPDATE tspd_template set CONFIGURED_BY_TRIAL_ID=null,LOCKED_BY_FTUSER_ID=null
where CONFIGURED_BY_TRIAL_ID = trialID;
DELETE FROM tspd_trial WHERE trial_id = trialID;
DELETE FROM dg_trial WHERE trial_id = trialID;
DELETE FROM trial WHERE id = trialID
and not exists ( select 1 from picase_trial where picase_trial.trial_id = trialID)
and not exists (select 1 from cro_trial where cro_trial.trial_id = trialID);
end;
/
/**** Added to DEVL,q007,q004,D005,D003,D004,D007,Q003,q002 database 10-Mar-12****/

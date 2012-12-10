alter table tsm10.tspd_document_history
modify(SOFTWARE_VERSION VARCHAR2(50));

alter table tsm10.tspd_document
modify(SOFTWARE_VERSION VARCHAR2(50));

alter table tsm10.TSPD_TEMPLATE
modify(SOFTWARE_VERSION VARCHAR2(50));

alter table tsm10.TSPD_TEMPLATE_HISTORY
modify(SOFTWARE_VERSION VARCHAR2(50));

alter table tsm10.TSPD_DOCUMENT
add (COPY_DOCUMENT_PERMISSION  varchar2(20)  default 'NotAllowed');

alter table tsm10.TSPD_DOCUMENT
add constraint copy_doc_perm_chk 
check( COPY_DOCUMENT_PERMISSION in ('NotAllowed','Allow','AllowProject'));

alter table tsm10.TSPD_CLIENT_DIV
add (TRIAL_COPY_DOCUMENT_PERMISSION  varchar2(20)  default 'NotAllowed');


alter table tsm10.TSPD_CLIENT_DIV
add constraint trial_copy_doc_perm_chk 
check( TRIAL_COPY_DOCUMENT_PERMISSION in ('NotAllowed','Allow','AllowProject'));

alter table tsm10.TSPD_TRIAL
add (SOURCE_TRIAL_ID  NUMBER(10) );

create or replace
TRIGGER tsm10.tspd_trial_tr1
BEFORE INSERT OR UPDATE OF SOURCE_TRIAL_ID  ON tsm10.TSPD_TRIAL
FOR EACH ROW
WHEN(NEW.SOURCE_TRIAL_ID IS NOT NULL)
DECLARE
v_count NUMBER;
Invalid_trialid EXCEPTION;
BEGIN

SELECT count(*) INTO v_count 
FROM tsm10.trial
WHERE id=:NEW.SOURCE_TRIAL_ID;
 IF v_count=0 
 THEN  RAISE Invalid_trialid;
 END IF;
 EXCEPTION
 WHEN Invalid_trialid THEN
 Raise_application_error(-20001, 'Invalid TrialID');
 WHEN OTHERS THEN
 NULL;
END;
/

create or replace
procedure       tsm10.copy_tspd_document(OldDocId in number, SnapshotType in varchar2 default 'Baseline' )
as
OldIcpId number(10);
NewIcpId number(10);
NewDocId number(10);

begin

select ICP_INSTANCE_ID into OldIcpId from  tspd_document where id=OldDocId;
select increment_sequence('icp_instance_seq') into NewIcpId from dual;
select increment_sequence('tspd_document_seq') into NewDocId from dual;

Insert into icp_instance select NewIcpId,TRIAL_ID,LAST_UPDATED,
VERSION_TIMESTAMP,DATA, SnapshotType ,'Frozen' 
from icp_instance
where id=OldIcpId;

Insert into tspd_diagram select increment_sequence('tspd_diagram_seq'),NewIcpId,
DIAGRAM,ICP_OBJECT_ID,ICP_OBJECT_TYPE,VERSION_TIMESTAMP from tspd_diagram
where ICP_INSTANCE_ID=OldIcpId;

insert into tspd_document select NewDocId,TRIAL_ID,DOCUMENT_TYPE,
DOCUMENT_NAME,AUTHOR_FTUSER_ID,CREATE_DATE-(1/43200),LAST_UPDATED,VERSION_TIMESTAMP,
DATA,SnapshotType,SnapshotType,SNAPSHOT_NOTES,REVIEW_BY_DATE,
REVIEW_BY_TIME,AMEND_TO_TSPD_DOCUMENT_ID,NewIcpId,
'Final',DOCUMENT_NOTES,sysdate,SOA_TBL_FORMAT,
REVIEW_REMINDER_DAYS,AMEND_NAME,LAST_COOKIE,SOFTWARE_VERSION,LOCALE,
DATE_FORMAT,AUTHOR_RELINQUISHED_DT,AUTHOR_MODEL_TYPE,
PUBLIC_VISIBLE_FLG,MACROS_DIRTY,UPDATE_REVISION_DOC_FLG,copy_document_permission 
from tspd_document where id=OldDocId;

Insert into TSPD_DOCUMENT_AUTHORS select
increment_sequence('tspd_document_authors_seq'),NewDocId,ftuser_id,document_type
from TSPD_DOCUMENT_AUTHORS where tspd_document_id=OldDocId;

end;
/

/**** Added to DEVL,q007,q004,D005,D003,D004,D007,Q003,q002 database 20-Mar-12****/
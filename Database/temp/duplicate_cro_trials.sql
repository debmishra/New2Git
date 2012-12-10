declare

cursor C1 is select id from trial where created_by='CROCAS' 
and trial_status <> 'DELETED' and client_div_id=42;

trialseq  number(10);
budgetseq number(10);


begin 

for ix1 in c1 loop 

 select increment_sequence('trial_seq') into trialseq from dual;

 insert into trial select 
 trialseq ,guid,TRIAL_STATUS, CREATED_BY,CLIENT_ID , PROJECT_ID ,            
 INDMAP_ID,PHASE_ID ,WIZARD_PAGE_NUMBER,WIZARD_PAGE_FLG,LOCKING_FTUSER_ID ,     
 LOCK_DATE, PLANNING_CURRENCY_ID,CLIENT_DIV_ID,PROJECT_AREA_ID ,       
 PROTOCOL_IDENTIFIER||'DUP1' from trial where id=ix1.id;  

  Insert into cro_trial select 
 trialseq, ARCHIVED_DATE,ARCHIVED_BY_ID,ARCHIVED_FLG,          
 CREATOR_FTUSER_ID,CREATE_DATE, PUBLISH_DATE,PUBLISH_FTGROUP_ID ,    
 COMMENTS,TOTAL_PRICE,  ALT_CURRENCY_ID,        
 ALT_TOTAL_PRICE from cro_trial where
 trial_id =ix1.id;  

 declare

 cursor c2 is select id from cro_budget where cro_trial_id=ix1.id;

 begin
 for ix2 in c2 loop

	select increment_sequence('cro_budget_seq') into budgetseq from dual;
 
	Insert into cro_budget select 
	budgetseq,COUNTRY_ID,SHORT_DESC,trialseq,CREATOR_FTUSER_ID,FTGROUP_ID,LOCKING_FTUSER_ID,NUM_LOCAL_SITES,        
	NUM_REGIONAL_SITES,NUM_CENTRAL_SITES,NUM_COMPL_PATIENTS,CRO_TYPE,CREATE_DATE,SEQUENCE,CURRENCY_ID,
	LOCAL_CURRENCY_ID,LOCK_DATE,BUILD_TAG_ID,TOTAL_COST,TOTAL_COST_LOCAL,IS_PUBLISHED,DELETE_FLG,CRO_COMPANY_ID,
	NUM_PATS_MONITORED,NUM_PROJ_MONTHS,PUBLISH_DATE,ALT_TOTAL_COST,WIZARD_PAGE_NUMBER,WIZARD_PAGE_FLG,
	SUPER_WIZ_GROUP_NAME,SUPER_WIZ_SCREEN_NAME,SUB_TOTAL_LOW,SUB_TOTAL_MED,SUB_TOTAL_HIGH,SUB_TOTAL_SEL,
	SUB_TOTAL,CRF_PAGES,COMPLETED_PATIENTS,EXTRA_PAGES,CAL_CENTRAL_UNIT,CAL_REGIONAL_UNIT,CAL_LOCAL_UNIT 
	from cro_budget where id=ix2.id ;  


	Insert into CRO_BUDGET_GROUP_PERMISSION select increment_sequence('cro_budget_group_permission_seq'),
	budgetseq,CLIENT_GROUP_ID ,RW_FLG from CRO_BUDGET_GROUP_PERMISSION
	where cro_budget_id =ix2.id;

	Insert into CRO_BUDGET_INPUT select increment_sequence('cro_budget_input_seq'),                     
	budgetseq,BUDGET_VALUE,ZEROED,CRO_CHOICE_ID,CRO_CATEGORY_ID,CRO_COMPONENT_ID
	from CRO_BUDGET_INPUT where CRO_BUDGET_ID = ix2.id;


	Insert into CRO_CATEGORY_ROLLUP select increment_sequence('cro_category_rollup_seq'),                     
	CRO_CATEGORY_ID,QUANTITY,LOW_PRICE,MEDIUM_PRICE,HIGH_PRICE,SELECTED_PRICE,
	TOTAL_PRICE,budgetseq,PRICE_RANGE,APPLY_TO_BUDGET,PARENT_CATEGORY_ID,
	SHORT_DESC from  CRO_CATEGORY_ROLLUP where CRO_BUDGET_ID = ix2.id;     

	Insert into cro_odc_item select increment_sequence('cro_odc_item_seq'),                    
	budgetseq,trialseq,CRO_ODC_DEF_ID,LOW_PRICE,
	MED_PRICE,HIGH_PRICE,SELECTED_PRICE,DISPLAY_ORDER,PRICE_RANGE,
	QUANTITY,TOTAL_PRICE,APPLIES_TO,ALT_TOTAL_PRICE,CURRENCY_ID,
	IS_DELETABLE from  cro_odc_item where CRO_BUDGET_ID = ix2.id; 
 end loop;
 end;
end loop;
end;
/ 

cleanup 
=======


TSM10@d003>select min(id), max(id) from trial where created_by='CROCAS' and 
  2  protocol_identifier like '%DUP1%';

   MIN(ID)    MAX(ID)
---------- ----------
     63534      64946

TSM10@d003>select min(id), max(id) from cro_budget where cro_trial_id 
  2  between 63534 and 64946;

   MIN(ID)    MAX(ID)
---------- ----------
      1646       9542

delete from CRO_BUDGET_GROUP_PERMISSION where cro_budget_id between 1646 and 9542;
delete from CRO_BUDGET_INPUT where cro_budget_id between 1646 and 9542;
delete from CRO_CATEGORY_ROLLUP  where cro_budget_id between 1646 and 9542;
delete from cro_odc_item where cro_budget_id between 1646 and 9542;
delete from cro_budget where id between 1646 and 9542;
delete from cro_trial where trial_id between 63534 and 64946;
delete from trial where id between 63534 and 64946 and created_by='CROCAS';
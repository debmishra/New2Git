drop table databld_run_prop;
drop table databld_run;
drop table id_control;

alter table pap_overhead drop column adj_ovrhd_pct_ids;
alter table pap_overhead drop column ofc_ovrhd_pct_ids;
alter table pap_overhead drop column pct_paid_pct_ids;
alter table pap_overhead drop column odc_pct_ids;
alter table pap_overhead drop column company_ovrhd_pct_ids;
alter table pap_overhead drop column company_odc_pct_ids;
alter table pap_overhead drop column company_pct_paid_pct_ids;

alter table g50_pap_overhead drop column adj_ovrhd_pct_ids;
alter table g50_pap_overhead drop column ofc_ovrhd_pct_ids;
alter table g50_pap_overhead drop column pct_paid_pct_ids;
alter table g50_pap_overhead drop column odc_pct_ids;
alter table g50_pap_overhead drop column company_ovrhd_pct_ids;
alter table g50_pap_overhead drop column company_odc_pct_ids;
alter table g50_pap_overhead drop column company_pct_paid_ids;

alter table industry_pap_odc_cost drop column pct_ids;

alter table institution_overhead drop column ofc_ovrhd_pct_ids;
alter table institution_overhead drop column adj_ovrhd_pct_ids;
alter table institution_overhead drop column ovrhd_base_pct_ids;
alter table institution_overhead drop column pct_paid_pct_ids;
alter table institution_overhead drop column ovrhd_18mo_pct_ids;

alter table pap_Institution_odc_cost drop column pct_ids;

alter table pap_Institution_proc_cost drop column pct_ids;


alter table COMPANY_PAP_ODC_COST drop column pct_ids;
alter table G50_COMPANY_PAP_ODC_COST drop column pct_ids;

alter table pap_clinical_proc_cost drop column industry_pct_ids;
alter table pap_clinical_proc_cost drop column company_pct_ids;

alter table g50_pap_clinical_proc_cost drop column industry_pct_ids;
alter table g50_pap_clinical_proc_cost drop column company_pct_ids;

alter table  ip_study_price drop column industry_pct_ids;
alter table  ip_study_price drop column co_pct_ids;

alter table  g50_ip_study_price drop column industry_pct_ids;
alter table  g50_ip_study_price drop column co_pct_ids;

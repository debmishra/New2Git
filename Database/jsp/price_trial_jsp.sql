CREATE OR REPLACE PROCEDURE price_trial (
  trialBlob IN OUT BLOB,
  rollupBlob IN OUT BLOB)
AS LANGUAGE JAVA
NAME 'com.fasttrack.tsm.budgetpricing.BudgetPricingStoredProc.priceTrial(oracle.sql.BLOB[], oracle.sql.BLOB[])';

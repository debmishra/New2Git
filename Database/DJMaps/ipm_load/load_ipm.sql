spool c:\tsm\database\djmaps\ipm_load\load_tsm10.log

select to_char(sysdate,'MM/DD/YYYY HH24:MI:ss')  from dual;

select 'ipm_cpp' from dual;
@C:\tsm\Database\DJMaps\ipm_load\ipm_cpp "&1"

select 'ipm_std' from dual;
@C:\tsm\Database\DJMaps\ipm_load\ipm_std "&1"

select 'ipm_weight' from dual;
@C:\tsm\Database\DJMaps\ipm_load\ipm_weight "&1"

select 'ipm_ph2to4_coeff' from dual;
@C:\tsm\Database\DJMaps\ipm_load\ipm_ph2to4_coeff "&1"

select 'ipm_ph2to4_adj_coeff' from dual;
@C:\tsm\Database\DJMaps\ipm_load\ipm_ph2to4_adj_coeff "&1"

select 'ipm_ph2to4_lkup_coeff' from dual;
--@C:\tsm\Database\DJMaps\ipm_load\ipm_ph2to4_lkup_coeff "&1"

select 'ipm_ph2to4_adj_country_ratio' from dual;
@C:\tsm\Database\DJMaps\ipm_load\ipm_ph2to4_adj_country_ratio "&1"

select 'modelled_inclusion' from dual;
@C:\tsm\Database\DJMaps\ipm_load\modelled_inclusion "&1"



select to_char(sysdate,'MM/DD/YYYY HH24:MI:ss')  from dual;
spool off

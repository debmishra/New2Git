spool c:\copy_tsm10\copylog.txt

conn tsm10t/kra8gpwl@prod

@c:\copy_tsm10\tsm10_constraints
@c:\copy_tsm10\trace_constraints
@c:\copy_tsm10\tsm10_grants_given_to_ft15 FT15T
@c:\copy_tsm10\trace_grants_given_to_ft15 FT15T

conn ft15t/kra8gpwl@prod

@c:\copy_tsm10\ft15_grants_given_to_tsm10 TSM10T
@c:\copy_tsm10\ft15_grants_given_to_trace TSM10T

conn tsm10t/kra8gpwl@prod

@c:\copy_tsm10\tsm10_synonyms FT15T
@c:\copy_tsm10\trace_synonyms FT15T
@c:\copy_tsm10\tsm10_foreign_keys
@c:\copy_tsm10\trace_foreign_keys
@c:\copy_tsm10\tsm10_grants_given_to_ftcommon FTCOMMON

conn ft15t/kra8gpwl@prod

@c:\copy_tsm10\copy_ft15_by_import TSM10T
@c:\copy_tsm10\ft15_grants_given_to_ftcommon FTCOMMON

spool off





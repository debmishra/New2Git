load data
infile "c:\ipt_data\ipm_phase1.dat"
append
into table ipm_phase1
fields terminated by "," optionally enclosed by '"' 
trailing nullcols
( 
COUNTRY                  "trim(:COUNTRY)",
STUDY                    "trim(:STUDY)",
POPULATION               "trim(:POPULATION)",
SITE                     "trim(:SITE)",
AGE                      "trim(:AGE)",
DURATION                 "trim(:DURATION)",
CONFINE                  "trim(:CONFINE)",
TREATMENT                "trim(:TREATMENT)",
SINGLE                   "trim(:SINGLE)",
S_LOW                    "trim(:S_LOW)",
S_MED                    "trim(:S_MED)",
S_HIGH                   "trim(:S_HIGH)",
S_GRANTS_LOW             "trim(:S_GRANTS_LOW)",
S_GRANTS_MED             "trim(:S_GRANTS_MED)",
S_GRANTS_HIGH            "trim(:S_GRANTS_HIGH)",
S_GRANTS_AVG             "trim(:S_GRANTS_AVG)",
S_GRANTS_COUNT          "trim(:S_GRANTS_COUNT)",
S_NEW_LOW                "trim(:S_NEW_LOW)",
S_NEW_MED                "trim(:S_NEW_MED)",
S_NEW_HIGH               "trim(:S_NEW_HIGH)",
MULTIPLE                 "trim(:MULTIPLE)",
M_LOW                    "trim(:M_LOW)",
M_MED                    "trim(:M_MED)",
M_HIGH                   "trim(:M_HIGH)",
M_GRANTS_LOW             "trim(:M_GRANTS_LOW)",
M_GRANTS_MED             "trim(:M_GRANTS_MED)",
M_GRANTS_HIGH            "trim(:M_GRANTS_HIGH)",
M_GRANTS_AVG             "trim(:M_GRANTS_AVG)",
M_GRANTS_COUNT          "trim(:M_GRANTS_COUNT)",
M_NEW_LOW                "trim(:M_NEW_LOW)",
M_NEW_MED                "trim(:M_NEW_MED)",
M_NEW_HIGH               "trim(:M_NEW_HIGH)"
)
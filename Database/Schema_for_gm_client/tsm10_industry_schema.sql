
CREATE TABLE temp_ip_study_price (
  id                     NUMBER(10,0) NOT NULL,
  indmap_id              NUMBER(10,0) NULL,
  country_id             NUMBER(10,0) NULL,
  cpp                    NUMBER(16,2) NULL,
  cpv                    NUMBER(16,2) NULL,
  phase_id               NUMBER(10,0) NULL,
  build_code_id          NUMBER(10,0) NOT NULL,
  ta_indmap_id           NUMBER(10,0) NULL,
  indgroup_indmap_id     NUMBER(10,0) NULL,
  investig_id            NUMBER(10,0) NULL,
  active_flg             NUMBER(1,0)  DEFAULT 0 NOT NULL,
  phase1type_id          NUMBER(10,0) NULL,
  primary_indication_flg NUMBER(1,0)  DEFAULT 1 NOT NULL,
  grant_date 		 date,
  entry_date 		 date
)
  tablespace tsmlarge PCTFREE 5
/

 
CREATE INDEX temp_ip_study_price_indx1
  ON temp_ip_study_price (
    country_id
  )
  TABLESPACE tsmlarge_indx
  PCTFREE 5
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT tisp_active_flg_check CHECK (
    active_flg in (0,1)
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmlarge_indx
    PCTFREE 5
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk1 FOREIGN KEY (
    indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk2 FOREIGN KEY (
    country_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk3 FOREIGN KEY (
    build_code_id
  ) REFERENCES build_code (
    id
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk4 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk5 FOREIGN KEY (
    ta_indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk6 FOREIGN KEY (
    indgroup_indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_ip_study_price
  ADD CONSTRAINT temp_ip_study_price_fk7 FOREIGN KEY (
    phase1type_id
  ) REFERENCES phase (
    id
  )
/



CREATE TABLE temp_odc (
  id                     NUMBER(10,0) NOT NULL,
  active_flg             NUMBER(1,0)  DEFAULT 0 NOT NULL,
  indmap_id              NUMBER(10,0) NULL,
  country_id             NUMBER(10,0) NULL,
  protocol_id            NUMBER(10,0) NULL,
  currency_id            NUMBER(10,0) NULL,
  cpp                    NUMBER(16,2) NULL,
  cpv                    NUMBER(16,2) NULL,
  cpgv                   NUMBER(16,2) NULL,
  institution_id         NUMBER(10,0) NULL,
  payment                NUMBER(16,2) NULL,
  phase_id               NUMBER(10,0) NULL,
  mapper_id              NUMBER(10,0) NULL,
  build_code_id          NUMBER(10,0) NOT NULL,
  ta_indmap_id           NUMBER(10,0) NULL,
  indgroup_indmap_id     NUMBER(10,0) NULL,
  payments_id            NUMBER(10,0) NULL,
  grant_date             DATE         NULL,
  entry_date             DATE         NULL,
  primary_indication_flg NUMBER(1,0)  DEFAULT 1 NOT NULL
)
  tablespace tsmlarge PCTFREE 5
/

CREATE INDEX temp_odc_indx1
  ON temp_odc (
    country_id,
    mapper_id
  )
  TABLESPACE tsmlarge_indx
  PCTFREE 5
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_active_check CHECK (
    active_flg in (0,1)
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmlarge_indx
    PCTFREE 5
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk1 FOREIGN KEY (
    indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk10 FOREIGN KEY (
    indgroup_indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk2 FOREIGN KEY (
    country_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk3 FOREIGN KEY (
    build_code_id
  ) REFERENCES build_code (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk4 FOREIGN KEY (
    currency_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk5 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk6 FOREIGN KEY (
    mapper_id
  ) REFERENCES mapper (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk7 FOREIGN KEY (
    institution_id
  ) REFERENCES institution (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk8 FOREIGN KEY (
    protocol_id
  ) REFERENCES protocol (
    id
  )
/

ALTER TABLE temp_odc
  ADD CONSTRAINT temp_odc_fk9 FOREIGN KEY (
    ta_indmap_id
  ) REFERENCES indmap (
    id
  )
/




CREATE TABLE temp_overhead (
  id                     NUMBER(10,0) NOT NULL,
  adj_other_pct          NUMBER(16,2) NULL,
  adj_ovrhd_pct          NUMBER(16,2) NULL,
  affiliation            VARCHAR2(20) NULL,
  indmap_id              NUMBER(10,0) NULL,
  country_id             NUMBER(10,0) NULL,
  protocol_id            NUMBER(10,0) NULL,
  grant_date             DATE         NULL,
  institution_id         NUMBER(10,0) NULL,
  ovrhd_basis            VARCHAR2(80) NULL,
  ovrhd_pct              NUMBER(16,2) NULL,
  pct_paid               NUMBER(16,2) NULL,
  phase_id               NUMBER(10,0) NULL,
  zip_code               VARCHAR2(20) NULL,
  build_code_id          NUMBER(10,0) NOT NULL,
  adj18mo_flg            NUMBER(1,0)  DEFAULT 0 NOT NULL,
  primary_flg            NUMBER(1,0)  DEFAULT 0 NOT NULL,
  ta_indmap_id           NUMBER(10,0) NULL,
  indgroup_indmap_id     NUMBER(10,0) NULL,
  active_flg             NUMBER(1,0)  DEFAULT 0 NOT NULL,
  investig_id            NUMBER(10,0) NULL,
  primary_indication_flg NUMBER(1,0)  DEFAULT 1 NOT NULL,
  entry_date 		 date
)tablespace tsmlarge pctfree 5
/

CREATE INDEX temp_overhead_indx1
  ON temp_overhead (
    country_id
  )
  TABLESPACE tsmlarge_indx
  PCTFREE   5
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_ovrhd_adj18mo_flg_check CHECK (
    adj18mo_flg in (0,1)
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_ovrhd_affiliation_check CHECK (
    affiliation in ('Affiliated','Unaffiliated','Both')
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT to_active_flg_check CHECK (
    active_flg in (0,1)
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT to_primary_flg_check CHECK (
    primary_flg in(0,1)
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmlarge_indx
    PCTFREE  5
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk1 FOREIGN KEY (
    indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk2 FOREIGN KEY (
    country_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk3 FOREIGN KEY (
    build_code_id
  ) REFERENCES build_code (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk4 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk5 FOREIGN KEY (
    institution_id
  ) REFERENCES institution (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk6 FOREIGN KEY (
    protocol_id
  ) REFERENCES protocol (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk7 FOREIGN KEY (
    ta_indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_overhead
  ADD CONSTRAINT temp_overhead_fk8 FOREIGN KEY (
    indgroup_indmap_id
  ) REFERENCES indmap (
    id
  )
/

CREATE TABLE temp_procedure (
  id                     NUMBER(10,0) NOT NULL,
  indmap_id              NUMBER(10,0) NULL,
  country_id             NUMBER(10,0) NULL,
  currency_id            NUMBER(10,0) NULL,
  grant_date             DATE         NULL,
  payment                NUMBER(16,2) NULL,
  phase_id               NUMBER(10,0) NULL,
  mapper_id              NUMBER(10,0) NULL,
  institution_id         NUMBER(10,0) NULL,
  build_code_id          NUMBER(10,0) NOT NULL,
  primary_flg            NUMBER(1,0)  DEFAULT 0 NOT NULL,
  ta_indmap_id           NUMBER(10,0) NULL,
  indgroup_indmap_id     NUMBER(10,0) NULL,
  active_flg             NUMBER(1,0)  DEFAULT 0 NOT NULL,
  payments_id            NUMBER(10,0) NULL,
  entry_date             DATE         NULL,
  primary_indication_flg NUMBER(1,0)  DEFAULT 1 NOT NULL
)
  tablespace tsmlarge PCTFREE 5 
/

CREATE INDEX temp_procedure_indx1
  ON temp_procedure (
    country_id,
    mapper_id
  )
  TABLESPACE tsmlarge_indx
  PCTFREE 5
/

CREATE INDEX temp_procedure_indx2
  ON temp_procedure (
    mapper_id
  )
  TABLESPACE tsmlarge_indx
  PCTFREE 5
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT tp_active_flg_check CHECK (
    active_flg in (0,1)
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT tp_primary_flg_check CHECK (
    primary_flg in (0,1)
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmlarge_indx
    PCTFREE 5
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk1 FOREIGN KEY (
    indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk2 FOREIGN KEY (
    country_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk3 FOREIGN KEY (
    build_code_id
  ) REFERENCES build_code (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk4 FOREIGN KEY (
    currency_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk5 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk6 FOREIGN KEY (
    mapper_id
  ) REFERENCES mapper (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk7 FOREIGN KEY (
    institution_id
  ) REFERENCES institution (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk8 FOREIGN KEY (
    ta_indmap_id
  ) REFERENCES indmap (
    id
  )
/

ALTER TABLE temp_procedure
  ADD CONSTRAINT temp_procedure_fk9 FOREIGN KEY (
    indgroup_indmap_id
  ) REFERENCES indmap (
    id
  )
/

CREATE TABLE derived_prices (
  id               NUMBER(10,0) NOT NULL,
  country_id       NUMBER(10,0) NOT NULL,
  low_price        NUMBER(12,2) NULL,
  med_price        NUMBER(12,2) NULL,
  high_price       NUMBER(12,2) NULL,
  "TYPE"             VARCHAR2(10) NOT NULL,
  procedure_def_id NUMBER(10,0) NULL,
  odc_def_id       NUMBER(10,0) NULL
)
  tablespace tsmlarge pctfree 5
/

ALTER TABLE derived_prices
  ADD CONSTRAINT dp_proc_check CHECK (
    procedure_def_id is null or odc_def_id is null
  )
/

ALTER TABLE derived_prices
  ADD CONSTRAINT dp_type_check CHECK (
    type in ('ODC','PROC')
  )
/

ALTER TABLE derived_prices
  ADD CONSTRAINT derived_prices_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE tsmlarge_indx
    PCTFREE  5
/

ALTER TABLE derived_prices
  ADD CONSTRAINT derived_prices_fk1 FOREIGN KEY (
    country_id
  ) REFERENCES country (
    id
  )
/

ALTER TABLE derived_prices
  ADD CONSTRAINT derived_prices_fk2 FOREIGN KEY (
    procedure_def_id
  ) REFERENCES procedure_def (
    id
  )
/

ALTER TABLE derived_prices
  ADD CONSTRAINT derived_prices_fk6 FOREIGN KEY (
    odc_def_id
  ) REFERENCES odc_def (
    id
  )
/

CREATE TABLE complexity_hist (
  id          NUMBER(10,0) NOT NULL,
  phase_id NUMBER(10,0) NOT NULL,                
  indmap_id   NUMBER(10,0) NOT NULL,   
  complexity_val NUMBER(12,2) NOT NULL,
  rec_cnt NUMBER(10,0) NOT NULL,
  complexity_p25 NUMBER(12,2)  NULL,
  complexity_p50 NUMBER(12,2)  NULL,
  complexity_p75 NUMBER(12,2)  NULL,
  specificity    NUMBER(10,0)  NULL,
  pct_ids        VARCHAR2(100) NULL
)
TABLESPACE TSMLARGE pctfree 20
/

ALTER TABLE complexity_hist 
  ADD CONSTRAINT complexity_hist_pk PRIMARY KEY (
    id
  )
  USING INDEX
    TABLESPACE TSMLARGE_indx
    PCTFREE    20
/

ALTER TABLE complexity_hist
  ADD CONSTRAINT complexity_hist_fk1 FOREIGN KEY (
    phase_id
  ) REFERENCES phase (
    id
  )
/
alter table complexity_hist modify(COMPLEXITY_VAL number(10,2));


INSERT into id_control VALUES('tsm10','complexity_hist',1);
commit;


CREATE TABLE temp_cpp (
  id                     NUMBER(10) NOT NULL,
  country_id             NUMBER(10),    
  indmap_id              NUMBER(10),
  phase_id               NUMBER(10),
  cpp                    NUMBER(16,2),   
  build_code_id          NUMBER(10) NOT NULL,
  ta_indmap_id           NUMBER(10),
  indgroup_indmap_id     NUMBER(10),
  investig_id            NUMBER(10),
  active_flg             NUMBER(1) DEFAULT 0 NOT NULL,
  grant_date             DATE,
  entry_date             DATE)
  TABLESPACE tsmlarge
  PCTFREE 5;

CREATE INDEX temp_cpp_indx1
  ON temp_cpp (country_id)
  TABLESPACE tsmlarge_indx
  PCTFREE 5;

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_active_flg_check 
  CHECK (active_flg in (0,1));

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_pk 
  PRIMARY KEY (id) USING 
  INDEX TABLESPACE tsmlarge_indx
    PCTFREE 5;

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_fk1 
  FOREIGN KEY (indmap_id) REFERENCES "&1".indmap (id);

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_fk2 
  FOREIGN KEY (country_id) REFERENCES "&1".country (id);

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_fk3 
  FOREIGN KEY (build_code_id) REFERENCES "&1".build_code (id);

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_fk4 
  FOREIGN KEY (phase_id) REFERENCES "&1".phase (id);

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_fk5 
  FOREIGN KEY (ta_indmap_id) REFERENCES "&1".indmap (id);

ALTER TABLE temp_cpp ADD CONSTRAINT temp_cpp_fk6 
  FOREIGN KEY (indgroup_indmap_id) REFERENCES "&1".indmap (id);


CREATE TABLE cpp_cost (
  id                NUMBER(10)  NOT NULL,
  country_id        NUMBER(10)  NOT NULL,
  indmap_id         NUMBER(10)  NOT NULL,
  phase_id          NUMBER(10)  NOT NULL,
  pct25             NUMBER(16,2),
  pct50             NUMBER(16,2),
  pct75             NUMBER(16,2),
  company_pct50     NUMBER(16,2), 
  co_exp_cnt        NUMBER(5),
  other_exp_cnt     NUMBER(5),
  industry_pct_ids  VARCHAR2(100),
  co_pct_ids        VARCHAR2(100),
  specificity       NUMBER(10))
  TABLESPACE tsmlarge
  PCTFREE    5;

ALTER TABLE cpp_cost   ADD CONSTRAINT cpp_cost_pk 
  PRIMARY KEY (id)  
  USING INDEX TABLESPACE tsmlarge_indx
  PCTFREE    5;

ALTER TABLE cpp_cost ADD CONSTRAINT cpp_cost_uq1 
  UNIQUE (country_id,indmap_id,phase_id)
  USING INDEX TABLESPACE tsmlarge_indx
  PCTFREE    5;

ALTER TABLE cpp_cost ADD CONSTRAINT cpp_cost_fk1 
 FOREIGN KEY (country_id) REFERENCES "&1".country (id);

ALTER TABLE cpp_cost ADD CONSTRAINT cpp_cost_fk2 
 FOREIGN KEY (phase_id) REFERENCES "&1".phase (id);

ALTER TABLE cpp_cost ADD CONSTRAINT cpp_cost_fk4 
  FOREIGN KEY (indmap_id) REFERENCES "&1".indmap (id);

Insert into id_control values ('tsm10','cpp_cost',1);
commit;

create sequence DERIVED_PRICES_SEQ;
create sequence TEMP_IP_STUDY_PRICE_SEQ;
create sequence TEMP_ODC_SEQ;
create sequence TEMP_OVERHEAD_SEQ;
create sequence TEMP_PROCEDURE_SEQ;
create sequence complexity_hist_SEQ;
create sequence temp_cpp_seq;
create sequence cpp_cost_seq;

Grant select,insert,update,delete on DERIVED_PRICES to "&1";
Grant select,insert,update,delete on TEMP_IP_STUDY_PRICE to "&1";
Grant select,insert,update,delete on TEMP_ODC to "&1";
Grant select,insert,update,delete on TEMP_OVERHEAD to "&1";
Grant select,insert,update,delete on TEMP_PROCEDURE to "&1";
Grant select,insert,update,delete on complexity_hist to "&1";
Grant select,insert,update,delete on temp_cpp to "&1";
Grant select,insert,update,delete on cpp_cost to "&1";

Grant select on PAP_CLINICAL_PROC_COST_SEQ to "&1";
Grant select on complexity_hist_SEQ to "&1";
Grant select on cpp_cost_SEQ to "&1";

-- insert into mapper select * from "&1".mapper;
insert into derived_prices select * from "&1".derived_prices;
commit;

create or replace view v_temp_procedure as
select
e.abbreviation country,
b.code indication,
c.code indgrp,
d.code TA,
h.cpt_code proc_code,
k.short_desc phase,
j.code company,
a.GRANT_DATE ,
a.PAYMENT,
a.PRIMARY_FLG,
a.ENTRY_DATE,
a.PRIMARY_INDICATION_FLG ,
a.ACTIVE_FLG,
a.PAYMENTS_ID FoxPro_payments_rownum,
i.name institution
from temp_procedure a, indmap b, indmap c, indmap d,
country e, mapper g, procedure_def h,
institution i, build_code j,phase k
where a.indmap_id=b.id(+) and
a.indgroup_indmap_id=c.id(+) and
a.ta_indmap_id=d.id(+) and
a.country_id=e.id(+) and
a.mapper_id=g.id(+) and
g.procedure_def_id=h.id(+) and
a.institution_id=i.id(+) and
a.build_code_id=j.id(+) and
a.phase_id=k.id(+)
/

CREATE OR REPLACE VIEW v_temp_odc (
  active_flg,
  indication,
  indgrp,
  ta,
  country,
  Currency,
  protocol,
  cpp,
  cpv,
  cpgv,
  institution,
  payment,
  phase,
  odc,
  company,
  foxpro_payments_rownum,
  grant_date,
  entry_date,
  primary_indication_flg
) AS
select
a.ACTIVE_FLG,
b.code indication,
c.code indgrp,
d.code TA,
e.abbreviation country,
m.name currency,
l.picas_protocol protocol,
a.CPP ,
a.CPV ,
a.CPGV,
i.name institution,
a.PAYMENT,
k.short_desc phase,
h.picas_code odc,
j.code company,
a.PAYMENTS_ID  FoxPro_payments_rownum,
a.GRANT_DATE,
a.ENTRY_DATE,
a.PRIMARY_INDICATION_FLG
from temp_odc a, protocol l, indmap b, indmap c, indmap d,
country e, mapper g, odc_def h,
institution i, build_code j,phase k, currency m
where a.protocol_id=l.id (+) and
a.indmap_id=b.id(+) and
a.indgroup_indmap_id=c.id(+) and
a.ta_indmap_id=d.id(+) and
a.country_id=e.id(+) and
a.currency_id=m.id(+) and
a.mapper_id=g.id(+) and
g.odc_def_id=h.id(+) and
a.institution_id=i.id(+) and
a.build_code_id=j.id(+) and
a.phase_id=k.id(+)
/


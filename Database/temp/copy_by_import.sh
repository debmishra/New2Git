imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=ft15 touser=ft15a statistics=NONE tables=client log=ft15client.log


imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10currency.log \
tables=currency

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10country.log \
tables=country

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=local_to_euro.log \
tables=local_to_euro,phase


imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=client_div.log \
tables=client_div,build_code,indmap


imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10client_div_to_lic_country.log \
tables=client_div_to_lic_country,client_div_to_lic_indmap,client_div_to_lic_phase,\
client_div_to_build_code

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10affiliation_factor.log \
tables=affiliation_factor

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10ip_duration_factor.log \
tables=ip_duration_factor

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10ip_weight.log \
tables=ip_weight

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10ip_cpp.log \
tables=ip_cpp

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10ip_duration.log \
tables=ip_duration

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10ip_business_factors.log \
tables=ip_business_factors

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=region.log \
tables=region

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10institution.log \
tables=institution

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10procedure_def.log \
tables=procedure_def,odc_def

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10mapper.log \
tables=mapper

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10pap_odc_pct.log \
tables=pap_odc_pct

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10pap_euro_overhead.log \
tables=pap_euro_overhead

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10add_study.log \
tables=add_study

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10protocol.log \
tables=protocol

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10investig.log \
tables=investig

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10payments.log \
tables=payments

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10protocol_to_indmap.log \
tables=protocol_to_indmap

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10price_level.log \
tables=price_level

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10procedure_to_protocol.log \
tables=procedure_to_protocol

imp dmishra/utest@utest file=./tsm10.dmp constraints=n grants=n ignore=y \
fromuser=tsm10 touser=tsm10a statistics=NONE log=tsm10build_tag.log \
tables=build_tag

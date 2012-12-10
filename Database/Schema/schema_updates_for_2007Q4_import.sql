-- before load

update country set currency_id = (select currency_id from country where
abbreviation='EUR') where abbreviation='LUX';
commit;

-- After load

update odc_def set procedure_level='Site' where picas_code='#1124';

update payments set outlier_cd=1 where id in
(848231,848233,848237,848238,848240,848241,848243,848245,848247,848248,848380,848382,
848383,848384,848387,848388,848390,848391,848392,848393,848394,848395,848397,848399,
848400,848401,848404,848407,848409,848411,848412,848414,848415,848416,848417,848386,
848413,848239,848396,848385,848402,848381,848408,848234,848398,848403);

update payments set payment=40 where id in (
605711,605729,605765,605783);

commit;


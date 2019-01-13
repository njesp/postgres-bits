-- psql -U postgres -d testdb -h secretubox.westeurope.cloudapp.azure.com
create or replace procedure insert_data_big ()
language 'plpgsql'
as $BODY$
declare
    c_a constant integer := 100;
    c_b constant integer := 200;
    c_c constant integer := 1000;
    t1id integer;
    t2id integer;
    t3id integer;
begin
    for i in 1..c_a loop
        insert into t1 (t1_v1 , t1_v2)
        values ((i * i) * random() , (i * i) * random())
    returning
        t1_id into t1id;
        for j in 1..c_b loop
            insert into t2 (t1_fk , t2_v1 , t2_v2)
            values (t1id , (j * j) * random() , (j * j) * random())
        returning
            t2_id into t2id;
            for k in 1..c_c loop
                insert into t3 (t2_fk , t3_v1 , t3_v2)
                values (t2id , (k * k) * random() , (k * k) * random())
            returning
                t3_id into t3id;
            end loop;
        end loop;
    end loop;
    commit;
end;
$BODY$;

drop table if exists t3;

drop table if exists t2;

drop table if exists t1;

create table t1 (
    t1_id bigserial primary key not null
    , t1_v1 integer not null
    , t1_v2 varchar(30) not null
);

create table t2 (
    t2_id bigserial primary key not null
    , t1_fk integer references t1 (t1_id)
    , t2_v1 integer not null
    , t2_v2 varchar(30) not null
);

create table t3 (
    t3_id bigserial primary key not null
    , t2_fk integer references t2 (t2_id)
    , t3_v1 integer not null
    , t3_v2 varchar(30) not null
);

\timing on
call insert_data_big ();


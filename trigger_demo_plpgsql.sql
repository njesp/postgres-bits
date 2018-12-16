drop table if exists master cascade;

drop table if exists master_hist cascade;

create table master (
    unit_id numeric(5 , 0) primary key not null
    , unit_detail varchar(30)
    , change_date timestamp not null default current_timestamp
);

create table master_hist (
    unit_id numeric(5 , 0) not null
    , unit_detail varchar(30)
    , archive_date timestamp default current_timestamp not null
);

create or replace function master_upd_fn ()
    returns trigger
as $$
begin
    if new.unit_detail != old.unit_detail then
        insert into master_hist (unit_id , unit_detail , archive_date)
        values (old.unit_id , old.unit_detail , current_timestamp);
    end if;
    return new;
end;
$$
language plpgsql;

create trigger master_upd_trg before
update
    on master for each row execute procedure master_upd_fn ();

insert into master (unit_id , unit_detail)
    values (1 , 'Original udgave') , (2 , 'Original nummer 2');

update
    master
set
    unit_detail = 'Nyt indhold'
    , change_date = current_timestamp
where
    unit_id = 1;

update
    master
set
    unit_detail = 'Endnu nyere indhold'
    , change_date = current_timestamp
where
    unit_id = 1;

select
    unit_id
    , unit_detail
    , change_date
from
    master;

select
    unit_id
    , unit_detail
    , archive_date
from
    master_hist;


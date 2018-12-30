-- Table: public.aisdata
drop table public.aisdata;

create table public.aisdata (
    tid timestamp(3) without time zone not null default now()
    , sys_id bigserial not null
    , txt text collate pg_catalog. "default" not null
    , constraint aisdata_pk primary key (sys_id))
with (oids = false) tablespace pg_default;

alter table public.aisdata owner to niels;


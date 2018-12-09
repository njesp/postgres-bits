-- Table: public.aisdata

 DROP TABLE public.aisdata;

CREATE TABLE public.aisdata
(
    tid timestamp(3) without time zone NOT NULL default now(),
    sys_id bigserial NOT NULL,
    txt text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT aisdata_pk PRIMARY KEY (sys_id)
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.aisdata
    OWNER to niels;
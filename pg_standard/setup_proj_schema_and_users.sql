revoke create on schema public
from
    public;

create schema p123456 authorization p123456_c;

grant all on schema p123456 to p123456_c;

grant usage on schema p123456 to p123456_r;

grant p123456_c to njn;

grant p123456_r to njn2;

alter default privileges for role p123456_c in schema p123456 grant select on tables to p123456_r;
alter default privileges for role p123456_c in schema p123456 grant select on sequences to p123456_r;
alter default privileges for role p123456_c in schema p123456 grant execute on routines to p123456_r;
alter default privileges for role p123456_c in schema p123456 grant usage on types to p123456_r;

-- connect njn, test at der er create. Tanken er at udviklere logger på som sig selv 
-- og via create rollen opretter objekter. read-rollen er en bred læserolle til schemaet. 
-- 
set search_path = p123456;
create table a (b numeric);
insert into a (b) values(1);
select b from a;

-- connect njn2, test at der er læse (via P123456_r)
-- 
select b from p123456.a;




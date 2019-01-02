-- Køres fra testdb databasen
-- psql -U postgres -d testdb -h localhost
revoke create on schema public
from
    public;

create schema p123456 authorization p123456_c;

--
grant all on schema p123456 to p123456_c;

grant usage on schema p123456 to p123456_r;

alter default privileges for role p123456_c in schema p123456 grant select on tables to p123456_r;

alter default privileges for role p123456_c in schema p123456 grant select on sequences to p123456_r;

alter default privileges for role p123456_c in schema p123456 grant execute on routines to p123456_r;

alter default privileges for role p123456_c in schema p123456 grant usage on types to p123456_r;

--
grant p123456_c to njn;

grant p123456_r to njn2;

--

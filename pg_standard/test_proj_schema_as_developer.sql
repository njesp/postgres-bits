-- Køres fra testdb databasen
-- psql -U njn -d testdb -h localhost
--
-- Test at der er create-rettighed. Udviklere logger på som sig selv og opretter objekter
-- via create-rollen. read-rollen er en bred læserolle til schemaet. 
-- 
-- set role sikrer at objekter oprettes som p123456_c og får denne som ejer.
-- Dette medfører at default privileges sat på schema for objekter oprettet som p123456_c virker. 
-- Hvis man opretter som sig selv (njn), så kan man sagtens, men default-rettighederne på schemaet
-- slår ikke igennem.
--
set role p123456_c;

set search_path = p123456;

create table a (
    b numeric
);

insert into a (b)
    values (1);

select
    b
from
    a;

select
    grantee
    , string_agg(privilege_type , ', ') as privileges
from
    information_schema.role_table_grants
where
    table_name = 'a'
group by
    grantee;

--

-- Køres fra testdb databasen
-- psql -U njn2 -d testdb -h localhost
--
-- Test at der er select-rettighed for en ikke-udvikler med read-rollen,
-- som er en bred læserolle til schemaet. 
-- 
set search_path = p123456;

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

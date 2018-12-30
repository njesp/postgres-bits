create or replace procedure insert_data (a_in integer , b_in integer)
language 'plpgsql'
as $BODY$
declare
    i integer := 0;
begin
    for j in i..a_in * b_in * 100 loop
        insert into t2 (b)
        values (j);
    end loop;
    --commit; Virker ikke når der kaldes fra Python
end;
$BODY$;

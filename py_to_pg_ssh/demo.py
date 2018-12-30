"""
Connect via SSH tunnel. Den der eksekverer skal kunne sshe igennem uden password
"""
import psycopg2
from sshtunnel import SSHTunnelForwarder

with SSHTunnelForwarder(ssh_address_or_host=('secretubox.westeurope.cloudapp.azure.com', 22),
                        remote_bind_address=('localhost', 5432)
                        ) as server:
    server.start()
    con = psycopg2.connect(
        f"dbname=postgres user=postgres password=password host=localhost port={server.local_bind_port}")
    cur = con.cursor()
    cur.execute(r"create table if not exists t2 (a timestamp default now(), b integer)")
    cur.execute(r"truncate table t2")
    cur.execute(r"insert into t2 (b) values(1)")
    cur.callproc('insert_data', 2, 2)
    cur.close()
    con.commit()
    con.close()

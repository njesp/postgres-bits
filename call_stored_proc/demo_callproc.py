import psycopg2
con = psycopg2.connect(dbname='postgres', user='postgres', password='password', host='localhost')
cur = con.cursor()
cur.execute(r"create table if not exists t2 (a timestamp default now(), b integer)")
cur.execute(r"truncate table t2")
# Egentlig burde det foregå via callproc, men den supporterer ikke stored procedures (nye i PostgreSQL 11)
cur.execute('call insert_data(%s,%s)', [2, 2])
cur.close()
con.commit()
con.close()
# Postgres og PgAdmin4

Postgres er bedst sammen med pgAdmin4

## Build

Docker-compose kombinerer de to docker images (postgres og pgadmin).

Filen docker-compose.yml beskriver sammenhængen mellem de containere der startes.

Ved første opstart kan man køre et sql-script efter eget valg. I docker-compose.yml er denne navngivet init.sql. 
Skal ligge i samme mappe som docker-compose.yml

```
# Current directory er hvor docker-compose.yml filen ligger
# Opret containere og start
docker-compose up
# I baggrunden:
docker-compose up -d
# Start stoppede containere
docker-compose start
# Stop
docker-compose stop
# Slet containere (ikke images)
docker-compose rm
# Uden prompt
docker-compose rm -f
```

## Use

Gå til [http://localhost:8080](http://localhost:8080)

Log på PgAdmin4 med username postgres@dst.dk og password postgres

### Opret connection til database

Create server.

Database er postgres, username er postgres, password er postgres. Hostname er postgres (service-navn fra docker-compose.yml)

Se logs fra Docker containere 

```
# Follow logs
docker-compose logs -f postgres
# eller 
docker-compose logs -f pgadmin
```

### connect 

```
docker exec -it pgd_postgres_1 psql -U postgres
```
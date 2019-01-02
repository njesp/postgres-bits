#!/usr/bin/env pwsh
# Kør Proof of Concept PostgreSQL scripts til at demonstrere 
# setuppet af databaseprojekter og rettigheder i PostgreSQL
#
Write-Host 'Opret database og roller/brugere'
psql -U postgres -d postgres -h localhost -f ./setup_db.sql
Write-Host 'Opret schema og sæt rettigheder'
psql -U postgres -d testdb -h localhost -f ./setup_proj_schema_and_users.sql
Write-Host 'Test at en bruger med udvikler-rolle kan oprette tabeller og at rettighederne bliver gode' 
psql -U njn -d testdb -h localhost -f ./test_proj_schema_as_developer.sql
Write-Host 'Test at en bruger med læse-rolle kan læse tabeller oprettet af projektet'
psql -U njn2 -d testdb -h localhost -f ./test_proj_schema_as_end_user.sql
#

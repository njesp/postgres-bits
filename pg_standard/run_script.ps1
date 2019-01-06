#!/usr/bin/env pwsh
# Kør Proof of Concept PostgreSQL scripts til at demonstrere 
# setuppet af databaseprojekter og rettigheder i PostgreSQL
#
#
# Tanken er at lade AD-grupper være autoritativ kilde til setuppet. 
# To standard-roller for hvert projekt. Et projekt er et schema. 
# Navnestandard P123456 er schema. P123456_C er create-rollen, som tildeles udviklere. P123456_R er 
# en standard læse-rolle, som der via default privs gives et sæt standard-rettigheder til. Hvis _R rollen ikke 
# giver mening i et givet projekt, så lader man være med at tildele den til nogen brugere. 
# Yderligere roller oprettes efter behov med P123456_ som prefix. De rettigheder disse roller har defineres 
# af projektet. Rollerne oprettes på baggrund af AD-gruppens eksistens. Tretegnsbrugere på PostgreSQL grantes
# roller ud fra medlemsskab af AD-gruppe. AD-grupper oprettes og får medlemmer via workflow. AD-gruppe har en 
# systemejer ud fra description. 
#
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

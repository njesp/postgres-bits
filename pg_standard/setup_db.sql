-- Køres fra postgres databasen
-- psql -U postgres -d postgres -h localhost
drop database if exists testdb;

drop role if exists njn;

drop role if exists njn2;

drop role if exists p123456_c;

drop role if exists p123456_r;

create database testdb with owner = postgres encoding = 'UTF8';

revoke all on database testdb
from
    public;

create role njn login password 'password' inherit;

create role njn2 login password 'password' inherit;

grant connect on database testdb to njn , njn2;

create role p123456_c noinherit;

create role p123456_r noinherit;


create table if not exists t (a int, b text);
\copy t(a, b) from stdin delimiter ';' csv
1;"abc"
2;"xyz"

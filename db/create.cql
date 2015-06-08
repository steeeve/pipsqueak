-- http://planetcassandra.org/getting-started-with-time-series-data-modeling/
-- INSERT INTO stats_by_day(label,date,time,value) VALUES ('foo','2013-04-03','2013-04-03 07:01:00','1');

CREATE KEYSPACE pipsqueak WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };

USE pipsqueak;

CREATE TABLE pips_by_day (
label text,
date text,
time timestamp,
value text,
PRIMARY KEY ((label,date),time)
);


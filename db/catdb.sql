DROP DATABASE IF EXISTS catdb;
CREATE DATABASE catdb WITH OWNER chase ENCODING 'UTF8';

DROP TABLE IF EXISTS cats;
CREATE TABLE cats (
	id serial PRIMARY KEY,
	name varchar(50) NOT NULL,
	about varchar(1000) NOT NULL,
	created_at timestamp DEFAULT current_timestamp
);

INSERT INTO cats (name, about) VALUES ('Cool Wiskerz', 'Chillin & meowin iz');
INSERT INTO cats (name, about) VALUES ('Jazzie', 'Fish bonez are my deal');
INSERT INTO cats (name, about) VALUES ('Simba', 'Hakuna matata');

DROP DATABASE IF EXISTS catdb;
CREATE DATABASE catdb WITH OWNER chase ENCODING 'UTF8';

DROP TABLE IF EXISTS cats;
CREATE TABLE cats (
	id serial PRIMARY KEY,
 	title varchar(50) NOT NULL,
 	body varchar(32000) NOT NULL,
 	created_at timestamp DEFAULT current_timestamp
);

INSERT INTO cats (title, body) VALUES ('Cats 1', 'Cats meow a lot');
INSERT INTO cats (title, body) VALUES ('Cats 2', 'Cats meow too much');
INSERT INTO cats (title, body) VALUES ('Cats 3', "Cats meow waay too much");

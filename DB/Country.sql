CREATE TABLE "Main".country (
	id serial4 NOT NULL,
	country_name varchar NULL,
	CONSTRAINT country_pk PRIMARY KEY (id)
);

INSERT INTO "Main".country
(id, country_name)
VALUES(1, 'Colombia');
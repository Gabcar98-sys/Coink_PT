
CREATE TABLE "Main".client (
	id serial4 NOT NULL,
	firstname varchar NULL,
	lastname varchar NULL,
	address varchar NULL,
	phonenumber int8 NULL,
	city_id int4 NULL,
	status int4 DEFAULT 1 NULL,
	CONSTRAINT client_pk PRIMARY KEY (id),
	CONSTRAINT client_city_fk FOREIGN KEY (city_id) REFERENCES "Main".city(id)
);

INSERT INTO "Main".client
(id, firstname, lastname, address, phonenumber, city_id, status)
VALUES(4, 'Gabriel', 'Cardenas', 'Cra. 21 #24 Sur-80, Bogotá', 3156571464, 107, 1);
INSERT INTO "Main".client
(id, firstname, lastname, address, phonenumber, city_id, status)
VALUES(8, 'Armando', 'Casas', 'Carrera 1-a 5-103', 3154785421, 1, 1);


CREATE OR REPLACE FUNCTION "Main".get_all_clients()
 RETURNS SETOF "Main".client
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT * FROM "Main"."client";
END;
$function$
;


CREATE TYPE "Main".client_info AS (
    firstname character varying,
    lastname character varying,
    address character varying,
    phonenumber bigint,
    city_name character varying,
    state_name character varying,
    country_name character varying
);

CREATE OR REPLACE FUNCTION "Main".get_client_by_id(p_client_id integer) 
RETURNS SETOF "Main".client_info
LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT 
        firstname, 
        lastname, 
        address, 
        phonenumber, 
        city_name,
		state_name,
		country_name
    FROM "Main"."client" cl 
	    INNER JOIN "Main"."city" c ON cl.city_id = c.id 
		INNER JOIN "Main"."state" s ON c.state_id = s.id 
		INNER JOIN "Main"."country" coun ON s.country_id = coun.id 
    WHERE 
		cl.id = p_client_id;
END;
$function$;


CREATE OR REPLACE PROCEDURE "Main".insert_client(IN p_first_name text, IN p_last_name text, IN p_address text, IN p_phone_number bigint, IN p_city_id integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    city_exists BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM "Main"."city" WHERE id = p_city_id)
    INTO city_exists;

    IF NOT city_exists THEN
        RAISE EXCEPTION 'La ciudad no existe.';
    ELSE
        INSERT INTO "Main"."client" (firstname, lastname, address, phonenumber, city_id)
        VALUES (p_first_name, p_last_name, p_address, p_phone_number, p_city_id);
    END IF;
END;
$procedure$
;



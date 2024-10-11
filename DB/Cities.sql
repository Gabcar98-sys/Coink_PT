CREATE TABLE "Main".city (
	id serial4 NOT NULL,
	city_name varchar NULL,
	state_id int4 NULL,
	status int4 DEFAULT 1 NULL,
	CONSTRAINT city_pk PRIMARY KEY (id),
	CONSTRAINT city_state_fk FOREIGN KEY (state_id) REFERENCES "Main".state(id)
);

CREATE OR REPLACE FUNCTION "Main".get_cities_by_state(p_state_id integer)
 RETURNS SETOF "Main".city
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT * FROM "Main"."city" where state_id = p_state_id;
END;
$function$
;

CREATE OR REPLACE PROCEDURE "Main".insert_city(IN p_city_name text, IN p_state_id integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    state_exists BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM "Main"."state" WHERE id = p_state_id)
    INTO state_exists;

    IF NOT state_exists THEN
        RAISE EXCEPTION 'El departamento no existe.';
    ELSE
		INSERT INTO "Main"."city" (city_name, state_id)
		VALUES(p_city_name, p_state_id);
    END IF;
END;
$procedure$
;

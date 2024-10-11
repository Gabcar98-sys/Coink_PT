CREATE TABLE "Main".state (
	id serial4 NOT NULL,
	state_name varchar NOT NULL,
	country_id int4 DEFAULT 1 NULL,
	CONSTRAINT state_pk PRIMARY KEY (id),
	CONSTRAINT state_country_fk FOREIGN KEY (country_id) REFERENCES "Main".country(id)
);

CREATE OR REPLACE FUNCTION "Main".get_states_by_country(p_country_id integer)
 RETURNS SETOF "Main".state
 LANGUAGE plpgsql
AS $function$
BEGIN
    RETURN QUERY SELECT * FROM "Main"."state" where country_id = p_country_id;
END;
$function$
;

CREATE OR REPLACE PROCEDURE "Main".insert_state(IN p_state_name text, IN p_country_id integer)
 LANGUAGE plpgsql
AS $procedure$
DECLARE
    country_exists BOOLEAN;
BEGIN
    SELECT EXISTS (SELECT 1 FROM "Main"."country" WHERE id = p_country_id)
    INTO country_exists;

    IF NOT country_exists THEN
        RAISE EXCEPTION 'El pais no existe.';
    ELSE
		INSERT INTO "Main"."state" (state_name, country_id)
		VALUES(p_state_name, p_country_id);
    END IF;
END;
$procedure$
;

INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(5, 'ANTIOQUIA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(8, 'ATLÁNTICO', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(11, 'BOGOTÁ, D.C.', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(13, 'BOLÍVAR', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(15, 'BOYACÁ', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(17, 'CALDAS', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(18, 'CAQUETÁ', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(19, 'CAUCA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(20, 'CESAR', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(23, 'CÓRDOBA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(25, 'CUNDINAMARCA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(27, 'CHOCÓ', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(41, 'HUILA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(44, 'LA GUAJIRA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(47, 'MAGDALENA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(50, 'META', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(52, 'NARIÑO', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(54, 'NORTE DE SANTANDER', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(63, 'QUINDIO', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(66, 'RISARALDA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(68, 'SANTANDER', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(70, 'SUCRE', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(73, 'TOLIMA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(76, 'VALLE DEL CAUCA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(81, 'ARAUCA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(85, 'CASANARE', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(86, 'PUTUMAYO', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(88, 'ARCHIPIÉLAGO DE SAN ANDRÉS, PROVIDENCIA Y SANTA CATALINA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(91, 'AMAZONAS', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(94, 'GUAINÍA', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(95, 'GUAVIARE', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(97, 'VAUPÉS', 1);
INSERT INTO "Main".state
(id, state_name, country_id)
VALUES(99, 'VICHADA', 1);
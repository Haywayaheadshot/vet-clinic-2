/* Database schema to keep the structure of entire database. */

CREATE TABLE animals
(
    id SERIAL PRIMARY KEY,
    name character varying(50),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weigth_kg double precision
);

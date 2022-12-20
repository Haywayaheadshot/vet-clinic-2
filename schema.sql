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


/* Modified table*/

CREATE TABLE IF NOT EXISTS public.animals
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 6 MINVALUE 6 MAXVALUE 2147483647 CACHE 1 ),
    name character varying(50) COLLATE pg_catalog."default",
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weigth_kg double precision,
    species text COLLATE pg_catalog."default",
    CONSTRAINT animals_pkey PRIMARY KEY (id)
)

-------------------

/*Query multiple tables*/

CREATE TABLE public.owners
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    full_name character varying,
    age integer,
    PRIMARY KEY (id)
);

CREATE TABLE public.species
(
    id integer NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 ),
    name character varying,
    PRIMARY KEY (id)
);

ALTER TABLE IF EXISTS public.animals
ADD COLUMN species_id integer;

ALTER TABLE animals
ADD CONSTRAINT species_id 
FOREIGN KEY (species_id) REFERENCES species (id);
    
ALTER TABLE IF EXISTS public.animals
ADD COLUMN owner_id integer;
    
ALTER TABLE animals
ADD CONSTRAINT owner_id 
FOREIGN KEY (owner_id) REFERENCES owners (id);


-------------------
/* Join Tables*/

CREATE TABLE public.vets
(
    id integer NOT NULL GENERATED ALWAYS AS IDENTITY,
    name character varying(255),
    age integer,
    date_of_graduation date,
    PRIMARY KEY (id)
);

CREATE TABLE public.specializations
(
    species_id integer,
    vets_id integer,
    PRIMARY KEY (vets_id, species_id),
    CONSTRAINT species_id FOREIGN KEY (species_id)
        REFERENCES public.species (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT vets_id FOREIGN KEY (vets_id)
        REFERENCES public.vets (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

CREATE TABLE public.visits
(
    animals_id integer,
    vets_id integer,
    date_of_visit date,
    CONSTRAINT animals_id FOREIGN KEY (animals_id)
        REFERENCES public.animals (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT vets_id FOREIGN KEY (vets_id)
        REFERENCES public.vets (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
);

-------------------
-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

--Create Indexes to optimize performance

CREATE INDEX animal_index ON visits(id_animals);
CREATE INDEX vet_index ON visits(id_vet);
CREATE INDEX ON owners (email);



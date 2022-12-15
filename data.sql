/* Populate database with sample data. */

INSERT INTO animals ("id","name","date_of_birth","escape_attempts","neutered","weigth_kg") VALUES (1, 'Agumon', "2020-02-03", 0, True, 10.23);
INSERT INTO animals ("id","name","date_of_birth","escape_attempts","neutered","weigth_kg") VALUES (2, 'Gabumon', "2018-11-15", 2, True, 8);
INSERT INTO animals ("id","name","date_of_birth","escape_attempts","neutered","weigth_kg") VALUES (3, 'Pikachu', "2021-01-07", 1, False, 15.04);
INSERT INTO animals ("id","name","date_of_birth","escape_attempts","neutered","weigth_kg") VALUES (4, 'Devimon', "2017-05-12", 5, True, 11);

----------------------

/* Update database */

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Charmander', '2020-02-08', 0, false, 11);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Plantmon', '2021-11-15', 2, true, 5.7);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Squirtle', '1993-04-02', 3, false, 12.13);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Angemon', '2005-06-12', 1, true, 45);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES ('Ditto', '2022-05-14', 4, true, 22);

----------------------

/* Add data to owners table */
INSERT INTO public.owners(
	full_name, age)
	VALUES ( 'Sam Smith', 34);
  
INSERT INTO public.owners(
	full_name, age)
	VALUES ( 'Jennifer Orwell', 19);
  
INSERT INTO public.owners(
	full_name, age)
	VALUES ( 'Bob', 45);
  
INSERT INTO public.owners(
	full_name, age)
	VALUES ( 'Melody Pond', 77);
  
INSERT INTO public.owners(
	full_name, age)
	VALUES ( 'Dean Winchester', 14);
  
INSERT INTO public.owners(
	full_name, age)
	VALUES ( 'Jodie Whittaker', 38);
  
  
 /* Add data to species table*/
 
INSERT INTO public.species(
	name)
	VALUES ('Pokemon');

INSERT INTO public.species(
	name)
	VALUES ('Digimon');
  
  /* Update animals table with species*/
  
UPDATE public.animals
	SET species_id=2
	WHERE name like '%mon';
  
UPDATE public.animals
	SET species_id=1
	WHERE species_id is null;
  
/* Update animals table with owners*/

UPDATE public.animals
	SET owner_id=1
	WHERE name= 'Agumon';

UPDATE public.animals
	SET owner_id=2
	WHERE name='Gabumon' OR name='Pikachu';
  
UPDATE public.animals
	SET owner_id=3
	WHERE name='Devimon' OR name='Plantmon';
  
UPDATE public.animals
	SET owner_id=4
	WHERE name='Charmander' OR name='Squirtle' OR name='Blossom';
  
UPDATE public.animals
	SET owner_id=5
	WHERE name='Angemon' OR name='Boarmon';
  
----------------------

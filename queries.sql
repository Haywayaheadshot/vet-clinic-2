/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';
select name from animals where date_of_birth between '2016-01-01' and '2019-12-31';
select name from animals where neutered = true and escape_attempts < 3;
select date_of_birth from animals where name in ('Agumon','Pikachu');
select name,escape_attempts from animals where weigth_kg > 10.5;
select * from animals where neutered = true;
select * from animals where name not  in ('Gabumon');
select * from animals where weigth_kg between 10.4 and 17.3;

/* New queries */
BEGIN;
UPDATE animals SET species= 'unspecified';
ROLLBACK;
SELECT * FROM animals;
/* */
BEGIN;
UPDATE animals SET species= 'pokemon';
COMMIT;
SELECT * FROM animals;
/* */
BEGIN;
UPDATE animals SET species= 'digimon' where name LIKE '%mon';
COMMIT;
SELECT * FROM animals;
/* */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
/* */
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
/* */
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT SP1;
UPDATE animals SET weigth_kg= weigth_kg * -1;
ROLLBACK TO SP1;
UPDATE animals SET weigth_kg= weigth_kg * -1;
COMMIT;


/* Custom Queries */
-- How many animals are there?
SELECT COUNT(name) FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals WHERE escape_attempts=0;
-- What is the average weigth of animals?
SELECT AVG(weigth_kg) from animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) from animals GROUP BY neutered;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) from animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;
-- What is the minimum and maximum weigth of each type of animal?
SELECT species, MIN(weigth_kg), MAX(weigth_kg) from animals GROUP BY species;

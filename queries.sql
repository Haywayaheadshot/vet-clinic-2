/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';
select name from animals where date_of_birth between '2016-01-01' and '2019-12-31';
select name from animals where neutered = true and escape_attempts < 3;
select date_of_birth from animals where name in ('Agumon','Pikachu');
select name,escape_attempts from animals where weigth_kg > 10.5;
select * from animals where neutered = true;
select * from animals where name not  in ('Gabumon');
select * from animals where weigth_kg between 10.4 and 17.3;

----------------------

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



----------------------

/* What animals belong to Melody Pond? */

SELECT * FROM animals as Animals
INNER JOIN owners as Owners
ON Animals.owner_id = Owners.id
WHERE full_name='Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */

SELECT * FROM animals as Animals
INNER JOIN species as Species
ON Animals.species_id = Species.id
WHERE Species.name= 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */

SELECT * FROM owners as Owners
LEFT JOIN animals as Animals
ON Owners.id = Animals.owner_id;

/* How many animals are there per species? */

SELECT Species.name, COUNT(Animals.species_id) FROM species as Species
INNER JOIN animals as Animals
ON Species.id= Animals.species_id
GROUP BY Species.name;

/* List all Digimon owned by Jennifer Orwell. */

SELECT * FROM animals as Animals
JOIN species as Species ON Species.id = Animals.species_id
JOIN owners as Owners ON Owners.id = Animals.owner_id
WHERE Species.name= 'Digimon' AND Owners.full_name = 'Jennifer Orwell';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT * FROM animals as Animals
JOIN owners as Owners ON Owners.id = Animals.owner_id
WHERE Animals.escape_attempts= 0 AND Owners.full_name= 'Dean Winchester';

/* Who owns the most animals? */

SELECT Animals.owner_id, Owners.full_name FROM animals as Animals
INNER JOIN owners as Owners
ON Animals.owner_id= Owners.id
GROUP BY Animals.owner_id, Owners.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;


----------------------

/* Who was the last animal seen by William Tatcher? */

SELECT vets.name, animals.name, date_of_visit FROM visits 
INNER JOIN animals
  ON animals.id = visits.animals_id
INNER JOIN vets
  ON vets.id = vets_id
WHERE date_of_visit = (SELECT MAX(date_of_visit) FROM visits where vets_id= 1);


/* How many different animals did Stephanie Mendez see? */

SELECT COUNT(animals_id) FROM visits WHERE vets_id= 3;

/* List all vets and their specialties, including vets with no specialties. */ 

SELECT vets.name, species.name FROM vets
LEFT JOIN specializations
  ON vets.id = specializations.vets_id
LEFT JOIN species
  ON species.id = species_id;
  
/* List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020. */ 

SELECT vets.name, animals.name, visits.date_of_visit FROM visits
INNER JOIN vets
  ON vets.id = visits.vets_id
INNER JOIN animals
  ON animals.id = animals_id
WHERE vets.name= 'Stephanie Mendez' AND date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';


/* What animal has the most visits to vets? */ 

SELECT animals.name FROM visits
INNER JOIN animals
  ON animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY COUNT(animals_id) DESC
LIMIT 1;


/* Who was Maisy Smith's first visit? */ 

SELECT date_of_visit, animals.name, vets.name FROM visits
INNER JOIN animals
  ON animals.id = visits.animals_id
INNER JOIN vets
  ON vets.id = vets_id
WHERE vets.name= 'Maisy Smith'
GROUP BY date_of_visit, animals.name, vets.name
ORDER BY date_of_visit ASC
LIMIT 1;


/* Details for most recent visit: animal information, vet information, and date of visit. */ 

SELECT date_of_visit, animals.name, animals.weigth_kg, animals.neutered, animals.date_of_birth, animals.escape_attempts,
  vets.name, vets.age, vets.date_of_graduation FROM visits
INNER JOIN animals
  ON animals.id = visits.animals_id
INNER JOIN vets
  ON vets.id = vets_id
ORDER BY date_of_visit DESC
LIMIT 1;


/* How many visits were with a vet that did not specialize in that animal's species? */ 

SELECT COUNT(animals.id) FROM visits 
INNER JOIN animals 
  ON animals.id = visits.animals_id
INNER JOIN vets
  ON vets.id = visits.vets_id
LEFT JOIN specializations
ON specializations.vets_id = visits.vets_id
WHERE animals.species_id != specializations.species_id AND vets.id!=3 OR specializations.species_id IS NULL;


/* What specialty should Maisy Smith consider getting? Look for the species she gets the most. */ 

SELECT species.name FROM visits
INNER JOIN animals 
  ON animals.id = visits.animals_id
INNER JOIN vets
  ON vets.id = visits.vets_id
INNER JOIN species
  ON species.id = species_id
WHERE vets.name= 'Maisy Smith'
GROUP BY 
species.name


----------------------

EXPLAIN ANALYZE SELECT COUNT(animals_id) FROM visits where animals_id = 4;
EXPLAIN ANALYZE SELECT (vets_id) FROM visits where vets_id = 2;
EXPLAIN ANALYZE SELECT DISTINCT(email) FROM owners where email = 'owner_18327@mail.com';

----------------------

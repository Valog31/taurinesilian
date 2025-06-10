-- EXERCICE 10 – Full scan et index
-- Suppression des contraintes  et vidage des tables

-- Suppression des contraintes pour pouvoir vider les tables 
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_material_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_disponibilite_fkey;
ALTER TABLE Disponibilite DROP CONSTRAINT IF EXISTS disponibilite_id_materiel_fkey;

-- Vidage  des tables avec réinitialisation des ID
TRUNCATE TABLE Reservation RESTART IDENTITY CASCADE;
TRUNCATE TABLE Disponibilite RESTART IDENTITY CASCADE;
TRUNCATE TABLE Materials RESTART IDENTITY CASCADE;
TRUNCATE TABLE User_ RESTART IDENTITY CASCADE;

-- Commentaire :
-- Cette étape vide  les tables principales et retire les contraintes
-- pour pouvoir tester ensuite les performances avec du volumes de données.
-- MEts do au bout de 2.74 Secondes : Query returned successfully in 2 secs 74 msec


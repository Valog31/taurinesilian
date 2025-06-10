
-- EXERCICE 7 : Requêtes avancées

-- 1. Afficher tous les utilisateurs ayant emprunté au moins un équipement
SELECT DISTINCT User_.ID, name, lastname
FROM User_
JOIN Reservation ON User_.ID = Reservation.ID;

-- 2. Afficher les équipements n’ayant jamais été empruntés
SELECT *
FROM Materials
WHERE Id_material NOT IN (
    SELECT Id_material FROM Reservation
);

-- 3. Afficher les équipements ayant été empruntés plus de 3 fois
SELECT Id_material, COUNT(*) AS nb_emprunts
FROM Reservation
GROUP BY Id_material
HAVING COUNT(*) > 3;

-- 4. Afficher le nombre d’emprunts pour chaque utilisateur, y compris ceux qui n’ont rien emprunté
SELECT User_.ID, name, lastname, COUNT(Reservation.Id_reservation) AS nb_emprunts
FROM User_
LEFT JOIN Reservation ON User_.ID = Reservation.ID
GROUP BY User_.ID, name, lastname
ORDER BY User_.ID;

-- Commentaire :
-- On utilise ici des jointures, des agrégations et des filtres 
-- Pour les équipements jamais empruntés, on compare avec les réservations 
-- Pour les emprunts > 3, on groupe par matériel et on mets HAVING.
-- La dernière requête utilise LEFT JOIN pour mêttre les utilisateurs sans emprunt.

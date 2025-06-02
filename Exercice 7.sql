1. Utilisateurs ayant emprunté au moins un équipement

SELECT DISTINCT u.ID, u.name, u.lastname
FROM User_ u
JOIN Reservation r ON u.ID = r.ID;



2. Équipements jamais empruntés

SELECT m.Id_material, m.name_material
FROM Materials m
LEFT JOIN Reservation r ON m.Id_material = r.Id_material
WHERE r.Id_reservation IS NULL;



3. Équipements empruntés plus de 3 fois

SELECT m.Id_material, m.name_material, COUNT(r.Id_reservation) AS nb_reservations
FROM Materials m
JOIN Reservation r ON m.Id_material = r.Id_material
GROUP BY m.Id_material, m.name_material
HAVING COUNT(r.Id_reservation) > 3;



4. Nombre d’emprunts par utilisateur (y compris ceux à 0)

SELECT 
    u.ID, 
    u.name, 
    u.lastname, 
    COUNT(r.Id_reservation) AS nb_emprunts
FROM User_ u
LEFT JOIN Reservation r ON u.ID = r.ID
GROUP BY u.ID, u.name, u.lastname
ORDER BY u.ID;

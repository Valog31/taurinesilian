-- EXERCICE 3 : Effectuer des requêtes de jointure

-- Une requête de jointure sur les utilisateurs ayant effectué une réservation
SELECT User_.ID, name, lastname, Reservation.Id_reservation, start_date, end_date
FROM User_
JOIN Reservation ON User_.ID = Reservation.ID;

-- Une requête de jointure pour récupérer les informations sur le matériel emprunté par un utilisateur donné
SELECT User_.ID, name, lastname, Materials.Id_material, name_material, state
FROM User_
JOIN Reservation ON User_.ID = Reservation.ID
JOIN Materials ON Reservation.Id_material = Materials.Id_material;

-- Commentaire :
-- Cet exercice montre comment relier les tables pour afficher des infos croisées,
-- par exemple quel utilisateur a emprunté quoi et à quelle date.

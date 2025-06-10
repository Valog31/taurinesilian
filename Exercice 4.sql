-- EXERCICE 4 : Effectuer des requêtes d'agrégation

-- Requête d’agrégation pour calculer le nombre total de réservations effectuées sur une période donnée
SELECT COUNT(*) AS nb_reservations
FROM Reservation
WHERE start_date >= '2024-05-01' AND end_date <= '2024-05-31';

-- Requête d’agrégation pour calculer le nombre d’utilisateurs ayant emprunté du matériel
SELECT COUNT(DISTINCT ID) AS nb_utilisateurs
FROM Reservation;

-- Commentaire :
-- Ici on utilise des fonctions d’agrégation comme COUNT pour obtenir des statistiques.
-- La première donne le nombre de réservations sur une période,
-- la deuxième le nombre d’utilisateurs uniques ayant fait au moins une réservation.

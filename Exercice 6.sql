-- EXERCICE 6 : Supprimer des données

-- Requête de suppression d’une réservation existante (res_005)
DELETE FROM Reservation
WHERE Id_reservation = 'res_005';

-- Requête de suppression des réservations dont la date de retour prévue est déjà passée
DELETE FROM Reservation
WHERE end_date < CURRENT_DATE;

-- Commentaire :
-- La première requête supprime la réservation 5.
-- La deuxième supprime toutes les réservations dont la fin est inférieure à aujourd’hui.

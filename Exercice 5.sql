-- EXERCICE 5 : Mettre à jour les données

-- Requête de modification de la quantité disponible d’un matériel (ex : on retire 1 unité au mat_001)
UPDATE Materials
SET quantity = quantity - 1
WHERE Id_material = 'mat_001';

-- Requête de modification de la quantité de tous les matériels qui sont en cours d'emprunt
-- et dont la date de retour (end_date) est dans plus de 2 jours
UPDATE Materials
SET quantity = quantity - 1
WHERE Id_material IN (
    SELECT Id_material
    FROM Reservation
    WHERE Statut = 'active'
      AND end_date > CURRENT_DATE + INTERVAL '2 days'
);

-- Commentaire :
-- La première requête met à jour manuellement la quantité d’un matériel après un emprunt.
-- La deuxième s’applique à tous les matériels empruntés dont la fin de réservation est prévue dans plus de 2 jours.
-- On utilise CURRENT_DATE et INTERVAL pour faire des comparaisons de dates dans PostgreSQL.
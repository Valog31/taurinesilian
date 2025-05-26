
Requête 1 — Supprimer une réservation spécifique
    Exemple : supprimer la réservation avec ID res_001
    DELETE FROM Reservation
    WHERE Id_reservation = 'res_001';



Requête 2 — Supprimer toutes les réservations dont la date de fin est passée
    DELETE FROM Reservation
    WHERE end_date < CURRENT_DATE;





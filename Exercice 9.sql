-- EXERCICE 9 : Gestion des retours de matériel avec contrôle des retards

-- 1. Création de la table RetourMateriel
CREATE TABLE RetourMateriel (
    id_retour SERIAL PRIMARY KEY,
    id_reservation VARCHAR(10) REFERENCES Reservation(Id_reservation),
    date_retour DATE,
    retard BOOLEAN
);

-- 2. Ajout d'une colonne dans Reservation pour enregistrer la date de retour effective
ALTER TABLE Reservation
ADD COLUMN date_retour_effectif DATE;

-- 3. Exemple d'insertion d'un retour de matériel à temps
INSERT INTO RetourMateriel (id_reservation, date_retour, retard)
VALUES ('res_001', '2024-05-15', FALSE);

-- 4. Exemple d'insertion d'un retour en retard
INSERT INTO RetourMateriel (id_reservation, date_retour, retard)
VALUES ('res_003', '2024-05-25', TRUE);

-- 5. Mise à jour de la table Reservation avec la date de retour 
UPDATE Reservation
SET date_retour_effectif = '2024-05-15'
WHERE Id_reservation = 'res_001';

UPDATE Reservation
SET date_retour_effectif = '2024-05-25'
WHERE Id_reservation = 'res_003';

-- 6. Vérifier les retards et calculer le montant des pénalités (5 € par jour)
SELECT
    r.Id_reservation,
    rm.date_retour,
    r.end_date,
    CASE
        WHEN rm.date_retour > r.end_date THEN 'En retard'
        ELSE 'À temps'
    END AS statut_retour,
    CASE
        WHEN rm.date_retour > r.end_date
        THEN (rm.date_retour - r.end_date) * 5
        ELSE 0
    END AS montant_penalite
FROM Reservation r
JOIN RetourMateriel rm ON r.Id_reservation = rm.id_reservation;

-- Commentaire :
-- Cette partie ajoute la gestion des retours dans une nouvelle table.
-- Le "retard" permet de savoir si l'étudiant est à l'heure
-- On met aussi à jour Reservation pour garder une trace 
-- La requête derniere permet de voir qui est en retard et combien il est endette

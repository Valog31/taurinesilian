-- EXERCICE 8 : Gestion des réservations avec contraintes de disponibilité

-- 1. Création de la table Disponibilite
CREATE TABLE Disponibilite (
    id_disponibilite SERIAL PRIMARY KEY,
    id_materiel VARCHAR(10) REFERENCES Materials(Id_material),
    date_debut DATE,
    date_fin DATE
);

-- 2. Ajout d’une colonne dans la table Reservation pour référencer la disponibilité utilisée
ALTER TABLE Reservation
ADD COLUMN id_disponibilite INTEGER REFERENCES Disponibilite(id_disponibilite);

-- 3. Exemple d’insertion de disponibilités
INSERT INTO Disponibilite (id_materiel, date_debut, date_fin) VALUES
('mat_001', '2024-06-01', '2024-06-15'),
('mat_002', '2024-06-05', '2024-06-20');

-- 4. Vérifier si un matériel est disponible pour une période donnée. Exemple : mat_001 demandé du 2024-06-10 au 2024-06-14
SELECT
    CASE
        WHEN '2024-06-10' >= date_debut AND '2024-06-14' <= date_fin
        THEN 'OK'
        ELSE 'KO'
    END AS disponibilite_statut
FROM Disponibilite
WHERE id_materiel = 'mat_001';

-- 5. Exemple d’insertion d’une réservation avec contrainte de disponibilité respectée 
INSERT INTO Reservation (Id_reservation, Statut, start_date, end_date, ID, Id_material, id_disponibilite)
VALUES ('res_006', 'active', '2024-06-10', '2024-06-14', '006', 'mat_001', 1);

-- 6. Gestion des disponibilités par les administrateurs (Ajouter une disponibilité)
INSERT INTO Disponibilite (id_materiel, date_debut, date_fin)
VALUES ('mat_003', '2024-07-01', '2024-07-10');

-- Modifier une disponibilité 
UPDATE Disponibilite
SET date_fin = '2024-07-15'
WHERE id_disponibilite = 3;

-- Supprimer une disponibilité
DELETE FROM Disponibilite
WHERE id_disponibilite = 2;

-- Commentaire :
-- On ajoute une contrainte à la réservation :
-- on ne peut réserver un matériel non dispo sur la période demandée.
-- On lie la réservation à une période de disponibilité via une clé étrangère.
-- Les admins peuvent aussi gérer les plages
-- Remplissage des tables

-- Insertion des utilisateurs
INSERT INTO User_ (ID, name, lastname) VALUES
('001', 'Alice', 'Durand'),
('002', 'Bob', 'Martin'),
('003', 'Claire', 'Lemoine'),
('004', 'David', 'Nguyen'),
('005', 'Emma', 'Petit'),
('006', 'Fabien', 'Lopez'),
('007', 'Gaëlle', 'Morel'),
('008', 'Hugo', 'Bernard'),
('009', 'Inès', 'Fabre'),
('010', 'Jules', 'Chevalier');

-- Insertion du matériel
INSERT INTO Materials (Id_material, name_material, state, quantity) VALUES
('mat_001', 'Ordinateur portable', 'bon', 5),
('mat_002', 'Vidéoprojecteur', 'moyen', 2),
('mat_003', 'Oscilloscope', 'bon', 3),
('mat_004', 'Imprimante 3D', 'mauvais', 1),
('mat_005', 'Multimètre', 'bon', 10),
('mat_006', 'Casque audio', 'bon', 7),
('mat_007', 'Caméra', 'moyen', 3),
('mat_008', 'Raspberry Pi', 'bon', 8),
('mat_009', 'Tablette', 'bon', 4),
('mat_010', 'Switch réseau', 'bon', 6);

-- Insertion des réservations
INSERT INTO Reservation (Id_reservation, Statut, start_date, end_date, ID, Id_material) VALUES
('res_001', 'active', '2024-05-10', '2024-05-15', '001', 'mat_001'),
('res_002', 'terminée', '2024-04-01', '2024-04-05', '002', 'mat_005'),
('res_003', 'active', '2024-05-12', '2024-05-20', '003', 'mat_003'),
('res_004', 'active', '2024-05-08', '2024-05-12', '004', 'mat_008'),
('res_005', 'terminée', '2024-03-20', '2024-03-25', '005', 'mat_002');

-- Commentaire :
-- Cet exercice sert à créer les trois tables principales (utilisateurs, matériel, réservation).
-- J’ai mis des identifiants lisibles en texte (ex : 'mat_001') pour que ce soit plus clair.


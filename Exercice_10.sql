-- Exercice 10 – SQL avec EXPLAIN ANALYZE et index

-- 1. On vide les tables pour repartir de zéro
TRUNCATE TABLE Reservation, Disponibilite, Materials, User_ RESTART IDENTITY CASCADE;

-- 2. On insère des données (exemple avec 1000 utilisateur)

DO $$
DECLARE i INT;
BEGIN
  FOR i IN 1..1000 LOOP
    INSERT INTO User_ (ID, name, lastname)
    VALUES (LPAD(i::text, 3, '0'), 'Nom_' || i, 'Prenom_' || i);
  END LOOP;
END $$;

-- Pareil pour les matériels
DO $$
DECLARE i INT;
BEGIN
  FOR i IN 1..1000 LOOP
    INSERT INTO Materials (Id_material, name_material, state, quantity)
    VALUES ('mat_' || LPAD(i::text, 3, '0'), 'Matériel ' || i, 'bon', 5);
  END LOOP;
END $$;

-- 3. Requête lente avec jointures
EXPLAIN ANALYZE
SELECT u.ID, u.name, r.start_date, m.name_material
FROM Reservation r
JOIN User_ u ON r.ID = u.ID
JOIN Materials m ON r.Id_material = m.Id_material
WHERE r.start_date > CURRENT_DATE - INTERVAL '30 days';

-- 4. Création des index pour accélérer
CREATE INDEX idx_reservation_user ON Reservation(ID);
CREATE INDEX idx_reservation_materiel ON Reservation(Id_material);
CREATE INDEX idx_reservation_start_date ON Reservation(start_date);

-- 5. Relancer la même requête (plus rapide normalement)
EXPLAIN ANALYZE
SELECT u.ID, u.name, r.start_date, m.name_material
FROM Reservation r
JOIN User_ u ON r.ID = u.ID
JOIN Materials m ON r.Id_material = m.Id_material
WHERE r.start_date > CURRENT_DATE - INTERVAL '30 days';

-- 6. Index GIN pour recherche floue
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE INDEX idx_name_gin ON User_ USING gin (name gin_trgm_ops);

-- Recherche avec LIKE optimisée
EXPLAIN ANALYZE
SELECT * FROM User_ WHERE name ILIKE '%Nom_12%';


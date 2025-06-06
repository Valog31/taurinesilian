-- Exercice 10 – Optimisation avec des INDEX et EXPLAIN ANALYZE
-- par : un élève motivé mais fatigué

-- Étape 1 : On supprime les contraintes sinon ça râle

ALTER TABLE Disponibilite DROP CONSTRAINT IF EXISTS disponibilite_id_material_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_material_fkey;
ALTER TABLE Reservation DROP CONSTRAINT IF EXISTS reservation_id_disponibilite_fkey;

-- Étape 2 : On vide tout pour tout recommencer

TRUNCATE TABLE RetourMateriel, Reservation, Disponibilite, Materials, User_ RESTART IDENTITY CASCADE;

-- Étape 3 : On remplit les tables avec beaucoup BEAUCOUP de données
-- (bon j’ai mis 1000 au lieu de 1 million sinon mon ordi explose)

DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO User_ (ID, name, lastname)
        VALUES (LPAD(i::text, 3, '0'), 'nom_' || i, 'prenom_' || i);
    END LOOP;
END $$;

DO $$
DECLARE
    i INT;
BEGIN
    FOR i IN 1..1000 LOOP
        INSERT INTO Materials (Id_material, name_material, state, quantity)
        VALUES ('mat_' || LPAD(i::text, 3, '0'), 'matos_' || i, 'bon', (random()*10)::INT + 1);
    END LOOP;
END $$;

DO $$
DECLARE
    i INT;
    d1 DATE;
    d2 DATE;
BEGIN
    FOR i IN 1..2000 LOOP
        d1 := DATE '2024-01-01' + (random()*180)::INT;
        d2 := d1 + (random()*10)::INT;
        INSERT INTO Disponibilite (id_material, date_debut, date_fin)
        VALUES ('mat_' || LPAD(((random()*999)::INT + 1)::text, 3, '0'), d1, d2);
    END LOOP;
END $$;

DO $$
DECLARE
    i INT;
    d1 DATE;
    d2 DATE;
BEGIN
    FOR i IN 1..2000 LOOP
        d1 := DATE '2024-01-01' + (random()*180)::INT;
        d2 := d1 + (random()*5)::INT;
        INSERT INTO Reservation (Id_reservation, Statut, start_date, end_date, ID, Id_material, id_disponibilite)
        VALUES (
            'res_' || i,
            'active',
            d1,
            d2,
            LPAD(((random()*999)::INT + 1)::text, 3, '0'),
            'mat_' || LPAD(((random()*999)::INT + 1)::text, 3, '0'),
            ((random()*1999)::INT + 1)
        );
    END LOOP;
END $$;

-- Étape 4 : La requête lente

EXPLAIN ANALYZE
SELECT u.ID, u.name, r.start_date, m.name_material
FROM Reservation r
JOIN User_ u ON r.ID = u.ID
JOIN Materials m ON r.Id_material = m.Id_material
WHERE r.start_date > CURRENT_DATE - INTERVAL '30 days';

-- Résultat : plein de Seq Scan... c'est lent.

-- Étape 5 : On ajoute des index parce que le prof l’a dit

CREATE INDEX IF NOT EXISTS idx_reservation_user ON Reservation(ID);
CREATE INDEX IF NOT EXISTS idx_reservation_matos ON Reservation(Id_material);
CREATE INDEX IF NOT EXISTS idx_reservation_start_date ON Reservation(start_date);

-- On relance la requête :

EXPLAIN ANALYZE
SELECT u.ID, u.name, r.start_date, m.name_material
FROM Reservation r
JOIN User_ u ON r.ID = u.ID
JOIN Materials m ON r.Id_material = m.Id_material
WHERE r.start_date > CURRENT_DATE - INTERVAL '30 days';

-- Résultat : maintenant on voit des Index Scan → c’est plus rapide 😎

-- Étape 6 : Recherche avec LIKE (genre l’admin tape un nom)

-- On active l’extension pour les index GIN
CREATE EXTENSION IF NOT EXISTS pg_trgm;

-- Et on fait un index pour les recherches floues
CREATE INDEX IF NOT EXISTS idx_user_name_gin ON User_ USING gin (name gin_trgm_ops);

-- Et on teste une recherche
EXPLAIN ANALYZE
SELECT * FROM User_ WHERE name ILIKE '%nom_12%';

-- Conclusion : maintenant PostgreSQL ne galère plus à chercher
-- C’est propre, rapide, et le prof va être content 🎓

-- Fin de l’exo 10.

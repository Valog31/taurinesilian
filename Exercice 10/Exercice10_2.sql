-- EXERCICE 10 – Étape 3 : Insertion de 2 000 000 lignes dans Disponibilite

DO $$
DECLARE
    i INT;
    start_date DATE;
    end_date DATE;
BEGIN
    FOR i IN 1..2000000 LOOP
        -- Génération aléatoire des dates
        start_date := DATE '2025-01-01' + (random() * 365)::INT;
        end_date := start_date + (random() * 30)::INT;

        INSERT INTO Disponibilite (id_materiel, date_debut, date_fin)
        VALUES (
            'mat_' || LPAD((random() * 99999)::INT + 1::text, 6, '0'),
            start_date,
            end_date
        );
    END LOOP;
END $$;

-- Commentaire :
-- On génère 2 millions de lignes avec des dates aléatoires.
-- L’id_materiel est au format 'mat_000001', 'mat_000542'...
-- Les plages de disponibilité durent jusqu’à 30 jours après le début.
-- MEts do au bout de 18 Secondes : Query returned successfully in 18 secs 220 msec
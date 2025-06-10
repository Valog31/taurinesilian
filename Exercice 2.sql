- EXERCICE 2 – Requêtes simples de sélection

-- 1. Afficher tous les utilisateurs
SELECT * FROM User_;

-- 2. Afficher tous les matériels
SELECT * FROM Materials;

-- 3. Afficher toutes les réservations
SELECT * FROM Reservation;

-- 4. Afficher uniquement les matériels en bon état
SELECT * FROM Materials
WHERE state = 'bon';

-- 5. Afficher les utilisateurs dont le nom commence par la lettre 'A'
SELECT * FROM User_
WHERE name LIKE 'A%';

-- 6. Afficher les réservations actives
SELECT * FROM Reservation
WHERE Statut = 'active';


-- 7. Afficher les matériels triés par quantité 
SELECT * FROM Materials
ORDER BY quantity DESC;

-- Commentaire :
-- Ces requêtes simples permettent de visualiser les contenus des tables
-- et de faire quelques premiers filtres ou tris .
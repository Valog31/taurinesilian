
##  1. Créer la table `Disponibilite`

```sql
CREATE TABLE Disponibilite (
    id_disponibilite SERIAL PRIMARY KEY,
    id_material VARCHAR(50) REFERENCES Materials(Id_material),
    date_debut DATE,
    date_fin DATE
);
```

---

##  2. Modifier la table `Reservation`

Ajoute une colonne `id_disponibilite` liée à la table `Disponibilite` :

```sql
ALTER TABLE Reservation
ADD COLUMN id_disponibilite INT REFERENCES Disponibilite(id_disponibilite);
```

---

##  3. Vérifier la disponibilité d’un matériel avant réservation

> Exemple : vérifier si le matériel `mat_001` est disponible du `2024-05-15` au `2024-05-20`.

```sql
SELECT
  CASE
    WHEN EXISTS (
      SELECT 1
      FROM Disponibilite d
      WHERE d.id_material = 'mat_001'
        AND d.date_debut <= DATE '2024-05-15'
        AND d.date_fin >= DATE '2024-05-20'
    )
    THEN 'OK'
    ELSE 'KO'
  END AS est_disponible;
```

---

##  4. Gérer les disponibilités (admin)

###  Ajouter une disponibilité

```sql
INSERT INTO Disponibilite (id_material, date_debut, date_fin)
VALUES ('mat_001', '2024-05-10', '2024-05-30');
```

### ✏ Modifier une période

```sql
UPDATE Disponibilite
SET date_fin = '2024-06-01'
WHERE id_disponibilite = 1;
```

###  Supprimer une période

```sql
DELETE FROM Disponibilite
WHERE id_disponibilite = 1;
```

---

##  5. Exemple complet : réserver un matériel **seulement si disponible**

Voici un script qui simule cette logique :

```sql
DO $$
DECLARE
  dispo_id INT;
BEGIN
  SELECT id_disponibilite INTO dispo_id
  FROM Disponibilite
  WHERE id_material = 'mat_001'
    AND date_debut <= DATE '2024-05-15'
    AND date_fin >= DATE '2024-05-20'
  LIMIT 1;

  IF dispo_id IS NOT NULL THEN
    INSERT INTO Reservation (Id_reservation, Statut, start_date, end_date, ID, Id_material, id_disponibilite)
    VALUES ('res_test', 'active', '2024-05-15', '2024-05-20', '001', 'mat_001', dispo_id);
  ELSE
    RAISE NOTICE 'Matériel non disponible pour cette période.';
  END IF;
END $$;
```

---


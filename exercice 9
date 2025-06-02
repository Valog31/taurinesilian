
##  1. Créer la table `RetourMateriel`

```sql
CREATE TABLE RetourMateriel (
    id_retour SERIAL PRIMARY KEY,
    id_reservation VARCHAR(50) REFERENCES Reservation(Id_reservation),
    date_retour DATE,
    retard BOOLEAN
);
```
---

##  2. Ajouter une colonne dans `Reservation` pour la date de retour effective

```sql
ALTER TABLE Reservation
ADD COLUMN date_retour_effectif DATE;
```

---

##  3. Calcul automatique du **retard**


```sql
DO $$
DECLARE
    reservation_id VARCHAR := 'res_003';
    retour_date DATE := '2024-05-22';
    date_fin DATE;
    retard_detecte BOOLEAN;
BEGIN
    -- Récupère la date de fin 
    SELECT end_date INTO date_fin
    FROM Reservation
    WHERE Id_reservation = reservation_id;

    -- Vérifie le retard
    retard_detecte := retour_date > date_fin;

    INSERT INTO RetourMateriel (id_reservation, date_retour, retard)
    VALUES (reservation_id, retour_date, retard_detecte);

    -- Met à jour la réservation a
    UPDATE Reservation
    SET date_retour_effectif = retour_date
    WHERE Id_reservation = reservation_id;
END $$;
```

---

##  4. Afficher les retours en retard et les pénalités - 5€ par jour de retard

```sql
SELECT 
    r.id_reservation,
    r.end_date,
    r.date_retour_effectif,
    GREATEST(r.date_retour_effectif - r.end_date, 0) AS nb_jours_retard,
    GREATEST(r.date_retour_effectif - r.end_date, 0) * 5 AS penalite_euros
FROM Reservation r
WHERE r.date_retour_effectif > r.end_date;
```



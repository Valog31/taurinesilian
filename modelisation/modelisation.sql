-- EXERCICE 1 – Création des tables + remplissage

-- Création des tables

-- Table des utilisateurs
CREATE TABLE User_ (
    ID VARCHAR(10) PRIMARY KEY,
    name VARCHAR(50),
    lastname VARCHAR(50)
);

-- Table du matériel
CREATE TABLE Materials (
    Id_material VARCHAR(10) PRIMARY KEY,
    name_material VARCHAR(100),
    state VARCHAR(20),
    quantity INTEGER
);

-- Table des réservations
CREATE TABLE Reservation (
    Id_reservation VARCHAR(10) PRIMARY KEY,
    Statut VARCHAR(20),
    start_date DATE,
    end_date DATE,
    ID VARCHAR(10),
    Id_material VARCHAR(10),
    FOREIGN KEY (ID) REFERENCES User_(ID),
    FOREIGN KEY (Id_material) REFERENCES Materials(Id_material)
);


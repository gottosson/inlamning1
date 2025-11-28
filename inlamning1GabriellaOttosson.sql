/*
Min lilla bokhandel
*/

CREATE DATABASE Bokhandel; -- skapar databasen
USE Bokhandel;

-- skapa kundtabellen
CREATE TABLE Kunder (
	KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100) NOT NULL, -- det måste finnas någonting, får inte vara tomt
	Email VARCHAR(255) UNIQUE NOT NULL,
    Telefon VARCHAR(100) UNIQUE NOT NULL,
    Adress VARCHAR(255) NOT NULL
    );
    
-- skapa produkttabellen
CREATE TABLE Produkter (
	ISBN VARCHAR(15) PRIMARY KEY,
    Titel VARCHAR(100) NOT NULL,
    Författare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK(Pris > 0),
    Lagerstatus INT DEFAULT 0 -- det kommer default att stå 0 istället för tomt
    );
    
-- skapa beställningar-tabellen
CREATE TABLE Bestallningar (
	Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Totalbelopp DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID) -- vi lånar KundID PK från Kunder-tabellen
    );
    
-- skapa orderrader-tabellen
CREATE TABLE Orderrader (
	OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    Ordernummer INT NOT NULL,
    ISBN VARCHAR(15) NOT NULL,
    Antal INT NOT NULL CHECK (Antal > 0),
    Pris DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Ordernummer) REFERENCES Bestallningar(Ordernummer),
    FOREIGN KEY (ISBN) REFERENCES Produkter(ISBN)
    );

-- nu infogar vi lite data i de olika tabellerna
INSERT INTO Kunder (Namn, Email, Telefon, Adress) VALUES
('Anna Lindberg', 'anna.lindberg@email.com', '+46701234567', 'Storgatan 12, 12345 Stockholm'),
('Johan Svensson', 'johan.svensson@email.com', '+46707654321', 'Lillvägen 7, 54321 Göteborg'),
('Maria Ekström', 'maria.ekstrom@email.com', '+46701122334', 'Björkvägen 2, 12233 Malmö'),
('Erik Holm', 'erik.holm@email.com', '+46704545456', 'Tallgatan 9, 56151 Huskvarna'),
('Sara Nilsson', 'sara.nilsson@email.com', '+46709988771', 'Ängsvägen 5, 38690 Kalmar');

INSERT INTO Produkter (ISBN, Titel, Författare, Pris, Lagerstatus) VALUES
('9789113100364', 'Vitön', 'Bea Uusma', '349', '25'),
('9789177754664', 'Tvättbjörnarnas stad', 'Fabian Göransson', '189', '15'),
('9789100199906', 'Den yttersta hemligheten', 'Dan Brown', '249', '50'),
('9789100808266', 'Artens överlevnad', 'Lydia Sandgren', '269', '19'),
('9789189928114', 'Klanen', 'Pascal Engman', '249', '27');

INSERT INTO Bestallningar (KundID, Totalbelopp) VALUES
('3', '538'),
('5', '249'),
('2', '518');


-- hämta data från Kunder-tabellen
SELECT Email, Telefon FROM Kunder;

-- filtrera data i Produkter-tabellen
SELECT * FROM Produkter WHERE Pris > 200; -- priset är över 200kronor

-- sortera data i Produkter-tabellen
SELECT * FROM Produkter ORDER BY Pris ASC; -- lägsta till högsta pris
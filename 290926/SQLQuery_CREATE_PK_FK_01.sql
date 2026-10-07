-- Datenbank erstellen
CREATE DATABASE TarifUebersicht;

-- Datenbank auswählen
USE TarifUebersicht;


-- Tabelle erstellen
CREATE TABLE ansprechpartner (
	ansprechpartnerNr INT IDENTITY PRIMARY KEY,
	vorname VARCHAR(50) NOT NULL,
	nachname VARCHAR(50) NOT NULL,
	telefon VARCHAR(30) NULL,
	email CHAR (75)NULL
	
);

CREATE TABLE kunde (
	kundenNr INT,
	CONSTRAINT kunden_id
		PRIMARY KEY (kundenNr),
	vorname VARCHAR(50)  NOT NULL,
	nachname VARCHAR(50) NOT NULL,
	strasse VARCHAR(50) NOT NULL,
	plz CHAR (5) NOT NULL,
	ort VARCHAR (50) NOT NULL,
	ansprechpartnerNr INT NOT NULL,
	CONSTRAINT fk_kunde
		FOREIGN KEY (ansprechpartnerNR)
		REFERENCES ansprechpartner (ansprechpartnerNr)
);

CREATE TABLE tarif (
	tarifNr INT IDENTITY PRIMARY KEY,
	bezeichungen VARCHAR (50) NULL
);

CREATE TABLE kunde_tarif (
	kunde_tarifNr INT IDENTITY  PRIMARY KEY,
	kundenNR INT,
	CONSTRAINT fk_kunde_tarif_kunde
		FOREIGN KEY (kundenNR)
		REFERENCES kunde (kundenNr),
	tarifNr INT,
	CONSTRAINT fk_kunde_tarif_tarif
		FOREIGN KEY (tarifNr)
		REFERENCES tarif (tarifNr),
	start_datum DATE NOT NULL,
	end_datum DATE NOT NULL
);
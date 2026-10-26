-- ВDatenbank erstellen
CREATE DATABASE fussballvereindb;

-- Datenbank auswählen
USE fussballvereindb;

-- Tabelle erstellen
CREATE TABLE Trainer (
	tr_id INT IDENTITY PRIMARY KEY,
	tr_vorname VARCHAR(50),
	tr_nachname VARCHAR(50),
	tr_geburt DATE,
	tr_license NVARCHAR (50)
);

CREATE TABLE Mannschaft (
	m_id INT IDENTITY PRIMARY KEY,
	m_bezeichnung VARCHAR(50),
	m_trainer INT,
	m_cotrainer INT,
	CONSTRAINT fk_mannschaft_trainer
		FOREIGN KEY (m_trainer) REFERENCES Trainer (tr_id),
	CONSTRAINT fk2_mannschaft_trainer
		FOREIGN KEY (m_cotrainer) REFERENCES Trainer (tr_id) 

);

CREATE TABLE Spieler (
	sp_id INT IDENTITY PRIMARY KEY,
	sp_vorname VARCHAR(50),
	sp_nachname VARCHAR(50),
	sp_geburt DATE,
	sp_passNr NVARCHAR (50),
	sp_m_id INT,
	CONSTRAINT fk_spieler_mannschaft
		FOREIGN KEY (sp_m_id) REFERENCES Mannschaft (m_id)
);

CREATE TABLE Spiel (
	spiel_id INT IDENTITY PRIMARY KEY,
	spiel_datum DATE,
	spiel_gegner VARCHAR(50)
	
);

CREATE TABLE SpielSpieler (
	sp_id INT,
	spiel_id INT,
	position VARCHAR(50),
	anfang DATE,
	endzeit DATE,
	CONSTRAINT pk_SpielSpieler
		PRIMARY KEY (sp_id, spiel_id, anfang),
	CONSTRAINT fk1_SpielSpieler_spieler
		FOREIGN KEY (sp_id) REFERENCES Spieler (sp_id),
	CONSTRAINT fk2_SpielSpieler_spiel
		FOREIGN KEY (spiel_id) REFERENCES Spiel (spiel_id),
);
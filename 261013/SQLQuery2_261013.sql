USE master;

-- Datenbank löschen, falls vorhanden
IF DB_ID('VereinDB') IS NOT NULL
BEGIN
	ALTER DATABASE VereinDB
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	DROP DATABASE VereinDB;
END

-- Datenbank erstellen
CREATE DATABASE VereinDB;
GO


CREATE Table Mannschaft (
	m_ID INT PRIMARY KEY,
	m_Bezeichnnung VARCHAR(50)

);

CREATE TABLE Trainer (
	t_ID INT,
	t_Name VARCHAR (50),
	t_Geburtsdatum DATE,
	m_ID INT,
	t_CoTrainerID INT,
	t_TrainerLicens NVARCHAR (20)
	CONSTRAINT pk_Trainer
		PRIMARY KEY (t_ID),
	CONSTRAINT fk_Trainer
		FOREIGN KEY (m_ID) REFERENCES Mannschaft(m_ID)
		);

CREATE TABLE SPIELER (
	s_ID INT,
	s_Name NVARCHAR(30),
	s_Geburtdatum DATE,
	s_SpielerPassNr INT,
	m_id INT
	CONSTRAINT pk_spieler
		PRIMARY KEY (s_ID),
	CONSTRAINT fk_spieler
		FOREIGN KEY (m_ID) REFERENCES Mannschaft(m_ID)

);

CREATE TABLE Spiel (
		spiel_ID INT,
		spieltag DATE,
		gegner1 INT,
		gegner2 INT
		CONSTRAINT pk_spiel
			PRIMARY KEY (spiel_ID),
		CONSTRAINT fk_spiel_manschaft
			FOREIGN KEY (gegner1) REFERENCES Mannschaft (m_ID),
		CONSTRAINT fk2_spiel_gegner
			FOREIGN KEY (gegner2) REFERENCES Mannschaft (m_ID)
			

);

CREATE TABLE spiel_spieler (
		s_ID INT,
		spiel_ID INT,
		position NVARCHAR (30),
		einsatzZeit DATE
		CONSTRAINT pk_spiel_spieler
			PRIMARY KEY (s_ID, spiel_ID, position),
		CONSTRAINT fk_spiel_spieler_spieler
			FOREIGN KEY (s_ID) REFERENCES Spieler (s_ID),
		CONSTRAINT fk_spiel_spieler_spiel
			FOREIGN KEY (spiel_ID) REFERENCES Spiel (spiel_ID)

);
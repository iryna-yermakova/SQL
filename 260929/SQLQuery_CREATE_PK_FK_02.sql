CREATE DATABASE BetribBedienungen;

USE BetribBedienungen;
GO

CREATE TABLE Abteilung (
	AbteilungNr INT IDENTITY,
	Bezeichnung VARCHAR(50) NOT NULL,
	Standort VARCHAR(50) NOT NULL,
	CONSTRAINT pk_abteilung
		PRIMARY KEY (AbteilungNr)
);

CREATE TABLE Mitarbeiter (
	PersonalNr INT IDENTITY,
	Vorname VARCHAR(50) NOT NULL,
	Nachname VARCHAR(50) NOT NULL,
	Geb_datum DATE,
	Gehalt MONEY,
	Taetigkeiten VARCHAR(50),
	AbteilungNr INT NOT NULL
	CONSTRAINT pk_mitarbeiter
		PRIMARY KEY (PersonalNr),
	CONSTRAINT fk_mitarbeiter_abteilung
		FOREIGN KEY (AbteilungNr)
		REFERENCES Abteilung (AbteilungNr)
);
CREATE TABLE Projekt (
	ProjektNr INT IDENTITY,
	Bezeichnung VARCHAR(50) NOT NULL,
	Projekt_begin DATE NOT NULL,
	Projekt_ende DATE NOT NULL,
	Leit_mitarbeit INT,
	CONSTRAINT pk_projekt
		PRIMARY KEY (ProjektNr),
	CONSTRAINT fk_projekt_leitet
		FOREIGN KEY (Leit_mitarbeit)
		REFERENCES Mitarbeiter (PersonalNr)

);

CREATE TABLE MitarbeiterProjekt (
	PersonalNr INT,
	ProjektNr INT,
	StundenZAhl FLOAT NOT NULL,
	CONSTRAINT fk_mitarbeiter_projekt_mitarbeiter
		FOREIGN KEY (PersonalNr)
		REFERENCES Mitarbeiter (PersonalNr),
	CONSTRAINT fk_mitarbeiter_projekt_projekt
		FOREIGN KEY (ProjektNr)
		REFERENCES Projekt (ProjektNr),
	CONSTRAINT pk_mitarbeiter_projekt
		PRIMARY KEY (PersonalNr, ProjektNr)

);
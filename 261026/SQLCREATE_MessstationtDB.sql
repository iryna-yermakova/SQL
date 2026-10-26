use master;
-- falls die DB vorhanden ist, löschen
DROP DATABASE IF EXISTS messstationdb;

-- Datenbank erstellen
CREATE DATABASE messstationdb;
GO



-- Datenbank auswählen
USE messstationdb;
GO

-- Tabelle erstellen
CREATE TABLE Region (
	reg_id INT IDENTITY PRIMARY KEY,
	reg_name VARCHAR(50)
	
);

CREATE TABLE Verarbeitungszentrum (
	vz_id INT IDENTITY PRIMARY KEY,
	vz_name VARCHAR(50)
	
);

CREATE TABLE Wetterelement (
	we_id INT IDENTITY PRIMARY KEY,
	we_name VARCHAR(50)
	
);

CREATE TABLE Messstation (
	ms_id INT IDENTITY PRIMARY KEY,
	ms_name VARCHAR(50),
	ms_reg_id INT,
	ms_vz_id INT,
	CONSTRAINT fk_Messstation_region
		FOREIGN KEY (ms_reg_id) REFERENCES Region (reg_id),
	CONSTRAINT fk_Messstation_verarbeitungszentrum
		FOREIGN KEY (ms_vz_id) REFERENCES Verarbeitungszentrum (vz_id)

);

CREATE TABLE Messgerät (
	mg_id INT IDENTITY PRIMARY KEY,
	mg_name VARCHAR(50)

);



CREATE TABLE MessstationMessgerät (
	ms_id INT,
	mg_id INT,
	CONSTRAINT pk_MessstationMessgerät
		PRIMARY KEY (ms_id, mg_id),
	CONSTRAINT fk_MessstationMessgerät_messstation
		FOREIGN KEY (ms_id) REFERENCES Messstation (ms_id),
	CONSTRAINT fk2_MessstationMessgerät_messgerät
		FOREIGN KEY (mg_id) REFERENCES Messgerät (mg_id) 

);

CREATE TABLE Mitarbeiter (
	mitar_id INT IDENTITY PRIMARY KEY,
	mitar_name VARCHAR(50)

);

CREATE TABLE MitarbeiterMessstation (
	mitar_id INT,
	ms_id INT,
	CONSTRAINT pk_MitarbeiterMessstation
		PRIMARY KEY (mitar_id, ms_id),
	CONSTRAINT fk_MitarbeiterMessstation_messstation
		FOREIGN KEY (ms_id) REFERENCES Messstation (ms_id),
	CONSTRAINT fk2_MitarbeiterMessstation_mitarbeiter
		FOREIGN KEY (mitar_id) REFERENCES Mitarbeiter (mitar_id) 

);

CREATE TABLE MessstationWetterelement (
	mw_we_id INT,
	mw_ms_id INT,
	CONSTRAINT pk_MessstationWetterelement
		PRIMARY KEY (mw_we_id, mw_ms_id),
	CONSTRAINT fk_MessstationWetterelement_messstation
		FOREIGN KEY (mw_ms_id) REFERENCES Messstation (ms_id),
	CONSTRAINT fk2_MessstationWetterelement_wetterelment
		FOREIGN KEY (mw_we_id) REFERENCES Wetterelement (we_id) 

);
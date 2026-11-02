--1. Schritt sich beim Datenbankserver anmelden bzw. einen Login erstellen
CREATE LOGIN hans WITH PASSWORD = 'hans123';

--2. Schritt User anlegen für den Login (Verbindung zum SQL-SERVER)
CREATE USER hans FOR LOGIN hans;

-- Leserte zuweisen mit GRANT

GRANT SELECT       --Zuweisung der Rechte (Deny, Revoke); Lesen : Select Schreiben
					-- INSERT, UPDATE, DELETE
ON dbo.Mitarbeiter -- ON-Klausel, Bezeichnungen des Objekts auf das sich die Recht beziehen
					-- hier dbo (databaseowner) Tabelle Mitarbeiter, SCHEMA::dbo
TO hans;


DENY SELECT		
ON dbo.Mitarbeiter 					
TO hans;

--mehrere Rechte gleichzeitig zuteilen zum lesen und schreiben für alle DBs

GRANT SELECT, INSERT, UPDATE, DELETE
ON SCHEMA :: dbo
TO hans;

SELECT *
FROM sys.database_permissions
WHERE grantee_principal_id = USER_ID('hans');

EXECUTE AS USER = 'hans';

SELECT * FROM dbo.Mitarbeiter;

REVERT;



SELECT
    permission_name,
    state_desc,
    class_desc
FROM sys.database_permissions
WHERE grantee_principal_id = USER_ID('hans');
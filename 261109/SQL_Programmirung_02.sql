--	Nutzen Sie die Datenbank ProjektDB zur 
--	Lösung dieser Aufgabe
USE ProjektDB;
GO

--	Aufgabe P1.1
--
--	Erstellen Sie eine gespeicherte Prozedur "sp_FilterMitarbeiter1",
--	die eine Liste der Mitarbeiter ausgibt, die in einer bestimmten
--	Abteilung arbeiten. Die Prozedur soll den Parameter @Abteilung
--	für die Bezeichnung der Abteilung entgegennehmen.
--
--	Beispiel: EXEC sp_FilterMitarbeiter1 'Einkauf'
--	
--	id     vorname  nachname  abt_id  bezeichnung
--	-----  -------  --------  ------  -----------
--	9912   Klaus    Wolf      a4      Einkauf
--	12121  Ursula   Richter   a4      Einkauf
--	20204  Dirk     Fuchs     a4      Einkauf
--	22222  Anke     Vogel     a4      Einkauf
CREATE OR ALTER PROCEDURE dbo.sp_FilterMitarbeiter1 @Abteilung VARCHAR(15)

AS
BEGIN
	SELECT m.id, m.vorname, m.nachname, m.abt_id, a.bezeichnung
	FROM Mitarbeiter m
		INNER JOIN Abteilung a ON m.abt_id = a.id
	WHERE a.bezeichnung = @Abteilung;
END;

EXEC dbo.sp_FilterMitarbeiter1 'Einkauf';

GO

--	Aufgabe P1.2
--
--	Verändern Sie die Prozedur aus Aufgabe P.1.
--	Wenn keine Mitarbeiter zur angeforderten Abteilung gefunden
--	werden, soll der Text 'Abteilung ungültig: <Bezeichnung>'
--	angezeigt werden. Entweder im Meldungs-Fenster oder im Grid.
--
--	Beispiel: EXEC sp_FilterMitarbeiter1 'Produktion'
--
--	Fehlermeldung
--	------------------------------
--	Abteilung ungültig: Produktion

CREATE OR ALTER PROCEDURE dbo.sp_FilterMitarbeiter1 @Abteilung VARCHAR(15)
AS
BEGIN
	IF EXISTS (SELECT a.bezeichnung FROM Abteilung a
			WHERE a.bezeichnung= @Abteilung)
	BEGIN 
	SELECT m.id, m.vorname, m.nachname, m.abt_id, a.bezeichnung
	FROM Mitarbeiter m
		INNER JOIN Abteilung a ON m.abt_id = a.id
	WHERE a.bezeichnung = @Abteilung
	END;
	ELSE
	BEGIN 
		PRINT 'Abteilung ungültig:' + @Abteilung
	END;
END;

EXEC dbo.sp_FilterMitarbeiter1 'Einkauff';

--Redur Lösung
GO
CREATE OR ALTER PROCEDURE sp_FilterMitarbeiter1
    @abt_bez VARCHAR(50)
AS
BEGIN
    IF @abt_bez IN (SELECT bezeichnung FROM Abteilung
                    WHERE @abt_bez = bezeichnung)
                    
            SELECT m.id, m.vorname, m.nachname, m.abt_id, ab.bezeichnung 
            FROM Mitarbeiter m
                JOIN Abteilung ab ON ab.id= m.abt_id
            WHERE @abt_bez = bezeichnung;

    ELSE
        PRINT 'Abteilung ungültig '
END;
GO

EXEC sp_FilterMitarbeiter1
    @abt_bez = 'Produktion';

DROP PROCEDURE IF EXISTS sp_FilterMitarbeiter1;
DROP PROCEDURE IF EXISTS dbo.Einkauf;

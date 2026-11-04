SELECT id, nachname, COALESCE (ort, 'kein Ort') AS ort
FROM Mitarbeiter;














SELECT m.id, m.nachname, COALESCE (p.bezeichnung, m.ort, '-k.A-') AS Angabe
FROM Mitarbeiter m
LEFT JOIN Arbeit a
ON a.mit_id = m.id AND a.aufgabe = 'Projektleiter'
LEFT JOIN Projekt p
ON p.id = a.pro_id;


-- Funktion TRIM entfernt Leerzeichen von Links und Rechts der Zeichenkette
SELECT '   Hallo   ' AS Ruf


SELECT TRIM('   Hallo    ') AS Ruf


SELECT CONCAT (TRIM(vorname), ' ', TRIM(nachname), ' ' TRIM(ort)) AS Name
FROM Mitarbeiter;

SELECT CONCAT_WS('-', TRIM(vorname),TRIM(nachname), TRIM(ort)) AS Name,
	LEN(vorname) AS LängeVorn,
	DATALENGTH(vorname) AS LängeByteVorn,  -- Unicode als nchar, nvarchar: 2Byte-Zeichen
	UPPER(vorname) AS GrossVorn,
	LOWER(vorname) AS KleinVorn,
	LEFT(vorname, 3) AS VornBis3,
	RIGHT(vorname, 3) AS VonRecht3Busr,
	SUBSTRING (vorname, 2, 4) AS TeilstringVonBis
FROM Mitarbeiter;

--Datumsfunktionen
--Aktuelle Datum
SELECT GETDATE() AS Zeitstempel,
	SYSDATETIME() AS Zeitstempel_datetime2;

SELECT einst_dat,
	DATENAME(dw, einst_dat) AS wochentag,
	DATENAME(month, einst_dat) AS month,
	DATENAME(wk, einst_dat) AS kalendarwoche,
	DATENAME(ISOWK, einst_dat) AS kalendarwocheEU
FROM Arbeit
WHERE DATENAME(month, einst_dat) = 'Dezember';


SELECT id, nachname,
	PATINDEX('%r', nachname) AS NanaMitsuche
FROM Mitarbeiter;

SELECT DATEADD(YEAR, 1, GETDATE()) AS aktDatumPlusJahr,
		DATEDIFF(day, '20261026', GETDATE()) AS DauerModul;

--Datentypen unwandeln
SELECT CAST(GETDATE() AS DATE) as datum, GETDATE() as aktDat;

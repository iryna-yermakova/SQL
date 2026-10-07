USE ProjektDB;

SELECT MIN (gehalt) AS mini,
	MAX(gehalt) AS maxi,
	AVG(gehalt) AS durch
FROM Gehalt;

SELECT SUM(gehalt) AS sume,
SUM(DISTINCT gehalt) AS einmlig
FROM Gehalt;

SELECT COUNT(*) AS alle,
	COUNT(ort) AS orte;
	COUNT(DISTINCT ort) AS eindeitige_orte
FROM Mitarbeiter;

SELECT COUNT(*) AS anzahl, nachname -- geht nicht
FROM Mitarbeiter;

SELECT COUNT(*) AS anzahl, STRING_AGG(nachname, ', ') AS namen
FROM Mitarbeiter;

-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:


-- ==================
-- Aggregatfunktionen
-- ==================

-- Aufgabe 4.1
--
-- Nennen Sie die kleinste Personalnummer der Mitarbeiter.
--
--      minimum
--		-------
--      2581
SELECT MIN(id) AS minimum
FROM Mitarbeiter;


-- Aufgabe 4.2
--
-- Berechnen Sie die Summe der finanziellen Mittel aller Projekte.
--
--      summe
--		---------
--      655000,00
SELECT SUM(mittel) AS summe
FROM Projekt;


-- Aufgabe 4.3
--
-- Berechnen Sie den arithmetischen Mittelwert der Geldbeträge, 
-- die höher als 92336,10 Euro sind.
--
--      durchschnitt
--		------------
--      141625,00

SELECT AVG(mittel) AS durchschnitt
FROM Projekt
WHERE mittel > 92336.10;

-- Aufgabe 4.4
--
-- Ermitteln Sie den höchsten, einzelnen Umsatz, der bisher erzielt wurde.
--
--      umsatz
--		---------
--      150000,00
SELECT MAX(umsatz) as umsatz
FROM Umsatz;


-- Aufgabe 4.5
--
-- Ermitteln Sie den kleinsten, einzelnen Umsatz, der im Jahr 2018 erzielt wurde.
--
--		umsatz
--		------
--		500,00

SELECT MIN(umsatz)
FROM Umsatz
WHERE YEAR(datum)=2018;

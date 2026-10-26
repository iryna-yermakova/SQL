-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;

-- Aufgabe 23.1
--
-- Nennen Sie die Abteilungsnummern der Mitarbeiter, die 
-- in Projekt 3 arbeiten. Nutzen Sie eine einfache 
-- Unterabfrage.
--
--      abt_id
--      2
--      2
--      3
--      5
SELECT abt_id
FROM Mitarbeiter
WHERE id IN ( SELECT mit_id FROM Arbeit
			WHERE pro_id = 3
			);


SELECT m.abt_id
FROM Mitarbeiter m
	INNER JOIN Arbeit a ON a.mit_id = m.id
WHERE a.pro_id = 3;


-- Aufgabe 23.2
--
-- Erstellen Sie eine Liste der Ids aller Mitarbeiter, 
-- deren Gehalt über dem  Durchschnitt liegt. Nutzen 
-- Sie eine einfache Unterabfrage.
--
--      mit_id
--      5765
--      9031
--      17000
--      22222
--      28559
--      29346
SELECT m.id
FROM Mitarbeiter m
	INNER JOIN Gehalt g ON g.mit_id = m.id
WHERE Gehalt > (SELECT AVG(Gehalt) 
				FROM Gehalt);

-- Aufgabe 23.3
--
-- Nennen Sie die Namen aller Mitarbeiter, die in einer 
-- Abteilung in Stuttgart arbeiten. Nutzen Sie eine 
-- einfache Unterabfrage.
--
--      nachname  vorname
--      Schäfer   Sabine
--      Huber     Petra
--      Keller    Hans
SELECT nachname, vorname
FROM Mitarbeiter 
WHERE abt_id = (SELECT id FROM Abteilung
		WHERE ort = 'Stuttgart'
		);

SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	INNER JOIN Abteilung a ON a.id = m.abt_id
WHERE a.ort = 'Stuttgart';


-- Aufgabe 23.4
--
-- Geben Sie eine Liste der Aufgaben im Projekt 1 aus und 
-- nennen Sie dazu den Namen des Mitarbeiters. Sortieren Sie
-- die Ausgabe nach der Aufgabe. Nutzen Sie eine korrelierte 
-- Unterabfrage im SELECT.
--
--      pro_id  aufgabe         nachname
--      1       NULL            Krüger
--      1       NULL            Mozer
--      1       Gruppenleiter   Meier
--      1       Projektleiter   Huber
--      1       Sachbearbeiter  Probst
SELECT a.pro_id, a.aufgabe,
	(SELECT nachname FROM Mitarbeiter m WHERE a.mit_id = m.id) as nachname
FROM Arbeit a
WHERE a.pro_id = 1
ORDER BY aufgabe ASC;


SELECT p.id, a.aufgabe, m.nachname
FROM Projekt p
	LEFT JOIN Arbeit a ON p.id = a.pro_id
	LEFT JOIN Mitarbeiter m ON m.id = a.mit_id
WHERE p.id = 1
ORDER BY a.aufgabe;


-- Aufgabe 23.5
--
-- Geben Sie eine Liste aller Abteilungsnamen aus. Geben 
-- Sie dazu aus, wie viele Mitarbeiter in der Abteilung 
-- arbeiten. Nutzen Sie eine korrelierte Unterabfrage 
-- im SELECT.
--
--      bezeichnung  anzahl
--      Beratung     2
--      Diagnose     3
--      Freigabe     3
--      Einkauf      4
--      Verkauf      3
SELECT a.bezeichnung,
		(SELECT COUNT(DISTINCT id) FROM Mitarbeiter m
		WHERE m.abt_id = a.id
		GROUP BY m.abt_id)as anzahl
FROM Abteilung a;

SELECT a.bezeichnung, COUNT(DISTINCT m.id) as anzahl
FROM Abteilung a
	INNER JOIN Mitarbeiter m ON m.abt_id = a.id
GROUP BY a.id, a.bezeichnung;

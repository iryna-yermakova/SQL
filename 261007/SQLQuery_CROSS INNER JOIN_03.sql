-- Nutzen Sie die ProjektDB-Datenbank, um die folgenden
-- Aufgaben zu lösen
USE ProjektDB;

-- Aufgabe 6.9
--
-- Nennen Sie einmalig die Namen der Projekte, in denen die 
-- Mitarbeiter arbeiten, die ein Gehalt von mindestens 
-- 5.000 € beziehen.
--
--      bezeichnung
--      Apollo
--      Ariane
--      Gemini
SELECT DISTINCT p.bezeichnung
FROM Projekt p
	INNER JOIN Arbeit ar ON p.id = ar.pro_id
	--INNER JOIN Mitarbeiter m ON m.id = ar.mit_id
	INNER JOIN Gehalt g ON g.mit_id = ar.mit_id
WHERE g.gehalt >= 5000;



-- Aufgabe 6.10
--
-- Erstellen Sie das Kartesische Produkt auf Mitarbeiter- und Abteilungs-Tabelle
--
--      id     nachname  vorname   abt_id  ort         chef_id  id  kuerzel  bezeichnung  ort
--      2581   Kaufmann  Brigitte  2       NULL        NULL     1   BE       Beratung     München
--      5765   Schäfer   Sabine    3       Landshut    2581     1   BE       Beratung     München
--      9031   Meier     Rainer    2       NULL        2581     1   BE       Beratung     München
--      9912   Wolf      Klaus     4       Heidenheim  22222    1   BE       Beratung     München
--      10102  Huber     Petra     3       Landshut    2581     1   BE       Beratung     München
--      12121  Richter   Ursula    4       München     22222    1   BE       Beratung     München
--      ...
--      (75 Zeilen)
SELECT *
FROM Mitarbeiter 
CROSS JOIN Abteilung;


-- Aufgabe 6.11
--
-- Finden Sie alle Mitarbeiter und dazu alle Abteilungen, in denen 
-- diese Mitarbeiter NICHT arbeiten.
--
--      id     nachname  vorname   abt_id  ort         chef_id  id  kuerzel  bezeichnung  ort
--      2581   Kaufmann  Brigitte  2       NULL        NULL     1   BE       Beratung     München
--      5765   Schäfer   Sabine    3       Landshut    2581     1   BE       Beratung     München
--      9031   Meier     Rainer    2       NULL        2581     1   BE       Beratung     München
--      9912   Wolf      Klaus     4       Heidenheim  22222    1   BE       Beratung     München
--      10102  Huber     Petra     3       Landshut    2581     1   BE       Beratung     München
--      12121  Richter   Ursula    4       München     22222    1   BE       Beratung     München
--      ...
--      (60 Zeilen)
SELECT *
FROM Mitarbeiter m
	CROSS JOIN Abteilung ab
WHERE m.abt_id <> ab.id;

SELECT *
FROM Mitarbeiter m
	INNER JOIN Abteilung a ON a.id <> m.abt_id;





-- Aufgabe 6.12
--
-- Nennen Sie die Abteilungsnamen der Mitarbeiter, die 
-- am 01.01.2019 eingestellt wurden.
--
--		bezeichnung
--		Freigabe
--		Einkauf
SELECT ab.bezeichnung
FROM Abteilung ab
	INNER JOIN Mitarbeiter m ON m.abt_id = ab.id
	INNER JOIN Arbeit ar ON m.id = ar.mit_id
WHERE ar.einst_dat = '20190101';



-- Aufgabe 6.13
--
-- Nennen Sie Namen und Vornamen aller Projektleiter, deren 
-- Abteilung den Standort Stuttgart hat.
--
--      nachname  vorname
--      Schäfer   Sabine
--      Huber     Petra

SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	INNER JOIN Arbeit ar ON m.id = ar.mit_id
	INNER JOIN Abteilung ab ON m.abt_id = ab.id 
	
WHERE ab.ort = 'Stuttgart' AND ar.aufgabe = 'Projektleiter';

-- Aufgabe 6.14
--
-- Nennen Sie einmalig die Namen der Projekte, in denen 
-- Mitarbeiter arbeiten, die zur Abteilung Beratung gehören.
--
--      bezeichnung
--      Apollo
--      Gemini
SELECT DISTINCT pr.bezeichnung
FROM Projekt pr
	INNER JOIN Arbeit ar ON ar.pro_id = pr.id 
	INNER JOIN Mitarbeiter m ON m.id = ar.mit_id
	INNER JOIN Abteilung ab ON ab.id = m.abt_id
WHERE ab.bezeichnung = 'Beratung';


-- Aufgabe 6.15
--
-- Nennen Sie die Kunden, an deren Projekten Mitarbeiter
-- arbeiten, die mindestens 5.000 € Gehalt bekommen. Nennen
-- Sie zu den Kunden auch die Anzahl dieser Mitarbeiter.
--
--      firma                    mitarbeiter
--      Finanzamt Ulm            2
--      Frankreich-Reisen GmbH   2
--      Technische Produkte oHG  1
SELECT k.firma, COUNT (DISTINCT ar.mit_id) as mitarbeiter
FROM Kunde k
	INNER JOIN Projekt p ON p.kunde_id = k.id
	INNER JOIN Arbeit ar ON ar.pro_id = p.id
	--INNER JOIN Mitarbeiter m ON m.id = ar.mit_id
	INNER JOIN Gehalt g ON g.mit_id = ar.mit_id
WHERE g.gehalt >= 5000
GROUP BY k.firma;


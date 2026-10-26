-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;

-- Aufgabe 7.1
--
-- Finden Sie alle Abteilungen, an deren Standorten 
-- sich weitere Abteilungen befinden. Geben Sie jeweils
-- alle Infos der Abteilungen aus.
--
--      id  kuerzel  bezeichnung  ort      id  kuerzel  bezeichnung  ort
--      1   BE       Beratung     München  1   BE       Beratung     München
--      2   DI       Diagnose     München  1   BE       Beratung     München
--      4   EK       Einkauf      München  1   BE       Beratung     München
--      1   BE       Beratung     München  2   DI       Diagnose     München
--      2   DI       Diagnose     München  2   DI       Diagnose     München
--      4   EK       Einkauf      München  2   DI       Diagnose     München
--      ...
--      (11 Zeilen)
SELECT *
FROM Abteilung a1
	INNER JOIN Abteilung a2 ON a1.ort = a2.ort;




-- Aufgabe 7.2
--
-- Überarbeiten Sie die Abfrage aus Aufgabe 7.1.
-- Diesmal sollen nur Zeilen ins Ergebnis übernommen 
-- werden, bei denen die Abteilungen sich unterscheiden.
--
--      id  kuerzel  bezeichnung  ort      id  kuerzel  bezeichnung  ort
--      1   BE       Beratung     München  2   DI       Diagnose     München
--      1   BE       Beratung     München  4   EK       Einkauf      München
--      2   DI       Diagnose     München  1   BE       Beratung     München
--      2   DI       Diagnose     München  4   EK       Einkauf      München
--      4   EK       Einkauf      München  1   BE       Beratung     München
--      4   EK       Einkauf      München  2   DI       Diagnose     München
SELECT *
FROM Abteilung a1
	INNER JOIN Abteilung a2 ON a1.ort = a2.ort 
WHERE a1.bezeichnung <> a2.bezeichnung;


-- Aufgabe 7.3
--
-- Überarbeiten Sie die Abfrage aus Aufgabe 7.2.
-- Diesmal soll jede Kombination nur einmal angezeigt 
-- werden. D.h. A-B ist das gleiche wie B-A.
--
--      id  kuerzel  bezeichnung  ort      id  kuerzel  bezeichnung  ort
--      2   DI       Diagnose     München  1   BE       Beratung     München
--      4   EK       Einkauf      München  1   BE       Beratung     München
--      4   EK       Einkauf      München  2   DI       Diagnose     München
SELECT *
FROM Abteilung a1
	INNER JOIN Abteilung a2 ON a1.ort = a2.ort 
WHERE a1.bezeichnung > a2.bezeichnung;


-- Aufgabe 7.4
--
-- Finden Sie heraus, ob es Mitarbeiter gibt, die einen 
-- Kollegen oder eine Kollegin aus derselben Abteilung 
-- in ihrem Wohnort haben (Stichwort Fahrgemeinschaft).
--
--      id     abt_id  nachname  ort
--      5765   3       Schäfer   Landshut
--      10102  3       Huber     Landshut
--      12121  4       Richter   München
--      22222  4       Vogel     München

SELECT m1.id, m1.abt_id, m1.nachname, m1.ort
FROM Mitarbeiter m1
	INNER JOIN Mitarbeiter m2 ON m1.abt_id = m2.abt_id  and m1.ort = m2.ort 
WHERE m1.id <>m2.id;

-- Aufgabe 7.5
--
-- Geben Sie die Mitarbeiter-Id, die Projektnummer und 
-- die Aufgabe der Mitarbeiter aus, die im gleichen 
-- Projekt die gleiche Aufgabe ausführen. Sortieren Sie
-- die Ausgabe ggf. sinnvoll.
--
--      mit_id  pro_id  aufgabe
--      25348   2       Sachbearbeiter
--      28559   2       Sachbearbeiter
--      20204   4       Sachbearbeiter
--      27365   4       Sachbearbeiter
SELECT a1.mit_id, a1.pro_id, a1.aufgabe
FROM Arbeit a1
	INNER JOIN Arbeit a2 ON a1.pro_id = a2.pro_id and a1.aufgabe = a2.aufgabe 
WHERE a1.mit_id <> a2.mit_id
ORDER BY a1.pro_id, a1.mit_id;


-- Aufgabe 7.6
--
-- Ermitteln Sie die Mitarbeiter mit Id, Vorname, Nachname
-- und dem Nachnamen des Vorgesetzten.
-- 
--      id     vorname   nachname  chef
--      5765   Sabine    Schäfer   Kaufmann
--      9031   Rainer    Meier     Kaufmann
--      9912   Klaus     Wolf      Vogel
--      10102  Petra     Huber     Kaufmann
--      12121  Ursula    Richter   Vogel
--      ...
--      (13 Zeilen)

SELECT m1.id, m1.vorname, m1. nachname, m2.nachname
FROM Mitarbeiter m1
	INNER JOIN Mitarbeiter m2 ON m1.chef_id = m2.id;

-- Aufgabe 7.7
--
-- Finden Sie die Abteilungen, in denen die beiden Vorgesetzten
-- Mitarbeiter arbeiten
--
--      id  kuerzel  bezeichnung  ort
--      2   DI       Diagnose     München
--      4   EK       Einkauf      München

SELECT DISTINCT ab2.*
FROM Mitarbeiter m1
	INNER JOIN Mitarbeiter m2 ON m1.chef_id = m2.id
	INNER JOIN Abteilung ab2 ON ab2.id = m2.abt_id
WHERE m2.abt_id = m1.abt_id;

-- Aufgabe 7.8
--
-- Ermitteln Sie, welche Mitarbeiter in der gleichen
-- Stadt wohnen wie ihre Vorgesetzten.
--
--      vorname  nachname  ort      chef_ort
--      Ursula   Richter   München  München
--      Rolf     Schubert  München  München

SELECT m1.id, m1.vorname, m1. nachname, m2.ort AS chef_ort
FROM Mitarbeiter m1
	INNER JOIN Mitarbeiter m2 ON m1.chef_id = m2.id
WHERE m1.ort = m2.ort;

-- Aufgabe 7.9
--
-- Ermitteln Sie, welche Mitarbeiter im gleichen Projekt
-- arbeiten wie ihre Vorgesetzten.
--
--      nachname  pro_id  chef_name  chef_pro_id
--      Huber     3       Kaufmann   3
--      Meier     3       Kaufmann   3
--      Krüger    5       Vogel      5
--      Wolf      5       Vogel      5

SELECT m1. nachname, a1.pro_id, m2.nachname AS chef_name, a2.pro_id as chef_pro_id
FROM Mitarbeiter m1
	INNER JOIN Mitarbeiter m2 ON m1.chef_id = m2.id
	INNER JOIN Arbeit a1 ON a1.mit_id = m1.id
	INNER JOIN Arbeit a2 ON a2.mit_id = m2.id
WHERE a1.pro_id = a2.pro_id
ORDER BY a1.pro_id, m1.nachname;

-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;

-- Aufgabe 21.1
--
-- Nennen Sie die kleinste Personalnummer der Mitarbeiter.
--
--      minimum
--      2581
SELECT MIN(id)
FROM Mitarbeiter;


-- Aufgabe 21.2
--
-- Berechnen Sie die Summe aller Gehälter der Mitarbeiter.
--
--      summe
--      54500,00
SELECT SUM(gehalt)
FROM Gehalt;


-- Aufgabe 21.3
--
-- Berechnen Sie den arithmetischen Mittelwert der Projekt-Mittel, 
-- die kleiner als 100.000 Euro sind.
--
--      durchschnitt
--      91750,00
SELECT AVG(mittel)
FROM Projekt
WHERE mittel <100000;

-- Aufgabe 21.4
--
-- Ermitteln Sie den kleinsten Umsatz, der je erzielt wurde.
--
--      umsatz
--      15,00
SELECT MIN(umsatz) AS umsatz
FROM Umsatz;


-- Aufgabe 21.5
--
-- Finden Sie heraus, in wie vielen verschiedenen Projekten die 
-- einzelnen Aufgaben ausgeübt werden. Nullwerte sollen nicht 
-- berücksichtigt werden!
--
--      aufgabe         anzahl
--      Gruppenleiter   3
--      Projektleiter   4
--      Sachbearbeiter  5
SELECT * FROM Arbeit;
SELECT aufgabe, COUNT(DISTINCT pro_id) AS anzahl
FROM Arbeit
WHERE aufgabe IS NOT NULL
GROUP BY aufgabe;


-- Aufgabe 21.6
--
-- Finden Sie heraus, wieviele Mitarbeiter in jedem Projekt arbeiten.
--
--      pro_id  anzahl
--      1       5
--      2       4
--      3       4
--      4       4
--      5       3
SELECT pro_id, COUNT(DISTINCT mit_id) AS anzahl
FROM Arbeit
GROUP BY pro_id;


-- Aufgabe 21.7
--
-- Gruppieren Sie die Reihen der Tabelle Arbeit nach den 
-- vorhandenen Aufgaben und zählen Sie die Anzahl der unter-
-- schiedlichen Mitarbeiter je Aufgabe.
--
--      aufgabe         anzahl
--      NULL            5
--      Gruppenleiter   3
--      Projektleiter   4
--      Sachbearbeiter  7
SELECT aufgabe, COUNT(DISTINCT mit_id) AS anzahl
FROM Arbeit
GROUP BY aufgabe;


-- Aufgabe 21.8
--
-- Wie viele "echte" Aufgaben nehmen die Mitarbeiter wahr,
-- deren Id kleiner als 20000 ist?
--
--      mit_id  anzahl
--      2581    1
--      5765    1
--      9031    2
--      9912    1
--      10102   2
--      12121   1
--      17000   0
--      18316   0
SELECT mit_id, COUNT(aufgabe)
FROM Arbeit
WHERE mit_id < 20000 
GROUP BY mit_id;


-- Aufgabe 21.9
--
-- Nennen Sie alle Projekte (pro_id), mit denen weniger als 
-- vier Mitarbeiter befasst sind.
--
--      pro_id  mitarbeiter
--      5      3
SELECT pro_id, COUNT(mit_id)
FROM Arbeit
GROUP BY pro_id
HAVING COUNT(mit_id) < 4;


-- Aufgabe 21.10
--
-- Finden Sie alle Mitarbeiter, die in mehr als einem Projekt arbeiten.
--
--      mit_id  projekte
--      9031    2
--      10102   2
--      17000   2
--      28559   2
--      29346   2
SELECT mit_id, COUNT(pro_id) AS projekte
FROM Arbeit
GROUP BY mit_id
HAVING COUNT(pro_id) > 1;


-- Aufgabe 21.11
-- 
-- Ermitteln Sie die Tage, an denen mehr als 50.000 €
-- Umsatz generiert wurde.
--
--      datum       umsatz
--      2019-02-01  150000,00
--      2019-05-01  100150,00
SELECT datum, SUM(umsatz) AS umsatz
FROM Umsatz
GROUP BY datum
HAVING SUM(umsatz) > 50000;


-- Aufgabe 21.12
--
-- Ermitteln Sie, welche Gehälter jeweils nur von genau einem
-- Mitarbeiter bezogen werden.
--
--      gehalt   mitarbeiter
--      1000,00  1
--      2500,00  1
--      4500,00  1
--      6000,00  1
SELECT gehalt, COUNT(mit_id)
FROM Gehalt
GROUP BY gehalt
HAVING COUNT(mit_id) = 1;


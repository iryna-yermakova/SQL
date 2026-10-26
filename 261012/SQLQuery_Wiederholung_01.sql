-- Nutzen Sie die Datenbank ProjektDB,
-- um die folgenden Aufgaben zu lösen.
USE ProjektDB;

-- Aufgabe 22.1
--
-- Schreiben Sie eine Abfrage, die Personalnummer,
-- Vorname, Nachname und den Name der Abteilung
-- der Mitarbeiter sortiert nach Personalnummer
-- ausgibt. Geben Sie nur die ersten drei Zeilen
-- aus.
--
--      id      vorname     nachname    bezeichnung
--      2581    Brigitte    Kaufmann    Diagnose
--      5765    Sabine      Schäfer     Freigabe
--      9031    Rainer      Meier       Diagnose
SELECT TOP(3) m.id, m.vorname, m.nachname, ab.bezeichnung
FROM Mitarbeiter m
	INNER JOIN Abteilung ab ON ab.id = m.abt_id
ORDER BY m.id ASC;

SELECT m.id, m.vorname, m.nachname, ab.bezeichnung
FROM Mitarbeiter m
	INNER JOIN Abteilung ab ON ab.id = m.abt_id
ORDER BY m.id ASC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

-- Aufgabe 22.2
--
-- Schreiben Sie eine Abfrage, die alle Projekt-Aufgaben 
-- mit den zugehörigen Projekten kombiniert. Geben Sie die
-- Felder pro_id, bezeichnung, mit_id und aufgabe aus. Sortieren 
-- Sie die Ausgabe nach pro_id aufsteigend und mit_id absteigend.
--
--      pro_id  bezeichnung mit_id  aufgabe
--      1       Apollo      29346   Sachbearbeiter
--      1       Apollo      28559   NULL
--      1       Apollo      17000   NULL
--      1       Apollo      10102   Projektleiter
--      1       Apollo      9031    Gruppenleiter 
--      ...
--      (20 Zeilen)
SELECT a.pro_id, pr.bezeichnung, a.mit_id, a.aufgabe
FROM Arbeit a
	INNER JOIN Projekt pr ON pr.id = a.pro_id
ORDER BY a.pro_id ASC, a.mit_id DESC;


-- Aufgabe 22.3
--
-- Erweitern Sie die Abfrage aus Aufgabe 22.2, indem Sie
-- zusätzlich noch den Nachnamen des Mitarbeiters im
-- Ergebnis mit ausgeben.
--
--      pro_id  bezeichnung mit_id  nachname    aufgabe
--      1       Apollo      29346   Probst      Sachbearbeiter
--      1       Apollo      28559   Mozer       NULL
--      1       Apollo      17000   Krüger      NULL
--      1       Apollo      10102   Huber       Projektleiter
--      1       Apollo      9031    Meier       Gruppenleiter
--      ...
--      (20 Zeilen)
SELECT a.pro_id, pr.bezeichnung, a.mit_id, m.nachname, a.aufgabe
FROM Arbeit a
	INNER JOIN Projekt pr ON pr.id = a.pro_id
	INNER JOIN Mitarbeiter m ON m.id = a.mit_id
ORDER BY a.pro_id ASC, a.mit_id DESC;


-- Aufgabe 22.4
--
-- Erweitern Sie die Abfrage aus Augfgabe 2.3, indem Sie
-- zusätzlich noch den Namen der Abteilung des Mitarbeiters
-- im Ergebnis anzeigen.
--
--      pro_id  bezeichnung mit_id  nachname    aufgabe         bezeichnung
--      1       Apollo      29346   Probst      Sachbearbeiter  Diagnose
--      1       Apollo      28559   Mozer       NULL            Beratung
--      1       Apollo      17000   Krüger      NULL            Verkauf
--      1       Apollo      10102   Huber       Projektleiter   Freigabe
--      1       Apollo      9031    Meier       Gruppenleiter   Diagnose
--      ...
--      (20 Zeilen)
SELECT a.pro_id, pr.bezeichnung, a.mit_id, m.nachname, a.aufgabe, ab.bezeichnung
FROM Arbeit a
	INNER JOIN Projekt pr ON pr.id = a.pro_id
	INNER JOIN Mitarbeiter m ON m.id = a.mit_id
	INNER JOIN Abteilung ab ON ab.id = m.abt_id
ORDER BY a.pro_id ASC, a.mit_id DESC;


-- Aufgabe 22.5
--
-- Finden Sie Namen und Vornamen aller Mitarbeiter, 
-- die im Projekt Merkur arbeiten.
--
--      nachname    vorname
--      Kaufmann    Brigitte            
--      Meier       Rainer              
--      Huber       Petra 
--      Schubert    Rolf
SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	INNER JOIN Arbeit a ON a.mit_id = m.id
	INNER JOIN Projekt pr ON pr.id = a.pro_id
WHERE pr.bezeichnung = 'Merkur';


-- Aufgabe 22.6
--
-- Nennen Sie Namen und Vornamen aller Projektleiter, deren 
-- Abteilung den Standort München hat.
--
--      nachname    vorname
--      Kaufmann    Brigitte
--      Vogel       Anke            

SELECT m.nachname, m.vorname
FROM Mitarbeiter m
	INNER JOIN Arbeit ar ON ar.mit_id = m.id 
	INNER JOIN Abteilung ab ON ab.id = m.abt_id
WHERE ar.aufgabe = 'Projektleiter' aND ab.ort = 'München';


-- Aufgabe 22.7
--
-- Nennen Sie einmalig die Namen der Projekte, in denen die 
-- Mitarbeiter arbeiten, die ein Gehalt von mindestens 
-- 5.000 € beziehen.
--
--      bezeichnung
--      Apollo
--      Ariane
--      Gemini
SELECT DISTINCT pr.bezeichnung
FROM Projekt pr 
	INNER JOIN Arbeit ar ON ar.pro_id = pr.id
	INNER JOIN Gehalt g ON g.mit_id = ar.mit_id
WHERE g.gehalt >= 5000;


-- Aufgabe 22.8
--
-- Finden Sie die Mitarbeiter, die das gleiche Gehalt
-- beziehen. Geben Sie die Personalnummer und das Gehalt
-- einmalig aus.
--
--      mit_id  gehalt
--      2581    3000,00
--      12121   3000,00
--      18316   3000,00
--      24321   3000,00
--      20204   3500,00
--      9912    3500,00
--      10102   3500,00
--      ...
--      (11 Zeilen)
SELECT DISTINCT g1.mit_id, g1.gehalt
FROM Gehalt g1
	INNER JOIN Gehalt g2 ON  g1.gehalt = g2.gehalt
	---INNER JOIN Mitarbeiter m ON m.id = g1.mit_id
WHERE g1.mit_id <> g2.mit_id
ORDER BY g1.gehalt;

SELECT mit_id, gehalt
FROM GEHALT
WHERE gehalt IN (
	SELECT gehalt FROM Gehalt 
	GROUP BY gehalt HAVING COUNT(*) > 1
	)
ORDER BY gehalt, mit_id;

-- Aufgabe 22.9
--
-- Finden Sie die Personalnummer, die Projektnummer
-- und die Aufgabe von Mitarbeitern aus, die die gleiche 
-- Aufgabe im gleichen Projekt ausführen.
--
--      mit_id  pro_id  aufgabe
--      25348   2       Sachbearbeiter
--      28559   2       Sachbearbeiter
--      20204   4       Sachbearbeiter
--      27365   4       Sachbearbeiter
SELECT a1.mit_id, a1.pro_id, a1.aufgabe
FROM Arbeit a1
	INNER JOIN Arbeit a2 ON a1.aufgabe = a2.aufgabe 
WHERE a1.pro_id = a2.pro_id and a1.mit_id <>a2.mit_id
ORDER BY a1.pro_id ASC, a1.mit_id ASC;


-- Aufgabe 22.10
--
-- Zeigen Sie alle Mitarbeiter der Abteilung 2 mit 
-- Personalnummer und Name an und geben Sie dazu die vom 
-- Mitarbeiter getätigten Umsätze aus. Hat der Mitarbeiter 
-- noch keine Umsätze getätigt, soll in der Spalte Umsatz 
-- eine 0 angezeigt werden.
--
--      id      nachname    umsatz
--      2581    Kaufmann    100000,00
--      9031    Meier       0,00
--      29346   Probst      0,00
SELECT m.id, m.nachname, COALESCE(SUM(u.umsatz), 0) 
FROM Abteilung ab
	LEFT JOIN Mitarbeiter m ON ab.id = m.abt_id 
	LEFT JOIN Umsatz u ON u.mit_id = m.id
WHERE ab.id = 2
GROUP BY m.id, m.nachname;


-- Aufgabe 22.11
--
-- Verändern Sie die Abfrage aus Aufgabe 22.10, indem Sie
-- jetzt alle Mitarbeiter anzeigen. Gruppieren Sie über
-- die Personalnummer und den Namen und geben Sie die Summe
-- der getätigten Umsätze aus. Wenn keine Umsätze getätigt
-- wurden, soll weiterhin eine 0 erscheinen.
--
--      id      nachname    umsatz
--      2581    Kaufmann    100000,00
--      5765    Schäfer     0,00
--      9031    Meier       0,00
--      9912    Wolf        0,00
--      10102   Huber       18000,00
--      12121   Richter     0,00
--      17000   Krüger      20000,00
--      18316   Müller      0,00
--      ...
--      (15 Zeilen)
SELECT m.id, m.nachname, COALESCE(SUM(u.umsatz), 0) 
FROM Mitarbeiter m 
	LEFT JOIN Abteilung ab ON ab.id = m.abt_id 
	LEFT JOIN Umsatz u ON u.mit_id = m.id
GROUP BY m.id, m.nachname;


-- Aufgabe 22.12
--
-- Verändern Sie die Abfrage aus Aufgabe 22.11, indem Sie
-- nur die Mitarbeiter anzeigen, die noch keine Umsätze 
-- getätigt haben.
--
--      id      nachname    umsatz
--      5765    Schäfer     0,00
--      9031    Meier       0,00
--      9912    Wolf        0,00
--      12121   Richter     0,00
--      18316   Müller      0,00
--      20204   Fuchs       0,00
--      22222   Vogel       0,00
--      24321   Schubert    0,00
--      27365   Albrecht    0,00
--      28559   Mozer       0,00
--      29346   Probst      0,00

SELECT m.id, m.nachname, COALESCE(SUM(u.umsatz), 0) 
FROM Mitarbeiter m 
	LEFT JOIN Abteilung ab ON ab.id = m.abt_id 
	LEFT JOIN Umsatz u ON u.mit_id = m.id
GROUP BY m.id, m.nachname
HAVING SUM(u.umsatz) IS NULL;

SELECT m.id, m.nachname, '0.00' AS umsatz
FROM Mitarbeiter m
LEFT JOIN Umsatz u ON u.mit_id = m.id
WHERE u.mit_id IS NULL;
----SELECT * FROM UMSATZ;

-- Aufgabe 22.13
--
-- Finden Sie alle Mitarbeiter mit Personalnummer und
-- Namen, die in keinem Projekt als Sachbearbeiter tätig sind.
--
--      id      nachname
--      2581    Kaufmann
--      5765    Schäfer
--      10102   Huber
--      12121   Richter
--      17000   Krüger
--      18316   Müller
--      22222   Vogel
--      24321   Schubert
SELECT DISTINCT m.id, m.nachname
FROM Mitarbeiter m
	LEFT JOIN Arbeit a ON m.id = a.mit_id
WHERE m.id NOT IN (SELECT mit_id FROM Arbeit WHERE aufgabe = 'Sachbearbeiter');

SELECT *
FROM Mitarbeiter m
	LEFT JOIN Arbeit a ON a.mit_id = m.id AND a.aufgabe = 'Sachbearbeiter'
WHERE a.mit_id IS NULL;




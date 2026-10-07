-- Nutzen Sie die Datenbank ProjektDB, 
-- um die folgenden Aufgaben zu lösen:
USE ProjektDB;

-- ======================
-- Einfache Unterabfragen
-- ======================

-- Aufgabe 5.1
--
-- Nennen Sie Personalnummer und Name des Mitarbeiters 
-- mit der kleinsten Personalnummer. Nutzen Sie eine 
-- einfache Unterabfrage.
--
--      id    nachname
--      2581  Kaufmann
SELECT * FROM Mitarbeiter;
SELECT MIN(id), nachname 
FROM Mitarbeiter
GROUP BY id;


-- Aufgabe 5.2
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
-------SELECT *FROM Arbeit;
-------SELECT * FROM Mitarbeiter;

-------SELECT mit_id
-------FROM Arbeit
-------WHERE pro_id = 3;

SELECT abt_id 
FROM Mitarbeiter
WHERE id IN (
		SELECT mit_id FROM Arbeit
		WHERE pro_id = 3
			);


-- Aufgabe 5.3
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

SELECT mit_id
FROM Gehalt
WHERE gehalt > (SELECT AVG(gehalt)
				FROM GEHALT);



-- Aufgabe 5.4
--
-- Nennen Sie die Nummern aller Projekte, in denen Mitarbeiter
-- arbeiten, deren Personalnummer kleiner als die Nummer des 
-- Mitarbeiters namens Müller ist. Nutzen Sie eine einfache 
-- Unterabfrage.
--
--      pro_id
--      1
--      3
--      4
--      5
SELECT DISTINCT pro_id
FROM Arbeit a
WHERE a.mit_id < 
			 (SELECT id
					FROM Mitarbeiter
					WHERE nachname LIKE 'Müller'
			);
		
					--SELECT id
					--FROM Mitarbeiter
					--WHERE id < (SELECT id
					--			FROM Mitarbeiter
					--			WHERE nachname LIKE 'Müller'
					--			);

					--SELECT id
					--FROM Mitarbeiter
					--WHERE nachname LIKE 'Müller';


-- Aufgabe 5.5
--
-- Nennen Sie die Namen aller Mitarbeiter, die in einer 
-- Abteilung in Ulm arbeiten. Nutzen Sie eine einfache 
-- Unterabfrage.
--
--      nachname  vorname
--      Krüger    Martin
--      Schubert  Rolf
--      Albrecht  Lena
SELECT nachname, vorname
FROM Mitarbeiter
WHERE abt_id IN (
		SELECT id FROM Abteilung
		WHERE ort = 'Ulm');

			--SELECT id
			--FROM Abteilung
			--WHERE ort LIKE 'Ulm';


			--SELECT * FROM Abteilung;
			--SELECT* FROM Mitarbeiter;

-- Aufgabe 5.6
--
-- Finden Sie die Personalnummer des Projektleiters, 
-- der in dieser Position als letzter einstellt wurde.
-- Nutzen Sie eine einfache Unterabfrage.
--
--      mit_id
--      2581
SELECT mit_id
FROM Arbeit
WHERE aufgabe = 'Projektleiter' AND einst_dat = (
				SELECT MAX(einst_dat) FROM Arbeit
				WHERE aufgabe LIKE 'Projektleiter'
				);

			----SELECT MAX(einst_dat)
			----FROM Arbeit
			----WHERE aufgabe LIKE 'Projektleiter'; 


-- Aufgabe 5.7
--
-- Nennen Sie die Namen aller Mitarbeiter, die im Projekt "Apollo" 
-- arbeiten. Nutzen Sie zwei verschachtelte Unterabfragen.
--
--      nachname
--      Meier
--      Huber
--      Krüger
--      Mozer
--      Probst
SELECT nachname
FROM Mitarbeiter
WHERE Mitarbeiter.id IN (
				SELECT mit_id
				FROM Arbeit
				WHERE Arbeit.pro_id IN (
							SELECT id FROM Projekt
							WHERE bezeichnung LIKE 'Apollo'
			));

						--SELECT id
						--FROM Projekt
						--WHERE bezeichnung LIKE 'Apollo';

						--SELECT * FROM Mitarbeiter;
						--SELECT * FROM Arbeit;
						--SELECT * FROM Projekt;

-- Aufgabe 5.8
--
-- Zeigen Sie Abteilungsnummer und den Namen der Abteilungen 
-- für die Mitarbeiter an, die am Projekt "Apollo" mitarbeiten. 
-- Nutzen Sie drei verschachtelte Unterabfragen.
--
--      id  bezeichnung
--      1   Beratung
--      2   Diagnose
--      3   Freigabe
--      5   Verkauf
SELECT id, bezeichnung
FROM Abteilung
WHERE id IN (
		SELECT abt_id
		FROM Mitarbeiter
		WHERE id IN ( 
				SELECT mit_id FROM Arbeit
				WHERE pro_id IN (
							SELECT id FROM Projekt
							WHERE bezeichnung = 'Apollo'
								)
					)
			);


SELECT id
FROM Projekt
WHERE bezeichnung = 'Apollo';

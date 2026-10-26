USE ProjektDB;

SELECT *
FROM Mitarbeiter m1
	INNER JOIN Mitarbeiter m2 ON m1.chef_id = m2.id;

SELECT *
FROM Gehalt g1
	INNER JOIN Gehalt g2 ON g1.gehalt = g2.gehalt
WHERE g1.mit_id <> g2.mit_id
ORDER BY g1.gehalt;
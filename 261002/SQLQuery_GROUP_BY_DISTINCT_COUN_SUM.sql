USE ProjektDB;

SELECT abt_id
FROM Mitarbeiter
GROUP BY abt_id;

SELECT DISTINCT abt_id
FROM Mitarbeiter;

SELECT abt_id, COUNT(*) AS anzahl
FROM Mitarbeiter
GROUP BY abt_id;

SELECT abt_id,nachname, COUNT(*) AS anzahl ---- geht nicht
FROM Mitarbeiter
GROUP BY abt_id;

SELECT abt_id, nachname, COUNT(*) AS anzahl
FROM Mitarbeiter
GROUP BY abt_id, nachname;

SELECT abt_id, STRING_AGG(nachname, ','), COUNT(*) AS anzahl
FROM Mitarbeiter
GROUP BY abt_id;

SELECT datum, SUM(umsatz) AS umsatz
FROM Umsatz
GROUP BY datum;

SELECT YEAR(datum), SUM(umsatz) AS umsatz
FROM Umsatz
GROUP BY YEAR(datum);

SELECT ort, COUNT(*) AS anzahl
FROM Mitarbeiter
GROUP BY ort;
USE ProjektDB;

SELECT mit_id, SUM(umsatz) AS umsatz
FROM umsatz
--WHERE SUM(umsatz) < 100000 geht nicht
GROUP BY mit_id
HAVING SUM(umsatz) < 200000; --das geht!


SELECT mit_id, SUM(umsatz) AS umsatz
FROM umsatz
GROUP BY mit_id
HAVING YEAR(datum) = 2018;-- geht nicht

SELECT mit_id, SUM(umsatz) AS umsatz
FROM umsatz
WHERE YEAR(datum) = 2018
GROUP BY mit_id
HAVING SUM(umsatz) < 100000;

SELECT mit_id, SUM(umsatz) AS umsatz
FROM umsatz
WHERE YEAR(datum) = 2018       -- "normale" Daten filtern
GROUP BY mit_id
HAVING SUM(umsatz) < 100000    -- Agregate filtern
ORDER BY mit_id DESC;          -- nur Agregete oder aus GROUP BY

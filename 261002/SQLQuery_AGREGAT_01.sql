USE ProjektDB;

SELECT *
FROM Mitarbeiter
ORDER BY ort DESC;

SELECT TOP (1) *
FROM Mitarbeiter
ORDER BY vorname DESC;

SELECT TOP (1) WITH TIES *
FROM Mitarbeiter
ORDER BY abt_id DESC;
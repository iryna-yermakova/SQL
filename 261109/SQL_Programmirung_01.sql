-- Variablen Deklaration
DECLARE @zahl1 int = 11, @zahl2 int = 22;
DECLARE @ergebnis int;

-- Wertzuweisung
SET @ergebnis = @zahl1 * @zahl2;

-- Ausgabe im Meldungsfenster
PRINT @ergebnis;

-- Ausgabe im Ergebnisfenster
SELECT @ergebnis;

-- Kombinierte Ausgabe
PRINT 'Das Ergebnis lautet: ' + CAST(@ergebnis AS varchar(10));

-- Ende Batch
GO



-----------------------------------------------
--Declaration und Initialisirung
DECLARE @zahl INT = 44;

-- Die IF-/ELSE-Anweisung
IF @zahl = 42
    BEGIN
        PRINT '@zahl = 42';
    END
IF @zahl < 42
    BEGIN
        PRINT '@zahl < 42';
    END
ELSE
    BEGIN
        PRINT '@zahl > 42';
END

-- Nach der IF/ELSE-Anweisung geht es normal weiter
PRINT 'Das ist das Ende!';
GO

-- Die Einrückungen sind natürlich optional.
-- BEGIN und END sind auch optional, wenn innerhalb
-- des Blocks nur eine Anweisung steht.

-------------------------------------
-- Deklaration der Variablen
DECLARE @zahl INT = 42;
DECLARE @text VARCHAR(30);

-- Text für Ausgabe auswählen
SET @text = CASE @zahl
    WHEN 42 THEN 'Treffer!'
    WHEN 41 THEN 'Ein kleines bisschen zu wenig.'
    WHEN 43 THEN 'Ein kleines bisschen zu viel.'
    ELSE 'Voll daneben!'
END;

-- Ausgabe
PRINT @text;
GO

-- WHEN ... THEN kann sich beliebig oft wiederholen
-- Der ELSE-Zweig ist optional


-------------------------------------------
-- Deklaration
DECLARE @zahl TINYINT = 30;

-- Schleife
WHILE @zahl < 42
BEGIN
    PRINT 'Wir sind aktuell bei ' + CAST(@zahl AS char(2));
    SET @zahl = @zahl + 1;
END

-- Ausgabe am Ende
IF @zahl = 42
    PRINT 'Wir haben es geschafft: ' + CAST(@zahl AS char(2));
ELSE
    PRINT 'Wir wollten zu hoch hinaus ...';

GO

------------------------------------------
-- Deklaration
DECLARE @zahl TINYINT = 55;

-- Schleife
WHILE @zahl < 42
BEGIN
    PRINT 'Wir sind aktuell bei ' + CAST(@zahl AS char(2));
    SET @zahl = @zahl + 1;
END

-- Ausgabe am Ende
IF @zahl = 42
    PRINT 'Wir haben es geschafft: ' + CAST(@zahl AS char(2));
ELSE
    PRINT 'Wir wollten zu hoch hinaus ...';

-- Mit BREAK kann die Bearbeitung der Schleife abgebrochen werden
-- Mit CONTINUE kann der nächste Schleifendurchlauf erzwungen werden

-----------------------------------

-- Deklaration
DECLARE @zahl1 TINYINT = 10;
DECLARE @zahl2 TINYINT = 0;

-- Ausführung ohne TRY/CATCH
PRINT 'Addition:';
SELECT @zahl1 + @zahl2;

PRINT 'Subtraktion:';
SELECT @zahl1 - @zahl2;

PRINT 'Division:';
SELECT @zahl1 / @zahl2;

PRINT 'Multiplikation:';
SELECT @zahl1 * @zahl2;

-- Ende
PRINT 'Fertig!';



-----------------------
-- Deklaration
DECLARE @zahl1 TINYINT = 10;
DECLARE @zahl2 TINYINT = 0;

-- Ausführung mit TRY/CATCH
BEGIN TRY
    SET NOCOUNT ON;
    PRINT 'Addition:' + CAST(@zahl1 + @zahl2 AS VARCHAR(10));
    ---SELECT @zahl1 + @zahl2;  

    
    PRINT 'Subtraktion:' + CAST(@zahl1 - @zahl2 AS VARCHAR(10));
    ---SELECT @zahl1 - @zahl2 as Ergebnise;

    PRINT 'Division:' + CAST(@zahl1 / @zahl2 AS VARCHAR(10));
    ---SELECT @zahl1 / @zahl2 as Ergebnise;

    PRINT 'Multiplikation:' + CAST(@zahl1 * @zahl2 AS VARCHAR(10));
    ----SELECT @zahl1 * @zahl2 as Ergebnise;
END TRY
BEGIN CATCH
    PRINT 'Im CATCH-Block';
END CATCH

PRINT 'Fertig!';



------------------
BEGIN TRY
    -- Ein "divide by zero"-Error
    -- wird provoziert:
    SELECT 1 / 0;
END TRY
BEGIN CATCH
    -- Ausgabe der relevanten
    -- Informationen als Tabelle
    SELECT
        ERROR_NUMBER()    AS errNum,
        ERROR_SEVERITY()  AS errSev,
        ERROR_STATE()     AS errState,
        ERROR_PROCEDURE() AS errProc,
        ERROR_LINE()      AS errLine,
        ERROR_MESSAGE()   AS errMess;
END CATCH
GO
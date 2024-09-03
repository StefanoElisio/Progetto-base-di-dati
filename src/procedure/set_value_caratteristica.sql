DROP PROCEDURE IF EXISTS set_value_caratteristica;
DELIMITER $$
-- procedura per aggiungere un valore ad una caratteristica di una richiesta
CREATE PROCEDURE set_value_caratteristica(
    ID_richiesta_acquisto INTEGER UNSIGNED,
    ID_caratteristica INTEGER UNSIGNED,
    valore VARCHAR(100)
)
BEGIN
    DECLARE caratteristica_esiste BIT;
    DECLARE ID_categoria INTEGER UNSIGNED;
    -- ricerca categoria associata iniziale
    SET ID_categoria = (
        SELECT ID_categoria
        FROM richiesta_acquisto ra
        WHERE ra.ID = ID_richiesta_acquisto
    );
    -- ricerca categorie
    CREATE TEMPORARY TABLE temp_caratteristiche AS
    WITH RECURSIVE CTE_Categorie AS (
        -- Seleziona la categoria iniziale
        SELECT ID, ID_padre
        FROM categoria
        WHERE ID = ID_categoria
        UNION ALL
        -- Ricerca dei padri
        SELECT c.ID, c.ID_padre
        FROM categoria c
        JOIN CTE_Categorie cte ON c.ID = cte.ID_padre
    )
    -- selezione caratteristiche relative alle categorie
    SELECT car.ID
    FROM caratteristica car
    JOIN CTE_Categorie cte ON car.ID_categoria = cte.ID;
    SET caratteristica_esiste = (
		SELECT EXISTS (
			SELECT 1
			FROM temp_caratteristiche
			WHERE temp_caratteristiche.ID = ID_caratteristica
		) 
    );
    -- inserimento della caratteristica
    IF caratteristica_esiste THEN
        INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica,valore)
        VALUES (ID_richiesta_acquisto,ID_caratteristica,valore);
    END IF;
END$$
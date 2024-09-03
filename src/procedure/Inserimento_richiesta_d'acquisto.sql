DROP PROCEDURE IF EXISTS deafult_caratteristiche;
DROP PROCEDURE IF EXISTS insert_richiesta;

DELIMITER $$
-- precedura che crea le caratteristiche per la richiesta e le setta sul valore di default
CREATE PROCEDURE deafult_caratteristiche(ID_richiesta_acquisto INTEGER UNSIGNED)
BEGIN
    DECLARE done BIT DEFAULT 0;
    DECLARE ID_categoria INTEGER UNSIGNED;
    DECLARE ID_caratteristica INTEGER UNSIGNED;
    -- Dichiarazione del cursore
    DECLARE cur CURSOR FOR
    WITH RECURSIVE CTE_Categorie AS (
        -- Seleziona la categoria iniziale
        SELECT ID, ID_padre
        FROM categoria
        WHERE ID = (
			SELECT ID_categoria
			FROM richiesta_acquisto ra
			WHERE ra.ID = ID_richiesta_acquisto
		)
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
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Loop per iterare su ogni caratteristica trovata
    OPEN cur;
    loop_caratteristiche: LOOP
        FETCH cur INTO ID_caratteristica;
        IF done THEN
            LEAVE loop_caratteristiche;
        END IF;
        INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica)
        VALUES(ID_richiesta_acquisto,ID_caratteristica);
    END LOOP;
    CLOSE cur;
END $$

-- creazione della richiesta
CREATE PROCEDURE insert_richiesta(
    ID_ordinante INTEGER UNSIGNED,
    ID_tecnico INTEGER UNSIGNED,
    ID_categoria INTEGER UNSIGNED,
    note TEXT
)
BEGIN
    INSERT INTO richiesta_acquisto(ID_ordinante,ID_tecnico,ID_categoria,note)
    VALUES (ID_ordinante,ID_tecnico,ID_categoria,note);

    CALL deafult_caratteristiche(LAST_INSERT_ID());
END$$

DELIMITER ;
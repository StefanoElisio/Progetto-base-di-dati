DROP PROCEDURE IF EXISTS deafult_caratteristiche;
DROP PROCEDURE IF EXISTS insert_richiesta;
DROP PROCEDURE IF EXISTS set_value_caratteristica;

DELIMITER $$
-- precedura che crea le caratteristiche per la richiesta e le setta sul valore di default
CREATE PROCEDURE deafult_caratteristiche()
BEGIN
    DECLARE done BIT DEFAULT NULL;
    DECLARE ID_car INT;
    DECLARE ID_rc INT;
    -- Dichiarazione del cursore
    DECLARE cur CURSOR FOR
    WITH RECURSIVE CTE_Categorie AS (
        -- Seleziona la categoria iniziale
        SELECT ID, ID_padre
        FROM categoria
        WHERE ID = (
			SELECT ID_categoria
			FROM richiesta_acquisto ra
			WHERE ra.ID = LAST_INSERT_ID()
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
    SET ID_rc =  LAST_INSERT_ID();
    -- Loop per iterare su ogni caratteristica trovata
    OPEN cur;
    loop_caratteristiche: LOOP
        FETCH cur INTO ID_car;
        IF done IS NOT NULL THEN
            LEAVE loop_caratteristiche;
        END IF;
        INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica)
        VALUES(ID_rc,ID_car);
    END LOOP;
    CLOSE cur;
END $$

-- procedura per la creazione della richiesta
CREATE PROCEDURE insert_richiesta(
    ID_ordinante INTEGER UNSIGNED,
    ID_tecnico INTEGER UNSIGNED,
    ID_categoria INTEGER UNSIGNED,
    note TEXT
)
BEGIN
    INSERT INTO richiesta_acquisto(ID_ordinante,ID_categoria,note)
    VALUES (ID_ordinante,ID_tecnico,ID_categoria,note);
    CALL deafult_caratteristiche();
END$$

-- procedura per modificare il valore ad una caratteristica di una richiesta
CREATE PROCEDURE set_value_caratteristica(
    ID_rc INTEGER UNSIGNED,
    ID_car INTEGER UNSIGNED,
    val VARCHAR(100)
)
BEGIN
    DECLARE ID_info INT DEFAULT NULL;
    SET ID_info = (
        SELECT ID
        FROM richiesta_info_caratteristiche
        WHERE ID_richiesta_acquisto = ID_rc
        AND ID_caratteristica = ID_car
    );
    -- inserimento della caratteristica
    IF ID_info IS NOT NULL THEN
        UPDATE richiesta_info_caratteristiche
        SET valore = val
        WHERE ID = ID_info;
    END IF;
END$$

DELIMITER ;
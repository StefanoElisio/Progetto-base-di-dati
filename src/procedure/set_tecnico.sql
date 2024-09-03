DROP PROCEDURE IF EXISTS set_tecnico;

DELIMITER $$
-- precedura che crea le caratteristiche per la richiesta e le setta sul valore di default
CREATE PROCEDURE set_tecnico(ID_rc INTEGER UNSIGNED, ID_tc INTEGER UNSIGNED)
BEGIN
    IF (SELECT ID_tecnico
    FROM richiesta_acquisto
    WHERE ID = ID_rc) IS NULL THEN
        UPDATE richiesta_acquisto
        SET ID_tecnico = ID_tc
        WHERE ID = ID_rc;
    END IF;
END$$

DELIMITER ;
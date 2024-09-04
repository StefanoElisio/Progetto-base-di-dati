DROP PROCEDURE IF EXISTS rc_without_tecnico;

DELIMITER $$
CREATE PROCEDURE rc_without_tecnico()
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    WHERE rc.ID_tecnico IS NULL;
END$$
DELIMITER ;
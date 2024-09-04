DROP PROCEDURE IF EXISTS num_rc_from_tecnico;

DELIMITER $$
CREATE PROCEDURE num_rc_from_tecnico(ID_tc INTEGER UNSIGNED)
BEGIN
    SELECT COUNT(*)
    FROM richiesta_acquisto
    WHERE ID_tecnico = ID_tc;
END$$
DELIMITER ;
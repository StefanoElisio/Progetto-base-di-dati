DROP PROCEDURE IF EXISTS delete_richiesta;

DELIMITER $$
CREATE PROCEDURE delete_richiesta(ID_rc INTEGER UNSIGNED)
BEGIN
    DELETE FROM richiesta_acquisto
    WHERE ID = ID_rc;
ENd$$

DELIMITER ;
DROP PROCEDURE IF EXISTS rc_approved_waiting;

DELIMITER $$
CREATE PROCEDURE rc_approved_waiting(ID_tc INTEGER UNSIGNED)
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    JOIN richiesta_relativo_prodotto rcp ON rc.ID = rcp.ID_richiesta_acquisto
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE rc.ID_tecnico = ID_tc
        AND val.decisione = 'approvato'
        AND ordinazione = 0;
END$$
DELIMITER ;
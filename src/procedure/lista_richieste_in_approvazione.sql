DROP PROCEDURE IF EXISTS list_rc_waiting_for_approve;

DELIMITER $$
CREATE PROCEDURE list_rc_waiting_for_approve()
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    JOIN richiesta_relativo_prodotto rcp ON rc.ID = rcp.ID_richiesta_acquisto
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE rc.esito = 'in corso'
        AND val.decisione IS NULL;
END$$

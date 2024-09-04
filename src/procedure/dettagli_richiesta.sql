DROP PROCEDURE IF EXISTS rc_details;

DELIMITER $$
CREATE PROCEDURE rc_details(ID_rc INTEGER UNSIGNED)
BEGIN
    SELECT rc.*, car.ID AS ID_caratteristica, car.nome, rcc.valore, 
        prod.ID AS ID_prodotto, prod.nome, val.decisione, val.motivazione
    FROM richiesta_acquisto rc
    LEFT JOIN richiesta_info_caratteristiche rcc ON rcc.ID_richiesta_acquisto = ID_rc
    LEFT JOIN caratteristica car ON rcc.ID_caratteristica = car.ID
    LEFT JOIN richiesta_relativo_prodotto rcp ON rcp.ID_richiesta_acquisto = ID_rc
    LEFT JOIN prodotto_candidato prod ON prod.ID = rcp.ID_prodotto_candidato
    LEFT JOIN valutazione val ON val.ID_richiesta_acquisto = ID_rc
        AND val.ID_prodotto_candidato = prod.ID
    WHERE rc.ID = ID_rc;
END$$
DELIMITER ;
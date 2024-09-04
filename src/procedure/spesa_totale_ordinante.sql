DROP PROCEDURE IF EXISTS tot_spesa_ordinante;
DELIMITER $$
CREATE PROCEDURE tot_spesa_ordinante(
    ID_ord INTEGER UNSIGNED,
    anno INTEGER UNSIGNED
)
BEGIN
    SELECT SUM(prod.prezzo)
    FROM ordinante ord
    JOIN richiesta_acquisto rc ON rc.ID_ordinante = ord.ID
    JOIN richiesta_relativo_prodotto rcp ON rcp.ID_richiesta_acquisto = rc.ID
    JOIN prodotto_candidato prod ON prod.ID = rcp.ID_prodotto_candidato
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE ord.ID = ID_ord
        AND val.decisione = 'approvato'
        AND YEAR(rc.tempo) = anno
        AND rc.esito = 'accettato';
END$$
DELIMITER ;
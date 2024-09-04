DROP PROCEDURE IF EXISTS insert_valutazione;

DELIMITER $$
CREATE PROCEDURE insert_valutazione(
    ID_prod INTEGER UNSIGNED,
    ID_ord INTEGER UNSIGNED,
    ID_rc INTEGER UNSIGNED,
    de ENUM('approvato', 'rifiutato'),
    mot TEXT
)
BEGIN
    -- update se esiste la valutazione e non è approvata 
    IF EXISTS(SELECT ID_val
        FROM valutazione
        WHERE ID_prodotto_candidato = ID_prod
        AND ID_ordinante = ID_ord
        AND ID_richiesta_acquisto = ID_rc
        AND decisione IS NULL
    ) AND de IS NOT NULL THEN
        UPDATE valutazione
        SET decisione = de
        WHERE ID = ID_val;
    -- insert se non esiste già
    ELSEIF EXISTS (SELECT * 
        FROM richiesta_relativo_prodotto 
        WHERE ID_richiesta_acquisto = ID_rc
        AND ID_prodotto_candidato = ID_prod
    ) AND EXISTS (SELECT *
        FROM richiesta_acquisto
        WHERE ID_ordinante = ID_ord
        AND ID = ID_rc
    )THEN
        IF(de = 'approvato') THEN
            INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione)
            VALUES  (ID_prod, ID_ord, ID_rc, de);
        ELSEIF (de = 'rifiutato') THEN
            INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione,motivazione)
            VALUES  (ID_prod, ID_ord, ID_rc, de, mot);
        END IF;
    END IF;
END$$
DELIMITER ;
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
    IF(de = 'approvato') THEN
        INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione)
        VALUES  (ID_prod, ID_ord, ID_rc, de);
    ELSE IF (de = 'rifiutato') THEN
        INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione,motivazione)
        VALUES  (ID_prod, ID_ord, ID_rc, de, mot);
END $$
DELIMITER ;
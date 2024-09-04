DROP PROCEDURE IF EXISTS avrage_time_evasion;

DELIMITER $$
CREATE PROCEDURE avrage_time_evasion()
BEGIN
    SELECT AVG(TIMESTAMPDIFF(MINUTE, rc.tempo, val.tempo))
    FROM richiesta_acquisto rc
    JOIN valutazione val ON val.ID_richiesta_acquisto = rc.ID;
END $$
DELIMITER ;
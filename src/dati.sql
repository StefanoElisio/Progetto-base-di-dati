USE market;

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE caratteristica;
TRUNCATE TABLE categoria;
TRUNCATE TABLE ordinante;
TRUNCATE TABLE prodotto_candidato;
TRUNCATE TABLE richiesta_acquisto;
TRUNCATE TABLE richiesta_info_caratteristiche;
TRUNCATE TABLE richiesta_relativo_prodotto;
TRUNCATE TABLE tecnico;
TRUNCATE TABLE tecnico_scelta_prodotto;
TRUNCATE TABLE valutazione;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO ordinante(username, nome, cognome)
VALUES 
    ('Fragola86', NULL, NULL),
    ('SuperMario', 'Mario', 'Rossi'),
    ('Fili_Gio', 'Filippo', 'Di giovanni');

INSERT INTO tecnico(username, nome, cognome)
VALUES 
    ('Agente007', 'James', 'Bond'),
    ('Alegorico', 'Alessando', 'Angelini'),
    ('Tecnico esperto', NULL, NULL);

INSERT INTO prodotto_candidato(
        numero_seriale,
        nome,
        nome_produttore,
        prezzo,
        url_approfondimento,
        note
    )
VALUES (
        '16cva8b18sca987h1',
        'MecBook Pro Max',
        'Apple',
        9999.98,
        'https://www.apple.com/it/macbook-pro',
        'Costa tanto e non ne vale la pena, ma se non lo fai cadere ti durerà, credo'
    ),
    (
        'caijbsib1ijscb1jciasbc',
        'AirForce1',
        'Nike',
        107.89,
        'https://www.nike.com/it/w/air-force-1',
        NULL
    ),
    (
        'ncq91ckihhc918s1xb19',
        'Giacca in pelle',
        'Calvin Klain',
        599.90,
        'https://www.calvinklein.it/giubbotti-stile-motociclista-in-pelle',
        NULL
    );

INSERT INTO categoria(nome)
VALUES
    ('Elettronica'), 
    ('Abbigliamento');
INSERT INTO categoria(ID_padre, nome)
VALUES
    (1,'SmartPhone'), 
    (1,'PC portatili'),
    (2,'Scarpe'),
    (2,'Giubbetti');

INSERT INTO richiesta_acquisto (ID_ordinante, ID_tecnico, ID_categoria, note)
VALUES 
    (2, 2, 6, 'Costo non maggiore di 1000$');
INSERT INTO richiesta_acquisto (ID_ordinante, ID_categoria, tempo, note)
VALUES 
    (3, 6, '2024-05-01 11:05:12', 'esteticamente piacevole se possibile');
INSERT INTO richiesta_acquisto (ID_ordinante, ID_tecnico, ID_categoria, tempo, note, esito)
VALUES 
    (1, 1, 1, '2024-06-01 12:34:56', 'Richiesta urgente', 'accettato'),
    (1, 3, 6, '2024-09-02 00:00:00','Costo non maggiore di 1000$', 'accettato');
INSERT INTO richiesta_acquisto (ID_ordinante, ID_tecnico, ID_categoria, note, esito)
VALUES 
    (3, 2, 4, NULL, 'respinto perché non funzionante');

INSERT INTO caratteristica(ID_categoria, nome)
VALUES
    (1,'Autonomia'),
    (3,'Pollici'),
    (3,'MegaPixel'),
    (4,'CPU'),
    (4,'GPU'),
    (2,'Genere'),
    (5,'Taglia'),
    (6,'Taglia'),
    (6,'Colore');

INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,decisione,motivazione)
VALUES
    (3, 2, 2,'rifiutato', 'Il prodotto ha superato il budget'),
    (2, 1, 3,'approvato', NULL),
    (3, 1, 4,'approvato', NULL);
INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto,tempo,decisione,ordinazione,motivazione)
VALUES
    (1, 2, 4, CURRENT_TIMESTAMP, 'approvato', 1, NULL);
INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,ID_richiesta_acquisto)
VALUES  
    (2, 3, 1);

INSERT INTO tecnico_scelta_prodotto (ID_tecnico, ID_prodotto_candidato)
VALUES
    (1,2),
    (2,1),
    (2,3),
    (1,2),
    (3,3);

INSERT INTO richiesta_relativo_prodotto(ID_richiesta_acquisto,ID_prodotto_candidato)
VALUES
    (2,1),
    (1,2),
    (4,3),
    (3,2);

INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica)
VALUES
    (1,1),
    (2,6),
    (2,8),
    (3,1);
INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica,valore)
VALUES
    (2,9,'BLU'),
    (3,4,'NVIDIA'),
    (3,5,'i5core');


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

INSERT INTO richiesta_acquisto (ID_ordinante, ID_tecnico, ID_categoria, tempo, note, esito)
VALUES 
    (1, 1, 1, '2024-06-01 12:34:56', 'Richiesta urgente', 'accettato');
INSERT INTO richiesta_acquisto (ID_ordinante, ID_tecnico, ID_categoria, note, esito)
VALUES 
    (1, 3, 6, 'Costo non maggiore di 1000$', 'respinto perché non conforme'),
    (3, 2, 3, NULL, 'respinto perché non funzionante');

INSERT INTO caratteristica(ID_categoria, nome)
VALUES
    (1,'Autonomia'),
    (2,'Pollici'),
    (2,'MegaPixel'),
    (3,'CPU'),
    (3,'GPU'),
    (4,'Genere'),
    (5,'Taglia'),
    (6,'Taglia'),
    (6,'Colore');

INSERT INTO valutazione(ID_prodotto_candidato,ID_ordinante,decisione,motivazione)
VALUES
    (3, 2, 'rifiutato', 'Il prodotto ha superato il budget'),
    (2, 1, 'approvato', NULL),
    (1, 3, 'approvato', NULL),
    (1, 1, 'rifiutato', 'Il prodotto non soddisfa i requisiti tecnici');

INSERT INTO tecnico_scelta_prodotto (ID_tecnico, ID_prodotto)
VALUES
    (1,2),
    (2,1),
    (2,3),
    (1,2),
    (3,3);

INSERT INTO richiesta_relativo_prodotto(ID_richiesta_acquisto,ID_prodotto)
VALUES
    (1,1),
    (1,2),
    (2,3),
    (3,2);

INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica)
VALUES
    (1,1),
    (1,3),
    (2,6);
INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica,valore)
VALUES
    (1,2,'almeno 12'),
    (3,6,'uomo'),
    (3,7,'media');


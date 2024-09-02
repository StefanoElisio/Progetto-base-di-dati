DROP DATABASE IF EXISTS market;
CREATE DATABASE market;
USE market;
CREATE TABLE ordinante (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    username varchar(20) UNIQUE,
    nome varchar(50),
    cognome varchar(50)
);
CREATE TABLE tecnico (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    username varchar(20) UNIQUE,
    nome varchar(50),
    cognome varchar(50)
);
CREATE TABLE prodotto_candidato (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    numero_seriale varchar(100) UNIQUE,
    nome varchar(20) NOT NULL,
    nome_produttore varchar(20) NOT NULL,
    prezzo DECIMAL(10, 2) NOT NULL,
    url_approfondimento varchar(250) NOT NULL,
    note TEXT
);
CREATE TABLE categoria (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    nome varchar(20) UNIQUE
);
CREATE TABLE richiesta_acquisto (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_ordinante INT NOT NULL,
    ID_tecnico INT NOT NULL,
    tempo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    note TEXT,
    esito ENUM(
        'accettato',
        'respinto perché non conforme',
        'respinto perché non funzionante'
    ) NOT NULL,
    FOREIGN KEY (ID_ordinante) REFERENCES ordinante(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ID_tecnico) REFERENCES tecnico(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    UNIQUE(ID_ordinante, tempo),
    UNIQUE(ID_tecnico, tempo)
);
CREATE TABLE caratteristica (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_categoria INT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    FOREIGN KEY (ID_categoria) REFERENCES categoria(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE(ID_categoria, nome)
);
CREATE TABLE valutazione (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_prodotto_candidato INT NOT NULL,
    ID_ordinante INT NOT NULL,
    decisione ENUM('approvato', 'rifiutato') NOT NULL,
    motivazione TEXT,
    FOREIGN KEY (ID_prodotto_candidato) REFERENCES prodotto_candidato(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ID_ordinante) REFERENCES ordinante(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CHECK (
        decisione = 'approvato'
        AND motivazione IS NULL
    ),
    CHECK(
        decisione = 'rifiutato'
        AND motivazione IS NOT NULL
    )
);
CREATE TABLE tecnico_prodotti (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_tecnico INT NOT NULL,
    ID_prodotto INT NOT NULL,
    FOREIGN KEY (ID_tecnico) REFERENCES tecnico(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (ID_prodotto) REFERENCES prodotto_candidato(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE richiesta_prodotti (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta_acquisto INT NOT NULL,
    ID_prodotto int NOT NULL,
    UNIQUE (ID_richiesta_acquisto, ID_prodotto),
    FOREIGN KEY (ID_richiesta_acquisto) REFERENCES richiesta_acquisto(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_prodotto) REFERENCES prodotto_candidato(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE richiesta_categoria (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta_acquisto INT NOT NULL,
    ID_categoria int NOT NULL,
    UNIQUE (ID_richiesta_acquisto, ID_categoria),
    FOREIGN KEY (ID_richiesta_acquisto) REFERENCES richiesta_acquisto(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_categoria) REFERENCES categoria(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE richiesta_caratteristiche (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta_acquisto INT NOT NULL,
    ID_caratteristica INT NOT NULL,
    valore VARCHAR(100) DEFAULT 'indifferente',
    UNIQUE (ID_richiesta_acquisto, ID_caratteristica),
    FOREIGN KEY (ID_richiesta_acquisto) REFERENCES richiesta_acquisto(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ID_caratteristica) REFERENCES caratteristica(ID) ON UPDATE CASCADE ON DELETE
);
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
    ID_padre INT DEFAULT NULL,
    nome varchar(20) UNIQUE,
    CONSTRAINT padre FOREIGN KEY (ID_padre) REFERENCES categoria(ID) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE richiesta_acquisto (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_ordinante INT NOT NULL,
    ID_tecnico INT NOT NULL,
    ID_categoria INT NOT NULL,
    tempo TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    note TEXT,
    esito ENUM(
        'in corso',
        'accettato',
        'respinto perché non conforme',
        'respinto perché non funzionante'
    ) NOT NULL,
    CONSTRAINT richiesta_ordinante FOREIGN KEY (ID_ordinante) REFERENCES ordinante(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT richiesta_tecnico FOREIGN KEY (ID_tecnico) REFERENCES tecnico(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT richiesta_categoria FOREIGN KEY (ID_categoria) REFERENCES categoria(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT un_ordinante UNIQUE(ID_ordinante, tempo),
    CONSTRAINT un_tecnico UNIQUE(ID_tecnico, tempo)
);
CREATE TABLE caratteristica (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_categoria INT NOT NULL,
    nome VARCHAR(20) NOT NULL,
    CONSTRAINT caratteristica_categoria FOREIGN KEY (ID_categoria) REFERENCES categoria(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT caratteristica_unica UNIQUE(ID_categoria, nome)
);
CREATE TABLE valutazione (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_prodotto_candidato INT NOT NULL,
    ID_ordinante INT NOT NULL,
    decisione ENUM('approvato', 'rifiutato') NOT NULL,
    motivazione TEXT,
    CONSTRAINT valutazione_prodotto FOREIGN KEY (ID_prodotto_candidato) REFERENCES prodotto_candidato(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT valutazione_ordinante FOREIGN KEY (ID_ordinante) REFERENCES ordinante(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT motivazione_consiste CHECK ((
        decisione = 'approvato'
        AND motivazione IS NULL
    ) OR (
        decisione = 'rifiutato'
        AND motivazione IS NOT NULL
    ))
);
CREATE TABLE tecnico_scelta_prodotto (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_tecnico INT NOT NULL,
    ID_prodotto INT NOT NULL,
    CONSTRAINT tecnico_scelto FOREIGN KEY (ID_tecnico) REFERENCES tecnico(ID) ON UPDATE CASCADE ON DELETE RESTRICT,
    CONSTRAINT prodotto_scelto FOREIGN KEY (ID_prodotto) REFERENCES prodotto_candidato(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE richiesta_relativo_prodotto (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta_acquisto INT NOT NULL,
    ID_prodotto int NOT NULL,
    CONSTRAINT richiesta_prodotto_unica UNIQUE (ID_richiesta_acquisto, ID_prodotto),
    CONSTRAINT richiesta_relativa FOREIGN KEY (ID_richiesta_acquisto) REFERENCES richiesta_acquisto(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT prodotto_relativo FOREIGN KEY (ID_prodotto) REFERENCES prodotto_candidato(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);
CREATE TABLE richiesta_info_caratteristiche (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_richiesta_acquisto INT NOT NULL,
    ID_caratteristica INT NOT NULL,
    valore VARCHAR(100) DEFAULT 'indifferente',
    CONSTRAINT richiesta_caratteristiche_unica UNIQUE (ID_richiesta_acquisto, ID_caratteristica),
    CONSTRAINT richiesta_info FOREIGN KEY (ID_richiesta_acquisto) REFERENCES richiesta_acquisto(ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT caratteristica_info FOREIGN KEY (ID_caratteristica) REFERENCES caratteristica(ID) ON UPDATE CASCADE ON DELETE RESTRICT
);
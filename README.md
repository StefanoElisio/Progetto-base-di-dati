# Laboratorio di Basi di Dati:  *Progetto Market*

| Matricola | Nome | Cognome |
|:---------:|:----:|:-------:|
| 281485 | Stefano | Elisio |                        

**Data di consegna del progetto**: 04/09/2024

## Analisi dei requisiti

1. L'ordinante effettua una richiesta d'acquisto specificando una o più categorie, e inserendo dei valori a tutte le caratteristiche relative alle categorie selezionate inserendo 'indifferente' se non si vuole specificare un valore, e delle note se necessita di specificare altro.
2. Ad ogni rischiesta verrà assegnato un tecnico incaricato che potrà valutarla in base ai dati inseriti nel punto 1 e sceglierà al di fuori del sistema un prodotto da candidare alla richiesta.
3. L'ordinante prenderà in visione il prodotto candidato e deciderà se respingerlo, ripartendo dal punto 2, o accettarlo.
4. In caso di ordine accettato il personale tecnico procederà all'aquisto del prodotto e alla consegna.
5. Una volta che il prodotto viene consegnato l'ordinate chiuderà la relativa richiesta d'acquisto indicando se il prodotto è stato accettato, respinto perché non conforme oppure respinto perché non funzionante.

### Scelte progettuali 

- la richiesta d'acquisto ha una sola categoria, le categorie hanno però struttura ad albero (se selezioni una categoria verranno considerate anche tutte le categorie padre imparentate).
- le categorie vengono inserite con valore indifferente automaticamente alla creazione della richiesta d'acquisto, e in seguito si possono andare a modificare i singoli valori dove necessario.
- ci possono essere caratteristiche con lo stesso nome ma saranno riferite a categorie diverse (ES. la caratteristica *taglia* può essere riferita sia alla categoria *scarpe* che alla categoria *giubetti* ma con valori non interscambiabili).
- non può essere candidato più volte lo stesso prodotto in una singola richiesta d'acquisto.
- a seguito della valutazione l'intero processo di acquisto e consegna verrà gestito da un singolo attributo della valutazione che indica se il prodotto è stato o meno ordinato.
- la valutazione non presenta attributo chiave in quanto è definito dalla relazione con la richiesta d'acquisto e con il prodotto candidato.

## Progettazione concettuale

<img src="assets\ER_concettuale.jpg">

- La categoria in questo caso comprende anche le categorie padre (ES. se si sceglie la categoria *laptop* si sottointende che si è scelta anche la categoria *elettronica*). Se si vuole inserire più di una categoria si usa una categoria più generica (ES. se si vuole scegliere sia la categoria *laptop* che la categoria *telefono* si sceglie la categoria *elettronica* che le comprende entrambe). Non si possono scegliere due categorie diametralmente opposte (ES. *laptop* e *scarpe*). Questo punto verrà implementato meglio dopo la ristrutturazione ed ottimizazzione del modello. 
- amministratore e persona sono entità superflue, utilizzate puramente a scopo di chiarezza in fase di creazione del modello, verranno rimosse in seguito.
- decisione->valutazione è un enumerativo che però durante la fase di creazione della valutazione avrà valore nulla in quanto spetta all'ordinante decidere se sarà approvata o rifiutata.

## Progettazione logica

### Ristrutturazione ed ottimizzazione del modello ER

<img src="assets\ER_ristrutturato.jpg">

- l'intera sezione dell'utente, della persona e dell'amministratore è stata rimossa in quanto superflua, e gli attributi sono stati ugualmente assegnati all'ordinante ed al tecnico.
- il tecnico incarica è stato rimosso in quanto non vi era nessuna differenza logia con il tecnico semplice, per identificare se un tecnico è o è stato incaricato basterà cercarlo nella relazione con richiesta d'acquisto.
- la categoria e la caratteristica sono state rese attributi assestanti, dove la categoria è autoriferente ed indica (se esiste) quale categoria gli fa da padre.
- la caratteristica ora fa riferimento alla categoria di cui appartiene e viene definita sia dal nome che dalla categoria, dato che (come spiegato in precedenza) ci possono essere più categorie con lo stesso nome.
-  Il valore della caratteristica viene definito solo nel momento in cui deve fare fuoire come informazione per una richiesta, quindi l'attributo valore appartiene alla relazione fra la richiesta d'acquisto e la caratteristica.
-  la descrizione è stata unita al prodotto candidato invece di trasformarsi a sua volta in una Entità in quanto, data la mancanza di attributi in prodotto e la relazione 1 a 1 fra la descrizione e il prodotto candidato, è stata ritenuta superflua.
-  l'ordinazione sarebbe dovuta diventare una entità a parte ma questo avrebbe esploso il diagramma, per semplicità (non per correttezza) il tempo dell'ordinazione e l'ordinazione stessa sono state entrambe assegnate alla valutazione, che gode delle stesse relazioni dell'ipotetica entità ordinazione.
-  l'ordinazione verrà inoltre gestita tramite un bit, settato di base a 0, e verrà impostato a 1 nel momento in cui il prodotto verrà ordinato, settando anche il tempo dell'ordinazione al timestamp attuale

### Traduzione del modello ER nel modello relazionale

* **Ordinante**(**<ins>ID</ins>**, username, nome, cognome)
* **Tecnico**(**<ins>ID</ins>**, username, nome, cognome)
* **Prodotto_candidato**(**<ins>ID</ins>**, numero_seriale, nome, nome_produttore, prezzo, url, note)
* **Categoria**(**<ins>ID</ins>**,**<ins>ID_padre</ins>** ,nome)
* **Richista_acquisto**(**<ins>ID</ins>**, **<ins>ID_ordinante</ins>**, **<ins>ID_ordinante</ins>**, **<ins>ID_tecnico</ins>**, tempo, note, esito)
* **Caratteristica**(**<ins>ID</ins>**, **<ins>ID_categoria</ins>**, nome)
* **Valutazione**(**<ins>ID</ins>**, **<ins>ID_richista_acquisto</ins>**, **<ins>ID_prodotto_candidato</ins>**, **<ins>ID_ordinante</ins>**, tempo, decisione, ordinazione, motivazione)
* **Tecnico_prodotti**(**<ins>ID</ins>**, **<ins>ID_tecnico</ins>**, **<ins>ID_prodotto</ins>**)
* **Richiesta_prodotti**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_prodotto</ins>**)
* **Richiesta_caratteristiche**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_caratteristica</ins>**, valore)

- **<ins>ID</ins>** è la chiave primaria
- **<ins>ID_entità</ins>** è la chiave esterna
- ID_prodotto è stato chiamato numero_seriale per evitare che si confodesse con l'ID effettivo auto-generato incrementalmente
- alcuni dei nomi presenti sul diagramma sono stati abbreviati per semplicità

## Progettazione fisica

### Implementazione del modello relazionale

- Per la creazione e il popolamento del database, utilizzare gli script [struttura](src/structure.sql) e [dati](src/dati.sql).
- Alternativamente si può utilizzare il file di [dump](src/dump/dump.sql), il quale contiene la struttura, tutti i dati, e le procedure utilizzate in seguito.
- Tutti gli script utilizzati sono inoltre presenti nella directory [src](src/).

### Implementazione dei vincoli

- nella tabella della valutazione sono stati inseriti dei check che impediscono che venga creata o modificata secondo i seguenti vincoli:
  - se la è rifiutata deve esserci una motivazione inserita e viceversa
  - se l'ordinazione non è avvenuta il tempo deve essere null e viceversa
 ```sql
CONSTRAINT motivazione_consiste CHECK ((
  decisione = 'approvato'
  AND motivazione IS NULL
) OR (
  decisione = 'rifiutato'
  AND motivazione IS NOT NULL
)),
CONSTRAINT tempo_ordinazione CHECK ((
  ordinazione = 0
  AND tempo IS NULL
) OR (
  ordinazione = 1
  AND tempo IS NOT NULL
))
```

### Implementazione funzionalità richieste

- Ogni funzionalità richiesta è implementata tramite una o una serie di stored procedures nella cartella [procedure](src/procedure/)

#### [Funzionalità 1](src/procedure/Inserimento_richiesta_d'acquisto.sql)

> Inserimento di una richiesta di acquisto (comprensiva di categoria di prodotto, di tutte le caratteristiche richieste per quella categoria di prodotto e delle eventuali note)

```sql
DROP PROCEDURE IF EXISTS deafult_caratteristiche;
DROP PROCEDURE IF EXISTS insert_richiesta;
DROP PROCEDURE IF EXISTS set_value_caratteristica;

DELIMITER $$
-- precedura che crea le caratteristiche per la richiesta e le setta sul valore di default
CREATE PROCEDURE deafult_caratteristiche(ID_rc INTEGER UNSIGNED)
BEGIN
    DECLARE done BIT DEFAULT NULL;
    DECLARE ID_car INT;
    -- Dichiarazione del cursore
    DECLARE cur CURSOR FOR
    WITH RECURSIVE CTE_Categorie AS (
        -- Seleziona la categoria iniziale
        SELECT ID, ID_padre
        FROM categoria
        WHERE ID = (
			SELECT ID_categoria
			FROM richiesta_acquisto ra
			WHERE ra.ID = ID_rc
		)
        UNION ALL
        -- Ricerca dei padri
        SELECT c.ID, c.ID_padre
        FROM categoria c
        JOIN CTE_Categorie cte ON c.ID = cte.ID_padre
    )
    -- selezione caratteristiche relative alle categorie
    SELECT car.ID
    FROM caratteristica car
    JOIN CTE_Categorie cte ON car.ID_categoria = cte.ID;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    -- Loop per iterare su ogni caratteristica trovata
    OPEN cur;
    loop_caratteristiche: LOOP
        FETCH cur INTO ID_car;
        IF done IS NOT NULL THEN
            LEAVE loop_caratteristiche;
        END IF;
        INSERT INTO richiesta_info_caratteristiche(ID_richiesta_acquisto,ID_caratteristica)
        VALUES(ID_rc,ID_car);
    END LOOP;
    CLOSE cur;
END $$

-- procedura per la creazione della richiesta
CREATE PROCEDURE insert_richiesta(
    ID_ord INTEGER UNSIGNED,
    ID_tec INTEGER UNSIGNED,
    ID_cat INTEGER UNSIGNED,
    testo TEXT,
    OUT new_id INTEGER UNSIGNED
)
BEGIN
    INSERT INTO richiesta_acquisto(ID_ordinante,ID_categoria,note)
    VALUES (ID_ord,ID_tec,ID_cat,testo);
    SET new_id = LAST_INSERT_ID();
    CALL deafult_caratteristiche(new_id);
END$$

-- procedura per modificare il valore ad una caratteristica di una richiesta
CREATE PROCEDURE set_value_caratteristica(
    ID_rc INTEGER UNSIGNED,
    ID_car INTEGER UNSIGNED,
    val VARCHAR(100)
)
BEGIN
    DECLARE ID_info INT DEFAULT NULL;
    SET ID_info = (
        SELECT ID
        FROM richiesta_info_caratteristiche
        WHERE ID_richiesta_acquisto = ID_rc
        AND ID_caratteristica = ID_car
    );
    -- inserimento della caratteristica
    IF ID_info IS NOT NULL THEN
        UPDATE richiesta_info_caratteristiche
        SET valore = val
        WHERE ID = ID_info;
    END IF;
END$$

DELIMITER ;
```

Esempio implementazione

```sql
CALL insert_richiesta(2,6,1,'prezzo ragionevole',@ID);
CALL set_value_caratteristica(@ID,2,'64');
```

#### [Funzionalità 2](src/procedure/set_tecnico.sql)

> Associazione di una richiesta di acquisto a un tecnico incaricato

```sql
DROP PROCEDURE IF EXISTS set_tecnico;

DELIMITER $$
-- precedura che crea le caratteristiche per la richiesta e le setta sul valore di default
CREATE PROCEDURE set_tecnico(ID_rc INTEGER UNSIGNED, ID_tc INTEGER UNSIGNED)
BEGIN
    IF (SELECT ID_tecnico
    FROM richiesta_acquisto
    WHERE ID = ID_rc) IS NULL THEN
        UPDATE richiesta_acquisto
        SET ID_tecnico = ID_tc
        WHERE ID = ID_rc;
    END IF;
END$$

DELIMITER ;
```

Esempio implementazione

```sql
CALL set_tecnico(7,13);
```

#### [Funzionalità 3](src/procedure/.sql)

> Approvazione del prodotto candidato relativo a una richiesta di acquisto

```sql
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
    -- update se esiste la valutazione e non è stata presa una decisione 
    IF EXISTS(SELECT ID_val
        FROM valutazione
        WHERE ID_prodotto_candidato = ID_prod
        AND ID_ordinante = ID_ord
        AND ID_richiesta_acquisto = ID_rc
        AND decisione IS NULL
    ) AND THEN
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
```

Esempio implementazione

```sql
CALL insert_valutazione(31,12,5,'approvato',NULL);
```

#### [Funzionalità 4](src/procedure/.sql)

> Eliminazione di una richiesta di acquisto dal sistema

```sql
DROP PROCEDURE IF EXISTS delete_richiesta;

DELIMITER $$
CREATE PROCEDURE delete_richiesta(ID_rc INTEGER UNSIGNED)
BEGIN
    DELETE FROM richiesta_acquisto
    WHERE ID = ID_rc;
ENd$$

DELIMITER ;
```

Esempio implementazione

```sql
CALL delete_richiesta(18);
```

#### [Funzionalità 5](src/procedure/.sql)

> Estrazione lista delle richieste di acquisto in corso (non chiuse) di un determinato ordinante, aventi un prodotto candidato associato ma non ancora approvato o respinto

```sql
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
```

Esempio implementazione

```sql
CALL list_rc_waiting_for_approve();
```

#### [Funzionalità 6](src/procedure/.sql)

> Estrazione lista delle richieste di acquisto non ancora assegnate ad alcun tecnico

```sql
DROP PROCEDURE IF EXISTS rc_without_tecnico;

DELIMITER $$
CREATE PROCEDURE rc_without_tecnico()
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    WHERE rc.ID_tecnico IS NULL;
END$$
DELIMITER ;
```

Esempio implementazione

```sql
CALL rc_without_tecnico();
```

#### [Funzionalità 7](src/procedure/.sql)

> Estrazione lista delle richieste di acquisto associate a un determinato tecnico con prodotto accettato ma non ancora ordinato

```sql
DROP PROCEDURE IF EXISTS rc_approved_waiting;

DELIMITER $$
CREATE PROCEDURE rc_approved_waiting(ID_tc INTEGER UNSIGNED)
BEGIN
    SELECT rc.*
    FROM richiesta_acquisto rc
    JOIN richiesta_relativo_prodotto rcp ON rc.ID = rcp.ID_richiesta_acquisto
    JOIN valutazione val ON rc.ID = val.ID_richiesta_acquisto 
        AND rcp.ID_prodotto_candidato = val.ID_prodotto_candidato
    WHERE rc.ID_tecnico = ID_tc
        AND val.decisione = 'approvato'
        AND ordinazione = 0;
END$$
DELIMITER ;
```

Esempio implementazione

```sql
CALL rc_approved_waiting(9);
```

#### [Funzionalità 8](src/procedure/.sql)

> Estrazione di tutti i dettagli di una richiesta di acquisto (richiesta iniziale, eventuale prodotto candidato, approvazione/rifiuto dell'ordinante con relativa motivazione)

```sql
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
```

Esempio implementazione

```sql
CALL rc_details(14);
```

#### [Funzionalità 9](src/procedure/.sql)

> Conteggio richieste di acquisto gestite globalmente da un determinato tecnico


```sql
DROP PROCEDURE IF EXISTS num_rc_from_tecnico;

DELIMITER $$
CREATE PROCEDURE num_rc_from_tecnico(ID_tc INTEGER UNSIGNED)
BEGIN
    SELECT COUNT(*)
    FROM richiesta_acquisto
    WHERE ID_tecnico = ID_tc;
END$$
DELIMITER ;
```

Esempio implementazione

```sql
CALL num_rc_from_tecnico(6);
```

#### [Funzionalità 10](src/procedure/.sql)

> Calcolo somma totale spesa da un determinato ordinante in un anno solare (suggerimento: si tratta dei prezzi dei prodotti candidati approvati, ordinati e con ordine chiuso con accettazione)

```sql
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
```

Esempio implementazione

```sql
CALL tot_spesa_ordinante(2,2024)
```

#### [Funzionalità 11](src/procedure/.sql)

> Calcolo tempo medio di evasione di un ordine da parte dei tecnici (il tempo di evasione è dato dalla differenza tra il momento in cui viene inserita una richiesta di acquisto e quello in cui il prodotto viene ordinato. suggerimento: questo vuol dire che dovete prevedere alcuni timestamp nel database che saranno impostati nei momenti opportuni...)

```sql
DROP PROCEDURE IF EXISTS avrage_time_evasion;

DELIMITER $$
CREATE PROCEDURE avrage_time_evasion()
BEGIN
    SELECT AVG(TIMESTAMPDIFF(MINUTE, rc.tempo, val.tempo))
    FROM richiesta_acquisto rc
    JOIN valutazione val ON val.ID_richiesta_acquisto = rc.ID;
END $$
DELIMITER ;
```

Esempio implementazione

```sql
CALL avrage_time_evasion();
```


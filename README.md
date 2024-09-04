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

- Riportate qui il **codice che implementa tutte le funzionalità richieste**, che si tratti di SQL o di pseudocodice o di entrambi. *Il codice di ciascuna funzionalità dovrà essere preceduto dal suo numero identificativo e dal testo della sua definizione*, come riportato nella specifica.

- Se necessario, riportate anche il codice delle procedure e/o viste di supporto.

#### Funzionalità 1

> Definizione come da specifica

```sql
CODICE
```

#### Funzionalità 2

> Definizione come da specifica

```sql
CODICE
```

## Interfaccia verso il database

- Opzionalmente, se avete deciso di realizzare anche una **(semplice) interfaccia** (a linea di comando o grafica) in un linguaggio di programmazione a voi noto (Java, PHP, ...) che manipoli il vostro database , dichiaratelo in questa sezione, elencando
  le tecnologie utilizzate e le funzionalità invocabili dall'interfaccia. 

- Il relativo codice sorgente dovrà essere *allegato *alla presente relazione.

-----

**Raccomandazioni finali**

- Questo documento è un modello che spero possa esservi utile per scrivere la documentazione finale del vostro progetto di Laboratorio di Basi di Dati.

- Cercate di includere tutto il codice SQL nella documentazione, come indicato in questo modello, per facilitarne la correzione. Potete comunque allegare alla documentazione anche il *dump* del vostro database o qualsiasi altro elemento che ritenete utile ai fini della valutazione.

- Ricordate che la documentazione deve essere consegnata, anche per email, almeno *una settimana prima* della data prevista per l'appello d'esame. Eventuali eccezioni a questa regola potranno essere concordate col docente.

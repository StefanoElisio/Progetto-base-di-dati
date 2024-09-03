# Laboratorio di Basi di Dati:  *Progetto Market*

| Matricola | Nome | Cognome |
|:---------:|:----:|:-------:|
| 281485 | Stefano | Elisio |                        

**Data di consegna del progetto**: 04/09/2024

## Analisi dei requisiti

1. L'ordinante effettua una richiesta d'acquisto specificando una o più categorie, e inserendo dei valori a tutte le caratteristiche relative alle categorie selezionate inserendo 'indifferente' se non si vuole specificare un valore, e delle note se necessita di specificare altro
2. Ad ogni rischiesta verrà assegnato un tecnico (incaricato) che potrà valutarla in base ai dati inseriti nel punto 1 e sceglierà al di fuori del sistema un prodotto da candidare alla richiesta
3. L'ordinante prenderà in visione in prodotto candidato e deciderà se respingerlo, ripartendo dal punto 2, o accettarlo
4. In caso di ordine accettato il personale tecnico procederà all'aquisto del prodotto e alla consegna
5. Una volta che il prodotto viene consegnato l'ordinate chiuderà la relativa richiesta d'acquisto indicando se il prodotto è stato accettato, respinto perché non conforme oppure respinto perché non funzionante

### Scelte progettuali 

- discutere le scelte progettuali e disambuguare eventuali elementi ambugui

## Progettazione concettuale

<img src="assets\ER_concettuale.jpg">

- Commentate gli elementi non visibili nella figura (ad esempio il contenuto degli attributi composti) nonché le scelte/assunzioni che vi hanno portato a creare determinate strutture, se lo ritenete opportuno.

### Formalizzazione dei vincoli non esprimibili nel modello ER

- Elencate gli altri **vincoli** sui dati che avete individuato e che non possono essere espressi nel diagramma ER.

## Progettazione logica

### Ristrutturazione ed ottimizzazione del modello ER

<img src="assets\ER_ristrutturato.jpg">

- Discutete le scelte effettuate, ad esempio nell'eliminare una generalizzazione o nello scindere un'entità.

### Traduzione del modello ER nel modello relazionale

* **Ordinante**(**<ins>ID</ins>**, username, nome, cognome)
* **Tecnico**(**<ins>ID</ins>**, username, nome, cognome)
* **Prodotto_candidato**(**<ins>ID</ins>**, numero_seriale, nome, nome_produttore, prezzo, url, note)
* **Categoria**(**<ins>ID</ins>**, nome)
* **Richista_acquisto**(**<ins>ID</ins>**, **<ins>ID_ordinante</ins>**, **<ins>ID_ordinante</ins>**, **<ins>ID_tecnico</ins>**, tempo, note, esito)
* **Caratteristica**(**<ins>ID</ins>**, **<ins>ID_categoria</ins>**, nome)
* **Valutazione**(**<ins>ID</ins>**, **<ins>ID_prodotto_candidato</ins>**, **<ins>ID_ordinante</ins>**, decisione, motivazione)
* **Tecnico_prodotti**(**<ins>ID</ins>**, **<ins>ID_tecnico</ins>**, **<ins>ID_prodotto</ins>**)
* **Richiesta_prodotti**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_prodotto</ins>**)
* **Richiesta_caratteristiche**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_caratteristica</ins>**, valore)

- **<ins>ID</ins>** è la chiave primaria
- **<ins>ID_entità</ins>** è la chiave esterna

## Progettazione fisica

### Implementazione del modello relazionale

- Inserite qui lo *script SQL* con cui **creare il database** il cui modello relazionale è stato illustrato nella sezione precedente. Ricordate di includere nel codice tutti
  i vincoli che possono essere espressi nel DDL. 

- Potete opzionalmente fornire anche uno script separato di popolamento (INSERT) del database su cui basare i test delle query descritte nella sezione successiva.

### Implementazione dei vincoli

- Nel caso abbiate individuato dei **vincoli ulteriori** che non sono esprimibili nel DDL, potrete usare questa sezione per discuterne l'implementazione effettiva, ad esempio riportando il codice di procedure o trigger, o dichiarando che dovranno essere implementati all'esterno del DBMS.

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

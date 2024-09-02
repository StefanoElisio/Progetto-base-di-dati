# Laboratorio di Basi di Dati:  *Progetto "Titolo"*

**Gruppo di lavoro**:

| Matricola | Nome | Cognome | Contributo al progetto |
|:---------:|:----:|:-------:|:----------------------:|
|           |      |         |                        |
|           |      |         |                        |

**Data di consegna del progetto**: gg/mm/aaaa

## Analisi dei requisiti

- E' possibile riportare in questa sezione i **requisiti **copiati dal documento di specifica, oppure semplicemente riassumerne gli aspetti più importanti.
  Vanno quindi (eventualmente) discusse tutte le scelte progettuali relative al dominio, le ambiguità e il modo in cui sono state risolte.

- E' possibile infine inserire qui un glossario che riporta tutti gli oggetti di dominio individuati, con la loro semantica, i loro eventuali sinonimi e le loro proprietà.

## Progettazione concettuale

- Riportate qui il **modello ER iniziale**. Cercate di renderlo *leggibile*, altrimenti correggerlo diventerà impossibile. Se è troppo piccolo, dividetelo in parti e/o allegate anche un'immagine ad alta risoluzione alla relazione.

- Commentate gli elementi non visibili nella figura (ad esempio il contenuto degli attributi composti) nonché le scelte/assunzioni che vi hanno portato a creare determinate strutture, se lo ritenete opportuno.

### Formalizzazione dei vincoli non esprimibili nel modello ER

- Elencate gli altri **vincoli** sui dati che avete individuato e che non possono essere espressi nel diagramma ER.

## Progettazione logica

### Ristrutturazione ed ottimizzazione del modello ER

- Riportate qui il modello **ER ristrutturato** ed eventualmente ottimizzato. 

- Discutete le scelte effettuate, ad esempio nell'eliminare una generalizzazione o nello scindere un'entità.

### Traduzione del modello ER nel modello relazionale

- **Ordinante**(**<ins>ID</ins>**, username, nome, cognome)
- **Tecnico**(**<ins>ID</ins>**, username, nome, cognome)
- **Prodotto_candidato**(**<ins>ID</ins>**, numero_seriale, nome, nome_produttore, prezzo, url, note)
- **Categoria**(**<ins>ID</ins>**, nome)
- **Richista_acquisto**(**<ins>ID</ins>**, **<ins>ID_ordinante</ins>**, **<ins>ID_tecnico</ins>**, timestamp, note, esito)
- **Caratteristica**(**<ins>ID</ins>**, **<ins>ID_categoria</ins>**, nome)
- **Valutazione**(**<ins>ID</ins>**, **<ins>ID_prodotto_candidato</ins>**, **<ins>ID_ordinante</ins>**, decisione, motivazione)
- **Tecnico_prodotti**(**<ins>ID</ins>**, **<ins>ID_tecnico</ins>**, **<ins>ID_prodotto</ins>**)
- **Richiesta_prodotti**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_prodotto</ins>**)
- **Richiesta_categorie**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_categoria</ins>**)
- **Richiesta_caratteristiche**(**<ins>ID</ins>**, **<ins>ID_richiesta_acquisto</ins>**, **<ins>ID_caratteristica</ins>**, valore)

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

-- 1. Quali sono le persone (id, nome e cognome) che hanno avuto assenze solo nei
-- giorni in cui non avevano alcuna attività (progettuali o non progettuali)?

SELECT DISTINCT p.id, p.nome, p.cognome
FROM persona p, assenza a
WHERE p.id = a.persona AND
	a.id NOT IN (Select a.id
		From Assenza a, attivitaProgetto ap
		Where a.persona = ap.persona And
		A.giorno = ap.giorno )
  AND a.id NOT IN (Select a.id
		From Assenza a, attivitaNonProgettuale anp
		Where a.persona = anp.persona And
		A.giorno = anp.giorno
)
ORDER BY p.id;

-- 2. Quali sono le persone (id, nome e cognome) che non hanno mai partecipato ad
-- alcun progetto durante la durata del progetto “Pegasus”?

WITH pegasus AS (
    SELECT inizio, fine
    FROM Progetto
    WHERE nome = 'Pegasus'
)
SELECT DISTINCT p.id, p.nome, p.cognome
FROM Persona p
WHERE p.id NOT IN (
    SELECT p.id
    FROM Persona p, pegasus pe, AttivitaProgetto ap
    WHERE p.id = ap.persona AND
        ap.giorno > pe.inizio AND
        ap.giorno < pe.fine
)
ORDER BY p.id;

 id |   nome    |   cognome   
----+-----------+-------------
  1 | Mario     | Rossi
  3 | Gino      | Spada
  5 | Guido     | Spensierato
  6 | Consolata | Ferrari
  7 | Andrea    | Verona
  9 | Carlo     | Zante
 12 | Dario     | Basile
 13 | Silvia    | Donati
 14 | Fiorella  | Martino
 15 | Leonardo  | Vitali
 16 | Paolo     | Valentini
 17 | Emilio    | Greco
 18 | Giulia    | Costa
 19 | Elisa     | Longo
 20 | Carla     | Martinelli
(15 rows)

-- 3. Quali sono id, nome, cognome e stipendio dei ricercatori con stipendio maggiore
-- di tutti i professori (associati e ordinari)?

WITH st_max AS (
    SELECT max(stipendio) as max_st
    FROM Persona
    WHERE posizione = 'Professore Associato' OR
        posizione = 'Professore Ordinario'
)

SELECT p.id, p.nome, p.cognome, p.stipendio
FROM Persona p, st_max st 
WHERE p.posizione = 'Ricercatore' AND
    p.stipendio > st.max_st
ORDER BY p.id;

 id | nome | cognome | stipendio 
----+------+---------+-----------
  0 | Anna | Bianchi |   45500.3
(1 row)

-- 4. Quali sono le persone che hanno lavorato su progetti con un budget superiore alla
-- media dei budget di tutti i progetti?

WITH mbudget AS (
    SELECT avg(budget) AS budgetm
    FROM Progetto
)
SELECT DISTINCT p.id, p.nome, p.cognome
FROM Persona p, AttivitaProgetto ap
WHERE p.id = ap.persona AND
    ap.progetto IN (SELECT p.id
        FROM Progetto p, mbudget m
        WHERE p.budget > m.budgetm)
ORDER BY p.id;

 id |  nome  | cognome 
----+--------+---------
  4 | Aurora | Bianchi
(1 row)

-- 5. Quali sono i progetti con un budget inferiore alla media, ma con un numero
-- complessivo di ore dedicate alle attività di ricerca sopra la media?

WITH mbudget AS (
    SELECT avg(budget) AS budgetm
    FROM Progetto
), nore AS (
    SELECT progetto, sum(oreDurata) AS NumOre
    FROM AttivitaProgetto
    GROUP BY progetto
), more AS (
    SELECT avg(NumOre) AS NumOre
    FROM nore
)
SELECT DISTINCT p.id, p.nome
FROM Progetto p, mbudget mb, nore ore, more mo
WHERE p.budget < mb.budgetm AND
    p.id = ore.progetto AND
    ore.NumOre > mo.NumOre
ORDER BY p.id;

 id |  nome   
----+---------
  1 | Pegasus
(1 row)
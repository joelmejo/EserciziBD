-- 1. Qual è media e deviazione standard degli stipendi per ogni categoria di strutturati?

SELECT posizione, avg(p.stipendio) AS media, stddev(p.stipendio) AS deviazione_standard
FROM Persona
GROUP BY posizione;

      posizione       |       media        | deviazione_standard 
----------------------+--------------------+---------------------
 Professore Ordinario | 39848.667317708336 |   2894.855495562445
 Professore Associato | 38211.143798828125 |   4359.258153186441
 Ricercatore          | 40304.271205357145 |   3602.198235119911
(3 rows)

-- 2. Quali sono i ricercatori (tutti gli attributi) con uno stipendio superiore alla media
-- della loro categoria?

WITH media AS (
    SELECT posizione, avg(stipendio) as media_stipendio
    FROM Persona
    WHERE posizione = 'Ricercatore'
    GROUP BY posizione
)

SELECT p.*
FROM Persona p, media as m
WHERE p.stipendio > m.media_stipendio
    AND p.posizione = m.posizione;

 id |  nome   |  cognome   |  posizione  | stipendio 
----+---------+------------+-------------+-----------
  0 | Anna    | Bianchi    | Ricercatore |   45500.3
  2 | Barbara | Burso      | Ricercatore |   40442.5
 12 | Dario   | Basile     | Ricercatore |     42566
 20 | Carla   | Martinelli | Ricercatore |   42030.2
(4 rows)

-- 3. Per ogni categoria di strutturati quante sono le persone con uno stipendio che
-- differisce di al massimo una deviazione standard dalla media della loro categoria?

WITH stde AS (
    SELECT posizione, avg(stipendio) AS media, stddev(stipendio) AS deviazione_standard
    FROM Persona
    GROUP BY posizione
)

SELECT p.posizione, count(*) AS numero
FROM Persona p, stde s
WHERE p.posizione = s.posizione
    AND (p.stipendio <= s.media + s.deviazione_standard AND p.stipendio >= s.media - s.deviazione_standard)
GROUP BY p.posizione;

      posizione       | numero 
----------------------+--------
 Professore Ordinario |      4
 Professore Associato |      6
 Ricercatore          |      4
(3 rows)

-- 4. Chi sono gli strutturati che hanno lavorato almeno 20 ore complessive in attività
-- progettuali? Restituire tutti i loro dati e il numero di ore lavorate.

WITH ore AS (
    SELECT p.id, sum(ap.oreDurata) AS somma
    FROM Persona p, AttivitaProgetto ap
    WHERE p.id = ap.persona
    GROUP BY p.id
)

SELECT p.*, o.somma as ore_lavorate
FROM Persona p, ore o
WHERE p.id = o.id
    AND o.somma >= 20;

 id | nome | cognome |  posizione  | stipendio | ore_lavorate 
----+------+---------+-------------+-----------+--------------
  0 | Anna | Bianchi | Ricercatore |   45500.3 |           38
(1 row)

-- 5. Quali sono i progetti la cui durata è superiore alla media delle durate di tutti i
-- progetti? Restituire nome dei progetti e loro durata in giorni.

WITH durata_progetti AS (
    SELECT id, nome, fine - inizio AS durata_giorni
    FROM Progetto
),

durata_media AS (
    SELECT avg(durata_giorni) AS media_durata
    FROM durata_progetti
)
 
SELECT dp.nome, dp.durata_giorni
FROM durata_media dm, durata_progetti dp
WHERE dp.durata_giorni > dm.media_durata;

    nome     | durata_giorni 
-------------+---------------
 WineSharing |          1825
 Simap       |          1505
(2 rows)

-- 6. Quali sono i progetti terminati in data odierna che hanno avuto attività di tipo
-- “Dimostrazione”? Restituire nome di ogni progetto e il numero complessivo delle
-- ore dedicate a tali attività nel progetto.

WITH prog_term AS (
    SELECT id
    FROM Progetto
    WHERE fine < CURRENT_DATE
)

SELECT

-- 7. Quali sono i professori ordinari che hanno fatto più assenze per malattia del nu-
-- mero di assenze medio per malattia dei professori associati? Restituire id, nome e
-- cognome del professore e il numero di giorni di assenza per malattia.
-- 1. Qual è media e deviazione standard degli stipendi per ogni categoria di strutturati?

SELECT posizione, avg(p.stipendio) AS media, stddev_samp(p.stipendio) AS deviazione_standard
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
    GROUP BY posizione
)

SELECT p.*, m.media_stipendio
FROM Persona p, media as m
WHERE p.stipendio > m.media_stipendio
    AND p.posizione = m.posizione;

-- 3. Per ogni categoria di strutturati quante sono le persone con uno stipendio che
-- differisce di al massimo una deviazione standard dalla media della loro categoria?



-- 4. Chi sono gli strutturati che hanno lavorato almeno 20 ore complessive in attività
-- progettuali? Restituire tutti i loro dati e il numero di ore lavorate.
-- 5. Quali sono i progetti la cui durata è superiore alla media delle durate di tutti i
-- progetti? Restituire nome dei progetti e loro durata in giorni.
-- 6. Quali sono i progetti terminati in data odierna che hanno avuto attività di tipo
-- “Dimostrazione”? Restituire nome di ogni progetto e il numero complessivo delle
-- ore dedicate a tali attività nel progetto.
-- 7. Quali sono i professori ordinari che hanno fatto più assenze per malattia del nu-
-- mero di assenze medio per malattia dei professori associati? Restituire id, nome e
-- cognome del professore e il numero di giorni di assenza per malattia.
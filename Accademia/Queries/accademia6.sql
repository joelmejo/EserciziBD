-- 1. Quanti sono gli strutturati di ogni fascia?

select posizione, count(*)
from persona
group by posizione;

--       posizione       | count 
-- ----------------------+-------
--  Professore Ordinario |     6
--  Professore Associato |     8
--  Ricercatore          |     7
-- (3 rows)

-- 2. Quanti sono gli strutturati con stipendio ≥ 40000?

select count(*)
from persona
where stipendio >= 40000;

--  count 
-- -------
--      9
-- (1 row)

-- 3. Quanti sono i progetti già finiti che superano il budget di 50000?

select count(*)
from progetto
where fine < CURRENT_DATE and budget > 50000;

--  count 
-- -------
--      5
-- (1 row)

-- 4. Qual è la media, il massimo e il minimo delle ore delle attività relative al progetto
-- ‘Pegasus’ ?

select avg(ap.oreDurata) as media, min(ap.oreDurata) as minimo, max(ap.oreDurata) as massimo
from progetto p, attivitaProgetto ap
where ap.progetto = p.id and p.nome = 'Pegasus';

--       mediaore      | massimoore | minimoore 
-- --------------------+------------+-----------
--  7.8571428571428571 |          8 |         7
-- (1 row)

-- 5. Quali sono le medie, i massimi e i minimi delle ore giornaliere dedicate al progetto
-- ‘Pegasus’ da ogni singolo docente?

select s.id, s.nome, s.cognome, avg(oreDurata) as media, min(oreDurata) as minimo, max(oreDurata) as massimo
from persona s, attivitaProgetto ap, progetto p
where p.nome = 'Pegasus' 
    and p.id = ap.progetto
    and ap.persona = s.id
group by s.id, s.nome, s.cognome;

--  id |  nome   | cognome  |       media        | minimo | massimo 
-- ----+---------+----------+--------------------+--------+---------
--   0 | Anna    | Bianchi  | 8.0000000000000000 |      8 |       8
--   2 | Barbara | Burso    | 7.0000000000000000 |      7 |       7
--   8 | Asia    | Giordano | 8.0000000000000000 |      8 |       8
--  10 | Ginevra | Riva     | 8.0000000000000000 |      8 |       8
-- (4 rows)

-- 6. Qual è il numero totale di ore dedicate alla didattica da ogni docente?

select s.id, s.nome, s.cognome, sum(oreDurata)
from persona s, attivitanonprogettuale anp
where anp.tipo = 'Didattica'
    and anp.persona = s.id
group by s.id, s.nome, s.cognome;

--  id |   nome    | cognome  | sum 
-- ----+-----------+----------+-----
--   0 | Anna      | Bianchi  |   4
--   1 | Mario     | Rossi    |   8
--   2 | Barbara   | Burso    |   8
--   6 | Consolata | Ferrari  |   7
--   8 | Asia      | Giordano |   8
-- (5 rows)

-- 7. Qual è la media, il massimo e il minimo degli stipendi dei ricercatori?

select avg(stipendio) as media, min(stipendio) as minimo, max(stipendio) as massimo
from persona
where posizione = 'Ricercatore';

--        media        | minimo | massimo 
-- --------------------+--------+---------
--  40304.271205357145 |  35500 | 45500.3
-- (1 row)

-- 8. Quali sono le medie, i massimi e i minimi degli stipendi dei ricercatori, dei professori
-- associati e dei professori ordinari?

select posizione, avg(stipendio) as media, min(stipendio) as minimo, max(stipendio) as massimo
from persona
group by posizione;

--       posizione       |       media        | minimo  | massimo 
-- ----------------------+--------------------+---------+---------
--  Professore Ordinario | 39848.667317708336 | 36922.1 | 45200.1
--  Professore Associato | 38211.143798828125 | 29200.1 | 43500.5
--  Ricercatore          | 40304.271205357145 |   35500 | 45500.3
-- (3 rows)

-- 9. Quante ore ‘Ginevra Riva’ ha dedicato ad ogni progetto nel quale ha lavorato?

select p.id, p.nome, sum(oreDurata)
from persona s, progetto p, attivitaProgetto ap
where s.nome = 'Ginevra'
    and s.cognome = 'Riva'
    and s.id = ap.persona
    and ap.progetto = p.id
group by p.id, p.nome;

--  id |  nome   | sum 
-- ----+---------+-----
--   1 | Pegasus |   8
-- (1 row)

-- 10. Qual è il nome dei progetti su cui lavorano più di due strutturati?

select distinct p.id, p.nome
from progetto p, attivitaProgetto ap1, attivitaProgetto ap2
where p.id = ap1.progetto
    and p.id = ap2.progetto
    and ap1.persona <> ap2.persona;

--      id |  nome   
-- ----+---------
--   3 | Simap
--   1 | Pegasus
-- (2 rows)

-- 11. Quali sono i professori associati che hanno lavorato su più di un progetto?

select distinct s.id, s.nome, s.cognome
from persona s, attivitaProgetto ap1, attivitaProgetto ap2
where s.posizione = 'Professore Associato'
    and ap1.persona = ap2.persona
    and s.id = ap1.persona
    and ap1.progetto <> ap2.progetto;

--  id |  nome  | cognome 
-- ----+--------+---------
--   4 | Aurora | Bianchi
-- (1 row)